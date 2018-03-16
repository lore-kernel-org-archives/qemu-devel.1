Received: from eggs.gnu.org ([2001:4830:134:3::10]:59061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwE-0006ds-6t
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ewnwA-0002Wb-59
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ewnwA-0002W9-15
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4D204023156
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:54:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 16 Mar 2018 12:53:49 +0100
Message-Id: <20180316115403.4148-2-quintela@redhat.com>
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v11 01/15] migration: Set error state in case
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
 migration/ram.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 7266351fd0..1b8095a358 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -414,6 +414,16 @@ static void terminate_multifd_send_threads(Error *errp)
 {
     int i;
 
+    if (errp) {
+        MigrationState *s = migrate_get_current();
+        migrate_set_error(s, errp);
+        if (s->state == MIGRATION_STATUS_SETUP ||
+            s->state == MIGRATION_STATUS_ACTIVE) {
+            migrate_set_state(&s->state, s->state,
+                              MIGRATION_STATUS_FAILED);
+        }
+    }
+
     for (i = 0; i < multifd_send_state->count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -514,6 +524,16 @@ static void terminate_multifd_recv_threads(Error *errp)
 {
     int i;
 
+    if (errp) {
+        MigrationState *s = migrate_get_current();
+        migrate_set_error(s, errp);
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
2.14.3
