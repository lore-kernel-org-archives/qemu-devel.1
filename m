Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C3EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16D4206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTkChkgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16D4206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwhE-0006Vd-QY
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdL-00015L-RV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdH-0008Sg-Vs
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592494755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cphq9My4Z0sqC2D491Z3D0cnxHSyHxCrPw5Ojc/D+mE=;
 b=NTkChkgsrMNkUranVY0wMQZ7C8vwcTNdMiPuPpYTYR0K5hjshGFnbNdkuvaoULHwzzeBx+
 ZfIQUaQzi2V+Qm/e+8IqQ+G5uzuWUSTDwKL29xN/XhjPo0p+so5n4sHa12WeoWuxJqDmDk
 8zCTW8BCHF4R8jxhHzuuZcJUWFCr4/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-lItAHX7UPcmN9CNLe9UONg-1; Thu, 18 Jun 2020 11:39:13 -0400
X-MC-Unique: lItAHX7UPcmN9CNLe9UONg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEA6ADBE9;
 Thu, 18 Jun 2020 15:39:11 +0000 (UTC)
Received: from localhost (ovpn-113-9.ams2.redhat.com [10.36.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 940E65D9D3;
 Thu, 18 Jun 2020 15:39:11 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 6/7] vfio-ccw: Add support for the CRW region and IRQ
Date: Thu, 18 Jun 2020 17:38:53 +0200
Message-Id: <20200618153854.271723-7-cohuck@redhat.com>
In-Reply-To: <20200618153854.271723-1-cohuck@redhat.com>
References: <20200618153854.271723-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
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
 Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Farhan Ali <alifm@linux.ibm.com>

The crw region can be used to obtain information about
Channel Report Words (CRW) from vfio-ccw driver.

Currently only channel-path related CRWs are passed to
QEMU from vfio-ccw driver.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200505125757.98209-7-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 47e43ea6068c..06e69d7066d5 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -44,7 +44,11 @@ struct VFIOCCWDevice {
     uint64_t schib_region_size;
     uint64_t schib_region_offset;
     struct ccw_schib_region *schib_region;
+    uint64_t crw_region_size;
+    uint64_t crw_region_offset;
+    struct ccw_crw_region *crw_region;
     EventNotifier io_notifier;
+    EventNotifier crw_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
 };
@@ -254,6 +258,44 @@ static void vfio_ccw_reset(DeviceState *dev)
     ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
 }
 
+static void vfio_ccw_crw_read(VFIOCCWDevice *vcdev)
+{
+    struct ccw_crw_region *region = vcdev->crw_region;
+    CRW crw;
+    int size;
+
+    /* Keep reading CRWs as long as data is returned */
+    do {
+        memset(region, 0, sizeof(*region));
+        size = pread(vcdev->vdev.fd, region, vcdev->crw_region_size,
+                     vcdev->crw_region_offset);
+
+        if (size == -1) {
+            error_report("vfio-ccw: Read crw region failed with errno=%d",
+                         errno);
+            break;
+        }
+
+        if (region->crw == 0) {
+            /* No more CRWs to queue */
+            break;
+        }
+
+        memcpy(&crw, &region->crw, sizeof(CRW));
+
+        css_crw_add_to_queue(crw);
+    } while (1);
+}
+
+static void vfio_ccw_crw_notifier_handler(void *opaque)
+{
+    VFIOCCWDevice *vcdev = opaque;
+
+    while (event_notifier_test_and_clear(&vcdev->crw_notifier)) {
+        vfio_ccw_crw_read(vcdev);
+    }
+}
+
 static void vfio_ccw_io_notifier_handler(void *opaque)
 {
     VFIOCCWDevice *vcdev = opaque;
@@ -340,6 +382,10 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         notifier = &vcdev->io_notifier;
         fd_read = vfio_ccw_io_notifier_handler;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        fd_read = vfio_ccw_crw_notifier_handler;
+        break;
     default:
         error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
         return;
@@ -391,6 +437,9 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
     case VFIO_CCW_IO_IRQ_INDEX:
         notifier = &vcdev->io_notifier;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        break;
     default:
         error_report("vfio: Unsupported device irq(%d)", irq);
         return;
@@ -468,10 +517,24 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         vcdev->schib_region = g_malloc(info->size);
     }
 
+    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
+                                   VFIO_REGION_SUBTYPE_CCW_CRW, &info);
+
+    if (!ret) {
+        vcdev->crw_region_size = info->size;
+        if (sizeof(*vcdev->crw_region) != vcdev->crw_region_size) {
+            error_setg(errp, "vfio: Unexpected size of the CRW region");
+            goto out_err;
+        }
+        vcdev->crw_region_offset = info->offset;
+        vcdev->crw_region = g_malloc(info->size);
+    }
+
     g_free(info);
     return;
 
 out_err:
+    g_free(vcdev->crw_region);
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
@@ -481,6 +544,7 @@ out_err:
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
+    g_free(vcdev->crw_region);
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
@@ -596,6 +660,14 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_notifier_err;
     }
 
+    if (vcdev->crw_region) {
+        vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX, &err);
+        if (err) {
+            vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
+            goto out_notifier_err;
+        }
+    }
+
     return;
 
 out_notifier_err:
@@ -620,6 +692,7 @@ static void vfio_ccw_unrealize(DeviceState *dev)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
+    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_ccw_put_device(vcdev);
-- 
2.25.4


