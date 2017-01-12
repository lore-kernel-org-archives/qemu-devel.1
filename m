Received: from eggs.gnu.org ([2001:4830:134:3::10]:44329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnO-0000FE-Pr
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnN-0005H3-Uc
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:18 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRjnN-0005Gq-Nr
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:17 -0500
Received: by mail-wm0-x242.google.com with SMTP id l2so5513501wml.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 10:08:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 19:08:00 +0100
Message-Id: <20170112180800.21085-11-pbonzini@redhat.com>
In-Reply-To: <20170112180800.21085-1-pbonzini@redhat.com>
References: <20170112180800.21085-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/10] async: optimize aio_bh_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

Avoid entering the slow path of qemu_lockcnt_dec_and_lock if
no bottom half has to be deleted.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 async.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/async.c b/async.c
index 2305e11..0d218ab 100644
--- a/async.c
+++ b/async.c
@@ -92,6 +92,7 @@ int aio_bh_poll(AioContext *ctx)
 {
     QEMUBH *bh, **bhp, *next;
     int ret;
+    bool deleted = false;
 
     qemu_lockcnt_inc(&ctx->list_lock);
 
@@ -112,9 +113,17 @@ int aio_bh_poll(AioContext *ctx)
             bh->idle = 0;
             aio_bh_call(bh);
         }
+        if (bh->deleted) {
+            deleted = true;
+        }
     }
 
     /* remove deleted bhs */
+    if (!deleted) {
+        qemu_lockcnt_dec(&ctx->list_lock);
+        return ret;
+    }
+
     if (qemu_lockcnt_dec_and_lock(&ctx->list_lock)) {
         bhp = &ctx->first_bh;
         while (*bhp) {
@@ -128,7 +137,6 @@ int aio_bh_poll(AioContext *ctx)
         }
         qemu_lockcnt_unlock(&ctx->list_lock);
     }
-
     return ret;
 }
 
-- 
2.9.3
