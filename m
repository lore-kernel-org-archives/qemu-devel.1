Received: from eggs.gnu.org ([2001:4830:134:3::10]:34995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKPR5-0003Zd-Fv
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKPR2-0002Nh-Ba
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:31:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKPR1-0002N6-Oa
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:31:12 -0400
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Mon, 12 Jun 2017 21:30:51 +0800
Message-ID: <1497274251-26448-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC] migration: kvmclock: save and load the
 PVCLOCK_TSC_UNSTABLE_BIT flag when migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, Jay Zhou <jianjay.zhou@huawei.com>

Guest using kvmclock will be hanged when migrating from unstable
tsc host to stable tsc host occasionally.
Sometimes, the tsc timestamp saved at the source side will be
backward when the guest stopped, and this value is transferred
to the destination side. The guest at the destination side thought
kvmclock is stable, so the protection mechanism against time
going backwards is not used.
When the first time vcpu0 enters the guest at the destination
side to update the wall clock, the result of
pvclock_clocksource_read will be backward occasionally,
which results in the wall clock drift.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 hw/i386/kvm/clock.c         | 12 ++++++++++--
 linux-headers/asm-x86/kvm.h |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 13eca37..fcc4f62 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -29,6 +29,7 @@
 
 #define TYPE_KVM_CLOCK "kvmclock"
 #define KVM_CLOCK(obj) OBJECT_CHECK(KVMClockState, (obj), TYPE_KVM_CLOCK)
+#define PVCLOCK_TSC_STABLE_BIT (1 << 0)
 
 typedef struct KVMClockState {
     /*< private >*/
@@ -57,7 +58,7 @@ struct pvclock_vcpu_time_info {
     uint8_t    pad[2];
 } __attribute__((__packed__)); /* 32 bytes */
 
-static uint64_t kvmclock_current_nsec(KVMClockState *s)
+static uint64_t kvmclock_current_nsec(KVMClockState *s, uint8_t *flags)
 {
     CPUState *cpu = first_cpu;
     CPUX86State *env = cpu->env_ptr;
@@ -77,6 +78,7 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
     cpu_physical_memory_read(kvmclock_struct_pa, &time, sizeof(time));
 
     assert(time.tsc_timestamp <= migration_tsc);
+    *flags = time.flags;
     delta = migration_tsc - time.tsc_timestamp;
     if (time.tsc_shift < 0) {
         delta >>= -time.tsc_shift;
@@ -153,16 +155,22 @@ static void kvmclock_vm_state_change(void *opaque, int running,
 
     if (running) {
         struct kvm_clock_data data = {};
+        uint8_t flags_at_migration;
 
         /*
          * If the host where s->clock was read did not support reliable
          * KVM_GET_CLOCK, read kvmclock value from memory.
          */
         if (!s->clock_is_reliable) {
-            uint64_t pvclock_via_mem = kvmclock_current_nsec(s);
+            uint64_t pvclock_via_mem = kvmclock_current_nsec(s,
+                                                    &flags_at_migration);
             /* We can't rely on the saved clock value, just discard it */
             if (pvclock_via_mem) {
                 s->clock = pvclock_via_mem;
+                /* whether src kvmclock has PVCLOCK_TSC_STABLE_BIT flag */
+                if (!(flags_at_migration & PVCLOCK_TSC_STABLE_BIT)) {
+                    data.flags |= MIGRATION_PVCLOCK_TSC_UNSTABLE_BIT;
+                }
             }
         }
 
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index c2824d0..9faed3e 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -360,4 +360,6 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+#define MIGRATION_PVCLOCK_TSC_UNSTABLE_BIT (1 << 0)
+
 #endif /* _ASM_X86_KVM_H */
-- 
1.8.3.1
