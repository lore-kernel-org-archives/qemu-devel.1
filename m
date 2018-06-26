Received: from eggs.gnu.org ([2001:4830:134:3::10]:46177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXiGy-00036N-Ks
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXiGt-000651-Ks
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:20:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fXiGt-00064R-F2
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:20:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A9A083207
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:20:14 +0000 (UTC)
References: <20180626060941.8326-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a5d044c3-a7c9-73c4-ab78-75ccc814518f@redhat.com>
Date: Tue, 26 Jun 2018 09:20:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180626060941.8326-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vga: set owner for mmio regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 26.06.2018 08:09, Gerd Hoffmann wrote:
> This makes sure the regions are properly cleaned when unplugging -device
> seconday-vga.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga_int.h    |  1 +
>  hw/display/vga-pci.c    | 11 ++++++-----
>  hw/display/virtio-vga.c |  2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)

Thanks, this fixes the issue indeed! Without this patch:

$ valgrind mips-softmmu/qemu-system-mips -accel qtest -monitor stdio
[...]
(qemu) device_add secondary-vga
Unsupported bus. Bus doesn't have property 'acpi-pcihp-bsel' set
(qemu) dump-guest-memory /dev/null 0 4096
==8407== Invalid read of size 8
==8407==    at 0x6B0DA5: object_dynamic_cast (object.c:613)
==8407==    by 0x6B0DA5: object_resolve_abs_path (object.c:1721)
==8407==    by 0x6B0E00: object_resolve_partial_path (object.c:1745)
==8407==    by 0x6B0E62: object_resolve_partial_path (object.c:1755)
[...]

With this patch applied, the problem is gone.

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
