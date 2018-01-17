Received: from eggs.gnu.org ([2001:4830:134:3::10]:47208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebrix-0000gY-I6
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebriw-00009F-BV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:42:07 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 17 Jan 2018 18:40:45 +0100
Message-Id: <20180117174047.6382-17-david@redhat.com>
In-Reply-To: <20180117174047.6382-1-david@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/18] s390x/tcg: cache the qemu flic in a
 central function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

This avoids tons of conversions when handling interrupts.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic.c          | 23 +++++++++++++++++------
 include/hw/s390x/s390_flic.h |  1 +
 target/s390x/interrupt.c     |  6 +++---
 target/s390x/misc_helper.c   |  2 +-
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 5febde2d65..b46c0f1bb4 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -22,6 +22,17 @@
 #include "qapi/error.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
+QEMUS390FLICState *s390_get_qemu_flic(S390FLICState *fs)
+{
+    static QEMUS390FLICState *flic;
+
+    if (!flic) {
+        /* we only have one flic device, so this is fine to cache */
+        flic = QEMU_S390_FLIC(fs);
+    }
+    return flic;
+}
+
 S390FLICState *s390_get_flic(void)
 {
     static S390FLICState *fs;
@@ -79,7 +90,7 @@ static void qemu_s390_release_adapter_routes(S390FLICState *fs,
 static int qemu_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
                            uint16_t subchannel_nr)
 {
-    QEMUS390FLICState *flic  = QEMU_S390_FLIC(fs);
+    QEMUS390FLICState *flic  = s390_get_qemu_flic(fs);
     QEMUS390FlicIO *cur, *next;
     uint8_t isc;
 
@@ -113,7 +124,7 @@ static int qemu_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
 static int qemu_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
                                      uint16_t mode)
 {
-    QEMUS390FLICState *flic  = QEMU_S390_FLIC(fs);
+    QEMUS390FLICState *flic  = s390_get_qemu_flic(fs);
 
     switch (mode) {
     case SIC_IRQ_MODE_ALL:
@@ -134,7 +145,7 @@ static int qemu_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
 static int qemu_s390_inject_airq(S390FLICState *fs, uint8_t type,
                                  uint8_t isc, uint8_t flags)
 {
-    QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
+    QEMUS390FLICState *flic = s390_get_qemu_flic(fs);
     S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
     bool flag = flags & S390_ADAPTER_SUPPRESSIBLE;
     uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
@@ -246,7 +257,7 @@ void qemu_s390_flic_dequeue_crw_mchk(QEMUS390FLICState *flic)
 
 static void qemu_s390_inject_service(S390FLICState *fs, uint32_t parm)
 {
-    QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
+    QEMUS390FLICState *flic = s390_get_qemu_flic(fs);
 
     g_assert(qemu_mutex_iothread_locked());
     /* multiplexing is good enough for sclp - kvm does it internally as well */
@@ -261,7 +272,7 @@ static void qemu_s390_inject_io(S390FLICState *fs, uint16_t subchannel_id,
                                 uint32_t io_int_word)
 {
     const uint8_t isc = IO_INT_WORD_ISC(io_int_word);
-    QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
+    QEMUS390FLICState *flic = s390_get_qemu_flic(fs);
     QEMUS390FlicIO *io;
 
     g_assert(qemu_mutex_iothread_locked());
@@ -279,7 +290,7 @@ static void qemu_s390_inject_io(S390FLICState *fs, uint16_t subchannel_id,
 
 static void qemu_s390_inject_crw_mchk(S390FLICState *fs)
 {
-    QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
+    QEMUS390FLICState *flic = s390_get_qemu_flic(fs);
 
     g_assert(qemu_mutex_iothread_locked());
     flic->pending |= FLIC_PENDING_MCHK_CR;
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 566d153371..a636afce42 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -135,6 +135,7 @@ bool qemu_s390_flic_has_any(QEMUS390FLICState *flic);
 void s390_flic_init(void);
 
 S390FLICState *s390_get_flic(void);
+QEMUS390FLICState *s390_get_qemu_flic(S390FLICState *fs);
 bool ais_needed(void *opaque);
 
 #endif /* HW_S390_FLIC_H */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 61691aa3a4..1947012b25 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -158,7 +158,7 @@ void s390_crw_mchk(void)
 
 bool s390_cpu_has_mcck_int(S390CPU *cpu)
 {
-    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
+    QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
     CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_MCHECK)) {
@@ -176,7 +176,7 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
 
 bool s390_cpu_has_ext_int(S390CPU *cpu)
 {
-    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
+    QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
     CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
@@ -218,7 +218,7 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
 
 bool s390_cpu_has_io_int(S390CPU *cpu)
 {
-    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
+    QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
     CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_IO)) {
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 083eb2d91b..a6a7dac623 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -452,7 +452,7 @@ uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
 {
     const uintptr_t ra = GETPC();
     S390CPU *cpu = s390_env_get_cpu(env);
-    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
+    QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
     QEMUS390FlicIO *io = NULL;
     LowCore *lowcore;
 
-- 
2.14.3
