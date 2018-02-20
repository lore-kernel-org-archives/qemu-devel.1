Received: from eggs.gnu.org ([2001:4830:134:3::10]:50853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoDmn-0005bB-6s
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 14:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoDml-0005D7-Ki
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 14:41:09 -0500
References: <20180220170135.5299-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d9713f2-87c1-12ba-3f46-a9a476279cda@redhat.com>
Date: Tue, 20 Feb 2018 13:40:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180220170135.5299-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 02/20/2018 11:01 AM, Alberto Garcia wrote:

tl:dr; I think we need a v3 with even more clarification.


> The documentation claims that the cluster descriptor contains the
> number of sectors used to store the compressed data, but what it
> actually contains is the number of sectors *minus one*.
> 
> That can be easily seen in qcow2_decompress_cluster(), that adds one
> to the value stored in that field:
> 
>    nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;

This is misleading.  It says how we take what is in the qcow2 file on 
reading in order to decompress, but still doesn't show how we generated 
that number.  Let's also compare it as well to what we WRITE into the 
qcow2 file:

     nb_csectors = ((cluster_offset + compressed_size - 1) >> 9) -
                   (cluster_offset >> 9);

I'm also making an additional observationn: Due to the pigeonhole 
principle and the fact that the compression stream adds metadata, we 
KNOW that there are some (rare) cases where attempting to compress data 
will actually result in an INCREASE in size ('man gzip' backs up this 
claim, calling out a worst case -0.015% compression ratio, or 15 bytes 
added for every 1000 bytes of input, on uncompressible data).  So 
presumably, we should state that a cluster can only be written in 
compressed form IF it occupies less space than the uncompressed cluster 
(we could also allow a compressed form that occupies the same length as 
the uncompressed cluster, but that's a waste of CPU cycles).

Once we have that restriction stated, then it becomes obvious that a 
compressed cluster should never REQUIRE using more than one host cluster 
(and this is backed up by qcow2_alloc_bytes() asserting that size <= 
s->cluster_size).  Where things get interesting, though, is whether we 
PERMIT a compressed cluster to overlap a host cluster boundary. 
Technically, it might be possible, but qemu does NOT do that (again, 
looking at qcow2_alloc_bytes() - we loop if free_in_cluster < size) - so 
we may want to be explicit about this point to prevent OTHER 
implementations from creating a compressed cluster that crosses host 
cluster boundaries (right now, I can't see qcow2_decompress_cluster() 
validating it, though - YIKES).

> 
> In addition to that this patch clarifies where the actual compressed
> data is located.
> 
> Although the size of the data is specified in sectors, the offset is
> not necessarily aligned to a sector boundary, so the actual data goes
> from the specified offset until the end of the last sector, leaving
> the initial bytes of the first sector (if any) unused.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> 
> v2: I realized that the documentation is not completely clear about
>      the exact location and size of the compressed data, so I updated
>      the patch to clarify this.
> 
> ---
>   docs/interop/qcow2.txt | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index d7fdb1fee3..dc2b9cefb2 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -427,9 +427,17 @@ Standard Cluster Descriptor:
>   Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>   

I'm looking at how this works for different cluster sizes.  If we have 
512-byte clusters, x is 61, and we DON'T have the 'number sectors' field 
at all!  But that still makes sense, provided that all consecutive host 
sectors used to hold a compressed guest cluster lie within a single host 
cluster.  If we ever allowed a compressed cluster to spill across two 
host clusters, it would cause mayhem in trying to track refcounts and 
other things.  So you can have two 512-byte guest clusters that manage 
to compress into the same host cluster, but must never have a single 
guest cluster that spills over a host cluster boundary.

For all other cluster sizes, the value of x leaves us exactly 
log2(cluster_size / 512) bits for the 'number sectors' field.  For 
example, with 64k clusters, x is 54, leaving 7 bits (64k/512 == 128, and 
2^7 covers the number of sectors in a 64k host cluster).  Whether all of 
these sectors should lie within the same host cluster should be stated 
(as I argued above, this is how qemu does it, so it SHOULD be part of 
the spec to prevent refcount and other confusion if some other 
implementation created images violating that).

>       Bit  0 -  x:    Host cluster offset. This is usually _not_ aligned to a
> -                    cluster boundary!
> +                    cluster or sector boundary!
>   
> -       x+1 - 61:    Compressed size of the images in sectors of 512 bytes
> +       x+1 - 61:    Number of 512-byte sectors used for the compressed data,
> +                    minus one (that is, a value of n here means n+1 sectors).
> +
> +                    The actual compressed data is located at the end of this
> +                    region, from the offset indicated in the previous field
> +                    until the end of the last sector.
> +
> +                    The initial bytes of this region are therefore unused if
> +                    the offset is not aligned to a sector boundary.

So, to make sure I understand, visually, suppose we have three 64k 
clusters that we compress; A which compresses to 224 bytes, B which 
compresses to 1120 bytes, and C which also compresses to 224 bytes 
(these numbers are reasonable, since 'printf "%*d" $((64*1024)) 1 | gzip 
-c | wc' compresses to 64k to 99 bytes) (the observant will notice I 
picked multiples of 32 bytes, for display purposes, but that in reality 
we have full byte granularity for both starting location and length of a 
compressed cluster).

+----------------+----------------+----------------+----------------+
+0x00020000      +0x00020200      +0x00020400      +0x00020600      +
+AAAAAAABBBBBBBBB+BBBBBBBBBBBBBBBB+BBBBBBBBBBCCCCCC+C...............+

We achieve the following layout by compressing cluster A into the start 
of the cluster at 0x00020000 until it finishes, then cluster B into the 
unused tail of that sector until it finishes (starting at 0x000200e0), 
and cluster C into the tail of the sector started by B (starting at 
0x00020540, ending at 0x0002061f).  Another interesting thing to note is 
that our choice of compression algorithm carries enough state that we 
can ALWAYS choose to feed too much to the decompression engine; but the 
trailing data will be ignored because we stop once we've decompressed 
64k of material.  So our real question is figuring out the bare minimum 
that we can feed to the engine and still decompress everything we need.

The number of sectors used for cluster A is pretty obviously 0 (you do 
not have to read any additional sectors to decompress A).  So the L2 
entry for A would be 0x40000000_00020000.  On decompression, we read the 
sector starting at that offset, 0 additional sectors, and although we 
feed the decompressor 512 bytes, it only needs to read 224 bytes before 
we are done reconstituting 64k bytes.

The value written in the number of sectors field for cluster B is 2. 
Yes, floor(1120/512) == 2, but more importantly, our decompression HAS 
to read two additional sectors beyond the starting offset in order to 
feed enough data to the engine.  That is, the L2 entry is 
0x41000000_000200e0), and we feed the decompressor 1312 bytes even 
though it only needs 1120.

But the value of the field for cluster C is 1, not 0, EVEN THOUGH it was 
the same compressed size as cluster A!  On write, we compute the sector 
containing the last byte, which is one greater than the sector 
containing the first byte.  The L2 entry is 0x40800000_00020540; and we 
feed the decompressor 704 bytes even though it only needs 224.

So if I may suggest:

    x+1 - 61:    Number of additional 512-byte sectors used for the
                 compressed data, beyond the sector containing the
                 offset in the previous field.  These sectors must fit
                 within the same host cluster.  Note that the compressed
                 data does not necessarily occupy all of the bytes in
                 the final sector; rather, decompression stops when it
                 has produced a cluster of data.  Another compressed
                 cluster may map to the tail of the final sector used
                 by this compressed cluster.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
