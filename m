Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7566AC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387D9206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387D9206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeUj-0003zp-Fs
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:32:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKD-0003V4-Ir
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKC-0003pr-Cl
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeKC-0003pN-4h; Thu, 25 Apr 2019 09:22:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64BDC3084039;
	Thu, 25 Apr 2019 13:22:03 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C9805D70A;
	Thu, 25 Apr 2019 13:22:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:27 +0200
Message-Id: <20190425132134.2839-13-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 25 Apr 2019 13:22:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/19] s390-bios: Refactor virtio to run channel
 programs via cio
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132127.8rsfYNHYTUom6bxuMoQUtqogspFcn5Hdvsu8i60IODs@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Now that we have a Channel I/O library let's modify virtio boot code to
make use of it for running channel programs.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-13-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/virtio.c | 57 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index aa9da7253fb2..35278eaee13d 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -14,6 +14,7 @@
 #include "virtio.h"
 #include "virtio-scsi.h"
 #include "bswap.h"
+#include "helper.h"
 
 #define VRING_WAIT_REPLY_TIMEOUT 30
 
@@ -89,33 +90,20 @@ int drain_irqs(SubChannelId schid)
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
+    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
 }
 
 static void vring_init(VRing *vr, VqInfo *info)
@@ -257,7 +245,7 @@ void virtio_setup_ccw(VDev *vdev)
     vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
 
-    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
+    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
 
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
@@ -278,18 +266,19 @@ void virtio_setup_ccw(VDev *vdev)
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
 
@@ -306,16 +295,17 @@ void virtio_setup_ccw(VDev *vdev)
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
 
@@ -323,8 +313,15 @@ bool virtio_is_supported(SubChannelId schid)
 {
     vdev.schid = schid;
     memset(&vdev.senseid, 0, sizeof(vdev.senseid));
-    /* run sense id command */
-    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid))) {
+
+    /*
+     * Run sense id command.
+     * The size of the senseid data differs between devices (notably,
+     * between virtio devices and dasds), so specify the largest possible
+     * size and suppress the incorrect length indication for smaller sizes.
+     */
+    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid),
+                true)) {
         return false;
     }
     if (vdev.senseid.cu_type == 0x3832) {
-- 
2.17.2


