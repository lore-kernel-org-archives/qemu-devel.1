Received: from eggs.gnu.org ([2001:4830:134:3::10]:48135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwZ0-00008r-Ne
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwYx-00052i-Ek
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59334
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dUwYx-00052e-9Q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BEs3BT055246
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:54 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bn0mv0m32-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:54 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 15:54:52 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 16:54:39 +0200
In-Reply-To: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170711145441.33925-5-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 4/6] s390x/css: add ORB to SubchDev
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

Since we are going to need a migration compatibility breaking change to
activate ChannelSubSys migration let us use the opportunity to introduce
ORB to the SubchDev before that (otherwise we would need separate
handling e.g. a compat property).

The ORB will be useful for implementing IDA, or async handling of
subchannel work.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 4747589d90..20b5fbed68 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -165,6 +165,36 @@ static const VMStateDescription vmstate_sense_id = {
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
 
@@ -193,6 +223,10 @@ const VMStateDescription vmstate_subch_dev = {
         VMSTATE_BOOL(ccw_fmt_1, SubchDev),
         VMSTATE_UINT8(ccw_no_data_cnt, SubchDev),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_schdev_orb,
+        NULL
     }
 };
 
@@ -1342,6 +1376,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     if (channel_subsys.chnmon_active) {
         css_update_chnmon(sch);
     }
+    sch->orb = *orb;
     sch->channel_prog = orb->cpa;
     /* Trigger the start function. */
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index eb0e26f258..5d302223e6 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -89,6 +89,7 @@ struct SubchDev {
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
     uint16_t migrated_schid; /* used for missmatch detection */
+    ORB orb;
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
-- 
2.11.2
