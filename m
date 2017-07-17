Received: from eggs.gnu.org ([2001:4830:134:3::10]:42485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1X-0000k4-9G
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1U-0004Zx-7S
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1U-0004Z9-1B
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:15 +0800
Message-Id: <20170717034825.1524-6-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] vvfat: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170629132749.997-6-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/vvfat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 4fd28e1..4dae790 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3078,8 +3078,14 @@ static int coroutine_fn
 write_target_commit(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
+    int ret;
+
     BDRVVVFATState* s = *((BDRVVVFATState**) bs->opaque);
-    return try_commit(s);
+    qemu_co_mutex_lock(&s->lock);
+    ret = try_commit(s);
+    qemu_co_mutex_unlock(&s->lock);
+
+    return ret;
 }
 
 static void write_target_close(BlockDriverState *bs) {
-- 
2.9.4
