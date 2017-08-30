Received: from eggs.gnu.org ([2001:4830:134:3::10]:57275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GP-0002jv-Rm
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GL-0005XT-Vq
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6GL-0005X0-N7
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:31 +0200
Message-Id: <20170830165252.13421-24-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 23/44] s390x/kvm: drop KVMState parameter from
 s390_get_memslot_count()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Not needed at that point.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-2-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c    | 2 +-
 target/s390x/cpu.h | 8 ++++----
 target/s390x/kvm.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 7ae6a0e37a..ffdf4712a1 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -57,7 +57,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     CPUState *cpu;
     int cpu_count = 0;
     int rnsize, rnmax;
-    int slots = MIN(machine->ram_slots, s390_get_memslot_count(kvm_state));
+    int slots = MIN(machine->ram_slots, s390_get_memslot_count());
     IplParameterBlock *ipib = s390_ipl_get_iplb();
 
     CPU_FOREACH(cpu) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 29fdd5d49a..44b1a7ab71 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1164,7 +1164,7 @@ void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
 int kvm_s390_cpu_restart(S390CPU *cpu);
-int kvm_s390_get_memslot_count(KVMState *s);
+int kvm_s390_get_memslot_count(void);
 int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
@@ -1204,7 +1204,7 @@ static inline int kvm_s390_cpu_restart(S390CPU *cpu)
 static inline void kvm_s390_cmma_reset(void)
 {
 }
-static inline int kvm_s390_get_memslot_count(KVMState *s)
+static inline int kvm_s390_get_memslot_count(void)
 {
   return MAX_AVAIL_SLOTS;
 }
@@ -1263,10 +1263,10 @@ static inline int s390_cpu_restart(S390CPU *cpu)
     return -ENOSYS;
 }
 
-static inline int s390_get_memslot_count(KVMState *s)
+static inline int s390_get_memslot_count(void)
 {
     if (kvm_enabled()) {
-        return kvm_s390_get_memslot_count(s);
+        return kvm_s390_get_memslot_count();
     } else {
         return MAX_AVAIL_SLOTS;
     }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 9de165d8b1..d961fcf18b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2317,9 +2317,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
     return kvm_vm_ioctl(kvm_state, KVM_IOEVENTFD, &kick);
 }
 
-int kvm_s390_get_memslot_count(KVMState *s)
+int kvm_s390_get_memslot_count(void)
 {
-    return kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
+    return kvm_check_extension(kvm_state, KVM_CAP_NR_MEMSLOTS);
 }
 
 int kvm_s390_get_ri(void)
-- 
2.13.5
