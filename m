Received: from eggs.gnu.org ([2001:4830:134:3::10]:40313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f1U1m-0001vZ-EB
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f1U1h-0000ph-I9
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 05:39:26 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <de89f57b-bbcc-20c9-b1e4-e9a96e87a31b@redhat.com>
References: <20180322124155.16257-1-berto@igalia.com>
	<de89f57b-bbcc-20c9-b1e4-e9a96e87a31b@redhat.com>
Date: Thu, 29 Mar 2018 11:39:18 +0200
Message-ID: <w51y3ib43w9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 28 Mar 2018 07:34:15 PM CEST, Max Reitz wrote:
>> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
>> index 45b359c2ba..5b9593016c 100755
>> --- a/tests/qemu-iotests/122
>> +++ b/tests/qemu-iotests/122
>
> Not sure if 122 is the right file for this...
>
> Or, let me rephrase, it does look to me like it is not the right file.
> But on the other hand, I don't see a more suitable file.

Yeah I was tempted to create a new one, but in the end I decided to put
it there. We can still create a new one if you feel strongly about it.

>>  echo
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

Yeah, it's also possible, you have to do it in the same qemu-io command
though, else it will allocate two host clusters. But yes, I can change
that.

>> +# Reduce size of compressed data to 4 sectors: this corrupts the image.
>> +poke_file "$TEST_IMG" $((0x800000)) "\x40\x06"
>> +$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
>> +
>> +# 'qemu-img check' however doesn't see anything wrong because it
>> +# doesn't try to decompress the data and the refcounts are consistent.
>> +# TODO: update qemu-img so this can be detected
>> +_check_test_img
>> +
>> +# Increase size of compressed data to the maximum (8192 sectors).
>> +# This makes QEMU read more data (8192 sectors instead of 5, host
>> +# addresses [0xa00000, 0xdfffff]), but the decompression algorithm
>> +# stops once we have enough to restore the uncompressed cluster, so
>> +# the rest of the data is ignored.
>> +poke_file "$TEST_IMG" $((0x800000)) "\x7f\xfe"
>> +# Do it also for the second compressed cluster (L2 entry at 0x800008).
>> +# In this case the compressed data would span 3 host clusters
>> +# (host addresses: [0xa00802, 0xe00801])
>> +poke_file "$TEST_IMG" $((0x800008)) "\x7f\xfe"
>> +
>> +# Here the image is too small so we're asking QEMU to read beyond the
>> +# end of the image.
>> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
>> +# But if we grow the image we won't be reading beyond its end anymore.
>> +$QEMU_IO -c "write -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
>> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
>
> Both reads result in exactly the same output, though, so it doesn't
> seem like qemu cares.
>
> (This is the reason I'm not merging this patch now, because that looks
> a bit fishy.)

In this example the size stored on the compressed cluster descriptor is
corrupted and larger than the size of the compressed data on disk.

In the first read the image is too small so this makes QEMU read not
only past the end of the compressed data, but also past the end of the
qcow2 image itself.

In the second read the qcow2 image is larger so QEMU reads actual data
from the subsequent clusters.

It doesn't make much difference. In the first case the buffer is padded
with zeroes and in the second with data from other clusters, but QEMU
only uses the data needed to restore the original uncompressed cluster
and the rest is ignored. But I thought I could still test both cases,
that's why there's two reads.

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

Compressed clusters never have OFLAG_COPIED and we treat it as an error
if they do (see check_refcounts_l2()), but their host clusters still
have a reference count.

A host cluster with 4 compressed clusters has a reference count of 4.

A compressed cluster that uses two host clusters (even if it's only
partially) increases the reference count of both of them.

In this test case the size field of the compressed cluster is too large,
so it includes uncompressed clusters that are contiguous to it. The
uncompressed clusters have refcount == 1 and OFLAG_COPIED, but QEMU
detects that the refcount should be larger and that OFLAG_COPIED should
not be there, that's why it's repaired.

Admittedly the way it's repaired is not the best one: the uncompressed
clusters have now extra references, but other than that I don't see any
harmful effect.

The proper fix for this would be to detect that the compressed cluster
size is incorrect and correct its value. There's a TODO for that (in the
first _check_test_img call where it's more severe), but now that I think
of it I should probably mention that in the second one as well.

Berto
