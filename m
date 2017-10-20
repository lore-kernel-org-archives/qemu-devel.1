Received: from eggs.gnu.org ([2001:4830:134:3::10]:59571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuZ-0003eQ-LU
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuX-00041F-Km
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:23 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:10 +0200
Message-Id: <20171020115418.2050-39-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 38/46] s390x: improve error handling for SSCH
 and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Simplify the error handling of the SSCH and RSCH handler avoiding
arbitrary and cryptic error codes being used to tell how the instruction
is supposed to end.  Let the code detecting the condition tell how it's
to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
in one go as the emulation of the two shares a lot of code.

For passthrough this change isn't pure refactoring, but changes the way
kernel reported EFAULT is handled. After clarifying the kernel interface
we decided that EFAULT shall be mapped to unit exception.  Same goes for
unexpected error codes and absence of required ORB flags.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20171017140453.51099-4-pasic@linux.vnet.ibm.com>
Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
[CH: cosmetic changes]
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c              | 84 +++++++++++++--------------------------------
 hw/s390x/s390-ccw.c         | 11 +++---
 hw/vfio/ccw.c               | 28 +++++++++++----
 include/hw/s390x/css.h      | 23 +++++++++----
 include/hw/s390x/s390-ccw.h |  2 +-
 target/s390x/ioinst.c       | 53 ++++------------------------
 6 files changed, 75 insertions(+), 126 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 4f964b7691..c87c1aecc0 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1181,12 +1181,11 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
 
 }
 
-static int sch_handle_start_func_passthrough(SubchDev *sch)
+static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
     SCSW *s = &sch->curr_status.scsw;
-    int ret;
 
     ORB *orb = &sch->orb;
     if (!(s->ctrl & SCSW_ACTL_SUSP)) {
@@ -1200,31 +1199,12 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
      */
     if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
         !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
-        return -EINVAL;
+        warn_report("vfio-ccw requires PFCH and C64 flags set");
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return IOINST_CC_EXPECTED;
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
@@ -1233,7 +1213,7 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-int do_subchannel_work_virtual(SubchDev *sch)
+IOInstEnding do_subchannel_work_virtual(SubchDev *sch)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -1247,12 +1227,12 @@ int do_subchannel_work_virtual(SubchDev *sch)
         sch_handle_start_func_virtual(sch);
     }
     css_inject_io_interrupt(sch);
-    return 0;
+    /* inst must succeed if this func is called */
+    return IOINST_CC_EXPECTED;
 }
 
-int do_subchannel_work_passthrough(SubchDev *sch)
+IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
 {
-    int ret = 0;
     SCSW *s = &sch->curr_status.scsw;
 
     if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
@@ -1262,16 +1242,15 @@ int do_subchannel_work_passthrough(SubchDev *sch)
         /* TODO: Halt handling */
         sch_handle_halt_func(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
-        ret = sch_handle_start_func_passthrough(sch);
+        return sch_handle_start_func_passthrough(sch);
     }
-
-    return ret;
+    return IOINST_CC_EXPECTED;
 }
 
-static int do_subchannel_work(SubchDev *sch)
+static IOInstEnding do_subchannel_work(SubchDev *sch)
 {
     if (!sch->do_subchannel_work) {
-        return -EINVAL;
+        return IOINST_CC_STATUS_PRESENT;
     }
     g_assert(sch->curr_status.scsw.ctrl & SCSW_CTRL_MASK_FCTL);
     return sch->do_subchannel_work(sch);
@@ -1561,27 +1540,23 @@ static void css_update_chnmon(SubchDev *sch)
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
+        return IOINST_CC_NOT_OPERATIONAL;
     }
 
     if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
-        ret = -EINPROGRESS;
-        goto out;
+        return IOINST_CC_STATUS_PRESENT;
     }
 
     if (s->ctrl & (SCSW_FCTL_START_FUNC |
                    SCSW_FCTL_HALT_FUNC |
                    SCSW_FCTL_CLEAR_FUNC)) {
-        ret = -EBUSY;
-        goto out;
+        return IOINST_CC_BUSY;
     }
 
     /* If monitoring is active, update counter. */
@@ -1594,10 +1569,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    ret = do_subchannel_work(sch);
-
-out:
-    return ret;
+    return do_subchannel_work(sch);
 }
 
 static void copy_irb_to_guest(IRB *dest, const IRB *src, PMCW *pmcw,
@@ -1844,27 +1816,23 @@ void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo)
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
+        return IOINST_CC_NOT_OPERATIONAL;
     }
 
     if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
-        ret = -EINPROGRESS;
-        goto out;
+        return IOINST_CC_STATUS_PRESENT;
     }
 
     if (((s->ctrl & SCSW_CTRL_MASK_FCTL) != SCSW_FCTL_START_FUNC) ||
         (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
         (!(s->ctrl & SCSW_ACTL_SUSP))) {
-        ret = -EINVAL;
-        goto out;
+        return IOINST_CC_BUSY;
     }
 
     /* If monitoring is active, update counter. */
@@ -1873,11 +1841,7 @@ int css_do_rsch(SubchDev *sch)
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
index 8614dda6f8..0ef232ec27 100644
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
+        return IOINST_CC_STATUS_PRESENT;
     }
+    return cdc->handle_request(sch);
 }
 
 static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 76323c6bde..636729c03d 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -47,9 +47,9 @@ struct VFIODeviceOps vfio_ccw_ops = {
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
@@ -60,8 +60,8 @@ static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
 
     memset(region, 0, sizeof(*region));
 
-    memcpy(region->orb_area, orb, sizeof(ORB));
-    memcpy(region->scsw_area, scsw, sizeof(SCSW));
+    memcpy(region->orb_area, &sch->orb, sizeof(ORB));
+    memcpy(region->scsw_area, &sch->curr_status.scsw, sizeof(SCSW));
 
 again:
     ret = pwrite(vcdev->vdev.fd, region,
@@ -71,10 +71,24 @@ again:
             goto again;
         }
         error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
-        return -errno;
+        ret = -errno;
+    } else {
+        ret = region->ret_code;
+    }
+    switch (ret) {
+    case 0:
+        return IOINST_CC_EXPECTED;
+    case -EBUSY:
+        return IOINST_CC_BUSY;
+    case -ENODEV:
+    case -EACCES:
+        return IOINST_CC_NOT_OPERATIONAL;
+    case -EFAULT:
+    default:
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return IOINST_CC_EXPECTED;
     }
-
-    return region->ret_code;
 }
 
 static void vfio_ccw_reset(DeviceState *dev)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 08ad1a14cf..666ce1174b 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -136,11 +136,22 @@ struct SubchDev {
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
@@ -199,9 +210,9 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
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
@@ -232,7 +243,7 @@ int css_do_msch(SubchDev *sch, const SCHIB *schib);
 int css_do_xsch(SubchDev *sch);
 int css_do_csch(SubchDev *sch);
 int css_do_hsch(SubchDev *sch);
-int css_do_ssch(SubchDev *sch, ORB *orb);
+IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb);
 int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
 void css_do_tsch_update_subch(SubchDev *sch);
 int css_do_stcrw(CRW *crw);
@@ -243,7 +254,7 @@ int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
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
index 47490f838a..16b5cf2fed 100644
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
+    setcc(cpu, css_do_ssch(sch, &orb));
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
+    setcc(cpu, css_do_rsch(sch));
 }
 
 #define RCHP_REG1_RES(_reg) (_reg & 0x00000000ff00ff00)
-- 
2.13.6
