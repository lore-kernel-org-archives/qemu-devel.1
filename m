Received: from eggs.gnu.org ([2001:4830:134:3::10]:36227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4f1-0001hY-Fw
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4f0-0003Dy-7J
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dg4ez-0003Dd-UO
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:10 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 Aug 2017 09:46:49 +0200
Message-Id: <20170811074652.31474-3-david@redhat.com>
In-Reply-To: <20170811074652.31474-1-david@redhat.com>
References: <20170811074652.31474-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/5] target/s390x: move a couple of
 functions to cpu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.h | 88 +++++++-----------------------------------------------
 2 files changed, 90 insertions(+), 78 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index dadd383..81165e8 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -392,6 +392,86 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 
     return s390_count_running_cpus();
 }
+
+int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_get_clock(tod_high, tod_low);
+    }
+    /* Fixme TCG */
+    *tod_high = 0;
+    *tod_low = 0;
+    return 0;
+}
+
+int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_set_clock(tod_high, tod_low);
+    }
+    /* Fixme TCG */
+    return 0;
+}
+
+int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_set_mem_limit(kvm_state, new_limit, hw_limit);
+    }
+    return 0;
+}
+
+void s390_cmma_reset(void)
+{
+    if (kvm_enabled()) {
+        kvm_s390_cmma_reset();
+    }
+}
+
+int s390_cpu_restart(S390CPU *cpu)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_cpu_restart(cpu);
+    }
+    return -ENOSYS;
+}
+
+int s390_get_memslot_count(KVMState *s)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_get_memslot_count(s);
+    } else {
+        return MAX_AVAIL_SLOTS;
+    }
+}
+
+int s390_assign_subch_ioeventfd(EventNotifier *notifier,
+                                              uint32_t sch_id, int vq,
+                                              bool assign)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
+    } else {
+        return 0;
+    }
+}
+
+void s390_crypto_reset(void)
+{
+    if (kvm_enabled()) {
+        kvm_s390_crypto_reset();
+    }
+}
+
+bool s390_get_squash_mcss(void)
+{
+    if (object_property_get_bool(OBJECT(qdev_get_machine()), "s390-squash-mcss",
+                                 NULL)) {
+        return true;
+    }
+
+    return false;
+}
 #endif
 
 static gchar *s390_gdb_arch_name(CPUState *cs)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1ab88ad..a9acef6 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -421,25 +421,8 @@ static inline int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
 }
 #endif
 
-static inline int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_get_clock(tod_high, tod_low);
-    }
-    /* Fixme TCG */
-    *tod_high = 0;
-    *tod_low = 0;
-    return 0;
-}
-
-static inline int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_set_clock(tod_high, tod_low);
-    }
-    /* Fixme TCG */
-    return 0;
-}
+int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
+int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low);
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
@@ -750,69 +733,18 @@ static inline void kvm_s390_crypto_reset(void)
 }
 #endif
 
-static inline int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_set_mem_limit(kvm_state, new_limit, hw_limit);
-    }
-    return 0;
-}
-
-static inline void s390_cmma_reset(void)
-{
-    if (kvm_enabled()) {
-        kvm_s390_cmma_reset();
-    }
-}
-
-static inline int s390_cpu_restart(S390CPU *cpu)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_cpu_restart(cpu);
-    }
-    return -ENOSYS;
-}
-
-static inline int s390_get_memslot_count(KVMState *s)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_get_memslot_count(s);
-    } else {
-        return MAX_AVAIL_SLOTS;
-    }
-}
-
+int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
+void s390_cmma_reset(void);
+int s390_cpu_restart(S390CPU *cpu);
+int s390_get_memslot_count(KVMState *s);
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
 void s390_crw_mchk(void);
-
-static inline int s390_assign_subch_ioeventfd(EventNotifier *notifier,
+int s390_assign_subch_ioeventfd(EventNotifier *notifier,
                                               uint32_t sch_id, int vq,
-                                              bool assign)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, assign);
-    } else {
-        return 0;
-    }
-}
-
-static inline void s390_crypto_reset(void)
-{
-    if (kvm_enabled()) {
-        kvm_s390_crypto_reset();
-    }
-}
-
-static inline bool s390_get_squash_mcss(void)
-{
-    if (object_property_get_bool(OBJECT(qdev_get_machine()), "s390-squash-mcss",
-                                 NULL)) {
-        return true;
-    }
-
-    return false;
-}
+                                              bool assign);
+void s390_crypto_reset(void);
+bool s390_get_squash_mcss(void);
 
 /* machine check interruption code */
 
-- 
2.9.4
