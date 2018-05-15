Received: from eggs.gnu.org ([2001:4830:134:3::10]:58073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYR-0002qW-FS
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYQ-0001gO-MZ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjYQ-0001gE-Ia
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22E8E40201A0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:40:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:39:41 +0200
Message-Id: <20180515234017.2277-5-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/40] migration: Set error state in case of
 error
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
 migration/ram.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index da0b567003..4d8be30676 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -448,10 +448,22 @@ struct {
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
+            s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
+            s->state == MIGRATION_STATUS_DEVICE ||
+            s->state == MIGRATION_STATUS_ACTIVE) {
+            migrate_set_state(&s->state, s->state,
+                              MIGRATION_STATUS_FAILED);
+        }
+    }
+
     for (i = 0; i < multifd_send_state->count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -548,10 +560,20 @@ struct {
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
