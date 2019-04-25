Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40930C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA47C212F5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA47C212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeOy-0007EP-7b
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:27:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKF-0003V5-BJ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKE-0003rs-8s
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeKE-0003rB-0U; Thu, 25 Apr 2019 09:22:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46B0158E5B;
	Thu, 25 Apr 2019 13:22:05 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9EE417A60;
	Thu, 25 Apr 2019 13:22:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:28 +0200
Message-Id: <20190425132134.2839-14-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 25 Apr 2019 13:22:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/19] s390-bios: Use control unit type to
 determine boot method
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
Message-ID: <20190425132128.xge96ds6VupZla_fURzlIVcNk5n_x56F_XxMmv-hKB4@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

The boot method is different depending on which device type we are
booting from. Let's examine the control unit type to determine if we're
a virtio device. We'll eventually add a case to check for a real dasd device
here as well.

Since we have to call enable_subchannel() in main now, might as well
remove that call from virtio.c : run_ccw(). This requires adding some
additional enable_subchannel calls to not break calls to
virtio_is_supported().

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-14-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c    | 16 ++++++++++++++--
 pc-bios/s390-ccw/netmain.c |  1 +
 pc-bios/s390-ccw/virtio.c  |  1 -
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index d3a161c68546..57a10138c65d 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -76,6 +76,7 @@ static bool find_subch(int dev_no)
         /* Skip net devices since no IPLB is created and therefore no
          * network bootloader has been loaded
          */
+        enable_subchannel(blk_schid);
         if (virtio_is_supported(blk_schid) &&
             virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
             continue;
@@ -198,13 +199,24 @@ static void virtio_setup(void)
 
 int main(void)
 {
+    uint16_t cutype;
+
     sclp_setup();
     css_setup();
     boot_setup();
     find_boot_device();
+    enable_subchannel(blk_schid);
 
-    virtio_setup();
-    zipl_load(); /* no return */
+    cutype = cu_type(blk_schid);
+    switch (cutype) {
+    case CU_TYPE_VIRTIO:
+        virtio_setup();
+        zipl_load(); /* no return */
+        break;
+    default:
+        print_int("Attempting to boot from unexpected device type", cutype);
+        panic("");
+    }
 
     panic("Failed to load OS from hard disk\n");
     return 0; /* make compiler happy */
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 5189c0fc39e5..f3542cb2cf11 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -476,6 +476,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
         if (!schib->pmcw.dnv) {
             continue;
         }
+        enable_subchannel(net_schid);
         if (!virtio_is_supported(net_schid)) {
             continue;
         }
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 35278eaee13d..fb40ca982853 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -102,7 +102,6 @@ static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
         ccw.flags |= CCW_FLAG_SLI;
     }
 
-    enable_subchannel(vdev->schid);
     return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
 }
 
-- 
2.17.2


