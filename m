Received: from eggs.gnu.org ([2001:4830:134:3::10]:60510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXfR-0008TT-4Z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXfO-00088L-AD
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGXfO-00087W-27
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FEEE3DBE3
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 21:30:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 23:29:19 +0200
Message-Id: <20170601212921.30241-10-quintela@redhat.com>
In-Reply-To: <20170601212921.30241-1-quintela@redhat.com>
References: <20170601212921.30241-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] migration: Move remaining exported
 functions to migration/misc.h
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
 hw/i386/pc_piix.c             |  2 +-
 hw/ppc/spapr.c                |  2 +-
 hw/xen/xen-common.c           |  2 +-
 include/migration/migration.h | 13 -------------
 include/migration/misc.h      | 12 ++++++++++++
 migration/migration.c         |  1 +
 qdev-monitor.c                |  2 +-
 ui/spice-core.c               |  2 +-
 vl.c                          |  1 -
 9 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc19d96..46a2bc4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -53,7 +53,7 @@
 #include "hw/xen/xen_pt.h"
 #endif
 #include "migration/global_state.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "kvm_i386.h"
 #include "sysemu/numa.h"
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ac8a317..0aadde6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -38,7 +38,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "migration/global_state.h"
 #include "migration/register.h"
 #include "mmu-hash64.h"
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index e265445..19ad79c 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -13,7 +13,7 @@
 #include "qmp-commands.h"
 #include "sysemu/char.h"
 #include "sysemu/accel.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "migration/global_state.h"
 
 //#define DEBUG_XEN
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5050454..601e4ab 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -122,26 +122,16 @@ void migrate_set_state(int *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 
-void qemu_start_incoming_migration(const char *uri, Error **errp);
-
 uint64_t migrate_max_downtime(void);
 
 void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s);
 
-void add_migration_state_change_notifier(Notifier *notify);
-void remove_migration_state_change_notifier(Notifier *notify);
 MigrationState *migrate_init(void);
 bool migration_is_blocked(Error **errp);
-bool migration_in_setup(MigrationState *);
-bool migration_is_idle(void);
-bool migration_has_finished(MigrationState *);
-bool migration_has_failed(MigrationState *);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
-/* ...and after the device transmission */
-bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);
 
 bool migrate_release_ram(void);
@@ -171,7 +161,4 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
 void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 
-void savevm_skip_section_footers(void);
-void savevm_skip_configuration(void);
-
 #endif
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 026b561..d5a433a 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -39,5 +39,17 @@ int64_t self_announce_delay(int round)
 /* migration/savevm.c */
 
 void dump_vmstate_json_to_file(FILE *out_fp);
+void savevm_skip_section_footers(void);
+void savevm_skip_configuration(void);
 
+/* migration/migration.c */
+void qemu_start_incoming_migration(const char *uri, Error **errp);
+bool migration_is_idle(void);
+void add_migration_state_change_notifier(Notifier *notify);
+void remove_migration_state_change_notifier(Notifier *notify);
+bool migration_in_setup(MigrationState *);
+bool migration_has_finished(MigrationState *);
+bool migration_has_failed(MigrationState *);
+/* ...and after the device transmission */
+bool migration_in_postcopy_after_devices(MigrationState *);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 6a7620b..b6c0cfd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -24,6 +24,7 @@
 #include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
+#include "migration/misc.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 3ecbf0b..8fd6df9 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "sysemu/block-backend.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 804abc5..a087ad5 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -35,7 +35,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/notify.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "hw/hw.h"
 #include "ui/spice-display.h"
 #include "qapi-event.h"
diff --git a/vl.c b/vl.c
index bf9aa6a..d442e42 100644
--- a/vl.c
+++ b/vl.c
@@ -93,7 +93,6 @@ int main(int argc, char **argv)
 #include "sysemu/dma.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
-#include "migration/migration.h"
 #include "sysemu/cpus.h"
 #include "migration/colo.h"
 #include "sysemu/kvm.h"
-- 
2.9.4
