Received: from eggs.gnu.org ([209.51.188.92]:60417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSm-0000Fw-Ed
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSl-0000Tv-Ik
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goTSl-0000SA-56
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:03 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDRXSO078724
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:30:01 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qap89nkrb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:59 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 13:29:47 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 08:29:19 -0500
In-Reply-To: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1548768562-20007-13-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 12/15] s390-bios: Refactor virtio to run
 channel programs via cio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Now that we have a Channel I/O library let's modify virtio boot code to
make use of it for running channel programs.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio.c | 48 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index aa9da72..f8d71ed 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -89,33 +89,20 @@ int drain_irqs(SubChannelId schid)
     }
 }
 
-static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
+static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
 {
     Ccw1 ccw = {};
-    CmdOrb orb = {};
-    int r;
-
-    enable_subchannel(vdev->schid);
-
-    /* start subchannel command */
-    orb.fmt = 1;
-    orb.cpa = (u32)(long)&ccw;
-    orb.lpm = 0x80;
 
     ccw.cmd_code = cmd;
     ccw.cda = (long)ptr;
     ccw.count = len;
 
-    r = ssch(vdev->schid, &orb);
-    /*
-     * XXX Wait until device is done processing the CCW. For now we can
-     *     assume that a simple tsch will have finished the CCW processing,
-     *     but the architecture allows for asynchronous operation
-     */
-    if (!r) {
-        r = drain_irqs(vdev->schid);
+    if (sli) {
+        ccw.flags |= CCW_FLAG_SLI;
     }
-    return r;
+
+    enable_subchannel(vdev->schid);
+    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);
 }
 
 static void vring_init(VRing *vr, VqInfo *info)
@@ -257,7 +244,7 @@ void virtio_setup_ccw(VDev *vdev)
     vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
 
-    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
+    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
 
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
@@ -278,18 +265,19 @@ void virtio_setup_ccw(VDev *vdev)
     default:
         panic("Unsupported virtio device\n");
     }
-    IPL_assert(run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size) == 0,
-               "Could not get block device configuration");
+    IPL_assert(
+        run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false) == 0,
+       "Could not get block device configuration");
 
     /* Feature negotiation */
     for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
         feats.features = 0;
         feats.index = i;
-        rc = run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats));
+        rc = run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), false);
         IPL_assert(rc == 0, "Could not get features bits");
         vdev->guest_features[i] &= bswap32(feats.features);
         feats.features = bswap32(vdev->guest_features[i]);
-        rc = run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats));
+        rc = run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), false);
         IPL_assert(rc == 0, "Could not set features bits");
     }
 
@@ -306,16 +294,17 @@ void virtio_setup_ccw(VDev *vdev)
         };
 
         IPL_assert(
-            run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config)) == 0,
+            run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config), false) == 0,
             "Could not get block device VQ configuration");
         info.num = config.num;
         vring_init(&vdev->vrings[i], &info);
         vdev->vrings[i].schid = vdev->schid;
-        IPL_assert(run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info)) == 0,
-                   "Cannot set VQ info");
+        IPL_assert(
+            run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false) == 0,
+            "Cannot set VQ info");
     }
     IPL_assert(
-        run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status)) == 0,
+        run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false) == 0,
         "Could not write status to host");
 }
 
@@ -324,7 +313,8 @@ bool virtio_is_supported(SubChannelId schid)
     vdev.schid = schid;
     memset(&vdev.senseid, 0, sizeof(vdev.senseid));
     /* run sense id command */
-    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid))) {
+    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid),
+                true)) {
         return false;
     }
     if (vdev.senseid.cu_type == 0x3832) {
-- 
2.7.4
