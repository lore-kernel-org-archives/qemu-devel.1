Received: from eggs.gnu.org ([209.51.188.92]:54154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Ap-0001dS-Tu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Ao-0008VL-D7
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:25:07 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 14 Jan 2019 16:24:04 +0200
Message-Id: <a9cbdb4058f3277c4132ac1ccbc5f3b131b688e7.1547475602.git.berto@igalia.com>
In-Reply-To: <cover.1547475602.git.berto@igalia.com>
References: <cover.1547475602.git.berto@igalia.com>
In-Reply-To: <cover.1547475602.git.berto@igalia.com>
References: <cover.1547475602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 6/6] block: Acquire the AioContext in
 usb_msd_storage_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/usb/dev-storage.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index cd5551d94f..fa6e552f0f 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -593,13 +593,18 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
     MSDState *s = USB_STORAGE_DEV(dev);
     BlockBackend *blk = s->conf.blk;
     SCSIDevice *scsi_dev;
+    AioContext *ctx;
 
     if (!blk) {
         error_setg(errp, "drive property not set");
         return;
     }
 
+    ctx = blk_get_aio_context(blk);
+    aio_context_acquire(ctx);
     blkconf_blocksizes(&s->conf);
+    aio_context_release(ctx);
+
     if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
                                        errp)) {
         return;
-- 
2.11.0
