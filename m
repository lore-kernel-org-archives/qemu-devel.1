Received: from eggs.gnu.org ([2001:4830:134:3::10]:53907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1d-0007aK-FG
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1X-00062o-6y
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:25 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:19 +0100
Message-Id: <20171214171004.25058-2-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/46] s390x/migration: use zero flag parameter
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

From: Christian Borntraeger <borntraeger@de.ibm.com>

valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
undefined value for flags. Kernels prior to 4.15 did not use that
field, and later kernels ignore it for compatibility reasons, but we
better play safe.

The same is true for SET_IRQ_STATE. We should make sure to not use the
flag field, either.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20171122142627.73170-2-borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index b03f583032..f205e0a2ca 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1979,7 +1979,10 @@ int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
 
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
 {
-    struct kvm_s390_irq_state irq_state;
+    struct kvm_s390_irq_state irq_state = {
+        .buf = (uint64_t) cpu->irqstate,
+        .len = VCPU_IRQ_BUF_SIZE,
+    };
     CPUState *cs = CPU(cpu);
     int32_t bytes;
 
@@ -1987,9 +1990,6 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
         return;
     }
 
-    irq_state.buf = (uint64_t) cpu->irqstate;
-    irq_state.len = VCPU_IRQ_BUF_SIZE;
-
     bytes = kvm_vcpu_ioctl(cs, KVM_S390_GET_IRQ_STATE, &irq_state);
     if (bytes < 0) {
         cpu->irqstate_saved_size = 0;
@@ -2003,7 +2003,10 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
-    struct kvm_s390_irq_state irq_state;
+    struct kvm_s390_irq_state irq_state = {
+        .buf = (uint64_t) cpu->irqstate,
+        .len = cpu->irqstate_saved_size,
+    };
     int r;
 
     if (cpu->irqstate_saved_size == 0) {
@@ -2014,9 +2017,6 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
         return -ENOSYS;
     }
 
-    irq_state.buf = (uint64_t) cpu->irqstate;
-    irq_state.len = cpu->irqstate_saved_size;
-
     r = kvm_vcpu_ioctl(cs, KVM_S390_SET_IRQ_STATE, &irq_state);
     if (r) {
         error_report("Setting interrupt state failed %d", r);
-- 
2.13.6
