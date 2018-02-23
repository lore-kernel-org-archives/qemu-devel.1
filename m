Received: from eggs.gnu.org ([2001:4830:134:3::10]:36412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epDQu-0001U6-QA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epDQo-0005sy-Kf
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:30:40 -0500
References: <20180223125047.343-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05a3cab8-d5a0-e63f-3ba5-3b29e6e19e9e@redhat.com>
Date: Fri, 23 Feb 2018 07:30:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180223125047.343-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Test abnormally large size in
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

On 02/23/2018 06:50 AM, Alberto Garcia wrote:
> L2 entries for compressed clusters have a field that indicates the
> number of sectors used to store the data in the image.
> 
> That's however not the size of the compressed data itself, just the
> number of sectors where that data is located. The actual data size is
> usually not a multiple of the sector size, and therefore cannot be
> represented with this field.
> 

> 
> Another effect of increasing the size field is that it can make it
> include data from the following host cluster. In this case 'qemu-img
> check' will detect that the refcounts are not correct, and we'll need
> to rebuild them.

Indeed, tweaking sizes (can) affect refcount computations.

> 
> Additionally, this patch also tests that decreasing the size corrupts
> the image since the original data can no longer be recovered. In this
> case QEMU returns an error when trying to read the compressed data,
> but 'qemu-img check' doesn't see anything wrong if the refcounts are
> consistent.
> 
> One possible task for the future is to make 'qemu-img check' verify
> the sizes of the compressed clusters, by trying to decompress the data
> and checking that the size stored in the L2 entry is correct.

Indeed, but that means...


> +
> +# Reduce size of compressed data to 4 sectors: this corrupts the image.
> +poke_file "$TEST_IMG" $((0x800000)) "\x40\x06"
> +$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +# 'qemu-img check' however doesn't see anything wrong because it
> +# doesn't try to decompress the data and the refcounts are consistent.
> +_check_test_img

...this spot should have a TODO comment that mentions the test needs 
updating if qemu-img check is taught to be pickier.

> +
> +# Increase size of compressed data to the maximum (8192 sectors).
> +# This makes QEMU read more data (8192 sectors instead of 5), but the
> +# decompression algorithm stops once we have enough to restore the
> +# uncompressed cluster, so the rest of the data is ignored.
> +poke_file "$TEST_IMG" $((0x800000)) "\x7f\xfe"
> +
> +# Here the image is too small so we're asking QEMU to read beyond the
> +# end of the image.
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +# But if we grow the image we won't be reading beyond its end anymore.
> +$QEMU_IO -c "write -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +# The refcount data is however wrong because due to the increased size
> +# of the compressed data it now reaches the following host cluster.
> +# This can be repaired by qemu-img check.
> +_check_test_img -r all
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
> +$QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir

Thanks - this indeed tests more scenarios than v1.

With the TODO comment added,
Reviewed-by: Eric Blake <eblake@redhat.com>

Hmm - I also wonder - does our refcount code properly account for a 
compressed cluster that would affect the refcount of THREE clusters? 
Remember, qemu will never emit a compressed cluster that touches more 
than two clusters, but when you enlarge the size, if offset part of the 
link was already in the tail of one cluster, then you can bleed over 
into not just one, but two additional host clusters.  Your test didn't 
cover that, because it uses a compressed cluster that maps to the start 
of the host cluster.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
