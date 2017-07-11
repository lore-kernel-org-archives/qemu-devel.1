Received: from eggs.gnu.org ([2001:4830:134:3::10]:48163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwZ2-0000AQ-98
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwYw-00052M-C9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:55:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45303
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dUwYw-000529-6v
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BEsLgc103867
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:53 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bn0msrm4a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:53 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 15:54:51 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 16:54:38 +0200
In-Reply-To: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170711145441.33925-4-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/6] s390x/css: add missing css state
 conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Although we have recently vmstatified the migration of some css
infrastructure,  for some css entities there is still state to be
migrated left, because the focus was keeping migration stream
compatibility (that is basically everything as-is).

Let us add vmstate helpers and extend existing vmstate descriptions so
that we have everything we need. Let us guard the added state via
css_migration_enabled, so we keep the compatible behavior if css
migration is disabled.

Let's also annotate the bits which do not need to be migrated for better
readability.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 hw/intc/s390_flic.c | 20 +++++++++++++++
 hw/s390x/css.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 837158bdaf..1678039d6b 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -138,6 +138,22 @@ static void qemu_s390_flic_register_types(void)
 
 type_init(qemu_s390_flic_register_types)
 
+static bool adapter_info_so_needed(void *opaque)
+{
+    return css_migration_enabled();
+}
+
+const VMStateDescription vmstate_adapter_info_so = {
+    .name = "s390_adapter_info/summary_offset",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = adapter_info_so_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(summary_offset, AdapterInfo),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_adapter_info = {
     .name = "s390_adapter_info",
     .version_id = 1,
@@ -151,6 +167,10 @@ const VMStateDescription vmstate_adapter_info = {
          */
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_adapter_info_so,
+        NULL
+    }
 };
 
 const VMStateDescription vmstate_adapter_routes = {
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index d67fffae30..4747589d90 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -29,12 +29,45 @@ typedef struct CrwContainer {
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
@@ -221,6 +254,19 @@ typedef struct CssImage {
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
@@ -238,10 +284,34 @@ typedef struct ChannelSubSys {
     uint64_t chnmon_area;
     CssImage *css[MAX_CSSID + 1];
     uint8_t default_cssid;
+    /* don't migrate, see css_register_io_adapters */
     IoAdapter *io_adapters[CSS_IO_ADAPTER_TYPE_NUMS][MAX_ISC + 1];
+    /* don't migrate, see get_indicator and IndAddrPtrTmp */
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
@@ -281,6 +351,10 @@ static int subch_dev_post_load(void *opaque, int version_id)
         css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
     }
 
+    if (css_migration_enabled()) {
+        /* No compat voodoo to do ;) */
+        return 0;
+    }
     /*
      * Hack alert. If we don't migrate the channel subsystem status
      * we still need to find out if the guest enabled mss/mcss-e.
-- 
2.11.2
