Received: from eggs.gnu.org ([2001:4830:134:3::10]:49529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difht-0002Zs-T6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhp-0007Rd-Ur
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhp-0007RI-ML
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:49 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:50 +0200
Message-Id: <20170818114353.13455-16-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 for-2.11 15/18] target/s390x: move a couple
 of functions to cpu.c
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

Prepare to move more stuff (especially KVM related) from cpu.h to
internal.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.h | 89 ++++++------------------------------------------=
------
 2 files changed, 89 insertions(+), 79 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index dadd383..90e2db7 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -392,6 +392,85 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S=
390CPU *cpu)
=20
     return s390_count_running_cpus();
 }
+
+int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_get_clock(tod_high, tod_low);
+    }
+    /* Fixme TCG */
+    *tod_high =3D 0;
+    *tod_low =3D 0;
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
+        return kvm_s390_set_mem_limit(new_limit, hw_limit);
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
+int s390_get_memslot_count(void)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_get_memslot_count();
+    } else {
+        return MAX_AVAIL_SLOTS;
+    }
+}
+
+int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id=
,
+                                int vq, bool assign)
+{
+    if (kvm_enabled()) {
+        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, ass=
ign);
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
+    if (object_property_get_bool(OBJECT(qdev_get_machine()), "s390-squas=
h-mcss",
+                                 NULL)) {
+        return true;
+    }
+
+    return false;
+}
 #endif
=20
 static gchar *s390_gdb_arch_name(CPUState *cs)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index af941f8..a2cefb7 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -439,25 +439,8 @@ static inline void kvm_s390_access_exception(S390CPU=
 *cpu, uint16_t code,
 }
 #endif
=20
-static inline int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_get_clock(tod_high, tod_low);
-    }
-    /* Fixme TCG */
-    *tod_high =3D 0;
-    *tod_low =3D 0;
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
=20
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
@@ -805,69 +788,17 @@ static inline void kvm_s390_crypto_reset(void)
 }
 #endif
=20
-static inline int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw=
_limit)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_set_mem_limit(new_limit, hw_limit);
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
-static inline int s390_get_memslot_count(void)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_get_memslot_count();
-    } else {
-        return MAX_AVAIL_SLOTS;
-    }
-}
-
+int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
+void s390_cmma_reset(void);
+int s390_cpu_restart(S390CPU *cpu);
+int s390_get_memslot_count(void);
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
 void s390_crw_mchk(void);
-
-static inline int s390_assign_subch_ioeventfd(EventNotifier *notifier,
-                                              uint32_t sch_id, int vq,
-                                              bool assign)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_assign_subch_ioeventfd(notifier, sch_id, vq, ass=
ign);
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
-    if (object_property_get_bool(OBJECT(qdev_get_machine()), "s390-squas=
h-mcss",
-                                 NULL)) {
-        return true;
-    }
-
-    return false;
-}
+int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id=
,
+                                int vq, bool assign);
+void s390_crypto_reset(void);
+bool s390_get_squash_mcss(void);
=20
 /* machine check interruption code */
=20
--=20
2.9.4
