Received: from eggs.gnu.org ([2001:4830:134:3::10]:48881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUG-0005kn-Ei
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUF-0001Nr-Ir
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:00 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Jun 2017 15:27:43 +0200
Message-Id: <20170629132749.997-6-pbonzini@redhat.com>
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
References: <20170629132749.997-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/11] vvfat: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/vvfat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 8ab647c0c6..d2679c2ff5 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2982,8 +2982,14 @@ static int coroutine_fn
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
2.13.0
