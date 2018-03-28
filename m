Received: from eggs.gnu.org ([2001:4830:134:3::10]:33287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1FLD-0001cb-6b
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1FLB-0005gf-Sn
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:58:31 -0400
References: <20180322124155.16257-1-berto@igalia.com>
	<de89f57b-bbcc-20c9-b1e4-e9a96e87a31b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a60b56cd-c786-fa4f-1405-8017140ff801@redhat.com>
Date: Wed, 28 Mar 2018 12:58:17 -0500
MIME-Version: 1.0
In-Reply-To: <de89f57b-bbcc-20c9-b1e4-e9a96e87a31b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v4] iotests: Test abnormally large
 size in compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 03/28/2018 12:34 PM, Max Reitz wrote:
> On 2018-03-22 13:41, Alberto Garcia wrote:
>> L2 entries for compressed clusters have a field that indicates the
>> number of sectors used to store the data in the image.
>>
>> That's however not the size of the compressed data itself, just the
>> number of sectors where that data is located. The actual data size is
>> usually not a multiple of the sector size, and therefore cannot be
>> represented with this field.
>>

>> +++ b/tests/qemu-iotests/122
> 
> Not sure if 122 is the right file for this...
> 
> Or, let me rephrase, it does look to me like it is not the right file.
> But on the other hand, I don't see a more suitable file.

Short of cloning 122 as the starting point and creating a new test file.

> 
>> @@ -130,6 +130,51 @@ $QEMU_IO -c "read -P 0    1024k 1022k" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fil
>>   
>>   
>>   echo
>> +echo "=== Corrupted size field in compressed cluster descriptor ==="
>> +echo
>> +# Create an empty image, fill half of it with data and compress it.
>> +# The L2 entries of the two compressed clusters are located at
>> +# 0x800000 and 0x800008, their original values are 0x4008000000a00000
>> +# and 0x4008000000a00802 (5 sectors for compressed data each).
>> +TEST_IMG="$TEST_IMG".1 _make_test_img 8M
>> +$QEMU_IO -c "write -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io | _filter_testdir
>> +$QEMU_IMG convert -c -O qcow2 -o cluster_size=2M "$TEST_IMG".1 "$TEST_IMG"
> 
> Why not just use "write -c" and drop the convert?  (You'd have to use
> two writes, though, one for each cluster.)

'write -c' is newer code; it may work, but it may also cause offsets to 
live elsewhere for knock-on effects later in the test. (It used to be 
compression was only possible during convert)


>> +
>> +# Here the image is too small so we're asking QEMU to read beyond the
>> +# end of the image.
>> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
>> +# But if we grow the image we won't be reading beyond its end anymore.
>> +$QEMU_IO -c "write -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
>> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> 
> Both reads result in exactly the same output, though, so it doesn't seem
> like qemu cares.
> 
> (This is the reason I'm not merging this patch now, because that looks a
> bit fishy.)

Hmm, you have an interesting point - should the read fail (you asked me 
to read more clusters than I have available) or succeed (since you asked 
me to read beyond EOF, I filled the tail of the buffer with all zeroes, 
then tried decompressing, and since decompression worked, it obviously 
didn't need the bytes that I filled in as zero).  It's a little nicer to 
fail (the image is fishy for requesting more clusters than are present, 
even if what IS present is sufficient to reconstruct the data).

> 
>> +
>> +# The refcount data is however wrong because due to the increased size
>> +# of the compressed data it now reaches the following host clusters.
>> +# This can be repaired by qemu-img check.
> 
> The OFLAG_COPIED repair looks a bit interesting, but, er, well.
> 
> Max
> 
> (Since a compressed cluster does not correspond 1:1 to a host cluster,
> you cannot say that a compressed cluster has a refcount -- only host
> clusters are refcounted.  So what is it supposed to mean that a
> compressed cluster has a refcount of 1?

A compressed cluster may affect the refcount of multiple clusters: the 
cluster that contains the initial offset, and the cluster that contains 
any of the nb_sectors that did not fit in the first cluster.  So, if I 
have a 4k-cluster image (where each character is a sector), and where 
the compressed clusters are nicely sector-aligned:

|1-------|2-------|3-------|
|AAAAAABB|BBBBCCCC|CC------|

Here, the L2 entry for A, B, and C each list nb_sectors of 5, as it 
takes 6 sectors to list the entire image, but nb_sectors does not 
include the sector that includes the original offset.  The refcount for 
cluster 1 is 2 (the full contents of compressed A and the first half of 
compressed B); for cluster 2 is 2 (the second half of compressed B and 
the first half of compressed C); and for cluster 3 is 1 (the second half 
of compressed C).

But what this patch is dealing with is when nb_sectors is larger than 
required.  With 4k sectors, qemu will never populate nb_clusters more 
than 8 (if the output is not nicely aligned, and 4096 bytes compresses 
down to only 4095, we can end up with 1 byte in the first sector, then 7 
complete sectors, then 510 bytes in a final sector, for 8 sectors beyond 
the initial offset).  But the qcow2 image is still valid even if the L2 
entry claims nb_sectors of 15; if that happens, then a compressed 
cluster can now affect the refcount of 3 clusters rather than the usual 
1 or 2.

> 
> I'd argue from a point of usefulness.  In theory, you could modify
> compressed clusters in-place, and then you'd need the information
> whether you are allowed to.  But that doesn't really depend on whether
> the host clusters touched by the compressed cluster have a refcount of
> 1, instead if depends on how many times the compressed cluster itself is
> referenced.  Unfortunately we have no refcounting structure for that.
> 
> So all in all OFLAG_COPIED is just useless for compressed clusters.)

In general, because we intentionally allow multiple compressed clusters 
to (try to) share a single host cluster, the refcount for compressed 
clusters will usually be larger than 1.  And OFLAG_COPIED is only useful 
when the refcount is 1, right?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
