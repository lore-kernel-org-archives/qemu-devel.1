Received: from eggs.gnu.org ([2001:4830:134:3::10]:50183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yl-0007Hz-7Y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dn5yi-0006J5-P3
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dn5yi-0006Ij-H5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:36:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UGa36d083450
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:29 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cnur1hj5k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:36:29 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 17:36:26 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 18:36:04 +0200
In-Reply-To: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170830163609.50260-5-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for SSCH
 and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Simplify the error handling of the SSCH and RSCH handler avoiding
arbitrary and cryptic error codes being mapped to what a subchannel is
supposed to do.  Let the code detecting the condition tell how it's to be
handled in a less ambiguous way.  It's best to handle SSCH and RSCH in
one go as the emulation of the two shares a lot of code.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

---
Notes:
Funny, we had a different swich-case for SSCH and RSCH. For
virtual it did not matter, but for passtrough it could. In practice
-EINVAL from the kernel would have been mapped to cc 2 in case of
RSCH and to cc 1 in case of SSHC which is absurd. Same goes for
-EBUSY from kernel which is correctly mapped to cc 2 in case of
SSCH, but for RSCH it gets mapped to cc 1 which is also absurd.
---
 hw/s390x/css.c              | 86 ++++++++++++++-------------------------------
 hw/s390x/s390-ccw.c         |  8 ++---
 hw/vfio/ccw.c               | 32 +++++++++++++----
 include/hw/s390x/css.h      | 30 ++++++++++++----
 include/hw/s390x/s390-ccw.h |  2 +-
 target/s390x/ioinst.c       | 61 +++++++++-----------------------
 6 files changed, 97 insertions(+), 122 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index bc47bf5b20..1102642c10 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1015,12 +1015,11 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
 
 }
 
-static int sch_handle_start_func_passthrough(SubchDev *sch)
+static void sch_handle_start_func_passthrough(SubchDev *sch)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
     SCSW *s = &sch->curr_status.scsw;
-    int ret;
 
     ORB *orb = &sch->orb;
     if (!(s->ctrl & SCSW_ACTL_SUSP)) {
@@ -1034,28 +1033,10 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
      */
     if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
         !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
-        return -ENODEV;
+        sch->iret.cc = 3;
     }
 
-    ret = s390_ccw_cmd_request(orb, s, sch->driver_data);
-    switch (ret) {
-    /* Currently we don't update control block and just return the cc code. */
-    case 0:
-        break;
-    case -EBUSY:
-        break;
-    case -ENODEV:
-        break;
-    case -EFAULT:
-         break;
-    case -EACCES:
-        /* Let's reflect an inaccessible host device by cc 3. */
-    default:
-        /* Let's make all other return codes map to cc 3.  */
-        ret = -ENODEV;
-    };
-
-    return ret;
+    s390_ccw_cmd_request(sch);
 }
 
 /*
@@ -1064,7 +1045,7 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-int do_subchannel_work_virtual(SubchDev *sch)
+void do_subchannel_work_virtual(SubchDev *sch)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -1078,41 +1059,35 @@ int do_subchannel_work_virtual(SubchDev *sch)
         sch_handle_start_func_virtual(sch);
     } else {
         /* Cannot happen. */
-        return -ENODEV;
+        sch->iret.cc = 3;
     }
     css_inject_io_interrupt(sch);
-    return 0;
 }
 
-int do_subchannel_work_passthrough(SubchDev *sch)
+void do_subchannel_work_passthrough(SubchDev *sch)
 {
-    int ret;
     SCSW *s = &sch->curr_status.scsw;
 
     if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
         /* TODO: Clear handling */
         sch_handle_clear_func(sch);
-        ret = 0;
     } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
         /* TODO: Halt handling */
         sch_handle_halt_func(sch);
-        ret = 0;
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
-        ret = sch_handle_start_func_passthrough(sch);
+        sch_handle_start_func_passthrough(sch);
     } else {
         /* Cannot happen. */
-        return -ENODEV;
+        sch->iret.cc = 3;
     }
-
-    return ret;
 }
 
-static int do_subchannel_work(SubchDev *sch)
+static void do_subchannel_work(SubchDev *sch)
 {
     if (sch->do_subchannel_work) {
-        return sch->do_subchannel_work(sch);
+        sch->do_subchannel_work(sch);
     } else {
-        return -ENODEV;
+        sch->iret.cc = 3;
     }
 }
 
@@ -1400,27 +1375,26 @@ static void css_update_chnmon(SubchDev *sch)
     }
 }
 
-int css_do_ssch(SubchDev *sch, ORB *orb)
+void css_do_ssch(SubchDev *sch, ORB *orb)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
-    int ret;
 
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
-        ret = -ENODEV;
-        goto out;
+        sch->iret.cc = 3;
+        return;
     }
 
     if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
