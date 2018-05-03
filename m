Received: from eggs.gnu.org ([2001:4830:134:3::10]:39075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fE9GT-0005T3-90
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fE9GQ-00050z-2V
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:06:57 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fE9GP-00050B-Pa
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:06:53 -0400
Received: by mail-pg0-x242.google.com with SMTP id m21-v6so12562235pgv.8
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 01:06:53 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu,  3 May 2018 16:06:11 +0800
Message-Id: <20180503080611.23834-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

QEMU 2.13 enables strict check for compression & decompression to
make the migration more robust, that depends on the source to fix
the internal design which triggers the unexpected error conditions

To make it work for migrating old version QEMU to 2.13 QEMU, we
introduce this parameter to disable the error check on the
destination which is the default behavior of the machine type
which is older than 2.13, alternately, the strict check can be
enabled explicitly as followings:
      -M pc-q35-2.11 -global migration.decompress-error-check=true

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hw/arm/virt.c              | 4 ++++
 hw/i386/pc_piix.c          | 1 +
 hw/i386/pc_q35.c           | 1 +
 hw/s390x/s390-virtio-ccw.c | 4 ++++
 include/hw/compat.h        | 7 ++++++-
 include/hw/i386/pc.h       | 3 +++
 migration/migration.c      | 4 ++++
 migration/migration.h      | 7 +++++++
 migration/ram.c            | 2 +-
 9 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a18291c5d5b..dd926aae23e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1574,6 +1574,9 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+#define VIRT_COMPAT_2_12 \
+    HW_COMPAT_2_12
+
 static void virt_2_12_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -1636,6 +1639,7 @@ static void virt_2_12_instance_init(Object *obj)
 
 static void virt_machine_2_12_options(MachineClass *mc)
 {
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(2, 12)
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 729a0508aa5..3a6da8cf996 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -430,6 +430,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass *m)
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
 DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9ae916327e7..1a0091fb287 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -312,6 +312,7 @@ static void pc_q35_2_12_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
 DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 435f7c99e77..b0b9456896e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -671,6 +671,9 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_2_12 \
+        HW_COMPAT_2_12
+
 #define CCW_COMPAT_2_11 \
         HW_COMPAT_2_11 \
         {\
@@ -762,6 +765,7 @@ static void ccw_machine_2_12_instance_options(MachineState *machine)
 
 static void ccw_machine_2_12_class_options(MachineClass *mc)
 {
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_12);
 }
 DEFINE_CCW_MACHINE(2_12, "2.12", true);
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 4681c2719a4..563908b874c 100644
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
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ffee8413f06..bebfed65519 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -305,6 +305,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_12 \
+    HW_COMPAT_2_12
+
 #define PC_COMPAT_2_11 \
     HW_COMPAT_2_11 \
     {\
diff --git a/migration/migration.c b/migration/migration.c
index 0bdb28e144c..3f5e622d3b0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2525,6 +2525,8 @@ void migration_global_dump(Monitor *mon)
                    ms->send_configuration ? "on" : "off");
     monitor_printf(mon, "send-section-footer: %s\n",
                    ms->send_section_footer ? "on" : "off");
+    monitor_printf(mon, "decompress-error-check: %s\n",
+                   ms->decompress_error_check ? "on" : "off");
 }
 
 #define DEFINE_PROP_MIG_CAP(name, x)             \
@@ -2538,6 +2540,8 @@ static Property migration_properties[] = {
                      send_configuration, true),
     DEFINE_PROP_BOOL("send-section-footer", MigrationState,
                      send_section_footer, true),
+    DEFINE_PROP_BOOL("decompress-error-check", MigrationState,
+                      decompress_error_check, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-compress-level", MigrationState,
diff --git a/migration/migration.h b/migration/migration.h
index 7c69598c54a..0ab293cd2fa 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -194,6 +194,13 @@ struct MigrationState
     bool send_configuration;
     /* Whether we send section footer during migration */
     bool send_section_footer;
+    /*
+     * Whether we abort the migration if decompression errors are
+     * detected at the destination. It is left at false for qemu
+     * older than 2.13, since only newer qemu sends streams that
+     * do not trigger spurious decompression errors.
+     */
+    bool decompress_error_check;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/ram.c b/migration/ram.c
index 912810c18e0..34d2369c379 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2581,7 +2581,7 @@ static void *do_data_decompress(void *opaque)
 
             ret = qemu_uncompress_data(&param->stream, des, pagesize,
                                        param->compbuf, len);
-            if (ret < 0) {
+            if (ret < 0 && migrate_get_current()->decompress_error_check) {
                 error_report("decompress data failed");
                 qemu_file_set_error(decomp_file, ret);
             }
-- 
2.14.3
