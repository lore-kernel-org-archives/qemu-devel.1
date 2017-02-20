Received: from eggs.gnu.org ([2001:4830:134:3::10]:39359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj9-0003qw-8A
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj5-0005cA-9k
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51111
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkj5-0005c1-3S
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:47 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9rbHw130253
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:46 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qtvs850e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:45 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:44 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:26 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-5-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 04/12] virtio-ccw: handle virtio 1 only devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

As a preparation for wiring-up virtio-crypto, the first non-transitional
virtio device on the ccw transport, let us introduce a mechanism for
disabling revision 0.  This is more or less equivalent with disabling
legacy as revision 0 is legacy only, and legacy drivers use the revision
0 exclusively.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c | 18 +++++++++++++++++-
 hw/s390x/virtio-ccw.h |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 63c46373fb..32c414f23d 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -280,6 +280,15 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                    ccw.cmd_code);
     check_len = !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG_DC));
 
+    if (dev->force_revision_1 && dev->revision < 0 &&
+        ccw.cmd_code != CCW_CMD_SET_VIRTIO_REV) {
+        /*
+         * virtio-1 drivers must start with negotiating to a revision >= 1,
+         * so post a command reject for all other commands
+         */
+        return -ENOSYS;
+    }
+
     /* Look at the command. */
     switch (ccw.cmd_code) {
     case CCW_CMD_SET_VQ:
@@ -638,7 +647,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
          * need to fetch it here. Nothing to do for now, though.
          */
         if (dev->revision >= 0 ||
-            revinfo.revision > virtio_ccw_rev_max(dev)) {
+            revinfo.revision > virtio_ccw_rev_max(dev) ||
+            (dev->force_revision_1 && !revinfo.revision)) {
             ret = -ENOSYS;
             break;
         }
@@ -669,6 +679,12 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
     if (!sch) {
         return;
     }
+    if (!virtio_ccw_rev_max(dev) && dev->force_revision_1) {
+        error_setg(&err, "Invalid value of property max_rev "
+                   "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
+        error_propagate(errp, err);
+        return;
+    }
 
     sch->driver_data = dev;
     sch->ccw_cb = virtio_ccw_cb;
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 77d10f1671..6a04e94f66 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -94,6 +94,7 @@ struct VirtioCcwDevice {
     IndAddr *indicators2;
     IndAddr *summary_indicator;
     uint64_t ind_bit;
+    bool force_revision_1;
 };
 
 /* The maximum virtio revision we support. */
-- 
2.11.0
