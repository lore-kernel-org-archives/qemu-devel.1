Received: from eggs.gnu.org ([2001:4830:134:3::10]:41300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VY-0008FM-Bp
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VX-0003mg-EH
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7VX-0003mc-8U
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:39:11 +0000
Message-Id: <20170116133911.21684-12-stefanha@redhat.com>
In-Reply-To: <20170116133911.21684-1-stefanha@redhat.com>
References: <20170116133911.21684-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] async: optimize aio_bh_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Avoid entering the slow path of qemu_lockcnt_dec_and_lock if
no bottom half has to be deleted.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170112180800.21085-11-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
