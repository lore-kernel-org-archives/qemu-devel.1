Received: from eggs.gnu.org ([2001:4830:134:3::10]:34004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaC-0002gF-3T
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIaB-0004lt-4O
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIaB-0004lB-0f
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBF1481A88AD
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:27:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Apr 2018 13:27:03 +0200
Message-Id: <20180425112723.1111-2-quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com>
References: <20180425112723.1111-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v12 01/21] migration: Set error state in case
 of error
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0e90efa092..2ae560ea80 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -415,10 +415,20 @@ struct {
     int count;
 } *multifd_send_state;
 
-static void terminate_multifd_send_threads(Error *errp)
+static void terminate_multifd_send_threads(Error *err)
 {
     int i;
 
+    if (err) {
+        MigrationState *s = migrate_get_current();
+        migrate_set_error(s, err);
+        if (s->state == MIGRATION_STATUS_SETUP ||
+            s->state == MIGRATION_STATUS_ACTIVE) {
+            migrate_set_state(&s->state, s->state,
+                              MIGRATION_STATUS_FAILED);
+        }
+    }
+
     for (i = 0; i < multifd_send_state->count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -515,10 +525,20 @@ struct {
     int count;
 } *multifd_recv_state;
 
-static void terminate_multifd_recv_threads(Error *errp)
+static void terminate_multifd_recv_threads(Error *err)
 {
     int i;
 
+    if (err) {
+        MigrationState *s = migrate_get_current();
+        migrate_set_error(s, err);
+        if (s->state == MIGRATION_STATUS_SETUP ||
+            s->state == MIGRATION_STATUS_ACTIVE) {
+            migrate_set_state(&s->state, s->state,
+                              MIGRATION_STATUS_FAILED);
+        }
+    }
+
     for (i = 0; i < multifd_recv_state->count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-- 
2.17.0