-        ret = -EINPROGRESS;
-        goto out;
+        sch->iret.cc = 1;
+        return;
     }
 
     if (s->ctrl & (SCSW_FCTL_START_FUNC |
                    SCSW_FCTL_HALT_FUNC |
                    SCSW_FCTL_CLEAR_FUNC)) {
-        ret = -EBUSY;
-        goto out;
+        sch->iret.cc = 2;
+        return;
     }
 
     /* If monitoring is active, update counter. */
@@ -1433,10 +1407,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    ret = do_subchannel_work(sch);
-
-out:
-    return ret;
+    do_subchannel_work(sch);
 }
 
 static void copy_irb_to_guest(IRB *dest, const IRB *src, PMCW *pmcw,
@@ -1683,27 +1654,26 @@ void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo)
     }
 }
 
-int css_do_rsch(SubchDev *sch)
+void css_do_rsch(SubchDev *sch)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
-    int ret;
 
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
-        ret = -ENODEV;
-        goto out;
+        sch->iret.cc = 3;
+        return;
     }
 
     if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
-        ret = -EINPROGRESS;
-        goto out;
+        sch->iret.cc = 1;
+        return;
     }
 
     if (((s->ctrl & SCSW_CTRL_MASK_FCTL) != SCSW_FCTL_START_FUNC) ||
         (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
         (!(s->ctrl & SCSW_ACTL_SUSP))) {
-        ret = -EINVAL;
-        goto out;
+        sch->iret.cc = 2;
+        return;
     }
 
     /* If monitoring is active, update counter. */
@@ -1713,10 +1683,6 @@ int css_do_rsch(SubchDev *sch)
 
     s->ctrl |= SCSW_ACTL_RESUME_PEND;
     do_subchannel_work(sch);
-    ret = 0;
-
-out:
-    return ret;
 }
 
 int css_do_rchp(uint8_t cssid, uint8_t chpid)
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 2b0741741c..fa0947894d 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -18,14 +18,14 @@
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-ccw.h"
 
-int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data)
+void s390_ccw_cmd_request(SubchDev *sch)
 {
-    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(data);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
 
     if (cdc->handle_request) {
-        return cdc->handle_request(orb, scsw, data);
+        cdc->handle_request(sch);
     } else {
-        return -ENODEV;
+        sch->iret.cc = 3;
     }
 }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index a8baadf57a..b2827ce987 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -23,6 +23,7 @@
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/ccw-device.h"
 #include "qemu/error-report.h"
+#include "cpu.h"
 
 #define TYPE_VFIO_CCW "vfio-ccw"
 typedef struct VFIOCCWDevice {
@@ -47,9 +48,9 @@ struct VFIODeviceOps vfio_ccw_ops = {
     .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
 };
 
-static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
+static void vfio_ccw_handle_request(SubchDev *sch)
 {
-    S390CCWDevice *cdev = data;
+    S390CCWDevice *cdev = sch->driver_data;
     VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
     struct ccw_io_region *region = vcdev->io_region;
     int ret;
@@ -60,8 +61,8 @@ static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
 
     memset(region, 0, sizeof(*region));
 
-    memcpy(region->orb_area, orb, sizeof(ORB));
-    memcpy(region->scsw_area, scsw, sizeof(SCSW));
+    memcpy(region->orb_area, &sch->orb, sizeof(ORB));
+    memcpy(region->scsw_area, &sch->curr_status.scsw, sizeof(SCSW));
 
 again:
     ret = pwrite(vcdev->vdev.fd, region,
@@ -71,10 +72,27 @@ again:
             goto again;
         }
         error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
-        return -errno;
+        ret = -errno;
+    } else {
+        ret = region->ret_code;
+    }
+    switch (-ret) {
+    /* Currently we don't update control block and just return the cc code. */
+    case 0:
+        sch->iret.cc = 0;
+        break;
+    case EBUSY:
+        sch->iret.cc = 2;
+        break;
+    case EFAULT:
+        sch->iret.pgm_chk = true;
+        sch->iret.irq_code = PGM_ADDRESSING;
+        break;
+    case ENODEV:
+    case EACCES:
+    default:
+        sch->iret.cc = 3;
     }
-
-    return region->ret_code;
 }
 
 static void vfio_ccw_reset(DeviceState *dev)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 5c5fe6b202..d093181a9e 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -94,13 +94,31 @@ struct SubchDev {
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
-    int (*do_subchannel_work) (SubchDev *);
+    void (*do_subchannel_work) (SubchDev *);
     SenseId id;
     void *driver_data;
+    /* io instructions conclude according to iret */
+    struct {
+        /*
+         * General semantic of cc codes of IO instructions is (brief):
+         * 0 -- produced expected result
+         * 1 -- produced alternate result
+         * 2 -- ineffective, because busy with previously initiated function
+         * 3 -- ineffective, not operational
+         */
+        uint32_t cc:4;
+        bool pgm_chk:1;
+        uint32_t irq_code;
+    } iret;
 };
 
 extern const VMStateDescription vmstate_subch_dev;
 
