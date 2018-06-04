Received: from eggs.gnu.org ([2001:4830:134:3::10]:47458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0U-0004QA-TH
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0S-00074Y-Uv
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPh0S-00074Q-Q5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:08 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  4 Jun 2018 06:21:52 +0200
Message-Id: <20180604042156.13812-2-quintela@redhat.com>
In-Reply-To: <20180604042156.13812-1-quintela@redhat.com>
References: <20180604042156.13812-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

QEMU 3.0 enables strict check for compression & decompression to
make the migration more robust, that depends on the source to fix
the internal design which triggers the unexpected error conditions

To make it work for migrating old version QEMU to 2.13 QEMU, we
introduce this parameter to disable the error check on the
destination which is the default behavior of the machine type
which is older than 2.13, alternately, the strict check can be
enabled explicitly as followings:
      -M pc-q35-2.11 -global migration.decompress-error-check=true

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/arm/virt.c         | 4 ++++
 hw/i386/pc_piix.c     | 1 +
 hw/i386/pc_q35.c      | 1 +
 include/hw/compat.h   | 7 ++++++-
 migration/migration.c | 4 ++++
 migration/migration.h | 7 +++++++
 migration/ram.c       | 2 +-
 7 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a3a28e20e8..b2a67a4c00 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1693,6 +1693,9 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+#define VIRT_COMPAT_2_12 \
+    HW_COMPAT_2_12
+
 static void virt_2_12_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -1763,6 +1766,7 @@ static void virt_2_12_instance_init(Object *obj)
 
 static void virt_machine_2_12_options(MachineClass *mc)
 {
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(2, 12)
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b4c5b03274..3d81136065 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -430,6 +430,7 @@ static void pc_i440fx_3_0_machine_options(MachineClass *m)
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
 DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 83d6d75efa..b60cbb9266 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -312,6 +312,7 @@ static void pc_q35_3_0_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
 DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 4681c2719a..563908b874 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,7 +1,12 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
-#define HW_COMPAT_2_12
+#define HW_COMPAT_2_12 \
+    {\
+        .driver   = "migration",\
+        .property = "decompress-error-check",\
+        .value    = "off",\
+    },
 
 #define HW_COMPAT_2_11 \
     {\
diff --git a/migration/migration.c b/migration/migration.c
index 05aec2c905..a5384865ff 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2971,6 +2971,8 @@ void migration_global_dump(Monitor *mon)
                    ms->send_configuration ? "on" : "off");
     monitor_printf(mon, "send-section-footer: %s\n",
                    ms->send_section_footer ? "on" : "off");
+    monitor_printf(mon, "decompress-error-check: %s\n",
+                   ms->decompress_error_check ? "on" : "off");
 }
 
 #define DEFINE_PROP_MIG_CAP(name, x)             \
@@ -2984,6 +2986,8 @@ static Property migration_properties[] = {
                      send_configuration, true),
     DEFINE_PROP_BOOL("send-section-footer", MigrationState,
                      send_section_footer, true),
+    DEFINE_PROP_BOOL("decompress-error-check", MigrationState,
+                      decompress_error_check, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-compress-level", MigrationState,
diff --git a/migration/migration.h b/migration/migration.h
index 8f0c82159b..5af57d616c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -212,6 +212,13 @@ struct MigrationState
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
     QemuSemaphore postcopy_pause_rp_sem;
+    /*
+     * Whether we abort the migration if decompression errors are
+     * detected at the destination. It is left at false for qemu
+     * older than 3.0, since only newer qemu sends streams that
+     * do not trigger spurious decompression errors.
+     */
+    bool decompress_error_check;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/ram.c b/migration/ram.c
index c53e8369a3..090187ca04 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2881,7 +2881,7 @@ static void *do_data_decompress(void *opaque)
 
             ret = qemu_uncompress_data(&param->stream, des, pagesize,
                                        param->compbuf, len);
-            if (ret < 0) {
+            if (ret < 0 && migrate_get_current()->decompress_error_check) {
                 error_report("decompress data failed");
                 qemu_file_set_error(decomp_file, ret);
             }
-- 
2.17.0
