Received: from eggs.gnu.org ([2001:4830:134:3::10]:53436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZ5-0003wj-22
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZ3-0003Cg-Et
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfZ3-0003CG-5S
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:45 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:51 +0200
Message-Id: <20170928203708.9376-14-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/30] s390x/kvm: factor out storing of CPU
 status
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Factor it out into s390_store_status(), to be used also by TCG later on.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.c   | 60 ++++++++++++++++++++++++++++++++++++++++++
 target/s390x/internal.h |  2 ++
 target/s390x/kvm.c      | 69 +++----------------------------------------------
 3 files changed, 65 insertions(+), 66 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index baa18777f1..4c11822074 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -245,6 +245,66 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
     }
 }
 
+struct sigp_save_area {
+    uint64_t    fprs[16];                       /* 0x0000 */
+    uint64_t    grs[16];                        /* 0x0080 */
+    PSW         psw;                            /* 0x0100 */
+    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
+    uint32_t    prefix;                         /* 0x0118 */
+    uint32_t    fpc;                            /* 0x011c */
+    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */
+    uint32_t    todpr;                          /* 0x0124 */
+    uint64_t    cputm;                          /* 0x0128 */
+    uint64_t    ckc;                            /* 0x0130 */
+    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
+    uint32_t    ars[16];                        /* 0x0140 */
+    uint64_t    crs[16];                        /* 0x0384 */
+};
+QEMU_BUILD_BUG_ON(sizeof(struct sigp_save_area) != 512);
+
+int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
+{
+    static const uint8_t ar_id = 1;
+    struct sigp_save_area *sa;
+    hwaddr len = sizeof(*sa);
+    int i;
+
+    sa = cpu_physical_memory_map(addr, &len, 1);
+    if (!sa) {
+        return -EFAULT;
+    }
+    if (len != sizeof(*sa)) {
+        cpu_physical_memory_unmap(sa, len, 1, 0);
+        return -EFAULT;
+    }
+
+    if (store_arch) {
+        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->fprs[i] = cpu_to_be64(get_freg(&cpu->env, i)->ll);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->grs[i] = cpu_to_be64(cpu->env.regs[i]);
+    }
+    sa->psw.addr = cpu_to_be64(cpu->env.psw.addr);
+    sa->psw.mask = cpu_to_be64(get_psw_mask(&cpu->env));
+    sa->prefix = cpu_to_be32(cpu->env.psa);
+    sa->fpc = cpu_to_be32(cpu->env.fpc);
+    sa->todpr = cpu_to_be32(cpu->env.todpr);
+    sa->cputm = cpu_to_be64(cpu->env.cputm);
+    sa->ckc = cpu_to_be64(cpu->env.ckc >> 8);
+    for (i = 0; i < 16; ++i) {
+        sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->ars[i] = cpu_to_be64(cpu->env.cregs[i]);
+    }
+
+    cpu_physical_memory_unmap(sa, len, 1, len);
+
+    return 0;
+}
 #endif /* CONFIG_USER_ONLY */
 
 void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 0ac026d30f..a301237c17 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -353,6 +353,8 @@ void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
 void do_restart_interrupt(CPUS390XState *env);
 void s390_handle_wait(S390CPU *cpu);
+#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
+int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
 #ifndef CONFIG_USER_ONLY
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(LowCore *lowcore);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 7f2623f679..c7d0145fa9 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1547,68 +1547,6 @@ static int do_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
     return 0;
 }
 
-struct sigp_save_area {
-    uint64_t    fprs[16];                       /* 0x0000 */
-    uint64_t    grs[16];                        /* 0x0080 */
-    PSW         psw;                            /* 0x0100 */
-    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
-    uint32_t    prefix;                         /* 0x0118 */
-    uint32_t    fpc;                            /* 0x011c */
-    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */
-    uint32_t    todpr;                          /* 0x0124 */
-    uint64_t    cputm;                          /* 0x0128 */
-    uint64_t    ckc;                            /* 0x0130 */
-    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
-    uint32_t    ars[16];                        /* 0x0140 */
-    uint64_t    crs[16];                        /* 0x0384 */
-};
-QEMU_BUILD_BUG_ON(sizeof(struct sigp_save_area) != 512);
-
-#define KVM_S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
-static int kvm_s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
-{
-    static const uint8_t ar_id = 1;
-    struct sigp_save_area *sa;
-    hwaddr len = sizeof(*sa);
-    int i;
-
-    sa = cpu_physical_memory_map(addr, &len, 1);
-    if (!sa) {
-        return -EFAULT;
-    }
-    if (len != sizeof(*sa)) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
-        return -EFAULT;
-    }
-
-    if (store_arch) {
-        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->fprs[i] = cpu_to_be64(get_freg(&cpu->env, i)->ll);
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->grs[i] = cpu_to_be64(cpu->env.regs[i]);
-    }
-    sa->psw.addr = cpu_to_be64(cpu->env.psw.addr);
-    sa->psw.mask = cpu_to_be64(get_psw_mask(&cpu->env));
-    sa->prefix = cpu_to_be32(cpu->env.psa);
-    sa->fpc = cpu_to_be32(cpu->env.fpc);
-    sa->todpr = cpu_to_be32(cpu->env.todpr);
-    sa->cputm = cpu_to_be64(cpu->env.cputm);
-    sa->ckc = cpu_to_be64(cpu->env.ckc >> 8);
-    for (i = 0; i < 16; ++i) {
-        sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->ars[i] = cpu_to_be64(cpu->env.cregs[i]);
-    }
-
-    cpu_physical_memory_unmap(sa, len, 1, len);
-
-    return 0;
-}
-
 static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -1628,7 +1566,7 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     case CPU_STATE_STOPPED:
         /* already stopped, just store the status */
         cpu_synchronize_state(cs);
-        kvm_s390_store_status(cpu, KVM_S390_STORE_STATUS_DEF_ADDR, true);
+        s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
         break;
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
@@ -1648,7 +1586,7 @@ static void sigp_store_status_at_address(CPUState *cs, run_on_cpu_data arg)
 
     cpu_synchronize_state(cs);
 
-    if (kvm_s390_store_status(cpu, address, false)) {
+    if (s390_store_status(cpu, address, false)) {
         set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
         return;
     }
@@ -2030,8 +1968,7 @@ static int handle_intercept(S390CPU *cpu)
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             }
             if (cpu->env.sigp_order == SIGP_STOP_STORE_STATUS) {
-                kvm_s390_store_status(cpu, KVM_S390_STORE_STATUS_DEF_ADDR,
-                                      true);
+                s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
             }
             cpu->env.sigp_order = 0;
             r = EXCP_HALTED;
-- 
2.13.5
