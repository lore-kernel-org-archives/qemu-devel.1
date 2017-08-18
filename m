Received: from eggs.gnu.org ([2001:4830:134:3::10]:49202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difh6-0001pN-OA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difh5-00077J-Bv
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difh5-000773-2x
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:36 +0200
Message-Id: <20170818114353.13455-2-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 01/18] s390x/kvm: drop KVMState
 parameter from s390_get_memslot_count()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Not needed at that point.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/sclp.c    | 2 +-
 target/s390x/cpu.h | 8 ++++----
 target/s390x/kvm.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9253dbb..8dd1109 100644
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
index 29fdd5d..44b1a7a 100644
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
index c4c5791..d0bb9e9 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2289,9 +2289,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
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
2.9.4
