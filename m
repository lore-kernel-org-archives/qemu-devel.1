Received: from eggs.gnu.org ([2001:4830:134:3::10]:59418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUdY-0000Ea-LQ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUdX-0006Eq-BX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXUdX-0006Dn-2N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B1B97C849
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:42:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 18 Jul 2017 17:41:25 +0200
Message-Id: <20170718154127.6459-15-quintela@redhat.com>
In-Reply-To: <20170718154127.6459-1-quintela@redhat.com>
References: <20170718154127.6459-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 14/16] migration: provide migrate_caps_check()
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

Abstract helper function to check migration capabilities (from the old
qmp_migrate_set_capabilities).  Prepare to be used somewhere else.

There is side effect on the change: when applying the capabilities, we
were skipping the invalid ones, but still applying the valid ones (if
they are provided in the same QMP request). After this refactoring,
we'll ignore all the capabilities if we detected invalid setup along the
way. However, I don't think it is a problem since general users should
not provide anything invalid after all.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1500349150-13240-9-git-send-email-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 79 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 26 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 915c8cc..74099b3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -588,43 +588,49 @@ MigrationInfo *qmp_query_migrate(Error **errp)
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
+    if (cap_list[MIGRATION_CAPABILITY_BLOCK]) {
+        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
+                   "block migration");
+        error_append_hint(errp, "Use drive_mirror+NBD instead.\n");
+        return false;
+    }
 #endif
-        s->enabled_capabilities[cap->value->capability] = cap->value->state;
-    }
 
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
@@ -634,11 +640,32 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
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
2.9.4
