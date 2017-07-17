Received: from eggs.gnu.org ([2001:4830:134:3::10]:42400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1N-0000NZ-Om
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1M-0004Vn-6m
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1L-0004Va-WD
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:11 +0800
Message-Id: <20170717034825.1524-2-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] qcow2: call CoQueue APIs under CoMutex
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
Message-Id: <20170629132749.997-2-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c144ea5..d5790af 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2025,8 +2025,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
     ret = 0;
 
 fail:
-    qemu_co_mutex_unlock(&s->lock);
-
     while (l2meta != NULL) {
         QCowL2Meta *next;
 
@@ -2040,6 +2038,8 @@ fail:
         l2meta = next;
     }
 
+    qemu_co_mutex_unlock(&s->lock);
+
     qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
-- 
2.9.4
