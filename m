Received: from eggs.gnu.org ([2001:4830:134:3::10]:49165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elGa1-0008AL-RB
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elGZz-0001WT-Ld
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:03:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elGZz-0001Vs-IG
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:03:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DDB94084FE8
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 16:03:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Feb 2018 16:03:39 +0000
Message-Id: <20180212160340.15333-2-dgilbert@redhat.com>
In-Reply-To: <20180212160340.15333-1-dgilbert@redhat.com>
References: <20180212160340.15333-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: Fix early failure cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Avoid crash in cleanup after a very early migration failure
(possibly due to my 688a3dcba980bf01344a  'Route errors down ...')

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8333d8e35e..7095c1040e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1602,11 +1602,13 @@ static void xbzrle_load_cleanup(void)
 
 static void ram_state_cleanup(RAMState **rsp)
 {
-    migration_page_queue_free(*rsp);
-    qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
-    qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
-    g_free(*rsp);
-    *rsp = NULL;
+    if (*rsp) {
+        migration_page_queue_free(*rsp);
+        qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
+        qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
+        g_free(*rsp);
+        *rsp = NULL;
+    }
 }
 
 static void xbzrle_cleanup(void)
-- 
2.14.3
