Received: from eggs.gnu.org ([2001:4830:134:3::10]:37590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUF-0007IC-1T
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyU9-00081H-48
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyU8-00080y-SV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:25 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:57 +0200
Message-Id: <20170918160012.4317-13-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 12/27] s390x/kvm: factor out storing of CPU
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Factor it out into s390_store_status(), to be used also by TCG later on.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.c   | 38 ++++++++++++++++++++++++++++++++++++++
 target/s390x/internal.h |  2 ++
 target/s390x/kvm.c      | 47 +++--------------------------------------------
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 75ceb0bf2b..09468f85fa 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -245,6 +245,44 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
     }
 }
 
+#define SAVE_AREA_SIZE 512
+int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
+{
+    static const uint8_t ar_id = 1;
+    uint64_t ckc = cpu->env.ckc >> 8;
+    void *mem;
+    int i;
+    hwaddr len = SAVE_AREA_SIZE;
+
+    mem = cpu_physical_memory_map(addr, &len, 1);
+    if (!mem) {
+        return -EFAULT;
+    }
+    if (len != SAVE_AREA_SIZE) {
+        cpu_physical_memory_unmap(mem, len, 1, 0);
+        return -EFAULT;
+    }
+
+    if (store_arch) {
+        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
+    }
+    for (i = 0; i < 16; ++i) {
+        *((uint64_t *)mem + i) = get_freg(&cpu->env, i)->ll;
+    }
+    memcpy(mem + 128, &cpu->env.regs, 128);
+    memcpy(mem + 256, &cpu->env.psw, 16);
+    memcpy(mem + 280, &cpu->env.psa, 4);
+    memcpy(mem + 284, &cpu->env.fpc, 4);
+    memcpy(mem + 292, &cpu->env.todpr, 4);
+    memcpy(mem + 296, &cpu->env.cputm, 8);
+    memcpy(mem + 304, &ckc, 8);
+    memcpy(mem + 320, &cpu->env.aregs, 64);
+    memcpy(mem + 384, &cpu->env.cregs, 128);
+
+    cpu_physical_memory_unmap(mem, len, 1, len);
+
+    return 0;
+}
 #endif /* CONFIG_USER_ONLY */
 
 void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 8fdeb867e1..30bcd7b662 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -339,6 +339,8 @@ void s390_cpu_recompute_watchpoints(CPUState *cs);
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
 void do_restart_interrupt(CPUS390XState *env);
+#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
+int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
 #ifndef CONFIG_USER_ONLY
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(LowCore *lowcore);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 66a56db175..a6bc27eb28 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1545,46 +1545,6 @@ static int do_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
     return 0;
 }
 
-#define KVM_S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
-#define SAVE_AREA_SIZE 512
-static int kvm_s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
-{
-    static const uint8_t ar_id = 1;
-    uint64_t ckc = cpu->env.ckc >> 8;
-    void *mem;
-    int i;
-    hwaddr len = SAVE_AREA_SIZE;
-
-    mem = cpu_physical_memory_map(addr, &len, 1);
-    if (!mem) {
-        return -EFAULT;
-    }
-    if (len != SAVE_AREA_SIZE) {
-        cpu_physical_memory_unmap(mem, len, 1, 0);
-        return -EFAULT;
-    }
-
-    if (store_arch) {
-        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
-    }
-    for (i = 0; i < 16; ++i) {
-        *((uint64_t *)mem + i) = get_freg(&cpu->env, i)->ll;
-    }
-    memcpy(mem + 128, &cpu->env.regs, 128);
-    memcpy(mem + 256, &cpu->env.psw, 16);
-    memcpy(mem + 280, &cpu->env.psa, 4);
-    memcpy(mem + 284, &cpu->env.fpc, 4);
-    memcpy(mem + 292, &cpu->env.todpr, 4);
-    memcpy(mem + 296, &cpu->env.cputm, 8);
-    memcpy(mem + 304, &ckc, 8);
-    memcpy(mem + 320, &cpu->env.aregs, 64);
-    memcpy(mem + 384, &cpu->env.cregs, 128);
-
-    cpu_physical_memory_unmap(mem, len, 1, len);
-
-    return 0;
-}
-
 static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -1604,7 +1564,7 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     case CPU_STATE_STOPPED:
         /* already stopped, just store the status */
         cpu_synchronize_state(cs);
-        kvm_s390_store_status(cpu, KVM_S390_STORE_STATUS_DEF_ADDR, true);
+        s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
         break;
     }
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
@@ -1624,7 +1584,7 @@ static void sigp_store_status_at_address(CPUState *cs, run_on_cpu_data arg)
 
     cpu_synchronize_state(cs);
 
-    if (kvm_s390_store_status(cpu, address, false)) {
+    if (s390_store_status(cpu, address, false)) {
         set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
         return;
     }
@@ -2005,8 +1965,7 @@ static int handle_intercept(S390CPU *cpu)
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
