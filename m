Received: from eggs.gnu.org ([2001:4830:134:3::10]:48921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dS8zn-0002M3-Mq
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dS8zk-0005OR-HN
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:35:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dS8zj-0005Np-HA
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:35:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v63LYejS099593
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 17:34:56 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bf27bk4wu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 17:34:56 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 22:34:53 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon,  3 Jul 2017 23:34:14 +0200
Message-Id: <20170703213414.94298-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] s390x: vmstatify config migration for
 virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Cornelia Huck <cohuck@kernel.org>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
flexibility (extending using subsections) and for fun.

To achieve this we need to hack the config_vector, which is VirtIODevice
(that is common virtio) state, in the middle of the VirtioCcwDevice state
representation.  This is somewhat ugly, but we have no choice because the
stream format needs to be preserved.

Almost no changes in behavior. Exception is everything that comes with
vmstate like extra bookkeeping about what's in the stream, and maybe some
extra checks and better error reporting.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---

I was pondering whether to drop or to keep the r-b's I've got for v2.
I've decided to keep the r-b's because the change corresponding to v3 are
IMHO non-substantive and  because the patch isn't exactly small (can't be
re-reviewed in a couple of seconds).

All r-b people are on cc and encouraged to scream at me if they don't
agree to keep their r-b.

