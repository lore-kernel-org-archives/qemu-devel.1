Received: from eggs.gnu.org ([2001:4830:134:3::10]:58787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vta-0002i5-JZ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtW-0003Hh-Eq
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:22 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:48 +0200
Message-Id: <20171020115418.2050-17-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 16/46] s390x/kvm: factor out storing of adtl CPU
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Called from SIGP code to be factored out, so let's move it. Add a
FIXME for TCG code in the future.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-15-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c   | 29 +++++++++++++++++++++++++++++
 target/s390x/internal.h |  1 +
 target/s390x/kvm.c      | 30 +-----------------------------
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 4c11822074..2505f3aec0 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -305,6 +305,35 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
 
     return 0;
 }
+
+#define ADTL_GS_OFFSET   1024 /* offset of GS data in adtl save area */
+#define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
+int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
+{
+    hwaddr save = len;
+    void *mem;
+
+    mem = cpu_physical_memory_map(addr, &save, 1);
+    if (!mem) {
+        return -EFAULT;
+    }
+    if (save != len) {
+        cpu_physical_memory_unmap(mem, len, 1, 0);
+        return -EFAULT;
+    }
+
+    /* FIXME: as soon as TCG supports these features, convert cpu->be */
+    if (s390_has_feat(S390_FEAT_VECTOR)) {
+        memcpy(mem, &cpu->env.vregs, 512);
+    }
+    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >= ADTL_GS_MIN_SIZE) {
+        memcpy(mem + ADTL_GS_OFFSET, &cpu->env.gscb, 32);
+    }
+
+    cpu_physical_memory_unmap(mem, len, 1, len);
+
+    return 0;
+}
 #endif /* CONFIG_USER_ONLY */
 
 void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index a301237c17..fb8ff6b078 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -355,6 +355,7 @@ void do_restart_interrupt(CPUS390XState *env);
 void s390_handle_wait(S390CPU *cpu);
 #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
 int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
+int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
 #ifndef CONFIG_USER_ONLY
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(LowCore *lowcore);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index aeea355cf3..bf6740df56 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1556,34 +1556,6 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
-#define ADTL_GS_OFFSET   1024 /* offset of GS data in adtl save area */
-#define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
-static int do_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
-{
-    hwaddr save = len;
-    void *mem;
-
-    mem = cpu_physical_memory_map(addr, &save, 1);
-    if (!mem) {
-        return -EFAULT;
-    }
-    if (save != len) {
-        cpu_physical_memory_unmap(mem, len, 1, 0);
-        return -EFAULT;
-    }
-
-    if (s390_has_feat(S390_FEAT_VECTOR)) {
-        memcpy(mem, &cpu->env.vregs, 512);
-    }
-    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >= ADTL_GS_MIN_SIZE) {
-        memcpy(mem + ADTL_GS_OFFSET, &cpu->env.gscb, 32);
-    }
-
-    cpu_physical_memory_unmap(mem, len, 1, len);
-
-    return 0;
-}
-
 static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -1676,7 +1648,7 @@ static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
 
     cpu_synchronize_state(cs);
 
-    if (do_store_adtl_status(cpu, addr, len)) {
+    if (s390_store_adtl_status(cpu, addr, len)) {
         set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
         return;
     }
-- 
2.13.6
