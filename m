Received: from eggs.gnu.org ([2001:4830:134:3::10]:37122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzloA-00026k-Ji
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzlo6-0003KE-Oq
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44162
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzlo6-0003J5-He
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:41:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94FdJH8112253
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 11:41:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dcxvfe6b7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:41:54 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 16:41:53 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 17:41:39 +0200
In-Reply-To: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171004154144.88995-4-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/8] s390x: improve error handling for SSCH
 and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Simplify the error handling of the SSCH and RSCH handler avoiding
arbitrary and cryptic error codes being used to tell how the instruction
is supposed to end.  Let the code detecting the condition tell how it's
to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
in one go as the emulation of the two shares a lot of code.

For passthrough this change isn't pure refactoring, but changes the
way kernel reported EFAULT is handled. After clarifying the kernel
interface we decided that EFAULT shall be mapped to unit exception.
Same goes for unexpected error codes.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

AFAIR we decided in the previous round to rather do transformation
and fixing in one patch than touch stuff twice. Hence this patch
ain't pure transformation any more.
---
 hw/s390x/css.c              | 83 +++++++++++++--------------------------------
 hw/s390x/s390-ccw.c         | 11 +++---
 hw/vfio/ccw.c               | 30 ++++++++++++----
 include/hw/s390x/css.h      | 24 +++++++++----
 include/hw/s390x/s390-ccw.h |  2 +-
 target/s390x/ioinst.c       | 53 ++++-------------------------
 6 files changed, 77 insertions(+), 126 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 4f47dbc8b0..b2978c3bae 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1003,12 +1003,11 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
 
 }
 
-static int sch_handle_start_func_passthrough(SubchDev *sch)
+static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
     SCSW *s = &sch->curr_status.scsw;
-    int ret;
 
     ORB *orb = &sch->orb;
     if (!(s->ctrl & SCSW_ACTL_SUSP)) {
@@ -1022,31 +1021,11 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
      */
     if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
         !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
-        return -EINVAL;
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return (IOInstEnding){.cc = 0};
     }
-
-    ret = s390_ccw_cmd_request(orb, s, sch->driver_data);
-    switch (ret) {
-    /* Currently we don't update control block and just return the cc code. */
-    case 0:
-        break;
-    case -EBUSY:
-        break;
-    case -ENODEV:
-        break;
-    case -EACCES:
-        /* Let's reflect an inaccessible host device by cc 3. */
-        ret = -ENODEV;
-        break;
-    default:
-       /*
-        * All other return codes will trigger a program check,
-        * or set cc to 1.
-        */
-       break;
-    };
-
-    return ret;
+    return s390_ccw_cmd_request(sch);
 }
 
 /*
@@ -1055,7 +1034,7 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-int do_subchannel_work_virtual(SubchDev *sch)
+IOInstEnding do_subchannel_work_virtual(SubchDev *sch)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -1069,12 +1048,12 @@ int do_subchannel_work_virtual(SubchDev *sch)
         sch_handle_start_func_virtual(sch);
     }
     css_inject_io_interrupt(sch);
-    return 0;
+    /* inst must succeed if this func is called */
+    return (IOInstEnding){.cc = 0};
 }
 
-int do_subchannel_work_passthrough(SubchDev *sch)
+IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
 {
-    int ret = 0;
     SCSW *s = &sch->curr_status.scsw;
 
     if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
@@ -1084,16 +1063,15 @@ int do_subchannel_work_passthrough(SubchDev *sch)
         /* TODO: Halt handling */
         sch_handle_halt_func(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
-        ret = sch_handle_start_func_passthrough(sch);
+        return sch_handle_start_func_passthrough(sch);
     }
-
-    return ret;
+    return (IOInstEnding){.cc = 0};
 }
 
