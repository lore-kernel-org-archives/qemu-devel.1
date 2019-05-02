Received: from eggs.gnu.org ([209.51.188.92]:59596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69W-0004P3-HM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69R-0002TF-N9
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69M-0000mD-3M
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so1794635wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:37 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 10:26:39 +0300
Message-Id: <20190502072641.4667-26-arilou@gmail.com>
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 25/27] kvm: Add API to read/write a CPU MSR
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, liran.alon@oracle.com, Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 accel/kvm/kvm-all.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 524c4ddfbd..35207d910b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2444,6 +2444,45 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
 }
 #endif /* !KVM_CAP_SET_GUEST_DEBUG */
 
+int kvm_arch_read_msr(CPUState *cpu, uint32_t index, uint64_t *value)
+{
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[1];
+    } msr_data;
+    int ret;
+
+    msr_data.info.nmsrs = 1;
+    msr_data.entries[0].index = index;
+    ret = kvm_vcpu_ioctl(cpu, KVM_GET_MSRS, &msr_data);
+    if (ret < 0) {
+        return ret;
+    }
+
+    *value = msr_data.entries[0].data;
+    return 0;
+}
+
+int kvm_arch_write_msr(CPUState *cpu, uint32_t index, uint64_t value)
+{
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[1];
+    } msr_data;
+    int ret;
+
+    msr_data.info.nmsrs = 1;
+    msr_data.entries[0].index = index;
+    msr_data.entries[0].reserved = 0;
+    msr_data.entries[0].data = value;
+    ret = kvm_vcpu_ioctl(cpu, KVM_SET_MSRS, &msr_data);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
     KVMState *s = kvm_state;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd190f..409b1a5444 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -462,6 +462,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
 uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
+int kvm_arch_read_msr(CPUState *cpu, uint32_t index, uint64_t *value);
+int kvm_arch_write_msr(CPUState *cpu, uint32_t index, uint64_t value);
 
 
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
-- 
2.20.1
