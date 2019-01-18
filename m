Received: from eggs.gnu.org ([209.51.188.92]:45601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXVC-0003hD-Qp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXVA-0007Be-2b
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52990 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkXV7-00077O-BB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:15 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 17:59:40 +0100
Message-Id: <1547830785-7079-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 07/12] target/mips: Update ITU to utilize
 SAARI and SAAR CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Update ITU to utilize SAARI and SAAR CP0 registers.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/mips/cps.c              |  8 ++++++++
 hw/misc/mips_itu.c         | 29 +++++++++++++++++++++++------
 include/hw/misc/mips_itu.h |  4 ++++
 target/mips/cpu.h          |  5 +++++
 target/mips/op_helper.c    | 14 ++++++++++++++
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 4285d19..fc97f59 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -69,6 +69,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
     target_ulong gcr_base;
     bool itu_present = false;
+    bool saar_present = false;
 
     for (i = 0; i < s->num_vp; i++) {
         cpu = MIPS_CPU(cpu_create(s->cpu_type));
@@ -82,12 +83,14 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
             itu_present = true;
             /* Attach ITC Tag to the VP */
             env->itc_tag = mips_itu_get_tag_region(&s->itu);
+            env->itu = &s->itu;
         }
         qemu_register_reset(main_cpu_reset, cpu);
     }
 
     cpu = MIPS_CPU(first_cpu);
     env = &cpu->env;
+    saar_present = (bool)env->saarp;
 
     /* Inter-Thread Communication Unit */
     if (itu_present) {
@@ -96,6 +99,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
         object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", &err);
         object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", &err);
+        object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
+                                 &err);
+        if (saar_present) {
+            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->CP0_SAAR);
+        }
         object_property_set_bool(OBJECT(&s->itu), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 4801958..ee1addc 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -84,7 +84,7 @@ static uint64_t itc_tag_read(void *opaque, hwaddr addr, unsigned size)
     return tag->ITCAddressMap[index];
 }
 
-static void itc_reconfigure(MIPSITUState *tag)
+void itc_reconfigure(MIPSITUState *tag)
 {
     uint64_t *am = &tag->ITCAddressMap[0];
     MemoryRegion *mr = &tag->storage_io;
@@ -92,6 +92,12 @@ static void itc_reconfigure(MIPSITUState *tag)
     uint64_t size = (1 * KiB) + (am[1] & ITC_AM1_ADDR_MASK_MASK);
     bool is_enabled = (am[0] & ITC_AM0_EN_MASK) != 0;
 
+    if (tag->saar_present) {
+        address = ((*(uint64_t *) tag->saar) & 0xFFFFFFFFE000ULL) << 4;
+        size = 1 << ((*(uint64_t *) tag->saar >> 1) & 0x1f);
+        is_enabled = *(uint64_t *) tag->saar & 1;
+    }
+
     memory_region_transaction_begin();
     if (!(size & (size - 1))) {
         memory_region_set_size(mr, size);
@@ -150,7 +156,12 @@ static inline ITCView get_itc_view(hwaddr addr)
 static inline int get_cell_stride_shift(const MIPSITUState *s)
 {
     /* Minimum interval (for EntryGain = 0) is 128 B */
-    return 7 + (s->ITCAddressMap[1] & ITC_AM1_ENTRY_GRAIN_MASK);
+    if (s->saar_present) {
+        return 7 + ((s->icr0 >> ITC_ICR0_BLK_GRAIN) &
+                    ITC_ICR0_BLK_GRAIN_MASK);
+    } else {
+        return 7 + (s->ITCAddressMap[1] & ITC_AM1_ENTRY_GRAIN_MASK);
+    }
 }
 
 static inline ITCStorageCell *get_cell(MIPSITUState *s,
@@ -499,10 +510,15 @@ static void mips_itu_reset(DeviceState *dev)
 {
     MIPSITUState *s = MIPS_ITU(dev);
 
-    s->ITCAddressMap[0] = 0;
-    s->ITCAddressMap[1] =
-        ((ITC_STORAGE_ADDRSPACE_SZ - 1) & ITC_AM1_ADDR_MASK_MASK) |
-        (get_num_cells(s) << ITC_AM1_NUMENTRIES_OFS);
+    if (s->saar_present) {
+        *(uint64_t *) s->saar = 0x11 << 1;
+        s->icr0 = get_num_cells(s) << ITC_ICR0_CELL_NUM;
+    } else {
+        s->ITCAddressMap[0] = 0;
+        s->ITCAddressMap[1] =
+            ((ITC_STORAGE_ADDRSPACE_SZ - 1) & ITC_AM1_ADDR_MASK_MASK) |
+            (get_num_cells(s) << ITC_AM1_NUMENTRIES_OFS);
+    }
     itc_reconfigure(s);
 
     itc_reset_cells(s);
@@ -513,6 +529,7 @@ static Property mips_itu_properties[] = {
                       ITC_FIFO_NUM_MAX),
     DEFINE_PROP_INT32("num-semaphores", MIPSITUState, num_semaphores,
                       ITC_SEMAPH_NUM_MAX),
+    DEFINE_PROP_BOOL("saar-present", MIPSITUState, saar_present, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 45a0c51..c44e767 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -70,6 +70,10 @@ typedef struct MIPSITUState {
     /* ITU Control Register */
     uint64_t icr0;
 
+    /* SAAR */
+    bool saar_present;
+    void *saar;
+
 } MIPSITUState;
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 185702d..48e86d1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -326,6 +326,7 @@ struct TCState {
 
 };
 
+struct MIPSITUState;
 typedef struct CPUMIPSState CPUMIPSState;
 struct CPUMIPSState {
     TCState active_tc;
@@ -917,6 +918,7 @@ struct CPUMIPSState {
     const mips_def_t *cpu_model;
     void *irq[8];
     QEMUTimer *timer; /* Internal timer */
+    struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
     target_ulong exception_base; /* ExceptionBase input to the core */
 };
@@ -1059,6 +1061,9 @@ void cpu_set_exception_base(int vp_index, target_ulong address);
 /* mips_int.c */
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 
+/* mips_itu.c */
+void itc_reconfigure(struct MIPSITUState *tag);
+
 /* helper.c */
 target_ulong exception_resume_pc (CPUMIPSState *env);
 
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 409c136..aebad24 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1635,6 +1635,13 @@ void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
     uint32_t target = env->CP0_SAARI & 0x3f;
     if (target < 2) {
         env->CP0_SAAR[target] = arg1 & 0x00000ffffffff03fULL;
+        switch (target) {
+        case 0:
+            if (env->itu) {
+                itc_reconfigure(env->itu);
+            }
+            break;
+        }
     }
 }
 
@@ -1645,6 +1652,13 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
         env->CP0_SAAR[target] =
             (((uint64_t) arg1 << 32) & 0x00000fff00000000ULL) |
             (env->CP0_SAAR[target] & 0x00000000ffffffffULL);
+        switch (target) {
+        case 0:
+            if (env->itu) {
+                itc_reconfigure(env->itu);
+            }
+            break;
+        }
     }
 }
 
-- 
2.7.4
