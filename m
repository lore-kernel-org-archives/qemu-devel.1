Received: from eggs.gnu.org ([2001:4830:134:3::10]:53454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZI-00048Y-JE
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZE-0003Hp-Lm
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfZE-0003HO-DY
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:52 +0200
Message-Id: <20170928203708.9376-15-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/30] s390x/kvm: factor out storing of adtl
 CPU status
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

Called from SIGP code to be factored out, so let's move it. Add a
FIXME for TCG code in the future.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
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
index c7d0145fa9..1aec1e26d4 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1519,34 +1519,6 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
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
@@ -1639,7 +1611,7 @@ static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
 
     cpu_synchronize_state(cs);
 
-    if (do_store_adtl_status(cpu, addr, len)) {
+    if (s390_store_adtl_status(cpu, addr, len)) {
         set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
         return;
     }
-- 
2.13.5
