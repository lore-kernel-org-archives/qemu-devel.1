Received: from eggs.gnu.org ([2001:4830:134:3::10]:45477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8c-00016u-SF
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8Z-0005LU-Pw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47904
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8Z-0005LF-Jx
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXoxd126831
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:27 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a8rx2fnnp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:26 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:25 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:35:05 +0200
In-Reply-To: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170505173507.74077-9-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 08/10] s390x/css: add ORB to SubchDev
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

Since we are going to need a migration compatibility breaking change to
activate ChannelSubSys migration let us use the opportunity to introduce
ORB to the SubchDev before that (otherwise we would need separate
handling e.g. a compat property).

The ORB will be useful for implementing IDA, or async handling of
subchannel work.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 94338b2..d9a0fb9 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -163,6 +163,36 @@ static const VMStateDescription vmstate_sense_id = {
     }
 };
 
+static const VMStateDescription vmstate_orb = {
+    .name = "s390_orb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(intparm, ORB),
+        VMSTATE_UINT16(ctrl0, ORB),
+        VMSTATE_UINT8(lpm, ORB),
+        VMSTATE_UINT8(ctrl1, ORB),
+        VMSTATE_UINT32(cpa, ORB),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vmstate_schdev_orb_needed(void *opaque)
+{
+    return css_migration_enabled();
+}
+
+static const VMStateDescription vmstate_schdev_orb = {
+    .name = "s390_subch_dev/orb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_schdev_orb_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(orb, SubchDev, 1, vmstate_orb, ORB),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int subch_dev_post_load(void *opaque, int version_id);
 static void subch_dev_pre_save(void *opaque);
 
@@ -187,6 +217,10 @@ const VMStateDescription vmstate_subch_dev = {
         VMSTATE_BOOL(ccw_fmt_1, SubchDev),
         VMSTATE_UINT8(ccw_no_data_cnt, SubchDev),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_schdev_orb,
+        NULL
     }
 };
 
@@ -1234,6 +1268,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     if (channel_subsys.chnmon_active) {
         css_update_chnmon(sch);
     }
+    sch->orb = *orb;
     sch->channel_prog = orb->cpa;
     /* Trigger the start function. */
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index e67ac5c..dbe093e 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -88,6 +88,7 @@ struct SubchDev {
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
     uint16_t migrated_schid; /* used for missmatch detection */
+    ORB orb;
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
-- 
2.10.2
