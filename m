Received: from eggs.gnu.org ([2001:4830:134:3::10]:54610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gXdhK-0008QN-S9
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 21:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gXdhH-0004Ks-JL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 21:59:30 -0500
Received: from [107.173.13.209] (port=56726 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gXdhH-0004He-Al
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 21:59:27 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 14 Dec 2018 13:58:49 +1100
Message-Id: <20181214025849.84274-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2] hmp: Print if memory section is
 registered with an accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This adds an accelerator name to the "into mtree -f" to tell the user if
a particular memory section is registered with the accelerator;
the primary user for this is KVM and such information is useful
for debugging purposes.

This adds a has_memory() callback to the accelerator class allowing any
accelerator to have a label in that memory tree dump.

Since memory sections are passed to memory listeners and get registered
in accelerators (rather than memory regions), this only prints new labels
for flatviews attached to the system address space.

An example:
 Root memory region: system
  0000000000000000-0000002fffffffff (prio 0, ram): /objects/mem0 kvm
  0000003000000000-0000005fffffffff (prio 0, ram): /objects/mem1 kvm
  0000200000000020-000020000000003f (prio 1, i/o): virtio-pci
  0000200080000000-000020008000003f (prio 0, i/o): capabilities

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This supercedes "[PATCH qemu] hmp: Print if memory section is registered in KVM"

---
Changes:
v2:
* added an accelerator callback instead of hardcoding it to kvm only
---
 include/sysemu/accel.h |  2 ++
 accel/kvm/kvm-all.c    | 10 ++++++++++
 memory.c               | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 637358f..30b456d 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -25,6 +25,7 @@
 
 #include "qom/object.h"
 #include "hw/qdev-properties.h"
+#include "exec/hwaddr.h"
 
 typedef struct AccelState {
     /*< private >*/
@@ -41,6 +42,7 @@ typedef struct AccelClass {
     int (*available)(void);
     int (*init_machine)(MachineState *ms);
     void (*setup_post)(MachineState *ms, AccelState *accel);
+    bool (*has_memory)(MachineState *ms, hwaddr start_addr, hwaddr size);
     bool *allowed;
     /*
      * Array of global properties that would be applied when specific
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4880a05..634f386 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2589,11 +2589,21 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
     return r;
 }
 
+static bool kvm_accel_has_memory(MachineState *ms, hwaddr start_addr,
+                                 hwaddr size)
+{
+    KVMState *kvm = KVM_STATE(ms->accelerator);
+    KVMMemoryListener *kml = &kvm->memory_listener;
+
+    return NULL != kvm_lookup_matching_slot(kml, start_addr, size);
+}
+
 static void kvm_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "KVM";
     ac->init_machine = kvm_init;
+    ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
 }
 
diff --git a/memory.c b/memory.c
index d14c6de..61e758a 100644
--- a/memory.c
+++ b/memory.c
@@ -29,7 +29,9 @@
 #include "exec/ram_addr.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/accel.h"
 #include "hw/qdev-properties.h"
+#include "hw/boards.h"
 #include "migration/vmstate.h"
 
 //#define DEBUG_UNASSIGNED
@@ -2924,6 +2926,8 @@ struct FlatViewInfo {
     int counter;
     bool dispatch_tree;
     bool owner;
+    AccelClass *ac;
+    const char *ac_name;
 };
 
 static void mtree_print_flatview(gpointer key, gpointer value,
@@ -2939,6 +2943,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     int n = view->nr;
     int i;
     AddressSpace *as;
+    bool system_as = false;
 
     p(f, "FlatView #%d\n", fvi->counter);
     ++fvi->counter;
@@ -2950,6 +2955,9 @@ static void mtree_print_flatview(gpointer key, gpointer value,
             p(f, ", alias %s", memory_region_name(as->root->alias));
         }
         p(f, "\n");
+        if (as == &address_space_memory) {
+            system_as = true;
+        }
     }
 
     p(f, " Root memory region: %s\n",
@@ -2985,6 +2993,13 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         if (fvi->owner) {
             mtree_print_mr_owner(p, f, mr);
         }
+
+        if (system_as && fvi->ac &&
+            fvi->ac->has_memory(current_machine,
+                                int128_get64(range->addr.start),
+                                MR_SIZE(range->addr.size) + 1)) {
+            p(f, " %s", fvi->ac_name);
+        }
         p(f, "\n");
         range++;
     }
@@ -3028,6 +3043,13 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
         };
         GArray *fv_address_spaces;
         GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
+        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
+
+        if (ac->has_memory) {
+            fvi.ac = ac;
+            fvi.ac_name = current_machine->accel ? current_machine->accel :
+                object_class_get_name(OBJECT_CLASS(ac));
+        }
 
         /* Gather all FVs in one table */
         QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-- 
2.17.1
