Received: from eggs.gnu.org ([2001:4830:134:3::10]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eCTcv-0003UJ-Os
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eCTcq-0000RT-Qb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:54:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52222
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eCTcq-0000QT-Jd
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:54:52 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8Gr1mT050132
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 11:54:50 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e45u5r2s3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 11:54:49 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 16:54:47 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 17:54:20 +0100
In-Reply-To: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171108165422.46267-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 1/3] s390x/ccs: add ccw-testdev emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Add a fake device meant for testing the correctness of our css emulation.

What we currently have is writing a Fibonacci sequence of uint32_t to the
device via ccw write. The write is going to fail if it ain't a Fibonacci
and indicate a device exception in scsw together with the proper residual
count. With this we can do basic verification of data integrity.

Of course lot's of invalid inputs (besides basic data processing) can be
tested with that as well.

We also have a no-op mode where the device just tells all-good! This
could be useful for fuzzing.

Usage:
1) fire up a qemu with something like -device ccw-testdev,devno=fe.0.0001
   on the command line
2) exercise the device from the guest

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

Introduction
------------

While discussing v1 we (more or less) decided a test device for ccw is a
good idea. This is an RFC because there are some unresolved technical
questions I would like to discuss.

Usage
-----

Build like this:  make CONFIG_CCW_TESTDEV=y

Changelog
---------

v1 -> v2:
- Renamed and moved to hw/misc/
- Changed cu_type to 0xfffe.
- Changed chpid_type to 0x25 (questionable).
- Extensibility: addedd both in-band (ccw) and out-of-band set mode
  mechanism. Currently we have two modes: fib and no-op. The purpose
  of the mode mechanism is to facilitate different behaviors. One can
  both specify and lock a mode on the command line.
- Added read for fib mode.

Things I've figured out and things to figure out
-----------------------------------------------

The zVM folks say they don't have a reserved cu_type reserved for test
(or hypervisor use in general). So I've gone with cu_type  0xfffe because
according to Christian  only numeric digit hex values are used, and Linux
uses x0ffff as extremal value.

The zVM folks say the don't have a chpid_type reserved for test (or
hypervisor use in general. So I took 0x25 for now, which belongs to FC
and should be safe in my opinion.

AFAIR there was some discussion on using a dedicated diag function code.
There are multiple such that could be re-purposed for out-of-band
signaling reserved by zVM. For now I've decided to go with a new subcode
for diag 0x500 as it appears to me that it requires less changes.

I've implemented both in-band and out-of-band signaling for influencing
what the testdev does from the guest. We should probably get rid of one.
I've just implemented both so we can discuss pros and cons with some
code.

I've taken subcode 254, the last one supported at the moment. I'm not
really happy with the way I 'took' it. Maybe all taken subcodes
could go into hw/s390x/s390-virtio-hcall.h either via include or
directly.

I'm not really happy with the side effects of moving it to hw/misc, which
ain't s390x specific. I've pretty much bounced off the build system, so
I would really appreciate some help here. Currently you have to say you
want it when you do make or it won't get compiled into your qemu. IMHO
this device only makes sense for testing and should not be rutinely
shipped in production builds. That is why I did not touch
default-configs/s390x-softmmu.mak.

I think, I have the most problematic places marked with a  TODO
comment in the code.

Happy reviewing and looking forward to your comments.
---
 hw/misc/Makefile.objs |   1 +
 hw/misc/ccw-testdev.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/ccw-testdev.h |  18 ++++
 3 files changed, 303 insertions(+)
 create mode 100644 hw/misc/ccw-testdev.c
 create mode 100644 hw/misc/ccw-testdev.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 19202d90cf..b41314d096 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -61,3 +61,4 @@ obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-y += mmio_interface.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o
