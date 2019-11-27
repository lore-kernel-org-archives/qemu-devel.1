Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF305C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88ECD2082D
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88ECD2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia3NX-0003aj-PQ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia3LY-00021a-8z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia3LX-0005TR-7p
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:51:32 -0500
Received: from relay.sw.ru ([185.231.240.75]:55610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia3LT-0005I7-I8; Wed, 27 Nov 2019 14:51:27 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia3LI-0004gM-F0; Wed, 27 Nov 2019 22:51:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH v6] hw/vfio/ap: drop local_err from vfio_ap_realize
Date: Wed, 27 Nov 2019 22:51:16 +0300
Message-Id: <20191127195116.30636-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: akrowiak@linux.ibm.com, vsementsov@virtuozzo.com, pmorel@linux.ibm.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, alex.williamson@redhat.com, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No reason for local_err here, use errp directly instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v6: keep return code checking [Cornelia]

 hw/vfio/ap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index da6a20669d..8fbaa724c2 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -89,14 +89,13 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 {
     int ret;
     char *mdevid;
-    Error *local_err = NULL;
     VFIOGroup *vfio_group;
     APDevice *apdev = AP_DEVICE(dev);
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
 
-    vfio_group = vfio_ap_get_group(vapdev, &local_err);
+    vfio_group = vfio_ap_get_group(vapdev, errp);
     if (!vfio_group) {
-        goto out_err;
+        return;
     }
 
     vapdev->vdev.ops = &vfio_ap_ops;
@@ -113,7 +112,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
      */
     vapdev->vdev.balloon_allowed = true;
 
-    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
+    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
     if (ret) {
         goto out_get_dev_err;
     }
@@ -123,8 +122,6 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 out_get_dev_err:
     vfio_ap_put_device(vapdev);
     vfio_put_group(vfio_group);
-out_err:
-    error_propagate(errp, local_err);
 }
 
 static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
-- 
2.21.0


