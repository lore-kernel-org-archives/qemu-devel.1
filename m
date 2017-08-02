Received: from eggs.gnu.org ([2001:4830:134:3::10]:37095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dcnrq-0005LF-EC
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dcnrm-0007HI-EK
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:14:54 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:55760)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dcnrl-00079m-QC
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:14:50 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 2 Aug 2017 23:27:34 +0800
Message-Id: <1501687654-10733-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] target-i386 : reduce rtc 0x70 access vm-exit
 time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

some versions of windows guest access rtc frequently because of 
rtc as system tick.guest access rtc like this: write register index 
to 0x70, then write or read data from 0x71. writing 0x70 port is 
just as index and do nothing else. So writing 0x70 is not necessory 
to exit to userspace every time and caching rtc register index in kvm 
can reduce VM-EXIT time.
without my patch, get the vm-exit time of accessing rtc 0x70 using
perf tools: (guest OS : windows 7 64bit)
IO Port Access  Samples Samples%   Time%    Min Time  Max Time  Avg time
0x70:POUT         86     30.99%    74.59%   9us       29us     10.75us ( +- 3.41% )

with my patch
IO Port Access  Samples Samples%  Time%   Min Time  Max Time   Avg time
 0x70:POUT       106    32.02%    29.47%    0us      10us     1.57us ( +- 7.38% )

the patch is a part of optimizing rtc 0x70 port access.another is in
kernel.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Liu Yi <liu.yi24@zte.com.cn>
---
 accel/kvm/kvm-all.c       | 17 +++++++++++++++++
 linux-headers/linux/kvm.h |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 46ce479..683274d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1483,6 +1483,21 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
+static void kvm_vrtc_create(KVMState *s)
+{
+    int ret;
+    if (kvm_check_extension(s, KVM_CAP_VRTC)) {
+        return;
+    }
+
+    ret = kvm_vm_ioctl(s, KVM_CREATE_VRTC);
+
+    if (ret < 0) {
+        fprintf(stderr, "Create kernel vrtc failed: %s\n", strerror(-ret));
+        exit(1);
+    }
+}
+
 static void kvm_irqchip_create(MachineState *machine, KVMState *s)
 {
     int ret;
@@ -1750,6 +1765,8 @@ static int kvm_init(MachineState *ms)
     if (machine_kernel_irqchip_allowed(ms)) {
         kvm_irqchip_create(ms, s);
     }
+
+    kvm_vrtc_create(s);
 
     if (kvm_eventfds_allowed) {
         s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 7971a4f..784179a 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -929,6 +929,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_VRTC 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1258,7 +1259,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_CONFIGURE_V3_MMU  _IOW(KVMIO,  0xaf, struct kvm_ppc_mmuv3_cfg)
 /* Available with KVM_CAP_PPC_RADIX_MMU */
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
-
+#define KVM_CREATE_VRTC           _IO(KVMIO,  0xba)
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
 
-- 
1.8.3.1
