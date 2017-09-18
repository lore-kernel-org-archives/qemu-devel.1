Received: from eggs.gnu.org ([2001:4830:134:3::10]:37652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUJ-0007LV-Ta
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUI-00085r-SV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUI-00085L-Kx
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:59 +0200
Message-Id: <20170918160012.4317-15-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 14/27] s390x/kvm: factor out storing of adtl
 CPU status
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

Called from SIGP code to be factored out, so let's move it. Add a
FIXME for TCG code in the future.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.c   | 29 +++++++++++++++++++++++++++++
 target/s390x/internal.h |  1 +
 target/s390x/kvm.c      | 30 +-----------------------------
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index e44d54b932..4d5a92c2ca 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -290,6 +290,35 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
 
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
index 30bcd7b662..1d86f48990 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -341,6 +341,7 @@ void s390x_cpu_timer(void *opaque);
 void do_restart_interrupt(CPUS390XState *env);
 #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
 int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
+int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
 #ifndef CONFIG_USER_ONLY
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(LowCore *lowcore);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index a6bc27eb28..01c4125d21 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1517,34 +1517,6 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
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
@@ -1637,7 +1609,7 @@ static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
 
     cpu_synchronize_state(cs);
 
-    if (do_store_adtl_status(cpu, addr, len)) {
+    if (s390_store_adtl_status(cpu, addr, len)) {
         set_sigp_status(si, SIGP_STAT_INVALID_PARAMETER);
         return;
     }
-- 
2.13.5
