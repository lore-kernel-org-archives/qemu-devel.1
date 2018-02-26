Received: from eggs.gnu.org ([2001:4830:134:3::10]:35297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqKSc-0008O6-3b
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqKSX-0005Pe-DH
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:13:01 -0500
References: <20180226143623.12200-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <220e737d-f773-1420-e632-b94558b98206@redhat.com>
Date: Mon, 26 Feb 2018 09:12:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180226143623.12200-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Test abnormally large size in
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

On 02/26/2018 08:36 AM, Alberto Garcia wrote:
> L2 entries for compressed clusters have a field that indicates the
> number of sectors used to store the data in the image.
> 

> 
> One consequence of this is that even if the size field is larger than
> it needs to be QEMU can handle it just fine: it will read more data
> from disk but it will ignore the extra bytes.

Modulo any ref count checks, of course ;)


> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> 
> v3: Add TODO comment, as suggested by Eric.
> 
>      Corrupt the length of the second compressed cluster as well so the
>      uncompressed data would span three host clusters.

Rather, it is the 'claimed' size of the compressed data that spans three 
host clusters.  I don't know if our refcount repair code is geared for 
that (it IS prepared for a compressed data cluster that spans two host 
clusters, but spanning three is only possible for externally-produced 
images, as in this test).


>   echo
> +echo "=== Corrupted size field in compressed cluster descriptor ==="
> +echo
> +# Create an empty image, fill half of it with data and compress it.
> +# The L2 entries of the two compressed clusters are located at
> +# 0x800000 and 0x800008, their original values are 0x4008000000a00000
> +# and 0x4008000000a00802 (5 sectors for compressed data each).
> +TEST_IMG="$TEST_IMG".1 _make_test_img 8M
> +$QEMU_IO -c "write -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io | _filter_testdir
> +$QEMU_IMG convert -c -O qcow2 -o cluster_size=2M "$TEST_IMG".1 "$TEST_IMG"

Is it worth a $QEMU_IO -c "read -v 0x800000 16" so that our .out file 
validates that we indeed see the values we expect (if some other qcow2 
change causes us to stick the L2 table at a different offset, the 
verbose read will make it a bit more obvious why this test starts 
failing).  But that's an extra layer of paranoia, I'm fairly confident 
this test would start failing even without that extra read, so it's not 
a reason for a respin.

> +
> +# Reduce size of compressed data to 4 sectors: this corrupts the image.
> +poke_file "$TEST_IMG" $((0x800000)) "\x40\x06"
> +$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +# 'qemu-img check' however doesn't see anything wrong because it
> +# doesn't try to decompress the data and the refcounts are consistent.
> +# TODO: update qemu-img so this can be detected
> +_check_test_img
> +
> +# Increase size of compressed data to the maximum (8192 sectors).
> +# This makes QEMU read more data (8192 sectors instead of 5, host
> +# addresses [0xa00000, 0xdfffff]), but the decompression algorithm
> +# stops once we have enough to restore the uncompressed cluster, so
> +# the rest of the data is ignored.
> +poke_file "$TEST_IMG" $((0x800000)) "\x7f\xfe"
> +# Do it also for the second compressed cluster (L2 entry at 0x800008).
> +# In this case the compressed data would span 3 host clusters
> +# (host addresses: [0xa00802, 0xe00801])
> +poke_file "$TEST_IMG" $((0x800008)) "\x7f\xfe"
> +
> +# Here the image is too small so we're asking QEMU to read beyond the
> +# end of the image.
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +# But if we grow the image we won't be reading beyond its end anymore.
> +$QEMU_IO -c "write -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +# The refcount data is however wrong because due to the increased size
> +# of the compressed data it now reaches the following host clusters.
> +# This can be repaired by qemu-img check.
> +_check_test_img -r all
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +$QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir

Looks good.  Thanks for adding this in v3.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
