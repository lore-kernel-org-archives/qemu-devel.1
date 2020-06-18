Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75732C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB5D214DB
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAuUH7Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB5D214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwhW-0006xQ-F1
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdJ-0000xz-1W
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdG-0008SQ-Kx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592494753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCEYr0g8iKifbSomrbzERt12ywKfjc13Gkq1WTvOmtA=;
 b=SAuUH7Wp4MZmUgagX2fAhtgAUfPc+MTqVxV3Qusi16H900zTG7QRklTbnPb6IIeYt0D3Dl
 3p0LYUYFOjfnHcNnROYm5fcdTW88NtM7tIZDOxXzh/BmY7G6tp4I9U/3hP/S0oVnwtNPFG
 ZIDYm8h1BxVfGbaHUWdYFb9J1juAcYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-YE5ninsmNDWxOkaYKmZhIA-1; Thu, 18 Jun 2020 11:39:08 -0400
X-MC-Unique: YE5ninsmNDWxOkaYKmZhIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B18978BFB48;
 Thu, 18 Jun 2020 15:39:07 +0000 (UTC)
Received: from localhost (ovpn-113-9.ams2.redhat.com [10.36.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56CC47166B;
 Thu, 18 Jun 2020 15:39:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/7] vfio-ccw: Refactor ccw irq handler
Date: Thu, 18 Jun 2020 17:38:51 +0200
Message-Id: <20200618153854.271723-5-cohuck@redhat.com>
In-Reply-To: <20200618153854.271723-1-cohuck@redhat.com>
References: <20200618153854.271723-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Farman <farman@linux.ibm.com>

Make it easier to add new ones in the future.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200505125757.98209-5-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 58 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index f5a5e038aa45..47e43ea6068c 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -324,22 +324,36 @@ read_err:
     css_inject_io_interrupt(sch);
 }
 
-static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
+static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
+                                           unsigned int irq,
+                                           Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
     struct vfio_irq_info *irq_info;
     size_t argsz;
     int fd;
+    EventNotifier *notifier;
+    IOHandler *fd_read;
+
+    switch (irq) {
+    case VFIO_CCW_IO_IRQ_INDEX:
+        notifier = &vcdev->io_notifier;
+        fd_read = vfio_ccw_io_notifier_handler;
+        break;
+    default:
+        error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
+        return;
+    }
 
-    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
-        error_setg(errp, "vfio: unexpected number of io irqs %u",
+    if (vdev->num_irqs < irq + 1) {
+        error_setg(errp, "vfio: unexpected number of irqs %u",
                    vdev->num_irqs);
         return;
     }
 
     argsz = sizeof(*irq_info);
     irq_info = g_malloc0(argsz);
-    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
+    irq_info->index = irq;
     irq_info->argsz = argsz;
     if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
               irq_info) < 0 || irq_info->count < 1) {
@@ -347,37 +361,49 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
         goto out_free_info;
     }
 
-    if (event_notifier_init(&vcdev->io_notifier, 0)) {
+    if (event_notifier_init(notifier, 0)) {
         error_setg_errno(errp, errno,
-                         "vfio: Unable to init event notifier for IO");
+                         "vfio: Unable to init event notifier for irq (%d)",
+                         irq);
         goto out_free_info;
     }
 
-    fd = event_notifier_get_fd(&vcdev->io_notifier);
-    qemu_set_fd_handler(fd, vfio_ccw_io_notifier_handler, NULL, vcdev);
+    fd = event_notifier_get_fd(notifier);
+    qemu_set_fd_handler(fd, fd_read, NULL, vcdev);
 
-    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
+    if (vfio_set_irq_signaling(vdev, irq, 0,
                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vcdev);
-        event_notifier_cleanup(&vcdev->io_notifier);
+        event_notifier_cleanup(notifier);
     }
 
 out_free_info:
     g_free(irq_info);
 }
 
-static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
+static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
+                                             unsigned int irq)
 {
     Error *err = NULL;
+    EventNotifier *notifier;
+
+    switch (irq) {
+    case VFIO_CCW_IO_IRQ_INDEX:
+        notifier = &vcdev->io_notifier;
+        break;
+    default:
+        error_report("vfio: Unsupported device irq(%d)", irq);
+        return;
+    }
 
-    if (vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
+    if (vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
     }
 
-    qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
+    qemu_set_fd_handler(event_notifier_get_fd(notifier),
                         NULL, NULL, vcdev);
-    event_notifier_cleanup(&vcdev->io_notifier);
+    event_notifier_cleanup(notifier);
 }
 
 static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
@@ -565,7 +591,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_region_err;
     }
 
-    vfio_ccw_register_io_notifier(vcdev, &err);
+    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
     if (err) {
         goto out_notifier_err;
     }
@@ -594,7 +620,7 @@ static void vfio_ccw_unrealize(DeviceState *dev)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
-    vfio_ccw_unregister_io_notifier(vcdev);
+    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_ccw_put_device(vcdev);
     vfio_put_group(group);
-- 
2.25.4


