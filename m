Received: from eggs.gnu.org ([2001:4830:134:3::10]:43889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORb-0004n8-W5
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORZ-0007wd-Sy
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:32 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:38 +0100
Message-Id: <20171211134740.8235-14-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 13/15] s390x/tcg: STSI overhaul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Current STSI implementation is a mess, so let's rewrite it.

Problems fixed by this patch:
1) The order of exceptions/when recognized is wrong.
2) We have to store to virtual address space, not absolute.
3) Alignment check of the block is missing.
3) The SMP information is not indicated.

While at it:
a) Make the code look nicer
    - get rid of nesting levels
    - use struct initialization instead of initializing to zero
    - rename a misspelled field and rename function code defines
    - use a union and have only one write statement
    - use cpu_to_beX()
b) Indicate the VM name/extended name + UUID just like KVM does
c) Indicate that all LPAR CPUs we fake are dedicated
d) Add a comment why we fake being a KVM guest
e) Give our guest as default the name "TCGguest"
f) Fake the same CPU information we have in our Guest for all layers

While at it, get rid of "potential_page_fault()" by forwarding the
retaddr properly.

The result is best verified by looking at "/proc/sysinfo" in the guest
when specifying on the qemu command line
    -uuid "74738ff5-5367-5958-9aee-98fffdcd1876" \
    -name "extra long guest name"

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  22 +++--
 target/s390x/misc_helper.c | 213 ++++++++++++++++++++++++---------------------
 2 files changed, 132 insertions(+), 103 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index bfe650c46e..aded28d390 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -425,11 +425,11 @@ static inline void setcc(S390CPU *cpu, uint64_t cc)
 }
 
 /* STSI */
-#define STSI_LEVEL_MASK         0x00000000f0000000ULL
-#define STSI_LEVEL_CURRENT      0x0000000000000000ULL
-#define STSI_LEVEL_1            0x0000000010000000ULL
-#define STSI_LEVEL_2            0x0000000020000000ULL
-#define STSI_LEVEL_3            0x0000000030000000ULL
+#define STSI_R0_FC_MASK         0x00000000f0000000ULL
+#define STSI_R0_FC_CURRENT      0x0000000000000000ULL
+#define STSI_R0_FC_LEVEL_1      0x0000000010000000ULL
+#define STSI_R0_FC_LEVEL_2      0x0000000020000000ULL
+#define STSI_R0_FC_LEVEL_3      0x0000000030000000ULL
 #define STSI_R0_RESERVED_MASK   0x000000000fffff00ULL
 #define STSI_R0_SEL1_MASK       0x00000000000000ffULL
 #define STSI_R1_RESERVED_MASK   0x00000000ffff0000ULL
@@ -464,7 +464,7 @@ struct sysib_122 {
     uint8_t res1[32];
     uint32_t capability;
     uint16_t total_cpus;
-    uint16_t active_cpus;
+    uint16_t conf_cpus;
     uint16_t standby_cpus;
     uint16_t reserved_cpus;
     uint16_t adjustments[2026];
@@ -524,6 +524,16 @@ struct sysib_322 {
 };
 QEMU_BUILD_BUG_ON(sizeof(struct sysib_322) != 4096);
 
+union sysib {
+    struct sysib_111 sysib_111;
+    struct sysib_121 sysib_121;
+    struct sysib_122 sysib_122;
+    struct sysib_221 sysib_221;
+    struct sysib_222 sysib_222;
+    struct sysib_322 sysib_322;
+};
+QEMU_BUILD_BUG_ON(sizeof(union sysib) != 4096);
+
 /* MMU defines */
 #define _ASCE_ORIGIN            ~0xfffULL /* segment table origin             */
 #define _ASCE_SUBSPACE          0x200     /* subspace group control           */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 8483abeda6..b9dbe01a62 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -36,6 +36,9 @@
 #include "hw/s390x/ebcdic.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
+#include "hw/s390x/ioinst.h"
+#include "hw/s390x/s390_flic.h"
+#include "hw/boards.h"
 #endif
 
 /* #define DEBUG_HELPER */
@@ -194,132 +197,148 @@ void HELPER(spt)(CPUS390XState *env, uint64_t time)
 }
 
 /* Store System Information */
-uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
-                      uint64_t r0, uint64_t r1)
+uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
 {
+    const uintptr_t ra = GETPC();
+    const uint32_t sel1 = r0 & STSI_R0_SEL1_MASK;
+    const uint32_t sel2 = r1 & STSI_R1_SEL2_MASK;
+    const MachineState *ms = MACHINE(qdev_get_machine());
+    uint16_t total_cpus = 0, conf_cpus = 0, reserved_cpus = 0;
     S390CPU *cpu = s390_env_get_cpu(env);
-    int cc = 0;
-    int sel1, sel2;
+    union sysib sysib = { 0 };
+    int i, cc = 0;
+
+    if ((r0 & STSI_R0_FC_MASK) > STSI_R0_FC_LEVEL_3) {
+        /* invalid function code: no other checks are performed */
+        return 3;
+    }
 
-    if ((r0 & STSI_LEVEL_MASK) <= STSI_LEVEL_3 &&
-        ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK))) {
-        /* valid function code, invalid reserved bits */
-        s390_program_interrupt(env, PGM_SPECIFICATION, 4, GETPC());
+    if ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
     }
 
-    sel1 = r0 & STSI_R0_SEL1_MASK;
-    sel2 = r1 & STSI_R1_SEL2_MASK;
+    if ((r0 & STSI_R0_FC_MASK) == STSI_R0_FC_CURRENT) {
+        /* query the current level: no further checks are performed */
+        env->regs[0] = STSI_R0_FC_LEVEL_3;
+        return 0;
+    }
 
-    /* XXX: spec exception if sysib is not 4k-aligned */
+    if (a0 & ~TARGET_PAGE_MASK) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+    }
 
