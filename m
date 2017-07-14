Received: from eggs.gnu.org ([2001:4830:134:3::10]:56855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPG-000054-4m
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPC-00044C-1D
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyPB-00043N-N7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB4snT110253
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:04 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmjb1f5u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:04 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:04:54 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:37 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-11-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 10/40] s390x/sic: realize SIC handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

Currently, we do nothing for the SIC instruction, but we need to
implement it properly. Let's add proper handling in the backend code.

Co-authored-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/css.c         | 26 ++++++++++++++++++++++++++
 hw/s390x/trace-events  |  1 +
 include/hw/s390x/css.h |  2 ++
 target/s390x/kvm.c     | 16 +++++++++++++++-
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1fcbc84..7b82176 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -521,6 +521,32 @@ void css_conditional_io_interrupt(SubchDev *sch)
     }
 }
 
+int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode)
+{
+    S390FLICState *fs = s390_get_flic();
+    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
+    int r;
+
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        r = -PGM_PRIVILEGED;
+        goto out;
+    }
+
+    trace_css_do_sic(mode, isc);
+    switch (mode) {
+    case SIC_IRQ_MODE_ALL:
+    case SIC_IRQ_MODE_SINGLE:
+        break;
+    default:
+        r = -PGM_OPERAND;
+        goto out;
+    }
+
+    r = fsc->modify_ais_mode(fs, isc, mode) ? -PGM_OPERATION : 0;
+out:
+    return r;
+}
+
 void css_adapter_interrupt(uint8_t isc)
 {
     uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
index 84ea964..f07e974 100644
--- a/hw/s390x/trace-events
+++ b/hw/s390x/trace-events
@@ -8,6 +8,7 @@ css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %02x
 css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
 css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm %08x, isc %x) %s"
 css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x)"
+css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode %x on isc %x"
 
 # hw/s390x/virtio-ccw.c
 virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index e028960..5ee6d52 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -12,6 +12,7 @@
 #ifndef CSS_H
 #define CSS_H
 
+#include "cpu.h"
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
@@ -165,6 +166,7 @@ typedef enum {
     CSS_IO_ADAPTER_TYPE_NUMS,
 } CssIoAdapterType;
 
+int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode);
 uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
                               uint8_t flags, Error **errp);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 7a2a7c0..78ebe83 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1206,7 +1206,21 @@ static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
 
 static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
 {
-    /* NOOP */
+    CPUS390XState *env = &cpu->env;
+    uint8_t r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
+    uint8_t r3 = run->s390_sieic.ipa & 0x000f;
+    uint8_t isc;
+    uint16_t mode;
+    int r;
+
+    cpu_synchronize_state(CPU(cpu));
+    mode = env->regs[r1] & 0xffff;
+    isc = (env->regs[r3] >> 27) & 0x7;
+    r = css_do_sic(env, isc, mode);
+    if (r) {
+        enter_pgmcheck(cpu, -r);
+    }
+
     return 0;
 }
 
-- 
2.7.4
