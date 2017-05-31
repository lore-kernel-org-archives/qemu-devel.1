Received: from eggs.gnu.org ([2001:4830:134:3::10]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dG0AG-0002R6-Bp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dG0AC-0001i2-Cs
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:40 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 May 2017 11:43:20 +0200
Message-Id: <20170531094330.1808-2-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-1-pbonzini@redhat.com>
References: <20170531094330.1808-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/11] qcow2: call CoQueue APIs under CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1c2697732b..c9193603b9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1696,8 +1696,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
     ret = 0;
 
 fail:
-    qemu_co_mutex_unlock(&s->lock);
-
     while (l2meta != NULL) {
         QCowL2Meta *next;
 
@@ -1711,6 +1709,8 @@ fail:
         l2meta = next;
     }
 
+    qemu_co_mutex_unlock(&s->lock);
+
     qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
-- 
2.13.0