@Christian: v2 was supposed to go in but since commit 8ed179c937 was
already on your branch and it interfered with v2 I had to do it's
equivalent here. (For reference see:
 https://www.mail-archive.com/qemu-devel@nongnu.org/msg455772.html).

v2 --> v3:
* rebased
* added handling (modulo QMP error reporting) equivalent to commit
  8ed179c937 ("s390x/css: catch section mismatch on load", 2017-05-18)
* added a hint "Bug!" to the _EQUAL check not expected to fail unless
  programing error in QEMU
* minor style issues (poited out by Dong Jia)
v1 --> v2:
* added r-bs
* fixed typo in commit message
* fixed a style issue found out by Connie
---
 hw/intc/s390_flic.c          |  28 ++++
 hw/s390x/ccw-device.c        |  10 ++
 hw/s390x/ccw-device.h        |   4 +
 hw/s390x/css.c               | 378 +++++++++++++++++++++++++------------------
 hw/s390x/virtio-ccw.c        | 158 +++++++++---------
 include/hw/s390x/css.h       |  12 +-
 include/hw/s390x/s390_flic.h |   5 +
 7 files changed, 358 insertions(+), 237 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index a26e90670f..a99a350d8e 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -17,6 +17,7 @@
 #include "trace.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 S390FLICState *s390_get_flic(void)
 {
@@ -136,3 +137,30 @@ static void qemu_s390_flic_register_types(void)
 }
 
 type_init(qemu_s390_flic_register_types)
+
+const VMStateDescription vmstate_adapter_info = {
+    .name = "s390_adapter_info",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(ind_offset, AdapterInfo),
+        /*
+         * We do not have to migrate neither the id nor the addresses.
+         * The id is set by css_register_io_adapter and the addresses
+         * are set based on the IndAddr objects after those get mapped.
+         */
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+const VMStateDescription vmstate_adapter_routes = {
+
+    .name = "s390_adapter_routes",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(adapter, AdapterRoutes, 1, vmstate_adapter_info,
+                       AdapterInfo),
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index fb8d640a7e..f9bfa154d6 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -50,6 +50,16 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
     dc->props = ccw_device_properties;
 }
 
+const VMStateDescription vmstate_ccw_dev = {
+    .name = "s390_ccw_dev",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_POINTER(sch, CcwDevice, vmstate_subch_dev, SubchDev),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const TypeInfo ccw_device_info = {
     .name = TYPE_CCW_DEVICE,
     .parent = TYPE_DEVICE,
diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 89c8e5dff7..4e6af287e7 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -27,6 +27,10 @@ typedef struct CcwDevice {
     CssDevId subch_id;
 } CcwDevice;
 
+extern const VMStateDescription vmstate_ccw_dev;
+#define VMSTATE_CCW_DEVICE(_field, _state)                     \
+    VMSTATE_STRUCT(_field, _state, 1, vmstate_ccw_dev, CcwDevice)
+
 typedef struct CCWDeviceClass {
     DeviceClass parent_class;
     void (*unplug)(HotplugHandler *, DeviceState *, Error **);
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 599805d275..d67fffae30 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -22,6 +22,7 @@
 #include "hw/s390x/css.h"
 #include "trace.h"
 #include "hw/s390x/s390_flic.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 typedef struct CrwContainer {
     CRW crw;
@@ -40,6 +41,181 @@ typedef struct SubchSet {
     unsigned long devnos_used[BITS_TO_LONGS(MAX_SCHID + 1)];
 } SubchSet;
 
+static const VMStateDescription vmstate_scsw = {
+    .name = "s390_scsw",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(flags, SCSW),
+        VMSTATE_UINT16(ctrl, SCSW),
+        VMSTATE_UINT32(cpa, SCSW),
+        VMSTATE_UINT8(dstat, SCSW),
+        VMSTATE_UINT8(cstat, SCSW),
+        VMSTATE_UINT16(count, SCSW),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_pmcw = {
+    .name = "s390_pmcw",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(intparm, PMCW),
+        VMSTATE_UINT16(flags, PMCW),
+        VMSTATE_UINT16(devno, PMCW),
+        VMSTATE_UINT8(lpm, PMCW),
+        VMSTATE_UINT8(pnom, PMCW),
+        VMSTATE_UINT8(lpum, PMCW),
+        VMSTATE_UINT8(pim, PMCW),
+        VMSTATE_UINT16(mbi, PMCW),
+        VMSTATE_UINT8(pom, PMCW),
+        VMSTATE_UINT8(pam, PMCW),
+        VMSTATE_UINT8_ARRAY(chpid, PMCW, 8),
+        VMSTATE_UINT32(chars, PMCW),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_schib = {
+    .name = "s390_schib",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(pmcw, SCHIB, 0, vmstate_pmcw, PMCW),
+        VMSTATE_STRUCT(scsw, SCHIB, 0, vmstate_scsw, SCSW),
+        VMSTATE_UINT64(mba, SCHIB),
+        VMSTATE_UINT8_ARRAY(mda, SCHIB, 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
+static const VMStateDescription vmstate_ccw1 = {
+    .name = "s390_ccw1",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(cmd_code, CCW1),
+        VMSTATE_UINT8(flags, CCW1),
+        VMSTATE_UINT16(count, CCW1),
+        VMSTATE_UINT32(cda, CCW1),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_ciw = {
+    .name = "s390_ciw",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(type, CIW),
+        VMSTATE_UINT8(command, CIW),
+        VMSTATE_UINT16(count, CIW),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sense_id = {
+    .name = "s390_sense_id",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(reserved, SenseId),
+        VMSTATE_UINT16(cu_type, SenseId),
+        VMSTATE_UINT8(cu_model, SenseId),
+        VMSTATE_UINT16(dev_type, SenseId),
+        VMSTATE_UINT8(dev_model, SenseId),
+        VMSTATE_UINT8(unused, SenseId),
+        VMSTATE_STRUCT_ARRAY(ciw, SenseId, MAX_CIWS, 0, vmstate_ciw, CIW),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int subch_dev_post_load(void *opaque, int version_id);
+static void subch_dev_pre_save(void *opaque);
+
+const char err_hint_devno[] = "Devno mismatch, tried to load wrong section!"
+    " Likely reason: some sequences of plug and unplug  can break"
+    " migration for machine versions prior to  2.7 (known design flaw).";
+
+const VMStateDescription vmstate_subch_dev = {
+    .name = "s390_subch_dev",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = subch_dev_post_load,
+    .pre_save = subch_dev_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_EQUAL(cssid, SubchDev, "Bug!"),
+        VMSTATE_UINT8_EQUAL(ssid, SubchDev, "Bug!"),
+        VMSTATE_UINT16(migrated_schid, SubchDev),
+        VMSTATE_UINT16_EQUAL(devno, SubchDev, err_hint_devno),
+        VMSTATE_BOOL(thinint_active, SubchDev),
+        VMSTATE_STRUCT(curr_status, SubchDev, 0, vmstate_schib, SCHIB),
+        VMSTATE_UINT8_ARRAY(sense_data, SubchDev, 32),
+        VMSTATE_UINT64(channel_prog, SubchDev),
+        VMSTATE_STRUCT(last_cmd, SubchDev, 0, vmstate_ccw1, CCW1),
+        VMSTATE_BOOL(last_cmd_valid, SubchDev),
+        VMSTATE_STRUCT(id, SubchDev, 0, vmstate_sense_id, SenseId),
+        VMSTATE_BOOL(ccw_fmt_1, SubchDev),
+        VMSTATE_UINT8(ccw_no_data_cnt, SubchDev),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+typedef struct IndAddrPtrTmp {
+    IndAddr **parent;
+    uint64_t addr;
+    int32_t len;
+} IndAddrPtrTmp;
+
+static int post_load_ind_addr(void *opaque, int version_id)
+{
+    IndAddrPtrTmp *ptmp = opaque;
+    IndAddr **ind_addr = ptmp->parent;
+
+    if (ptmp->len != 0) {
+        *ind_addr = get_indicator(ptmp->addr, ptmp->len);
+    } else {
+        *ind_addr = NULL;
+    }
+    return 0;
+}
+
+static void pre_save_ind_addr(void *opaque)
+{
+    IndAddrPtrTmp *ptmp = opaque;
+    IndAddr *ind_addr = *(ptmp->parent);
+
+    if (ind_addr != NULL) {
+        ptmp->len = ind_addr->len;
+        ptmp->addr = ind_addr->addr;
+    } else {
+        ptmp->len = 0;
+        ptmp->addr = 0L;
+    }
+}
+
+const VMStateDescription vmstate_ind_addr_tmp = {
+    .name = "s390_ind_addr_tmp",
+    .pre_save = pre_save_ind_addr,
+    .post_load = post_load_ind_addr,
+
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32(len, IndAddrPtrTmp),
+        VMSTATE_UINT64(addr, IndAddrPtrTmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_ind_addr = {
+    .name = "s390_ind_addr_tmp",
+    .fields = (VMStateField[]) {
+        VMSTATE_WITH_TMP(IndAddr*, IndAddrPtrTmp, vmstate_ind_addr_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 typedef struct CssImage {
     SubchSet *sch_set[MAX_SSID + 1];
     ChpInfo chpids[MAX_CHPID + 1];
@@ -77,6 +253,52 @@ static ChannelSubSys channel_subsys = {
         QTAILQ_HEAD_INITIALIZER(channel_subsys.indicator_addresses),
 };
 
+static void subch_dev_pre_save(void *opaque)
+{
+    SubchDev *s = opaque;
+
+    /* Prepare remote_schid for save */
+    s->migrated_schid = s->schid;
+}
+
+static int subch_dev_post_load(void *opaque, int version_id)
+{
+
+    SubchDev *s = opaque;
+
+    /* Re-assign the subchannel to remote_schid if necessary */
+    if (s->migrated_schid != s->schid) {
+        if (css_find_subch(true, s->cssid, s->ssid, s->schid) == s) {
+            /*
+             * Cleanup the slot before moving to s->migrated_schid provided
+             * it still belongs to us, i.e. it was not changed by previous
+             * invocation of this function.
+             */
+            css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, NULL);
+        }
+        /* It's OK to re-assign without a prior de-assign. */
+        s->schid = s->migrated_schid;
+        css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
+    }
+
+    /*
+     * Hack alert. If we don't migrate the channel subsystem status
+     * we still need to find out if the guest enabled mss/mcss-e.
+     * If the subchannel is enabled, it certainly was able to access it,
+     * so adjust the max_ssid/max_cssid values for relevant ssid/cssid
+     * values. This is not watertight, but better than nothing.
+     */
+    if (s->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA) {
+        if (s->ssid) {
+            channel_subsys.max_ssid = MAX_SSID;
+        }
+        if (s->cssid != channel_subsys.default_cssid) {
+            channel_subsys.max_cssid = MAX_CSSID;
+        }
+    }
+    return 0;
+}
+
 IndAddr *get_indicator(hwaddr ind_addr, int len)
 {
     IndAddr *indicator;
@@ -1747,162 +1969,6 @@ int css_enable_mss(void)
     return 0;
 }
 
-void subch_device_save(SubchDev *s, QEMUFile *f)
-{
-    int i;
-
-    qemu_put_byte(f, s->cssid);
-    qemu_put_byte(f, s->ssid);
-    qemu_put_be16(f, s->schid);
-    qemu_put_be16(f, s->devno);
-    qemu_put_byte(f, s->thinint_active);
-    /* SCHIB */
-    /*     PMCW */
-    qemu_put_be32(f, s->curr_status.pmcw.intparm);
-    qemu_put_be16(f, s->curr_status.pmcw.flags);
-    qemu_put_be16(f, s->curr_status.pmcw.devno);
-    qemu_put_byte(f, s->curr_status.pmcw.lpm);
-    qemu_put_byte(f, s->curr_status.pmcw.pnom);
-    qemu_put_byte(f, s->curr_status.pmcw.lpum);
-    qemu_put_byte(f, s->curr_status.pmcw.pim);
-    qemu_put_be16(f, s->curr_status.pmcw.mbi);
-    qemu_put_byte(f, s->curr_status.pmcw.pom);
-    qemu_put_byte(f, s->curr_status.pmcw.pam);
-    qemu_put_buffer(f, s->curr_status.pmcw.chpid, 8);
-    qemu_put_be32(f, s->curr_status.pmcw.chars);
-    /*     SCSW */
-    qemu_put_be16(f, s->curr_status.scsw.flags);
-    qemu_put_be16(f, s->curr_status.scsw.ctrl);
-    qemu_put_be32(f, s->curr_status.scsw.cpa);
-    qemu_put_byte(f, s->curr_status.scsw.dstat);
-    qemu_put_byte(f, s->curr_status.scsw.cstat);
-    qemu_put_be16(f, s->curr_status.scsw.count);
-    qemu_put_be64(f, s->curr_status.mba);
-    qemu_put_buffer(f, s->curr_status.mda, 4);
-    /* end SCHIB */
-    qemu_put_buffer(f, s->sense_data, 32);
-    qemu_put_be64(f, s->channel_prog);
-    /* last cmd */
-    qemu_put_byte(f, s->last_cmd.cmd_code);
-    qemu_put_byte(f, s->last_cmd.flags);
-    qemu_put_be16(f, s->last_cmd.count);
-    qemu_put_be32(f, s->last_cmd.cda);
-    qemu_put_byte(f, s->last_cmd_valid);
-    qemu_put_byte(f, s->id.reserved);
-    qemu_put_be16(f, s->id.cu_type);
-    qemu_put_byte(f, s->id.cu_model);
-    qemu_put_be16(f, s->id.dev_type);
-    qemu_put_byte(f, s->id.dev_model);
-    qemu_put_byte(f, s->id.unused);
-    for (i = 0; i < ARRAY_SIZE(s->id.ciw); i++) {
-        qemu_put_byte(f, s->id.ciw[i].type);
-        qemu_put_byte(f, s->id.ciw[i].command);
-        qemu_put_be16(f, s->id.ciw[i].count);
-    }
-    qemu_put_byte(f, s->ccw_fmt_1);
-    qemu_put_byte(f, s->ccw_no_data_cnt);
-}
-
-int subch_device_load(SubchDev *s, QEMUFile *f)
-{
-    SubchDev *old_s;
-    Error *err = NULL;
-    uint16_t old_schid = s->schid;
-    uint16_t old_devno = s->devno;
-    int i;
-
-    s->cssid = qemu_get_byte(f);
-    s->ssid = qemu_get_byte(f);
-    s->schid = qemu_get_be16(f);
-    s->devno = qemu_get_be16(f);
-    if (s->devno != old_devno) {
-        /* Only possible if machine < 2.7 (no css_dev_path) */
-
-        error_setg(&err, "%x != %x", old_devno,  s->devno);
-        error_append_hint(&err, "Devno mismatch, tried to load wrong section!"
-                          " Likely reason: some sequences of plug and unplug"
-                          " can break migration for machine versions prior to"
-                          " 2.7 (known design flaw).\n");
-        error_report_err(err);
-        return -EINVAL;
-    }
-    /* Re-assign subch. */
-    if (old_schid != s->schid) {
-        old_s = channel_subsys.css[s->cssid]->sch_set[s->ssid]->sch[old_schid];
-        /*
-         * (old_s != s) means that some other device has its correct
-         * subchannel already assigned (in load).
-         */
-        if (old_s == s) {
-            css_subch_assign(s->cssid, s->ssid, old_schid, s->devno, NULL);
-        }
-        /* It's OK to re-assign without a prior de-assign. */
-        css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
-    }
-    s->thinint_active = qemu_get_byte(f);
-    /* SCHIB */
-    /*     PMCW */
-    s->curr_status.pmcw.intparm = qemu_get_be32(f);
-    s->curr_status.pmcw.flags = qemu_get_be16(f);
-    s->curr_status.pmcw.devno = qemu_get_be16(f);
-    s->curr_status.pmcw.lpm = qemu_get_byte(f);
-    s->curr_status.pmcw.pnom  = qemu_get_byte(f);
-    s->curr_status.pmcw.lpum = qemu_get_byte(f);
-    s->curr_status.pmcw.pim = qemu_get_byte(f);
-    s->curr_status.pmcw.mbi = qemu_get_be16(f);
-    s->curr_status.pmcw.pom = qemu_get_byte(f);
-    s->curr_status.pmcw.pam = qemu_get_byte(f);
-    qemu_get_buffer(f, s->curr_status.pmcw.chpid, 8);
-    s->curr_status.pmcw.chars = qemu_get_be32(f);
-    /*     SCSW */
-    s->curr_status.scsw.flags = qemu_get_be16(f);
-    s->curr_status.scsw.ctrl = qemu_get_be16(f);
-    s->curr_status.scsw.cpa = qemu_get_be32(f);
-    s->curr_status.scsw.dstat = qemu_get_byte(f);
-    s->curr_status.scsw.cstat = qemu_get_byte(f);
-    s->curr_status.scsw.count = qemu_get_be16(f);
-    s->curr_status.mba = qemu_get_be64(f);
-    qemu_get_buffer(f, s->curr_status.mda, 4);
-    /* end SCHIB */
-    qemu_get_buffer(f, s->sense_data, 32);
-    s->channel_prog = qemu_get_be64(f);
-    /* last cmd */
-    s->last_cmd.cmd_code = qemu_get_byte(f);
-    s->last_cmd.flags = qemu_get_byte(f);
-    s->last_cmd.count = qemu_get_be16(f);
-    s->last_cmd.cda = qemu_get_be32(f);
-    s->last_cmd_valid = qemu_get_byte(f);
-    s->id.reserved = qemu_get_byte(f);
-    s->id.cu_type = qemu_get_be16(f);
-    s->id.cu_model = qemu_get_byte(f);
-    s->id.dev_type = qemu_get_be16(f);
-    s->id.dev_model = qemu_get_byte(f);
-    s->id.unused = qemu_get_byte(f);
-    for (i = 0; i < ARRAY_SIZE(s->id.ciw); i++) {
-        s->id.ciw[i].type = qemu_get_byte(f);
-        s->id.ciw[i].command = qemu_get_byte(f);
-        s->id.ciw[i].count = qemu_get_be16(f);
-    }
-    s->ccw_fmt_1 = qemu_get_byte(f);
-    s->ccw_no_data_cnt = qemu_get_byte(f);
-    /*
-     * Hack alert. We don't migrate the channel subsystem status (no
-     * device!), but we need to find out if the guest enabled mss/mcss-e.
-     * If the subchannel is enabled, it certainly was able to access it,
-     * so adjust the max_ssid/max_cssid values for relevant ssid/cssid
-     * values. This is not watertight, but better than nothing.
-     */
-    if (s->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA) {
-        if (s->ssid) {
-            channel_subsys.max_ssid = MAX_SSID;
-        }
-        if (s->cssid != channel_subsys.default_cssid) {
-            channel_subsys.max_cssid = MAX_CSSID;
-        }
-    }
-    return 0;
-}
-
 void css_reset_sch(SubchDev *sch)
 {
     PMCW *p = &sch->curr_status.pmcw;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 90d37cb9ff..f0e7fc8e9b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -34,9 +34,87 @@
 #include "virtio-ccw.h"
 #include "trace.h"
 #include "hw/s390x/css-bridge.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 #define NR_CLASSIC_INDICATOR_BITS 64
 
+static int virtio_ccw_dev_post_load(void *opaque, int version_id)
+{
+    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(opaque);
+    CcwDevice *ccw_dev = CCW_DEVICE(dev);
+    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
+
+    ccw_dev->sch->driver_data = dev;
+    if (ccw_dev->sch->thinint_active) {
+        dev->routes.adapter.adapter_id = css_get_adapter_id(
+                                         CSS_IO_ADAPTER_VIRTIO,
+                                         dev->thinint_isc);
+    }
+    /* Re-fill subch_id after loading the subchannel states.*/
+    if (ck->refill_ids) {
+        ck->refill_ids(ccw_dev);
+    }
+    return 0;
+}
+
+typedef struct VirtioCcwDeviceTmp {
+    VirtioCcwDevice *parent;
+    uint16_t config_vector;
+} VirtioCcwDeviceTmp;
+
+static void virtio_ccw_dev_tmp_pre_save(void *opaque)
+{
+    VirtioCcwDeviceTmp *tmp = opaque;
+    VirtioCcwDevice *dev = tmp->parent;
+    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
+
+    tmp->config_vector = vdev->config_vector;
+}
+
+static int virtio_ccw_dev_tmp_post_load(void *opaque, int version_id)
+{
+    VirtioCcwDeviceTmp *tmp = opaque;
+    VirtioCcwDevice *dev = tmp->parent;
+    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
+
+    vdev->config_vector = tmp->config_vector;
+    return 0;
+}
+
+const VMStateDescription vmstate_virtio_ccw_dev_tmp = {
+    .name = "s390_virtio_ccw_dev_tmp",
+    .pre_save = virtio_ccw_dev_tmp_pre_save,
+    .post_load = virtio_ccw_dev_tmp_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(config_vector, VirtioCcwDeviceTmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_virtio_ccw_dev = {
+    .name = "s390_virtio_ccw_dev",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = virtio_ccw_dev_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_CCW_DEVICE(parent_obj, VirtioCcwDevice),
+        VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
+        VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
+        VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
+        /*
+         * Ugly hack because VirtIODevice does not migrate itself.
+         * This also makes legacy via vmstate_save_state possible.
+         */
+        VMSTATE_WITH_TMP(VirtioCcwDevice, VirtioCcwDeviceTmp,
+                         vmstate_virtio_ccw_dev_tmp),
+        VMSTATE_STRUCT(routes, VirtioCcwDevice, 1, vmstate_adapter_routes,
+                       AdapterRoutes),
+        VMSTATE_UINT8(thinint_isc, VirtioCcwDevice),
+        VMSTATE_INT32(revision, VirtioCcwDevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
                                VirtioCcwDevice *dev);
 
@@ -1239,89 +1317,13 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
 static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    CcwDevice *ccw_dev = CCW_DEVICE(d);
-    SubchDev *s = ccw_dev->sch;
-    VirtIODevice *vdev = virtio_ccw_get_vdev(s);
-
-    subch_device_save(s, f);
-    if (dev->indicators != NULL) {
-        qemu_put_be32(f, dev->indicators->len);
-        qemu_put_be64(f, dev->indicators->addr);
-    } else {
-        qemu_put_be32(f, 0);
-        qemu_put_be64(f, 0UL);
-    }
-    if (dev->indicators2 != NULL) {
-        qemu_put_be32(f, dev->indicators2->len);
-        qemu_put_be64(f, dev->indicators2->addr);
-    } else {
-        qemu_put_be32(f, 0);
-        qemu_put_be64(f, 0UL);
-    }
-    if (dev->summary_indicator != NULL) {
-        qemu_put_be32(f, dev->summary_indicator->len);
-        qemu_put_be64(f, dev->summary_indicator->addr);
-    } else {
-        qemu_put_be32(f, 0);
-        qemu_put_be64(f, 0UL);
-    }
-    qemu_put_be16(f, vdev->config_vector);
-    qemu_put_be64(f, dev->routes.adapter.ind_offset);
-    qemu_put_byte(f, dev->thinint_isc);
-    qemu_put_be32(f, dev->revision);
+    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
 }
 
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    CcwDevice *ccw_dev = CCW_DEVICE(d);
-    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
-    SubchDev *s = ccw_dev->sch;
-    VirtIODevice *vdev = virtio_ccw_get_vdev(s);
-    int len;
-    int ret;
-
-    s->driver_data = dev;
-    ret = subch_device_load(s, f);
-    if (ret) {
-        return ret;
-    }
-    /* Re-fill subch_id after loading the subchannel states.*/
-    if (ck->refill_ids) {
-        ck->refill_ids(ccw_dev);
-    }
-    len = qemu_get_be32(f);
-    if (len != 0) {
-        dev->indicators = get_indicator(qemu_get_be64(f), len);
-    } else {
-        qemu_get_be64(f);
-        dev->indicators = NULL;
-    }
-    len = qemu_get_be32(f);
-    if (len != 0) {
-        dev->indicators2 = get_indicator(qemu_get_be64(f), len);
-    } else {
-        qemu_get_be64(f);
-        dev->indicators2 = NULL;
-    }
-    len = qemu_get_be32(f);
-    if (len != 0) {
-        dev->summary_indicator = get_indicator(qemu_get_be64(f), len);
-    } else {
-        qemu_get_be64(f);
-        dev->summary_indicator = NULL;
-    }
-    qemu_get_be16s(f, &vdev->config_vector);
-    dev->routes.adapter.ind_offset = qemu_get_be64(f);
-    dev->thinint_isc = qemu_get_byte(f);
-    dev->revision = qemu_get_be32(f);
-    if (s->thinint_active) {
-        dev->routes.adapter.adapter_id = css_get_adapter_id(
-                                         CSS_IO_ADAPTER_VIRTIO,
-                                         dev->thinint_isc);
-    }
-
-    return 0;
+    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
 }
 
 static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 596a2f2ef3..eb0e26f258 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -88,6 +88,7 @@ struct SubchDev {
     bool ccw_fmt_1;
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
+    uint16_t migrated_schid; /* used for missmatch detection */
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
@@ -96,6 +97,8 @@ struct SubchDev {
     void *driver_data;
 };
 
+extern const VMStateDescription vmstate_subch_dev;
+
 /*
  * Identify a device within the channel subsystem.
  * Note that this can be used to identify either the subchannel or
@@ -118,18 +121,21 @@ typedef struct IndAddr {
     hwaddr addr;
     uint64_t map;
     unsigned long refcnt;
-    int len;
+    int32_t len;
     QTAILQ_ENTRY(IndAddr) sibling;
 } IndAddr;
 
+extern const VMStateDescription vmstate_ind_addr;
+
+#define VMSTATE_PTR_TO_IND_ADDR(_f, _s)                                   \
+    VMSTATE_STRUCT(_f, _s, 1, vmstate_ind_addr, IndAddr*)
+
 IndAddr *get_indicator(hwaddr ind_addr, int len);
 void release_indicator(AdapterInfo *adapter, IndAddr *indicator);
 int map_indicator(AdapterInfo *adapter, IndAddr *indicator);
 
 typedef SubchDev *(*css_subch_cb_func)(uint8_t m, uint8_t cssid, uint8_t ssid,
                                        uint16_t schid);
-void subch_device_save(SubchDev *s, QEMUFile *f);
-int subch_device_load(SubchDev *s, QEMUFile *f);
 int css_create_css_image(uint8_t cssid, bool default_image);
 bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index f9e6890c90..caa6fc608d 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -31,6 +31,11 @@ typedef struct AdapterRoutes {
     int gsi[ADAPTER_ROUTES_MAX_GSI];
 } AdapterRoutes;
 
+extern const VMStateDescription vmstate_adapter_routes;
+
+#define VMSTATE_ADAPTER_ROUTES(_f, _s) \
+    VMSTATE_STRUCT(_f, _s, 1, vmstate_adapter_routes, AdapterRoutes)
+
 #define TYPE_S390_FLIC_COMMON "s390-flic"
 #define S390_FLIC_COMMON(obj) \
     OBJECT_CHECK(S390FLICState, (obj), TYPE_S390_FLIC_COMMON)
-- 
2.11.2
