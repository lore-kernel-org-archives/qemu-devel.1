Received: from eggs.gnu.org ([2001:4830:134:3::10]:52684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fahak-0003xs-Kg
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fahah-0004ox-EW
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:13:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:39291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fahah-0004oN-4D
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:13:03 -0400
From: Jingqi Liu <jingqi.liu@intel.com>
Date: Wed,  4 Jul 2018 21:12:22 +0800
Message-Id: <1530709942-87947-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH] kvm: x86: Add support for -machine
 split-lock-ac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, wei.w.wang@intel.com, Jingqi Liu <jingqi.liu@intel.com>

Add the option split-lock-ac to control whether the #AC
exception is generated for split locked accesses, which
is introduced for the machine, there is an example to enable it:
-machine split-lock-ac=on
It is disabled on default.

When bit 29 of the MSR (33H) is set, the processor
causes an #AC exception to be issued instead of suppressing LOCK on
bus(during split lock access).

Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 accel/kvm/kvm-all.c       | 10 ++++++++++
 hw/core/machine.c         | 19 +++++++++++++++++++
 include/hw/boards.h       |  1 +
 linux-headers/linux/kvm.h |  1 +
 qemu-options.hx           |  3 +++
 5 files changed, 34 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index eb7db92..e960a4d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1699,6 +1699,16 @@ static int kvm_init(MachineState *ms)
 
     s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
 
+    if (ms->split_lock_ac &&
+        kvm_check_extension(s, KVM_CAP_X86_SPLIT_LOCK_AC)) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_SPLIT_LOCK_AC, 0);
+        if (ret) {
+            fprintf(stderr, "Could not enable the feature that #AC exception"
+                    "will be generated for split lock accesses!\n");
+            goto err;
+        }
+    }
+
     return 0;
 
 err:
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 617e5f8..e054119 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -350,6 +350,22 @@ static void machine_set_memory_encryption(Object *obj, const char *value,
     ms->memory_encryption = g_strdup(value);
 }
 
+static void machine_set_split_lock_ac(Object *obj, bool value,
+                                      Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->split_lock_ac = value;
+}
+
+static bool machine_get_split_lock_ac(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->split_lock_ac;
+}
+
+
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type)
 {
     strList *item = g_new0(strList, 1);
@@ -634,6 +650,9 @@ static void machine_class_init(ObjectClass *oc, void *data)
         &error_abort);
     object_class_property_set_description(oc, "memory-encryption",
         "Set memory encyption object to use", &error_abort);
+    object_class_property_add_bool(oc, "split-lock-ac",
+        machine_get_split_lock_ac, machine_set_split_lock_ac,
+        &error_abort);
 }
 
 static void machine_class_base_init(ObjectClass *oc, void *data)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 79069dd..9c1e2c0 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -256,6 +256,7 @@ struct MachineState {
     bool suppress_vmdesc;
     bool enforce_config_section;
     bool enable_graphics;
+    bool split_lock_ac;
     char *memory_encryption;
     DeviceMemoryState *device_memory;
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 98f389a..4bfa879 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_X86_SPLIT_LOCK_AC 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 81b1e99..935cefe 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -44,6 +44,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
     "                s390-squash-mcss=on|off (deprecated) controls support for squashing into default css (default=off)\n"
+    "                split-lock-ac=on|off controls support #AC exception for split locked accesses (default=off)\n"
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n",
     QEMU_ARCH_ALL)
 STEXI
@@ -113,6 +114,8 @@ NOTE: this parameter is deprecated. Please use @option{-global}
 @option{migration.send-configuration}=@var{on|off} instead.
 @item memory-encryption=@var{}
 Memory encryption object to use. The default is none.
+@item split-lock-ac=on|off
+Enables or disables #AC exception for split locked accesses.
 @end table
 ETEXI
 
-- 
1.8.3.1
