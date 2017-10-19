Received: from eggs.gnu.org ([2001:4830:134:3::10]:51733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NL-0000lS-20
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NK-0003DK-7m
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e54NK-0003Ct-1a
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 194424E919
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 06:32:13 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 19 Oct 2017 14:31:58 +0800
Message-Id: <20171019063200.19048-3-peterx@redhat.com>
In-Reply-To: <20171019063200.19048-1-peterx@redhat.com>
References: <20171019063200.19048-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] migration: provide ram_state_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

There are two Mutexes that are created but not yet destroyed for
RAMState.  Fix that.

Since we are at it, provide helper function to clean up RAMState.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fd8e14c59b..72c48e76e9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1566,6 +1566,15 @@ static void xbzrle_load_cleanup(void)
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
@@ -1595,10 +1604,8 @@ static void ram_save_cleanup(void *opaque)
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
2.13.5