-    switch (r0 & STSI_LEVEL_MASK) {
-    case STSI_LEVEL_1:
+    /* count the cpus and split them into configured and reserved ones */
+    for (i = 0; i < ms->possible_cpus->len; i++) {
+        total_cpus++;
+        if (ms->possible_cpus->cpus[i].cpu) {
+            conf_cpus++;
+        } else {
+            reserved_cpus++;
+        }
+    }
+
+    /*
+     * In theory, we could report Level 1 / Level 2 as current. However,
+     * the Linux kernel will detect then assume that we have a sclp
+     * linemode console (which is not the default for QEMU), therefore not
+     * displaying boot messages and making booting a Linux kernel under
+     * TCG harder
+     *
+     * For now we fake the same SMP configuration on all levels.
+     *
+     * TODO: We could later make the level configurable via the machine
+     *       and change defaults (linemode console) based on machine type
+     *       and accelerator.
+     */
+    switch (r0 & STSI_R0_FC_MASK) {
+    case STSI_R0_FC_LEVEL_1:
         if ((sel1 == 1) && (sel2 == 1)) {
             /* Basic Machine Configuration */
-            struct sysib_111 sysib;
             char type[5] = {};
 
-            memset(&sysib, 0, sizeof(sysib));
-            ebcdic_put(sysib.manuf, "QEMU            ", 16);
+            ebcdic_put(sysib.sysib_111.manuf, "QEMU            ", 16);
             /* same as machine type number in STORE CPU ID, but in EBCDIC */
             snprintf(type, ARRAY_SIZE(type), "%X", cpu->model->def->type);
-            ebcdic_put(sysib.type, type, 4);
+            ebcdic_put(sysib.sysib_111.type, type, 4);
             /* model number (not stored in STORE CPU ID for z/Architecure) */
-            ebcdic_put(sysib.model, "QEMU            ", 16);
-            ebcdic_put(sysib.sequence, "QEMU            ", 16);
-            ebcdic_put(sysib.plant, "QEMU", 4);
-            cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
+            ebcdic_put(sysib.sysib_111.model, "QEMU            ", 16);
+            ebcdic_put(sysib.sysib_111.sequence, "QEMU            ", 16);
+            ebcdic_put(sysib.sysib_111.plant, "QEMU", 4);
         } else if ((sel1 == 2) && (sel2 == 1)) {
             /* Basic Machine CPU */
-            struct sysib_121 sysib;
-
-            memset(&sysib, 0, sizeof(sysib));
-            /* XXX make different for different CPUs? */
-            ebcdic_put(sysib.sequence, "QEMUQEMUQEMUQEMU", 16);
-            ebcdic_put(sysib.plant, "QEMU", 4);
-            stw_p(&sysib.cpu_addr, env->core_id);
-            cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
+            ebcdic_put(sysib.sysib_121.sequence, "QEMUQEMUQEMUQEMU", 16);
+            ebcdic_put(sysib.sysib_121.plant, "QEMU", 4);
+            sysib.sysib_121.cpu_addr = cpu_to_be16(env->core_id);
         } else if ((sel1 == 2) && (sel2 == 2)) {
             /* Basic Machine CPUs */
-            struct sysib_122 sysib;
-
-            memset(&sysib, 0, sizeof(sysib));
-            stl_p(&sysib.capability, 0x443afc29);
-            /* XXX change when SMP comes */
-            stw_p(&sysib.total_cpus, 1);
-            stw_p(&sysib.active_cpus, 1);
-            stw_p(&sysib.standby_cpus, 0);
-            stw_p(&sysib.reserved_cpus, 0);
-            cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
+            sysib.sysib_122.capability = cpu_to_be32(0x443afc29);
+            sysib.sysib_122.total_cpus = cpu_to_be16(total_cpus);
+            sysib.sysib_122.conf_cpus = cpu_to_be16(conf_cpus);
+            sysib.sysib_122.reserved_cpus = cpu_to_be16(reserved_cpus);
         } else {
             cc = 3;
         }
         break;
-    case STSI_LEVEL_2:
-        {
-            if ((sel1 == 2) && (sel2 == 1)) {
-                /* LPAR CPU */
-                struct sysib_221 sysib;
-
-                memset(&sysib, 0, sizeof(sysib));
-                /* XXX make different for different CPUs? */
-                ebcdic_put(sysib.sequence, "QEMUQEMUQEMUQEMU", 16);
-                ebcdic_put(sysib.plant, "QEMU", 4);
-                stw_p(&sysib.cpu_addr, env->core_id);
-                stw_p(&sysib.cpu_id, 0);
-                cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
-            } else if ((sel1 == 2) && (sel2 == 2)) {
-                /* LPAR CPUs */
-                struct sysib_222 sysib;
-
-                memset(&sysib, 0, sizeof(sysib));
-                stw_p(&sysib.lpar_num, 0);
-                sysib.lcpuc = 0;
-                /* XXX change when SMP comes */
-                stw_p(&sysib.total_cpus, 1);
-                stw_p(&sysib.conf_cpus, 1);
-                stw_p(&sysib.standby_cpus, 0);
-                stw_p(&sysib.reserved_cpus, 0);
-                ebcdic_put(sysib.name, "QEMU    ", 8);
-                stl_p(&sysib.caf, 1000);
-                stw_p(&sysib.dedicated_cpus, 0);
-                stw_p(&sysib.shared_cpus, 0);
-                cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
-            } else {
-                cc = 3;
-            }
-            break;
+    case STSI_R0_FC_LEVEL_2:
+        if ((sel1 == 2) && (sel2 == 1)) {
+            /* LPAR CPU */
+            ebcdic_put(sysib.sysib_221.sequence, "QEMUQEMUQEMUQEMU", 16);
+            ebcdic_put(sysib.sysib_221.plant, "QEMU", 4);
+            sysib.sysib_221.cpu_addr = cpu_to_be16(env->core_id);
+        } else if ((sel1 == 2) && (sel2 == 2)) {
+            /* LPAR CPUs */
+            sysib.sysib_222.lcpuc = 0x80; /* dedicated */
+            sysib.sysib_222.total_cpus = cpu_to_be16(total_cpus);
+            sysib.sysib_222.conf_cpus = cpu_to_be16(conf_cpus);
+            sysib.sysib_222.reserved_cpus = cpu_to_be16(reserved_cpus);
+            ebcdic_put(sysib.sysib_222.name, "QEMU    ", 8);
+            sysib.sysib_222.caf = cpu_to_be32(1000);
+            sysib.sysib_222.dedicated_cpus = cpu_to_be16(conf_cpus);
+        } else {
+            cc = 3;
         }
-    case STSI_LEVEL_3:
-        {
-            if ((sel1 == 2) && (sel2 == 2)) {
-                /* VM CPUs */
-                struct sysib_322 sysib;
-
-                memset(&sysib, 0, sizeof(sysib));
-                sysib.count = 1;
-                /* XXX change when SMP comes */
-                stw_p(&sysib.vm[0].total_cpus, 1);
-                stw_p(&sysib.vm[0].conf_cpus, 1);
-                stw_p(&sysib.vm[0].standby_cpus, 0);
-                stw_p(&sysib.vm[0].reserved_cpus, 0);
-                ebcdic_put(sysib.vm[0].name, "KVMguest", 8);
-                stl_p(&sysib.vm[0].caf, 1000);
-                ebcdic_put(sysib.vm[0].cpi, "KVM/Linux       ", 16);
-                cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
+        break;
+    case STSI_R0_FC_LEVEL_3:
+        if ((sel1 == 2) && (sel2 == 2)) {
+            /* VM CPUs */
+            sysib.sysib_322.count = 1;
+            sysib.sysib_322.vm[0].total_cpus = cpu_to_be16(total_cpus);
+            sysib.sysib_322.vm[0].conf_cpus = cpu_to_be16(conf_cpus);
+            sysib.sysib_322.vm[0].reserved_cpus = cpu_to_be16(reserved_cpus);
+            sysib.sysib_322.vm[0].caf = cpu_to_be32(1000);
+            /* Linux kernel uses this to distinguish us from z/VM */
+            ebcdic_put(sysib.sysib_322.vm[0].cpi, "KVM/Linux       ", 16);
+            sysib.sysib_322.vm[0].ext_name_encoding = 2; /* UTF-8 */
+
+            /* If our VM has a name, use the real name */
+            if (qemu_name) {
+                memset(sysib.sysib_322.vm[0].name, 0x40,
+                       sizeof(sysib.sysib_322.vm[0].name));
+                ebcdic_put(sysib.sysib_322.vm[0].name, qemu_name,
+                           MIN(sizeof(sysib.sysib_322.vm[0].name),
+                               strlen(qemu_name)));
+                strncpy((char *)sysib.sysib_322.ext_names[0], qemu_name,
+                        sizeof(sysib.sysib_322.ext_names[0]));
             } else {
-                cc = 3;
+                ebcdic_put(sysib.sysib_322.vm[0].name, "TCGguest", 8);
+                strcpy((char *)sysib.sysib_322.ext_names[0], "TCGguest");
             }
-            break;
+
+            /* add the uuid */
+            memcpy(sysib.sysib_322.vm[0].uuid, &qemu_uuid,
+                   sizeof(sysib.sysib_322.vm[0].uuid));
+        } else {
+            cc = 3;
         }
-    case STSI_LEVEL_CURRENT:
-        env->regs[0] = STSI_LEVEL_3;
-        break;
-    default:
-        cc = 3;
         break;
     }
 
+    if (cc == 0) {
+        if (s390_cpu_virt_mem_write(cpu, a0, 0, &sysib, sizeof(sysib))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+        }
+    }
+
     return cc;
 }
 
-- 
2.14.3
