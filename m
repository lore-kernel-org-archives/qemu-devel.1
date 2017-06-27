Received: from eggs.gnu.org ([2001:4830:134:3::10]:48684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPhqA-0001H4-Co
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPhq9-0002Zy-4H
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:11:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPhq8-0002Zu-SO
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:11:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02AA580F99
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 04:11:00 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 27 Jun 2017 12:10:18 +0800
Message-Id: <1498536619-14548-10-git-send-email-peterx@redhat.com>
In-Reply-To: <1498536619-14548-1-git-send-email-peterx@redhat.com>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 09/10] migration: merge
 enforce_config_section somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

These two parameters:

- MachineState::enforce_config_section
- MigrationState::send_configuration

are playing similar role here. This patch merges the first one into
second, then we'll have a single place to reference whether we need to
send the configuration section.

I didn't remove the MachineState.enforce_config_section field since when
applying that machine property (in machine_set_property()) we haven't
yet initialized global properties and migration object. Then, it's
still not easy to pass that boolean to MigrationState at such an early
time.

A natural benefit for current patch is that now we kept the meaning of
"enforce-config-section" since it'll still have the highest
priority (that's what "enforce" mean I guess).

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 12 ++++++++++++
 migration/savevm.c    | 12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 96c6412..e7e6cf3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -42,6 +42,7 @@
 #include "exec/target_page.h"
 #include "io/channel-buffer.h"
 #include "migration/colo.h"
+#include "hw/boards.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
@@ -102,9 +103,20 @@ static MigrationState *current_migration;
 
 void migration_object_init(void)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+
     /* This can only be called once. */
     assert(!current_migration);
     current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
+
+    /*
+     * We cannot really do this in migration_instance_init() since at
+     * that time global properties are not yet applied, then this
+     * value will be definitely replaced by something else.
+     */
+    if (ms->enforce_config_section) {
+        current_migration->send_configuration = true;
+    }
 }
 
 /* For outgoing */
diff --git a/migration/savevm.c b/migration/savevm.c
index 7b39fb9..be3f885 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -943,20 +943,13 @@ bool qemu_savevm_state_blocked(Error **errp)
     return false;
 }
 
-static bool enforce_config_section(void)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    return machine->enforce_config_section;
-}
-
 void qemu_savevm_state_header(QEMUFile *f)
 {
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
 
-    if (migrate_get_current()->send_configuration ||
-        enforce_config_section()) {
+    if (migrate_get_current()->send_configuration) {
         qemu_put_byte(f, QEMU_VM_CONFIGURATION);
         vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
     }
@@ -1980,8 +1973,7 @@ int qemu_loadvm_state(QEMUFile *f)
         return -ENOTSUP;
     }
 
-    if (migrate_get_current()->send_configuration ||
-        enforce_config_section()) {
+    if (migrate_get_current()->send_configuration) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
             return -EINVAL;
-- 
2.7.4