-static int do_subchannel_work(SubchDev *sch)
+static IOInstEnding do_subchannel_work(SubchDev *sch)
 {
     if (!sch->do_subchannel_work) {
-        return -EINVAL;
+        return (IOInstEnding){.cc = 1};
     }
     g_assert(sch->curr_status.scsw.ctrl & SCSW_CTRL_MASK_FCTL);
     return sch->do_subchannel_work(sch);
@@ -1383,27 +1361,23 @@ static void css_update_chnmon(SubchDev *sch)
     }
 }
 
-int css_do_ssch(SubchDev *sch, ORB *orb)
+IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
-    int ret;
 
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
-        ret = -ENODEV;
-        goto out;
+        return (IOInstEnding){.cc = 3};
     }
 
     if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
-        ret = -EINPROGRESS;
-        goto out;
+        return (IOInstEnding){.cc = 1};
     }
 
     if (s->ctrl & (SCSW_FCTL_START_FUNC |
                    SCSW_FCTL_HALT_FUNC |
                    SCSW_FCTL_CLEAR_FUNC)) {
-        ret = -EBUSY;
-        goto out;
+        return (IOInstEnding){.cc = 2};
     }
 
     /* If monitoring is active, update counter. */
@@ -1416,10 +1390,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    ret = do_subchannel_work(sch);
-
-out:
-    return ret;
+    return do_subchannel_work(sch);
 }
 
 static void copy_irb_to_guest(IRB *dest, const IRB *src, PMCW *pmcw,
@@ -1666,27 +1637,23 @@ void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo)
     }
 }
 
-int css_do_rsch(SubchDev *sch)
+IOInstEnding css_do_rsch(SubchDev *sch)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
-    int ret;
 
     if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
-        ret = -ENODEV;
-        goto out;
+        return (IOInstEnding){.cc = 3};
     }
 
     if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
-        ret = -EINPROGRESS;
-        goto out;
+        return (IOInstEnding){.cc = 1};
     }
 
     if (((s->ctrl & SCSW_CTRL_MASK_FCTL) != SCSW_FCTL_START_FUNC) ||
         (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
         (!(s->ctrl & SCSW_ACTL_SUSP))) {
-        ret = -EINVAL;
-        goto out;
+        return (IOInstEnding){.cc = 2};
     }
 
     /* If monitoring is active, update counter. */
@@ -1695,11 +1662,7 @@ int css_do_rsch(SubchDev *sch)
     }
 
     s->ctrl |= SCSW_ACTL_RESUME_PEND;
-    do_subchannel_work(sch);
-    ret = 0;
-
-out:
-    return ret;
+    return do_subchannel_work(sch);
 }
 
 int css_do_rchp(uint8_t cssid, uint8_t chpid)
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 8614dda6f8..5d2c305b71 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -18,15 +18,14 @@
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-ccw.h"
 
-int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data)
+IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
 {
-    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(data);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
 
-    if (cdc->handle_request) {
-        return cdc->handle_request(orb, scsw, data);
-    } else {
-        return -ENOSYS;
+    if (!cdc->handle_request) {
+        return (IOInstEnding){.cc = 1};
     }
+    return cdc->handle_request(sch);
 }
 
 static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index a8baadf57a..dbb5b201de 100644
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
+static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
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
@@ -71,10 +72,25 @@ again:
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
+        return (IOInstEnding){.cc = 0};
+    case EBUSY:
+        return (IOInstEnding){.cc = 2};
+    case ENODEV:
+    case EACCES:
+        return (IOInstEnding){.cc = 3};
+    case EFAULT:
+    default:
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return (IOInstEnding){.cc = 0};
     }
-
-    return region->ret_code;
 }
 
 static void vfio_ccw_reset(DeviceState *dev)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 66916b6546..2116c6b3c7 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -107,11 +107,22 @@ struct SubchDev {
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
-    int (*do_subchannel_work) (SubchDev *);
+    IOInstEnding (*do_subchannel_work) (SubchDev *);
     SenseId id;
     void *driver_data;
 };
 
