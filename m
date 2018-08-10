Received: from eggs.gnu.org ([2001:4830:134:3::10]:39404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fo84G-0003L3-8R
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fo84D-0002i2-3C
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:07:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:34474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fo84C-0002Qr-PB
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:07:01 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Fri, 10 Aug 2018 22:06:28 +0800
Message-Id: <1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 2/3] kvm: Add support to
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
Cc: qemu-devel@nongnu.org, robert.hu@intel.com, jingqi.liu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

Add kvm_get_supported_feature_msrs() to get supported MSR feature index list.
Add kvm_arch_get_supported_msr_feature() to get each MSR features value.

kvm_get_supported_feature_msrs() is called in kvm_arch_init().
kvm_arch_get_supported_msr_feature() is called by
x86_cpu_get_supported_feature_word().

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 include/sysemu/kvm.h |  2 ++
 target/i386/kvm.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

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
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9313602..70d8606 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -107,6 +107,7 @@ static int has_pit_state2;
 static bool has_msr_mcg_ext_ctl;
 
 static struct kvm_cpuid2 *cpuid_cache;
+static struct kvm_msr_list *kvm_feature_msrs;
 
 int kvm_has_pit_state2(void)
 {
@@ -420,6 +421,41 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
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
+    /*Check if the requested feature MSR is supported*/
+    int i;
+    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
+        if (index == kvm_feature_msrs->indices[i]) {
+            break;
+        }
+    }
+    if (i >= kvm_feature_msrs->nmsrs) {
+        fprintf(stderr, "Requested MSR (index= %d) is not supported.\n", index);
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
@@ -1238,7 +1274,45 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
         env->mp_state = KVM_MP_STATE_INIT_RECEIVED;
     }
 }
+static int kvm_get_supported_feature_msrs(KVMState *s)
+{
+    static int kvm_supported_feature_msrs;
+    int ret = 0;
+
+    if (kvm_supported_feature_msrs == 0) {
+        struct kvm_msr_list msr_list;
+
+        kvm_supported_feature_msrs++;
+
+        msr_list.nmsrs = 0;
+        ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, &msr_list);
+        if (ret < 0 && ret != -E2BIG) {
+            return ret;
+        }
+
+        assert(msr_list.nmsrs > 0);
+        kvm_feature_msrs = (struct kvm_msr_list *) \
+            g_malloc0(sizeof(msr_list) +
+                     msr_list.nmsrs * sizeof(msr_list.indices[0]));
+        if (kvm_feature_msrs == NULL) {
+            fprintf(stderr, "Failed to allocate space for KVM Feature MSRs"
+                "which has %d MSRs\n", msr_list.nmsrs);
+            return -1;
+        }
+
+        kvm_feature_msrs->nmsrs = msr_list.nmsrs;
+        ret = kvm_ioctl(s, KVM_GET_MSR_FEATURE_INDEX_LIST, kvm_feature_msrs);
 
+        if (ret < 0) {  /*ioctl failure*/
+            fprintf(stderr, "Fetch KVM feature MSRs failed: %s\n",
+                strerror(-ret));
+            g_free(kvm_feature_msrs);
+            return ret;
+        }
+    }
+
+    return 0;
+}
 static int kvm_get_supported_msrs(KVMState *s)
 {
     static int kvm_supported_msrs;
@@ -1400,6 +1474,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
+    ret = kvm_get_supported_feature_msrs(s);
+    if (ret < 0) {
+        return ret;
+    }
+
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
 
-- 
1.8.3.1