+obj-$(CONFIG_CCW_TESTDEV) += ccw-testdev.o
diff --git a/hw/misc/ccw-testdev.c b/hw/misc/ccw-testdev.c
new file mode 100644
index 0000000000..39cf46e90d
--- /dev/null
+++ b/hw/misc/ccw-testdev.c
@@ -0,0 +1,284 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "ccw-testdev.h"
+#include "hw/s390x/css.h"
+#include "hw/s390x/css-bridge.h"
+#include "hw/s390x/3270-ccw.h"
+#include "exec/address-spaces.h"
+#include "hw/s390x/s390-virtio-hcall.h"
+#include <error.h>
+
+typedef struct CcwTestDevDevice {
+    CcwDevice parent_obj;
+    uint16_t cu_type;
+    uint8_t chpid_type;
+    uint32_t op_mode;
+    bool op_mode_locked;
+    struct {
+        uint32_t ring[4];
+        unsigned int next;
+    } fib;
+} CcwTestDevDevice;
+
+typedef struct CcwTestDevClass {
+    CCWDeviceClass parent_class;
+    DeviceRealize parent_realize;
+} CcwTestDevClass;
+
+#define TYPE_CCW_TESTDEV "ccw-testdev"
+
+#define CCW_TESTDEV(obj) \
+     OBJECT_CHECK(CcwTestDevDevice, (obj), TYPE_CCW_TESTDEV)
+#define CCW_TESTDEV_CLASS(klass) \
+     OBJECT_CLASS_CHECK(CcwTestDevClass, (klass), TYPE_CCW_TESTDEV)
+#define CCW_TESTDEV_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(CcwTestDevClass, (obj), TYPE_CCW_TESTDEV)
+
+typedef int (*ccw_cb_t)(SubchDev *, CCW1);
+static ccw_cb_t get_ccw_cb(CcwTestDevOpMode op_mode);
+
+/* TODO This is the in-band set mode. We may want to get rid of it. */
+static int set_mode_ccw(SubchDev *sch)
+{
+    CcwTestDevDevice *d = sch->driver_data;
+    const char pattern[] = CCW_TST_SET_MODE_INCANTATION;
+    char buf[sizeof(pattern)];
+    int ret;
+    uint32_t tmp;
+
+    if (d->op_mode_locked) {
+        return -EINVAL;
+    }
+
+    ret = ccw_dstream_read(&sch->cds, buf);
+    if (ret) {
+        return ret;
+    }
+    ret = strncmp(buf, pattern, sizeof(pattern));
+    if (ret) {
+        return 0; /* ignore malformed request -- maybe fuzzing */
+    }
+    ret = ccw_dstream_read(&sch->cds, tmp);
+    if (ret) {
+        return ret;
+    }
+    be32_to_cpus(&tmp);
+    if (tmp >= OP_MODE_MAX) {
+        return -EINVAL;
+    }
+    d->op_mode = tmp;
+    sch->ccw_cb = get_ccw_cb(d->op_mode);
+    return ret;
+}
+
+
+static unsigned int abs_to_ring(unsigned int i)
+{
+    return i & 0x3;
+}
+
+static int  ccw_testdev_write_fib(SubchDev *sch)
+{
+    CcwTestDevDevice *d = sch->driver_data;
+    bool is_fib = true;
+    uint32_t tmp;
+    int ret = 0;
+
+    d->fib.next = 0;
+    while (ccw_dstream_avail(&sch->cds) > 0) {
+        ret = ccw_dstream_read(&sch->cds, tmp);
+        if (ret) {
+            error(0, -ret, "fib");
+            break;
+        }
+        d->fib.ring[abs_to_ring(d->fib.next)] = cpu_to_be32(tmp);
+        if (d->fib.next > 2) {
+            tmp = (d->fib.ring[abs_to_ring(d->fib.next - 1)]
+                  + d->fib.ring[abs_to_ring(d->fib.next - 2)]);
+            is_fib = tmp ==  d->fib.ring[abs_to_ring(d->fib.next)];
+            if (!is_fib) {
+                break;
+            }
+        }
+        ++(d->fib.next);
+    }
+    if (!is_fib) {
+        sch->curr_status.scsw.ctrl &= ~SCSW_ACTL_START_PEND;
+        sch->curr_status.scsw.ctrl |= SCSW_STCTL_PRIMARY |
+                                      SCSW_STCTL_SECONDARY |
+                                      SCSW_STCTL_ALERT |
+                                      SCSW_STCTL_STATUS_PEND;
+        sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
+        sch->curr_status.scsw.cpa = sch->channel_prog + 8;
+        sch->curr_status.scsw.dstat =  SCSW_DSTAT_UNIT_EXCEP;
+        return -EIO;
+    }
+    return ret;
+}
+
+static int  ccw_testdev_read_fib(SubchDev *sch)
+{
+    uint32_t l = 0, m = 1, n = 0;
+    int ret = 0;
+
+    while (ccw_dstream_avail(&sch->cds) > 0) {
+        n = m + l;
+        l = m;
+        m = n;
+        ret = ccw_dstream_read(&sch->cds, n);
+    }
+    return ret;
+}
+
+static int ccw_testdev_ccw_cb_mode_fib(SubchDev *sch, CCW1 ccw)
+{
+    switch (ccw.cmd_code) {
+    case CCW_CMD_READ:
+        ccw_testdev_read_fib(sch);
+        break;
+    case CCW_CMD_WRITE:
+        return ccw_testdev_write_fib(sch);
+    case CCW_CMD_CTL_MODE:
+        return set_mode_ccw(sch);
+    default:
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int ccw_testdev_ccw_cb_mode_nop(SubchDev *sch, CCW1 ccw)
+{
+    CcwTestDevDevice *d = sch->driver_data;
+
+    if (!d->op_mode_locked && ccw.cmd_code == CCW_CMD_CTL_MODE) {
+        return set_mode_ccw(sch);
+    }
+    return 0;
+}
+
+static ccw_cb_t get_ccw_cb(CcwTestDevOpMode op_mode)
+{
+    switch (op_mode) {
+    case OP_MODE_FIB:
+        return ccw_testdev_ccw_cb_mode_fib;
+    case OP_MODE_NOP:
+    default:
+        return ccw_testdev_ccw_cb_mode_nop;
+    }
+}
+
+static void ccw_testdev_realize(DeviceState *ds, Error **errp)
+{
+    uint16_t chpid;
+    CcwTestDevDevice *dev = CCW_TESTDEV(ds);
+    CcwTestDevClass *ctc = CCW_TESTDEV_GET_CLASS(dev);
+    CcwDevice *cdev = CCW_DEVICE(ds);
+    BusState *qbus = qdev_get_parent_bus(ds);
+    VirtualCssBus *cbus = VIRTUAL_CSS_BUS(qbus);
+    SubchDev *sch;
+    Error *err = NULL;
+
+    sch = css_create_sch(cdev->devno, true, cbus->squash_mcss, errp);
+    if (!sch) {
+        return;
+    }
+
+    sch->driver_data = dev;
+    cdev->sch = sch;
+    chpid = css_find_free_chpid(sch->cssid);
+
+    if (chpid > MAX_CHPID) {
+        error_setg(&err, "No available chpid to use.");
+        goto out_err;
+    }
+
+    sch->id.reserved = 0xff;
+    sch->id.cu_type = dev->cu_type;
+    css_sch_build_virtual_schib(sch, (uint8_t)chpid,
+                                dev->chpid_type);
+    sch->ccw_cb = get_ccw_cb(dev->op_mode);
+    sch->do_subchannel_work = do_subchannel_work_virtual;
+
+
+    ctc->parent_realize(ds, &err);
+    if (err) {
+        goto out_err;
+    }
+
+    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
+                          ds->hotplugged, 1);
+    return;
+
+out_err:
+    error_propagate(errp, err);
+    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+    cdev->sch = NULL;
+    g_free(sch);
+}
+
+static Property ccw_testdev_properties[] = {
+    DEFINE_PROP_UINT16("cu_type", CcwTestDevDevice, cu_type,
+                        0xfffe), /* only numbers used for real HW */
+    DEFINE_PROP_UINT8("chpid_type", CcwTestDevDevice, chpid_type,
+                       0x25), /* took FC, TODO discuss */
+    DEFINE_PROP_UINT32("op_mode", CcwTestDevDevice, op_mode,
+                       0), /* TODO discuss */
+    DEFINE_PROP_BOOL("op_mode_locked", CcwTestDevDevice, op_mode_locked,
+                       false), /* TODO discuss */
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+/* TODO This is the out-of-band variant. We may want to get rid of it */
+static int set_mode_diag(const uint64_t *args)
+{
+    uint64_t subch_id = args[0];
+    uint64_t op_mode = args[1];
+    SubchDev *sch;
+    CcwTestDevDevice *dev;
+    int cssid, ssid, schid, m;
+
+    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
+        return -EINVAL;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (!sch || !css_subch_visible(sch)) {
+        return -EINVAL;
+    }
+    dev = CCW_TESTDEV(sch->driver_data);
+    if (dev->op_mode_locked) {
+        return op_mode == dev->op_mode ? 0 : -EINVAL;
+    }
+    dev->op_mode = op_mode;
+    sch->ccw_cb = get_ccw_cb(dev->op_mode);
+    return 0;
+}
+
+static void ccw_testdev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    CcwTestDevClass *ctc = CCW_TESTDEV_CLASS(klass);
+
+    dc->props = ccw_testdev_properties;
+    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    ctc->parent_realize = dc->realize;
+    dc->realize = ccw_testdev_realize;
+    dc->hotpluggable = false;
+
+    s390_register_virtio_hypercall(CCW_TST_DIAG_500_SUB, set_mode_diag);
+}
+
+static const TypeInfo ccw_testdev_info = {
+    .name = TYPE_CCW_TESTDEV,
+    .parent = TYPE_CCW_DEVICE,
+    .instance_size = sizeof(CcwTestDevDevice),
+    .class_init = ccw_testdev_class_init,
+    .class_size = sizeof(CcwTestDevClass),
+};
+
+static void ccw_testdev_register(void)
+{
+    type_register_static(&ccw_testdev_info);
+}
+
+type_init(ccw_testdev_register)
diff --git a/hw/misc/ccw-testdev.h b/hw/misc/ccw-testdev.h
new file mode 100644
index 0000000000..f4d4570f5e
--- /dev/null
+++ b/hw/misc/ccw-testdev.h
@@ -0,0 +1,18 @@
+#ifndef HW_s390X_CCW_TESTDEV_H
+#define HW_s390X_CCW_TESTDEV_H
+
+typedef enum CcwTestDevOpMode {
+    OP_MODE_NOP = 0,
+    OP_MODE_FIB = 1,
+    OP_MODE_MAX /* extremal element */
+} CcwTestDevOpMode;
+
+#define CCW_CMD_READ 0x01U
+#define CCW_CMD_WRITE 0x02U
+
+#define CCW_CMD_CTL_MODE 0x07U
+#define CCW_TST_SET_MODE_INCANTATION "SET MODE="
+/* Subcode for diagnose 500 (virtio hypercall). */
+#define CCW_TST_DIAG_500_SUB 254
+
+#endif
-- 
2.13.5
