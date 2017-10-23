Received: from eggs.gnu.org ([2001:4830:134:3::10]:35868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHO-0005mb-Sw
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHN-0000Li-Ug
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHN-0000Kb-O4
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E35438048C
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:53 +0200
Message-Id: <20171023160800.20540-15-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 14/21] migration: provide ram_state_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

There are two Mutexes that are created but not yet destroyed for
RAMState.  Fix that.

Since we are at it, provide helper function to clean up RAMState.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 13f4b3d101..d91e8787ae 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1576,6 +1576,15 @@ static void xbzrle_load_cleanup(void)
     XBZRLE.decoded_buf = NULL;
 }
 
+static void ram_state_cleanup(RAMState **rsp)
+{
+    migration_page_queue_free(*rsp);
+    qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
+    qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
+    g_free(*rsp);
+    *rsp = NULL;
+}
+
 static void ram_save_cleanup(void *opaque)
 {
     RAMState **rsp = opaque;
@@ -1605,10 +1614,8 @@ static void ram_save_cleanup(void *opaque)
         XBZRLE.zero_target_page = NULL;
     }
     XBZRLE_cache_unlock();
-    migration_page_queue_free(*rsp);
     compress_threads_save_cleanup();
-    g_free(*rsp);
-    *rsp = NULL;
+    ram_state_cleanup(rsp);
 }
 
 static void ram_state_reset(RAMState *rs)
-- 
2.13.6
