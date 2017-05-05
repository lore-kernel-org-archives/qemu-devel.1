Received: from eggs.gnu.org ([2001:4830:134:3::10]:45413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8X-00012A-5H
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8T-0005Hy-Tn
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42642
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8T-0005Hl-NE
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXl0B028360
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:21 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a8vep3w47-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:20 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:18 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:35:00 +0200
In-Reply-To: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170505173507.74077-4-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 03/10] s390x/css: add vmstate entities for css
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

As a preparation for switching to a vmstate based migration let us
introduce vmstate entities (e.g. VMStateDescription) for the css entities
to be migrated. Alongside some comments explaining or indicating the not
migration of certain members are introduced too.

No changes in behavior, we just added some dead code -- which should
rise to life soon.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 276 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h |  10 +-
 2 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c03bb20..2bda7d0 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -20,29 +20,231 @@
 #include "hw/s390x/css.h"
 #include "trace.h"
 #include "hw/s390x/s390_flic.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 typedef struct CrwContainer {
     CRW crw;
     QTAILQ_ENTRY(CrwContainer) sibling;
 } CrwContainer;
 
+static const VMStateDescription vmstate_crw = {
+    .name = "s390_crw",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(flags, CRW),
+        VMSTATE_UINT16(rsid, CRW),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_crw_container = {
+    .name = "s390_crw_container",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(crw, CrwContainer, 0, vmstate_crw, CRW),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 typedef struct ChpInfo {
     uint8_t in_use;
     uint8_t type;
     uint8_t is_virtual;
 } ChpInfo;
 
+static const VMStateDescription vmstate_chp_info = {
+    .name = "s390_chp_info",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(in_use, ChpInfo),
+        VMSTATE_UINT8(type, ChpInfo),
+        VMSTATE_UINT8(is_virtual, ChpInfo),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 typedef struct SubchSet {
     SubchDev *sch[MAX_SCHID + 1];
     unsigned long schids_used[BITS_TO_LONGS(MAX_SCHID + 1)];
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
+const VMStateDescription vmstate_subch_dev = {
+    .name = "s390_subch_dev",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = subch_dev_post_load,
+    .pre_save = subch_dev_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_EQUAL(cssid, SubchDev),
+        VMSTATE_UINT8_EQUAL(ssid, SubchDev),
+        VMSTATE_UINT16(migrated_schid, SubchDev),
+        VMSTATE_UINT16_EQUAL(devno, SubchDev),
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
+static int css_get_ind_addr(QEMUFile *f, void *pv, size_t size,
+                            VMStateField *field)
+{
+    int32_t len;
+    IndAddr **ind_addr = pv;
+
+    len = qemu_get_be32(f);
+    if (len != 0) {
+        *ind_addr = get_indicator(qemu_get_be64(f), len);
+    } else {
+        qemu_get_be64(f);
+        *ind_addr = NULL;
+    }
+    return 0;
+}
+
+static int css_put_ind_addr(QEMUFile *f, void *pv, size_t size,
+                            VMStateField *field, QJSON *vmdesc)
+{
+    IndAddr *ind_addr = *(IndAddr **) pv;
+
+    if (ind_addr != NULL) {
+        qemu_put_be32(f, ind_addr->len);
+        qemu_put_be64(f, ind_addr->addr);
+    } else {
+        qemu_put_be32(f, 0);
+        qemu_put_be64(f, 0UL);
+    }
+    return 0;
+}
+
+const VMStateInfo vmstate_info_ind_addr = {
+    .name = "s390_ind_addr",
+    .get = css_get_ind_addr,
+    .put = css_put_ind_addr
+};
+
 typedef struct CssImage {
     SubchSet *sch_set[MAX_SSID + 1];
     ChpInfo chpids[MAX_CHPID + 1];
 } CssImage;
 
+static const VMStateDescription vmstate_css_img = {
+    .name = "s390_css_img",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        /* Subchannel sets have no relevant state. */
+        VMSTATE_STRUCT_ARRAY(chpids, CssImage, MAX_CHPID + 1, 0,
+                             vmstate_chp_info, ChpInfo),
+        VMSTATE_END_OF_LIST()
+    }
+
+};
+
 typedef struct IoAdapter {
     uint32_t id;
     uint8_t type;
@@ -60,10 +262,34 @@ typedef struct ChannelSubSys {
     uint64_t chnmon_area;
     CssImage *css[MAX_CSSID + 1];
     uint8_t default_cssid;
+    /* don't migrate */
     IoAdapter *io_adapters[CSS_IO_ADAPTER_TYPE_NUMS][MAX_ISC + 1];
+    /* don't migrate */
     QTAILQ_HEAD(, IndAddr) indicator_addresses;
 } ChannelSubSys;
 
+static const VMStateDescription vmstate_css = {
+    .name = "s390_css",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_QTAILQ_V(pending_crws, ChannelSubSys, 1, vmstate_crw_container,
+                         CrwContainer, sibling),
+        VMSTATE_BOOL(sei_pending, ChannelSubSys),
+        VMSTATE_BOOL(do_crw_mchk, ChannelSubSys),
+        VMSTATE_BOOL(crws_lost, ChannelSubSys),
+        /* These were kind of migrated by virtio */
+        VMSTATE_UINT8(max_cssid, ChannelSubSys),
+        VMSTATE_UINT8(max_ssid, ChannelSubSys),
+        VMSTATE_BOOL(chnmon_active, ChannelSubSys),
+        VMSTATE_UINT64(chnmon_area, ChannelSubSys),
+        VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(css, ChannelSubSys, MAX_CSSID + 1,
+                0, vmstate_css_img, CssImage),
+        VMSTATE_UINT8(default_cssid, ChannelSubSys),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static ChannelSubSys channel_subsys = {
     .pending_crws = QTAILQ_HEAD_INITIALIZER(channel_subsys.pending_crws),
     .do_crw_mchk = true,
@@ -75,6 +301,56 @@ static ChannelSubSys channel_subsys = {
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
+    if (css_migration_enabled()) {
+        /* No compat voodoo to do ;) */
+        return 0;
+    }
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
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index f1f0d7f..6a451b2 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -87,6 +87,7 @@ struct SubchDev {
     bool ccw_fmt_1;
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
+    uint16_t migrated_schid; /* used for missmatch detection */
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
@@ -94,14 +95,21 @@ struct SubchDev {
     void *driver_data;
 };
 
+extern const VMStateDescription vmstate_subch_dev;
+
 typedef struct IndAddr {
     hwaddr addr;
     uint64_t map;
     unsigned long refcnt;
-    int len;
+    int32_t len;
     QTAILQ_ENTRY(IndAddr) sibling;
 } IndAddr;
 
+extern const VMStateInfo vmstate_info_ind_addr;
+
+#define VMSTATE_PTR_TO_IND_ADDR(_f, _s)                                   \
+    VMSTATE_SINGLE(_f, _s, 1 , vmstate_info_ind_addr, IndAddr*)
+
 IndAddr *get_indicator(hwaddr ind_addr, int len);
 void release_indicator(AdapterInfo *adapter, IndAddr *indicator);
 int map_indicator(AdapterInfo *adapter, IndAddr *indicator);
-- 
2.10.2