+static inline void css_subch_clear_iret(SubchDev *sch)
+{
+    memset(&sch->iret, 0, sizeof(sch->iret));
+}
+
 /*
  * Identify a device within the channel subsystem.
  * Note that this can be used to identify either the subchannel or
@@ -156,9 +174,9 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
 void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
 void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
-int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data);
-int do_subchannel_work_virtual(SubchDev *sub);
-int do_subchannel_work_passthrough(SubchDev *sub);
+void s390_ccw_cmd_request(SubchDev *sch);
+void do_subchannel_work_virtual(SubchDev *sub);
+void do_subchannel_work_passthrough(SubchDev *sub);
 
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
@@ -189,7 +207,7 @@ int css_do_msch(SubchDev *sch, const SCHIB *schib);
 int css_do_xsch(SubchDev *sch);
 int css_do_csch(SubchDev *sch);
 int css_do_hsch(SubchDev *sch);
-int css_do_ssch(SubchDev *sch, ORB *orb);
+void css_do_ssch(SubchDev *sch, ORB *orb);
 int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
 void css_do_tsch_update_subch(SubchDev *sch);
 int css_do_stcrw(CRW *crw);
@@ -200,7 +218,7 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
 void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo);
 int css_enable_mcsse(void);
 int css_enable_mss(void);
-int css_do_rsch(SubchDev *sch);
+void css_do_rsch(SubchDev *sch);
 int css_do_rchp(uint8_t cssid, uint8_t chpid);
 bool css_present(uint8_t cssid);
 #endif
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 9f45cf1347..d2159c9ed7 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -33,7 +33,7 @@ typedef struct S390CCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
     void (*unrealize)(S390CCWDevice *dev, Error **errp);
-    int (*handle_request) (ORB *, SCSW *, void *);
+    void (*handle_request) (SubchDev *sch);
 } S390CCWDeviceClass;
 
 #endif
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 51fbea620d..e8044068c2 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -217,8 +217,6 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     SubchDev *sch;
     ORB orig_orb, orb;
     uint64_t addr;
-    int ret = -ENODEV;
-    int cc;
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
@@ -238,33 +236,17 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     }
     trace_ioinst_sch_id("ssch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_ssch(sch, &orb);
+    if (!sch || !css_subch_visible(sch)) {
+        setcc(cpu, 3);
+        return;
     }
-    switch (ret) {
-    case -ENODEV:
-        cc = 3;
-        break;
-    case -EBUSY:
-        cc = 2;
-        break;
-    case -EFAULT:
-        /*
-         * TODO:
-         * I'm wondering whether there is something better
-         * to do for us here (like setting some device or
-         * subchannel status).
-         */
-        program_interrupt(env, PGM_ADDRESSING, 4);
+    css_subch_clear_iret(sch);
+    css_do_ssch(sch, &orb);
+    if (sch->iret.pgm_chk) {
+        program_interrupt(env, sch->iret.irq_code, 4);
         return;
-    case 0:
-        cc = 0;
-        break;
-    default:
-        cc = 1;
-        break;
     }
-    setcc(cpu, cc);
+    setcc(cpu, sch->iret.cc);
 }
 
 void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb)
@@ -767,8 +749,6 @@ void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    int ret = -ENODEV;
-    int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
@@ -776,24 +756,17 @@ void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1)
     }
     trace_ioinst_sch_id("rsch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_rsch(sch);
+    if (!sch || !css_subch_visible(sch)) {
+        setcc(cpu, 3);
+        return;
     }
-    switch (ret) {
-    case -ENODEV:
-        cc = 3;
-        break;
-    case -EINVAL:
-        cc = 2;
-        break;
-    case 0:
-        cc = 0;
-        break;
-    default:
-        cc = 1;
-        break;
+    css_subch_clear_iret(sch);
+    css_do_rsch(sch);
+    if (sch->iret.pgm_chk) {
+        program_interrupt(&cpu->env, sch->iret.irq_code, 4);
+        return;
     }
-    setcc(cpu, cc);
+    setcc(cpu, sch->iret.cc);
 }
 
 #define RCHP_REG1_RES(_reg) (_reg & 0x00000000ff00ff00)
-- 
2.13.5
