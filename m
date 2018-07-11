Received: from eggs.gnu.org ([2001:4830:134:3::10]:50212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1fdF5t-00065u-KV
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1fdF5p-0003vW-GW
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:23:45 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1fdF5p-0003vP-AF
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:23:41 -0400
Received: by mail-pf0-x243.google.com with SMTP id u16-v6so18410480pfh.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:23:41 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 11 Jul 2018 21:22:44 +0800
Message-Id: <1531315364-2551-1-git-send-email-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH] kvmclock: run KVM_KVMCLOCK_CTRL ioctl in vcpu
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, elohimes@gmail.com, chaiwen@baidu.com

According to KVM API Documentation, we should only
run vcpu ioctls from the same thread that was used
to create the vcpu. This patch makes KVM_KVMCLOCK_CTRL
ioctl consistent with the Documentation.

No functional change.

Signed-off-by: Yongji Xie <xieyongji@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
---
 hw/i386/kvm/clock.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 0bf1c60..25ea783 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -147,6 +147,15 @@ static void kvm_update_clock(KVMClockState *s)
     s->clock_is_reliable = kvm_has_adjust_clock_stable();
 }
 
+static void do_kvmclock_ctrl(CPUState *cpu, run_on_cpu_data data)
+{
+    int ret = kvm_vcpu_ioctl(cpu, KVM_KVMCLOCK_CTRL, 0);
+
+    if (ret && ret != -EINVAL) {
+        fprintf(stderr, "%s: %s\n", __func__, strerror(-ret));
+    }
+}
+
 static void kvmclock_vm_state_change(void *opaque, int running,
                                      RunState state)
 {
@@ -183,13 +192,7 @@ static void kvmclock_vm_state_change(void *opaque, int running,
             return;
         }
         CPU_FOREACH(cpu) {
-            ret = kvm_vcpu_ioctl(cpu, KVM_KVMCLOCK_CTRL, 0);
-            if (ret) {
-                if (ret != -EINVAL) {
-                    fprintf(stderr, "%s: %s\n", __func__, strerror(-ret));
-                }
-                return;
-            }
+            run_on_cpu(cpu, do_kvmclock_ctrl, RUN_ON_CPU_NULL);
         }
     } else {
 
-- 
1.7.9.5
