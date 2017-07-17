Received: from eggs.gnu.org ([2001:4830:134:3::10]:60917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1NH-0007G6-Rx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1NG-0002NB-Ox
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1NG-0002MQ-FO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:27:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6500D356CD
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:27:25 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:09 +0800
Message-Id: <1500279971-13875-10-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-1-git-send-email-peterx@redhat.com>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/11] migration: provide
 migrate_caps_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Abstract helper function to check migration capabilities (from the old
qmp_migrate_set_capabilities).  Prepare to be used somewhere else.

There is side effect on the change: when applying the capabilities, we
were skipping the invalid ones, but still applying the valid ones (if
they are provided in the same QMP request). After this refactoring,
we'll ignore all the capabilities if we detected invalid setup along the
way. However, I don't think it is a problem since general users should
not provide anything invalid after all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 79 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 26 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index eb750c5..52db5e7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -579,43 +579,49 @@ MigrationInfo *qmp_query_migrate(Error **errp)
     return info;
 }
 
-void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
-                                  Error **errp)
+/**
+ * @migration_caps_check - check capability validity
+ *
+ * @cap_list: old capability list, array of bool
+ * @params: new capabilities to be applied soon
+ * @errp: set *errp if the check failed, with reason
+ *
+ * Returns true if check passed, otherwise false.
+ */
+static bool migrate_caps_check(bool *cap_list,
+                               MigrationCapabilityStatusList *params,
+                               Error **errp)
 {
-    MigrationState *s = migrate_get_current();
     MigrationCapabilityStatusList *cap;
-    bool old_postcopy_cap = migrate_postcopy_ram();
+    bool old_postcopy_cap;
 
-    if (migration_is_setup_or_active(s->state)) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
-        return;
-    }
+    old_postcopy_cap = cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM];
 
     for (cap = params; cap; cap = cap->next) {
+        cap_list[cap->value->capability] = cap->value->state;
+    }
+
 #ifndef CONFIG_LIVE_BLOCK_MIGRATION
-        if (cap->value->capability == MIGRATION_CAPABILITY_BLOCK
-            && cap->value->state) {
-            error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
-                       "block migration");
-            error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
-            continue;
-        }
-#endif
-        s->enabled_capabilities[cap->value->capability] = cap->value->state;
+    if (cap_list[MIGRATION_CAPABILITY_BLOCK]) {
+        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
+                   "block migration");
+        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+        return false;
     }
+#endif
 
-    if (migrate_postcopy_ram()) {
-        if (migrate_use_compression()) {
+    if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+        if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
             /* The decompression threads asynchronously write into RAM
              * rather than use the atomic copies needed to avoid
              * userfaulting.  It should be possible to fix the decompression
              * threads for compatibility in future.
              */
-            error_report("Postcopy is not currently compatible with "
-                         "compression");
-            s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_RAM] =
-                false;
+            error_setg(errp, "Postcopy is not currently compatible "
+                       "with compression");
+            return false;
         }
+
         /* This check is reasonably expensive, so only when it's being
          * set the first time, also it's only the destination that needs
          * special support.
@@ -625,11 +631,32 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
             /* postcopy_ram_supported_by_host will have emitted a more
              * detailed message
              */
-            error_report("Postcopy is not supported");
-            s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_RAM] =
-                false;
+            error_setg(errp, "Postcopy is not supported");
+            return false;
         }
     }
+
+    return true;
+}
+
+void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
+                                  Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    MigrationCapabilityStatusList *cap;
+
+    if (migration_is_setup_or_active(s->state)) {
+        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        return;
+    }
+
+    if (!migrate_caps_check(s->enabled_capabilities, params, errp)) {
+        return;
+    }
+
+    for (cap = params; cap; cap = cap->next) {
+        s->enabled_capabilities[cap->value->capability] = cap->value->state;
+    }
 }
 
 /*
-- 
2.7.4
