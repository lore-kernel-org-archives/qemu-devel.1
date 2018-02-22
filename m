Received: from eggs.gnu.org ([2001:4830:134:3::10]:57986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eow6Y-0006Ia-Cq
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eow6X-0007qm-HU
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:00:30 -0500
References: <20180222161811.26200-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea7725b4-a06a-0be0-4fc2-80cfa4359489@redhat.com>
Date: Thu, 22 Feb 2018 13:00:08 -0600
MIME-Version: 1.0
In-Reply-To: <20180222161811.26200-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Test abnormally large size in
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

On 02/22/2018 10:18 AM, Alberto Garcia wrote:
> L2 entries for compressed clusters have a field that indicates the
> number of sectors used to store the data in the image.
> 
> That's however not the size of the compressed data itself, just the
> number of sectors where that data is located. The actual data size is
> usually not a multiple of the sector size, and therefore cannot be
> represented with this field.
> 
> The way it works is that QEMU reads all the specified sectors and
> starts decompressing the data until there's enough to recover the
> original uncompressed cluster. If there are any bytes left that
> haven't been decompressed they are simply ignored.
> 
> One consequence of this is that even if the size field is larger than
> it needs to be QEMU can handle it just fine: it will read more data
> from disk but it will ignore the extra bytes.

(is that true even for the corner case when the size field points beyond 
the end of the image?  But not important to the meat of the patch)

> 
> This test creates an image with a compressed cluster that uses 5
> sectors (2.5 KB), increases the size field to the maximum (8192
> sectors, or 4 MB) and verifies that the data can be read without
> problems.
> 
> This test is important because while the decompressed data takes
> exactly one cluster, the maximum value allowed in the compressed size
> field is twice the cluster size. So although QEMU won't produce images
> with such large values we need to make sure that it can handle them.
> 
> Aditionally, this patch also tests that decreasing the size corrupts

s/Aditionally/Additionally/

> the image since the original data can no longer be recovered.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   tests/qemu-iotests/122     | 22 ++++++++++++++++++++++
>   tests/qemu-iotests/122.out |  9 +++++++++
>   2 files changed, 31 insertions(+)
> 

> +
> +# Reduce size of compressed data to 4 sectors: this corrupts the image
> +poke_file "$TEST_IMG".1 $((0x800000)) "\x40\x06"
> +$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io | _filter_testdir
> +

Should we run 'qemu-img check' at this point, to see if that likewise 
diagnoses the image as broken?  (And if it doesn't, should it be able to?)

> +# Increase size of compressed data to the maximum (8192 sectors)
> +# This makes QEMU read more data (8192 sectors instead of 5), but the
> +# decompression algorithm stops once we have enough to restore the
> +# uncompressed cluster, so the rest of the data is ignored
> +poke_file "$TEST_IMG".1 $((0x800000)) "\x7f\xfe"
> +$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io | _filter_testdir
> +

But what you added is a strict improvement, so
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
