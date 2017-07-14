Received: from eggs.gnu.org ([2001:4830:134:3::10]:55898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOC-0007X2-UG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyO9-0003Xg-Pt
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyO9-0003XK-HH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EAxbK0067840
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:00 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bps7dg9xb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:59 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:03:57 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:42 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-16-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 15/40] s390x/css: add ORB to SubchDev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Since we are going to need a migration compatibility breaking change to
activate ChannelSubSys migration let us use the opportunity to introduce
ORB to the SubchDev before that (otherwise we would need separate
handling e.g. a compat property).

The ORB will be useful for implementing IDA, or async handling of
subchannel work.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Message-Id: <20170711145441.33925-5-pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/css.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index e9a0613..0768fec 100644
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
 
@@ -1386,6 +1420,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     if (channel_subsys.chnmon_active) {
         css_update_chnmon(sch);
     }
+    sch->orb = *orb;
     sch->channel_prog = orb->cpa;
     /* Trigger the start function. */
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index dd36d39..8f08126 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -90,6 +90,7 @@ struct SubchDev {
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
     uint16_t migrated_schid; /* used for missmatch detection */
+    ORB orb;
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
-- 
2.7.4
