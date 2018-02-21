Received: from eggs.gnu.org ([2001:4830:134:3::10]:60728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoVtX-0004ie-0M
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 10:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoVtS-00077X-UJ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 10:01:19 -0500
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
	<w51tvuak6b0.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37fa8b17-116b-ea53-6f65-68412fdb813c@redhat.com>
Date: Wed, 21 Feb 2018 09:00:54 -0600
MIME-Version: 1.0
In-Reply-To: <w51tvuak6b0.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: Avoid memory over-allocation on
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

On 02/21/2018 04:04 AM, Alberto Garcia wrote:
> On Tue 20 Feb 2018 11:24:59 PM CET, Eric Blake wrote:
> 
> I was also preparing a patch to change this, but you arrived first :-)
> 
>> So, it's time to cut back on the waste.  A compressed cluster
>> will NEVER occupy more than an uncompressed cluster (okay, gzip
>> DOES document that because the compression stream adds metadata,
>> and because of the pigeonhole principle, there are worst case
>> scenarios where attempts to compress will actually inflate an
>> image - but in those cases, we would just write the cluster
>> uncompressed instead of inflating it).  And as that is a smaller
>> amount of memory, we can get by with the simpler g_malloc.
> 
>> -        if (!s->cluster_cache) {
>> -            s->cluster_cache = g_malloc(s->cluster_size);
>> +            assert(!s->cluster_cache);
>> +            s->cluster_data = g_try_malloc(s->cluster_size);
>> +            s->cluster_cache = g_try_malloc(s->cluster_size);

Shoot - I made edits that I forgot to commit before sending; I meant for 
these to be g_malloc() rather than g_try_malloc().

> 
> There's a few things here:
> 
> - QEMU won't write compressed data if the size is >= s->cluster_size
>    (there's an explicit check for that in qcow2_co_pwritev_compressed())

Correct, we never cause inflation (and even if we wanted to, we can't, 
because the qcow2 format doesn't have enough bits for us to record that 
many sectors for a compressed stream that occupies more space than the 
original cluster).

> 
> - The size field of the compressed cluster descriptor *does* allow
>    larger sizes, so you can't simply read csize bytes into
>    s->cluster_data becuase you could cause a buffer overflow.

Let's step through this:

   nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask + 1;

Since s->csize_mask is determined by s->cluster_size / 512, then after 
this assignment, the most nb_csectors can be is exactly s->cluster_size 
/ 512.

   sector_offset = coffset & 511;
   csize = nb_csectors * 512 - sector_offset;

And here, csize can only get smaller than the length picked by 
nb_csectors.  Therefore, csize is GUARANTEED to be <= c->sector_size.

> 
> - Solution a: check that csize < s->cluster_size and return an error if
>    it's not. However! although QEMU won't produce an image with a
>    compressed cluster that is larger than the uncompressed one, the qcow2
>    on-disk format in principle allows for that, so arguably we should
>    accept it.

No, the qcow2 on-disk format does not have enough bits reserved for 
that.  It is impossible to store an inflated cluster, because you don't 
have enough bits to record it.

That said, we MAY have a bug, more likely to be visible in 512-byte 
clusters but possible on any size.  While the 'number sectors' field IS 
sufficient for any compressed cluster starting at offset 0 in the 
cluster, we run into issues if the starting offset is later in the 
cluster.  That is, even though the compressed length of a 512-byte 
cluster is <= 512 (or we wouldn't compress it), if we start at offset 
510, we NEED to read the next cluster to get the rest of the compressed 
stream - but at 512-byte clusters, there are 0 bits reserved for 'number 
sectors'.  Per the above calculations with the example offset of 510, 
nb_csectors would be 1 (it can't be anything else for a 512-byte cluster 
image), and csize would then be 2 bytes, which is insufficient for 
reading back enough data to reconstruct the cluster.

We probably need to clarify in the spec that if the starting offset of a 
compressed cluster falls mid-sector, then the compressed size has to be 
smaller than cluster size - (offset % 512) (this requirement is already 
there implicitly due to the field widths, but being explicit can't 
hurt).  We probably also need to fix our compression code to actually do 
the right thing, particularly for 512-byte clusters where we are most 
likely to run into a compressed size that is likely to overflow the 
space available for nb_csectors.

> 
> - Solution b: the width of the 'compressed cluster size' field is
>    (cluster_bits - 8), that's (cluster_size / 256) sectors.

Not true.  It is (cluster_bits - 9) or (cluster_size / 512).  Remember, 
x = 62 - (cluster_bits - 8); for a 512-byte cluster, x = 61.  The 
'number sectors' field is then bits x+1 - 61 (but you can't have a 
bitfield occupying bit 62 upto 61; especially since bit 62 is the bit 
for compressed cluster).

> Since the
>    size of each sector is 512 bytes, the maximum possible size that the
>    field can store is (cluster_size * 2) bytes. So allocate that amount
>    of space for s->cluster_data, read the data as it is on disk and let
>    the decompression code return an error if the data is indeed
>    corrupted or it doesn't fit in the output buffer.

Again, I argue that the qcow2 spec says that the maximum size for a 
compressed cluster is cluster_size, even if it spills over a host 
cluster boundary.  But if in practice, we HAVE allowed a spillover 
beyond the 'number fields' maximum size because of a non-zero offset, 
where we weren't careful about what got recorded into the qcow2 image, 
then we could instead state that reading s->cluster_size+512 is 
guaranteed to find the end of the compressed stream, even when 'number 
fields' is 0 because of overflow, at which point, sizing the buffer to 
be one sector larger than a cluster will mean that we can cope even with 
512-byte clusters that were compressed incorrectly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
