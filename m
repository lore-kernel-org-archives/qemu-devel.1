Received: from eggs.gnu.org ([2001:4830:134:3::10]:33342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMdto-0008P7-9U
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMdtn-0001fl-Cc
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:54:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  6 Dec 2017 17:54:14 +0000
Message-Id: <20171206175414.27666-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] block: avoid recursive AioContext acquire in
 bdrv_inactivate_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

BDRV_POLL_WHILE() does not support recursive AioContext locking.  It
only releases the AioContext lock once regardless of how many times the
caller has acquired it.  This results in a hang since the IOThread does
not make progress while the AioContext is still locked.

The following steps trigger the hang:

  $ qemu-system-x86_64 -M accel=kvm -m 1G -cpu host \
                       -object iothread,id=iothread0 \
                       -device virtio-scsi-pci,iothread=iothread0 \
                       -drive if=none,id=drive0,file=test.img,format=raw \
                       -device scsi-hd,drive=drive0 \
                       -drive if=none,id=drive1,file=test.img,format=raw \
                       -device scsi-hd,drive=drive1
  $ qemu-system-x86_64 ...same options... \
                       -incoming tcp::1234
  (qemu) migrate tcp:127.0.0.1:1234
  ...hang...

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 9a1a0d1e73..1c37ce4554 100644
--- a/block.c
+++ b/block.c
@@ -4320,9 +4320,15 @@ int bdrv_inactivate_all(void)
     BdrvNextIterator it;
     int ret = 0;
     int pass;
+    GSList *aio_ctxs = NULL, *ctx;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        aio_context_acquire(bdrv_get_aio_context(bs));
+        AioContext *aio_context = bdrv_get_aio_context(bs);
+
+        if (!g_slist_find(aio_ctxs, aio_context)) {
+            aio_ctxs = g_slist_prepend(aio_ctxs, aio_context);
+            aio_context_acquire(aio_context);
+        }
     }
 
     /* We do two passes of inactivation. The first pass calls to drivers'
@@ -4340,9 +4346,11 @@ int bdrv_inactivate_all(void)
     }
 
 out:
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        aio_context_release(bdrv_get_aio_context(bs));
+    for (ctx = aio_ctxs; ctx != NULL; ctx = ctx->next) {
+        AioContext *aio_context = ctx->data;
+        aio_context_release(aio_context);
     }
+    g_slist_free(aio_ctxs);
 
     return ret;
 }
-- 
2.14.3
