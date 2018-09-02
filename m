Received: from [2001:4830:134:3::10] (port=53871 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fwRqJ-00089e-R0
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fwRpX-0007Yy-Fv
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:50:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:48449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fwRpL-0007UU-Ho
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:50:15 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Sun,  2 Sep 2018 19:46:06 +0800
Message-Id: <1535888767-154680-3-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1535888767-154680-1-git-send-email-robert.hu@linux.intel.com>
References: <1535888767-154680-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v4 2/3] kvm: Add support to
 KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: qemu-devel@nongnu.org, robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

Add kvm_get_supported_feature_msrs() to get supported MSR feature index list.
Add kvm_arch_get_supported_msr_feature() to get each MSR features value.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 include/sysemu/kvm.h |  2 ++
 target/i386/cpu.c    |  7 ++---
 target/i386/kvm.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 0b64b8e..97d8d9d 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -463,6 +463,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
+uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
+
 
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a252c26..0160e97 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3670,7 +3670,7 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
-    uint32_t r;
+    uint32_t r = 0;
 
     if (kvm_enabled()) {
         switch (wi->type) {
@@ -3679,8 +3679,9 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                 wi->cpuid.ecx,
                                                 wi->cpuid.reg);
             break;
-        default:
-            r = 0;
+        case MSR_FEATURE_WORD:
+            r = kvm_arch_get_supported_msr_feature(kvm_state,
+                        wi->msr.index);
             break;
         }
     } else if (hvf_enabled()) {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0b2a07d..bfd8088 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -107,6 +107,7 @@ static int has_pit_state2;
 static bool has_msr_mcg_ext_ctl;
 
 static struct kvm_cpuid2 *cpuid_cache;
+static struct kvm_msr_list *kvm_feature_msrs;
 
 int kvm_has_pit_state2(void)
 {
@@ -420,6 +421,33 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     return ret;
 }
 
+uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
+{
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[1];
+    } msr_data;
+    uint32_t ret;
+
+    if (kvm_feature_msrs == NULL) { /*ARCH doesn't support feature MSRs*/
+        return 0;
+    }
+
+    msr_data.info.nmsrs = 1;
+    msr_data.entries[0].index = index;
+
+    ret = kvm_ioctl(s, KVM_GET_MSRS, &msr_data);
+
+    if (ret != 1) {
+        fprintf(stderr, "KVM get MSR (index=0x%x) feature failed, %s\n",
+            index, strerror(-ret));
+        exit(1);
+    }
+
+    return msr_data.entries[0].data;
+}
+
+
 typedef struct HWPoisonPage {
     ram_addr_t ram_addr;
     QLIST_ENTRY(HWPoisonPage) list;
@@ -1239,6 +1267,45 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
     }
 }
 
+static int kvm_get_supported_feature_msrs(KVMState *s)
+{
+    int ret = 0;
+
+    if (kvm_feature_msrs != NULL) {
+        return 0;
+    }
+
+    if (!kvm_check_extension(s, KVM_CAP_GET_MSR_FEATURES)) {
+        return -1;
+    }
+
+    struct kvm_msr_list msr_list;
+
+    msr_list.nmsrs = 0;
+    ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, &msr_list);
+    if (ret < 0 && ret != -E2BIG) {
+        return ret;
+    }
+
+    assert(msr_list.nmsrs > 0);
+    kvm_feature_msrs = (struct kvm_msr_list *) \
+        g_malloc0(sizeof(msr_list) +
+                 msr_list.nmsrs * sizeof(msr_list.indices[0]));
+
+    kvm_feature_msrs->nmsrs = msr_list.nmsrs;
+    ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, kvm_feature_msrs);
+
+    if (ret < 0) {
+        fprintf(stderr, "Fetch KVM feature MSRs failed: %s\n",
+            strerror(-ret));
+        g_free(kvm_feature_msrs);
+        kvm_feature_msrs = NULL;
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_get_supported_msrs(KVMState *s)
 {
     static int kvm_supported_msrs;
@@ -1392,6 +1459,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
+    ret = kvm_get_supported_feature_msrs(s);
+    if (ret < 0) { /*if MSR based features aren't supported, ignore it.*/
+        warn_report("Get supported feature MSRs failed.");
+    }
+
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
 
-- 
1.8.3.1
