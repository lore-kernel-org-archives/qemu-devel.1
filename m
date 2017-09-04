Received: from eggs.gnu.org ([2001:4830:134:3::10]:37643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXQ-0004WT-Tc
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXL-00011j-Ec
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotXL-00011N-63
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:43 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:43:05 +0200
Message-Id: <20170904154316.4148-9-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/19] s390x: move sclp_service_call() to
 interrupt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

Fix up includes and rename it to s390x_*.
cpu.h is now free of externally implemented functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/sclp.c            | 51 +---------------------------------------------
 include/hw/s390x/sclp.h    |  1 +
 target/s390x/cpu.h         |  5 +----
 target/s390x/interrupt.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/kvm.c         |  2 +-
 target/s390x/misc_helper.c |  2 +-
 6 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index fd097262c7..9618dfac0a 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -24,7 +24,7 @@
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
 
-static inline SCLPDevice *get_sclp_device(void)
+SCLPDevice *get_sclp_device(void)
 {
     static SCLPDevice *sclp;
 
@@ -424,55 +424,6 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
     }
 }
 
-int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
-{
-    SCLPDevice *sclp = get_sclp_device();
-    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
-    int r = 0;
-    SCCB work_sccb;
-
-    hwaddr sccb_len = sizeof(SCCB);
-
-    /* first some basic checks on program checks */
-    if (env->psw.mask & PSW_MASK_PSTATE) {
-        r = -PGM_PRIVILEGED;
-        goto out;
-    }
-    if (cpu_physical_memory_is_io(sccb)) {
-        r = -PGM_ADDRESSING;
-        goto out;
-    }
-    if ((sccb & ~0x1fffUL) == 0 || (sccb & ~0x1fffUL) == env->psa
-        || (sccb & ~0x7ffffff8UL) != 0) {
-        r = -PGM_SPECIFICATION;
-        goto out;
-    }
-
-    /*
-     * we want to work on a private copy of the sccb, to prevent guests
-     * from playing dirty tricks by modifying the memory content after
-     * the host has checked the values
-     */
-    cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
-
-    /* Valid sccb sizes */
-    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader) ||
-        be16_to_cpu(work_sccb.h.length) > SCCB_SIZE) {
-        r = -PGM_SPECIFICATION;
-        goto out;
-    }
-
-    sclp_c->execute(sclp, &work_sccb, code);
-
-    cpu_physical_memory_write(sccb, &work_sccb,
-                              be16_to_cpu(work_sccb.h.length));
-
-    sclp_c->service_interrupt(sclp, sccb);
-
-out:
-    return r;
-}
-
 static void service_interrupt(SCLPDevice *sclp, uint32_t sccb)
 {
     SCLPEventFacility *ef = sclp->event_facility;
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index a72d096081..1cc233d01f 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -237,6 +237,7 @@ static inline int sccb_data_len(SCCB *sccb)
 }
 
 
+SCLPDevice *get_sclp_device(void);
 void s390_sclp_init(void);
 sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
 sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 6c0abb9894..147aceba28 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -698,6 +698,7 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo, void *puc);
 
 
 /* interrupt.c */
+int s390x_sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
 void s390_crw_mchk(void);
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
@@ -718,8 +719,4 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
         s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
 
-
-/* outside of target/s390x/ */
-int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
-
 #endif
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 9aa6b89301..a3b627dd40 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -17,6 +17,7 @@
 #include "hw/s390x/ioinst.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/s390x/sclp.h"
 #endif
 
 /* Ensure to exit the TB after this call! */
@@ -161,4 +162,52 @@ void s390_crw_mchk(void)
     }
 }
 
+int s390x_sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
+{
+    SCLPDevice *sclp = get_sclp_device();
+    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
+    int r = 0;
+    SCCB work_sccb;
+
+    hwaddr sccb_len = sizeof(SCCB);
+
+    /* first some basic checks on program checks */
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        r = -PGM_PRIVILEGED;
+        goto out;
+    }
+    if (cpu_physical_memory_is_io(sccb)) {
+        r = -PGM_ADDRESSING;
+        goto out;
+    }
+    if ((sccb & ~0x1fffUL) == 0 || (sccb & ~0x1fffUL) == env->psa
+        || (sccb & ~0x7ffffff8UL) != 0) {
+        r = -PGM_SPECIFICATION;
+        goto out;
+    }
+
+    /*
+     * we want to work on a private copy of the sccb, to prevent guests
+     * from playing dirty tricks by modifying the memory content after
+     * the host has checked the values
+     */
+    cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
+
+    /* Valid sccb sizes */
+    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader) ||
+        be16_to_cpu(work_sccb.h.length) > SCCB_SIZE) {
+        r = -PGM_SPECIFICATION;
+        goto out;
+    }
+
+    sclp_c->execute(sclp, &work_sccb, code);
+
+    cpu_physical_memory_write(sccb, &work_sccb,
+                              be16_to_cpu(work_sccb.h.length));
+
+    sclp_c->service_interrupt(sclp, sccb);
+
+out:
+    return r;
+}
 #endif
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ed59896423..c36e4efdec 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1069,7 +1069,7 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
     sccb = env->regs[ipbh0 & 0xf];
     code = env->regs[(ipbh0 & 0xf0) >> 4];
 
-    r = sclp_service_call(env, sccb, code);
+    r = s390x_sclp_service_call(env, sccb, code);
     if (r < 0) {
         kvm_s390_program_interrupt(cpu, -r);
     } else {
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index b142db71c6..57c02ddf1b 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -76,7 +76,7 @@ void HELPER(exception)(CPUS390XState *env, uint32_t excp)
 uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
     qemu_mutex_lock_iothread();
-    int r = sclp_service_call(env, r1, r2);
+    int r = s390x_sclp_service_call(env, r1, r2);
     if (r < 0) {
         program_interrupt(env, -r, 4);
         r = 0;
-- 
2.13.5
