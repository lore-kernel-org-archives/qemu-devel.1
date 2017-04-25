Received: from eggs.gnu.org ([2001:4830:134:3::10]:55753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38b6-0007mN-58
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38b3-0006AY-QJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38b3-00069c-Gb
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 887C623E6D4
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:06:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:46 +0200
Message-Id: <20170425220451.6028-37-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 36/41] migration: Move more exported functions
 to migration/misc.h
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
 hw/i386/pc_piix.c             | 2 +-
 hw/ppc/spapr.c                | 2 +-
 include/migration/migration.h | 6 ------
 include/migration/misc.h      | 6 ++++++
 migration/migration.c         | 1 +
 qdev-monitor.c                | 2 +-
 vl.c                          | 1 -
 xen-common.c                  | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6c72bd3..d68859e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -53,7 +53,7 @@
 #include "hw/xen/xen_pt.h"
 #endif
 #include "migration/global_state.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "kvm_i386.h"
 
 #define MAX_IDE_BUS 2
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f779c35..74cea96 100644
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
diff --git a/include/migration/migration.h b/include/migration/migration.h
index fc31f8e..1e18b24 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -127,8 +127,6 @@ void migrate_set_state(int *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 
-void qemu_start_incoming_migration(const char *uri, Error **errp);
-
 uint64_t migrate_max_downtime(void);
 
 void migrate_fd_error(MigrationState *s, const Error *error);
@@ -140,7 +138,6 @@ void remove_migration_state_change_notifier(Notifier *notify);
 MigrationState *migrate_init(void);
 bool migration_is_blocked(Error **errp);
 bool migration_in_setup(MigrationState *);
-bool migration_is_idle(void);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* True if outgoing migration has entered postcopy phase */
@@ -176,7 +173,4 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
 void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 
-void savevm_skip_section_footers(void);
-void savevm_skip_configuration(void);
-
 #endif
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 21a9182..6709b15 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -35,5 +35,11 @@ int64_t self_announce_delay(int round)
 /* migration/savevm.c */
 
 void dump_vmstate_json_to_file(FILE *out_fp);
+void savevm_skip_section_footers(void);
+void savevm_skip_configuration(void);
+
+/* migration/migration.c */
+void qemu_start_incoming_migration(const char *uri, Error **errp);
+bool migration_is_idle(void);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 4cda97c..287b762 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -24,6 +24,7 @@
 #include "ram.h"
 #include "rdma.h"
 #include "migration/global_state.h"
+#include "migration/misc.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
diff --git a/qdev-monitor.c b/qdev-monitor.c
index e61d596..5ab468f 100644
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
diff --git a/vl.c b/vl.c
index c0796e4..d506c7e 100644
--- a/vl.c
+++ b/vl.c
@@ -92,7 +92,6 @@ int main(int argc, char **argv)
 #include "sysemu/tpm.h"
 #include "sysemu/dma.h"
 #include "audio/audio.h"
-#include "migration/migration.h"
 #include "sysemu/cpus.h"
 #include "migration/colo.h"
 #include "sysemu/kvm.h"
diff --git a/xen-common.c b/xen-common.c
index 172131a..2daf2aa 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -13,7 +13,7 @@
 #include "qmp-commands.h"
 #include "sysemu/char.h"
 #include "sysemu/accel.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "migration/global_state.h"
 
 //#define DEBUG_XEN
-- 
2.9.3