+static inline void sch_gen_unit_exception(SubchDev *sch)
+{
+    sch->curr_status.scsw.ctrl &= ~SCSW_ACTL_START_PEND;
+    sch->curr_status.scsw.ctrl |= SCSW_STCTL_PRIMARY |
+                                  SCSW_STCTL_SECONDARY |
+                                  SCSW_STCTL_ALERT |
+                                  SCSW_STCTL_STATUS_PEND;
+    sch->curr_status.scsw.cpa = sch->channel_prog + 8;
+    sch->curr_status.scsw.dstat =  SCSW_DSTAT_UNIT_EXCEP;
+}
+
 extern const VMStateDescription vmstate_subch_dev;
 
 /*
@@ -170,9 +181,9 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
 void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
 void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
-int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data);
-int do_subchannel_work_virtual(SubchDev *sub);
-int do_subchannel_work_passthrough(SubchDev *sub);
+IOInstEnding s390_ccw_cmd_request(SubchDev *sch);
+IOInstEnding do_subchannel_work_virtual(SubchDev *sub);
+IOInstEnding do_subchannel_work_passthrough(SubchDev *sub);
 
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
@@ -197,13 +208,14 @@ SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
 void css_conditional_io_interrupt(SubchDev *sch);
+
 int css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 int css_do_msch(SubchDev *sch, const SCHIB *schib);
 int css_do_xsch(SubchDev *sch);
 int css_do_csch(SubchDev *sch);
 int css_do_hsch(SubchDev *sch);
-int css_do_ssch(SubchDev *sch, ORB *orb);
+IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb);
 int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
 void css_do_tsch_update_subch(SubchDev *sch);
 int css_do_stcrw(CRW *crw);
@@ -214,7 +226,7 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
 void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo);
 int css_enable_mcsse(void);
 int css_enable_mss(void);
-int css_do_rsch(SubchDev *sch);
+IOInstEnding css_do_rsch(SubchDev *sch);
 int css_do_rchp(uint8_t cssid, uint8_t chpid);
 bool css_present(uint8_t cssid);
 #endif
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 9f45cf1347..7d15a1a5d4 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -33,7 +33,7 @@ typedef struct S390CCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
     void (*unrealize)(S390CCWDevice *dev, Error **errp);
-    int (*handle_request) (ORB *, SCSW *, void *);
+    IOInstEnding (*handle_request) (SubchDev *sch);
 } S390CCWDeviceClass;
 
 #endif
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 47490f838a..582287ff6c 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -218,8 +218,6 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     SubchDev *sch;
     ORB orig_orb, orb;
     uint64_t addr;
-    int ret = -ENODEV;
-    int cc;
     CPUS390XState *env = &cpu->env;
     uint8_t ar;
 
@@ -239,33 +237,11 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     }
     trace_ioinst_sch_id("ssch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_ssch(sch, &orb);
-    }
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
+    if (!sch || !css_subch_visible(sch)) {
+        setcc(cpu, 3);
         return;
-    case 0:
-        cc = 0;
-        break;
-    default:
-        cc = 1;
-        break;
     }
-    setcc(cpu, cc);
+    setcc(cpu, css_do_ssch(sch, &orb).cc);
 }
 
 void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb)
@@ -784,8 +760,6 @@ void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1)
 {
     int cssid, ssid, schid, m;
     SubchDev *sch;
-    int ret = -ENODEV;
-    int cc;
 
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
         program_interrupt(&cpu->env, PGM_OPERAND, 4);
@@ -793,24 +767,11 @@ void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1)
     }
     trace_ioinst_sch_id("rsch", cssid, ssid, schid);
     sch = css_find_subch(m, cssid, ssid, schid);
-    if (sch && css_subch_visible(sch)) {
-        ret = css_do_rsch(sch);
-    }
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
+    if (!sch || !css_subch_visible(sch)) {
+        setcc(cpu, 3);
+        return;
     }
-    setcc(cpu, cc);
+    setcc(cpu, css_do_rsch(sch).cc);
 }
 
 #define RCHP_REG1_RES(_reg) (_reg & 0x00000000ff00ff00)
-- 
2.13.5
