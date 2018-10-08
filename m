Received: from eggs.gnu.org ([2001:4830:134:3::10]:46884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9X1c-000686-8V
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9X1Z-0007A4-5N
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:00:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48434 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g9X1Y-000755-Ly
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:00:45 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  8 Oct 2018 16:56:34 +0200
Message-Id: <1539010596-30858-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 10/12] hw/mips: Update ITU to utilise
 SAARI/SAAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Yongbok Kim <yongbok.kim@mips.com>

Update the ITU to utilise SAARI/SAAR registers and add new ITU
Control Register (ICR0).

Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/mips/cps.c              |  8 ++++++
 hw/misc/mips_itu.c         | 72 +++++++++++++++++++++++++++++++++++++++++-----
 include/hw/misc/mips_itu.h |  7 +++++
 target/mips/cpu.h          |  5 ++++
 target/mips/op_helper.c    | 14 +++++++++
 5 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 4285d19..dd68795 100644
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
+    saar_present = (bool) env->saarp;
 
     /* Inter-Thread Communication Unit */
     if (itu_present) {
@@ -96,6 +99,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
         object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", &err);
         object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", &err);
+        object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
+                                 &err);
+        if (saar_present) {
+            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *) &env->CP0_SAAR);
+        }
         object_property_set_bool(OBJECT(&s->itu), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 43bbec4..746e0c2 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -55,9 +55,17 @@ typedef enum ITCView {
     ITCVIEW_EF_SYNC = 2,
     ITCVIEW_EF_TRY  = 3,
     ITCVIEW_PV_SYNC = 4,
-    ITCVIEW_PV_TRY  = 5
+    ITCVIEW_PV_TRY  = 5,
+    ITCVIEW_PV_ICR  = 15
 } ITCView;
 
+#define ITC_ICR0_CELL_NUM   16
+#define ITC_ICR0_BLK_GRAIN  8
+#define ITC_ICR0_BLK_GRAIN_MASK  0x7
+#define ITC_ICR0_ERR_AXI    2
+#define ITC_ICR0_ERR_PARITY 1
+#define ITC_ICR0_ERR_EXEC   0
+
 MemoryRegion *mips_itu_get_tag_region(MIPSITUState *itu)
 {
     return &itu->tag_io;
@@ -76,7 +84,7 @@ static uint64_t itc_tag_read(void *opaque, hwaddr addr, unsigned size)
     return tag->ITCAddressMap[index];
 }
 
-static void itc_reconfigure(MIPSITUState *tag)
+void itc_reconfigure(MIPSITUState *tag)
 {
     uint64_t *am = &tag->ITCAddressMap[0];
     MemoryRegion *mr = &tag->storage_io;
@@ -84,6 +92,12 @@ static void itc_reconfigure(MIPSITUState *tag)
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
@@ -142,7 +156,12 @@ static inline ITCView get_itc_view(hwaddr addr)
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
@@ -356,6 +375,12 @@ static void view_pv_try_write(ITCStorageCell *c)
     view_pv_common_write(c);
 }
 
+static void raise_exception(int excp)
+{
+    current_cpu->exception_index = excp;
+    cpu_loop_exit(current_cpu);
+}
+
 static uint64_t itc_storage_read(void *opaque, hwaddr addr, unsigned size)
 {
     MIPSITUState *s = (MIPSITUState *)opaque;
@@ -363,6 +388,14 @@ static uint64_t itc_storage_read(void *opaque, hwaddr addr, unsigned size)
     ITCView view = get_itc_view(addr);
     uint64_t ret = -1;
 
+    switch (size) {
+    case 1:
+    case 2:
+        s->icr0 |= 1 << ITC_ICR0_ERR_AXI;
+        raise_exception(EXCP_DBE);
+        return 0;
+    }
+
     switch (view) {
     case ITCVIEW_BYPASS:
         ret = view_bypass_read(cell);
@@ -382,6 +415,9 @@ static uint64_t itc_storage_read(void *opaque, hwaddr addr, unsigned size)
     case ITCVIEW_PV_TRY:
         ret = view_pv_try_read(cell);
         break;
+    case ITCVIEW_PV_ICR:
+        ret = s->icr0;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "itc_storage_read: Bad ITC View %d\n", (int)view);
@@ -398,6 +434,14 @@ static void itc_storage_write(void *opaque, hwaddr addr, uint64_t data,
     ITCStorageCell *cell = get_cell(s, addr);
     ITCView view = get_itc_view(addr);
 
+    switch (size) {
+    case 1:
+    case 2:
+        s->icr0 |= 1 << ITC_ICR0_ERR_AXI;
+        raise_exception(EXCP_DBE);
+        return;
+    }
+
     switch (view) {
     case ITCVIEW_BYPASS:
         view_bypass_write(cell, data);
@@ -417,6 +461,15 @@ static void itc_storage_write(void *opaque, hwaddr addr, uint64_t data,
     case ITCVIEW_PV_TRY:
         view_pv_try_write(cell);
         break;
+    case ITCVIEW_PV_ICR:
+        if (data & 0x7) {
+            /* clear ERROR bits */
+            s->icr0 &= ~(data & 0x7);
+        }
+        /* set BLK_GRAIN */
+        s->icr0 &= ~0x700;
+        s->icr0 |= data & 0x700;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "itc_storage_write: Bad ITC View %d\n", (int)view);
@@ -479,10 +532,15 @@ static void mips_itu_reset(DeviceState *dev)
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
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 030eb4a..bb9667a 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -66,6 +66,13 @@ typedef struct MIPSITUState {
     /* ITC Configuration Tags */
     uint64_t ITCAddressMap[ITC_ADDRESSMAP_NUM];
     MemoryRegion tag_io;
+
+    /* ITU Control Registers */
+    uint64_t icr0;
+
+    /* SAAR */
+    bool saar_present;
+    void *saar;
 } MIPSITUState;
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 87c0a93..7bc45d5 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -172,6 +172,7 @@ struct TCState {
     float_status msa_fp_status;
 };
 
+struct MIPSITUState;
 typedef struct CPUMIPSState CPUMIPSState;
 struct CPUMIPSState {
     TCState active_tc;
@@ -639,6 +640,7 @@ struct CPUMIPSState {
     const mips_def_t *cpu_model;
     void *irq[8];
     QEMUTimer *timer; /* Internal timer */
+    struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
     target_ulong exception_base; /* ExceptionBase input to the core */
 };
@@ -781,6 +783,9 @@ void cpu_set_exception_base(int vp_index, target_ulong address);
 /* mips_int.c */
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 
+/* mips_itu.c */
+void itc_reconfigure(struct MIPSITUState *tag);
+
 /* helper.c */
 target_ulong exception_resume_pc (CPUMIPSState *env);
 
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 6f53757..eb63d20 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1560,6 +1560,13 @@ void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
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
 
@@ -1570,6 +1577,13 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
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
