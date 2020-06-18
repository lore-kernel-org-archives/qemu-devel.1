Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D6C4345B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67334206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFJZtDqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67334206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwef-0002cg-FD
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdG-0000tL-Fd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57944
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdE-0008S2-1r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592494751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SKwsg7fjhgUuUg0jcYJc5w5X/OZ14mQSnvNpy01/2M=;
 b=QFJZtDqzb8uFkmG9VKkxTKVZPe4t7pA+kTpF6gqXWN0zUeuFtODqRy5aDNCz1Pl6tHOpHO
 XAKQ5skeWRJS/IC7UqGhSQGxCyEMN0Z0L36/ovDupmWLrtEU/Tllk3ZSh1/d7wXboAlFBQ
 BCQ5dQWvxT+wacdWgogncuFAignTEhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-BhulzFeEOzChB2N4WftpyA-1; Thu, 18 Jun 2020 11:39:07 -0400
X-MC-Unique: BhulzFeEOzChB2N4WftpyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DAE0107ACCA;
 Thu, 18 Jun 2020 15:39:05 +0000 (UTC)
Received: from localhost (ovpn-113-9.ams2.redhat.com [10.36.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19C3F1E226B;
 Thu, 18 Jun 2020 15:39:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/7] vfio-ccw: Add support for the schib region
Date: Thu, 18 Jun 2020 17:38:50 +0200
Message-Id: <20200618153854.271723-4-cohuck@redhat.com>
In-Reply-To: <20200618153854.271723-1-cohuck@redhat.com>
References: <20200618153854.271723-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The schib region can be used to obtain the latest SCHIB from the host
passthrough subchannel. Since the guest SCHIB is virtualized,
we currently only update the path related information so that the
guest is aware of any path related changes when it issues the
'stsch' instruction.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200505125757.98209-4-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c              | 13 ++++++--
 hw/s390x/s390-ccw.c         | 21 +++++++++++++
 hw/vfio/ccw.c               | 63 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h      |  3 +-
 include/hw/s390x/s390-ccw.h |  1 +
 target/s390x/ioinst.c       |  3 +-
 6 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 5d8e08667e6f..a44faa3549b4 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1335,11 +1335,20 @@ static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
     }
 }
 
-int css_do_stsch(SubchDev *sch, SCHIB *schib)
+IOInstEnding css_do_stsch(SubchDev *sch, SCHIB *schib)
 {
+    int ret;
+
+    /*
+     * For some subchannels, we may want to update parts of
+     * the schib (e.g., update path masks from the host device
+     * for passthrough subchannels).
+     */
+    ret = s390_ccw_store(sch);
+
     /* Use current status. */
     copy_schib_to_guest(schib, &sch->curr_status);
-    return 0;
+    return ret;
 }
 
 static void copy_pmcw_from_guest(PMCW *dest, const PMCW *src)
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index c48510f9e543..b497571863f6 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -51,6 +51,27 @@ int s390_ccw_clear(SubchDev *sch)
     return cdc->handle_clear(sch);
 }
 
+IOInstEnding s390_ccw_store(SubchDev *sch)
+{
+    S390CCWDeviceClass *cdc = NULL;
+    int ret = IOINST_CC_EXPECTED;
+
+    /*
+     * This code is called for both virtual and passthrough devices,
+     * but only applies to to the latter.  This ugly check makes that
+     * distinction for us.
+     */
+    if (object_dynamic_cast(OBJECT(sch->driver_data), TYPE_S390_CCW)) {
+        cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
+    }
+
+    if (cdc && cdc->handle_store) {
+        ret = cdc->handle_store(sch);
+    }
+
+    return ret;
+}
+
 static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
                                   char *sysfsdev,
                                   Error **errp)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ca06213d0375..f5a5e038aa45 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -41,6 +41,9 @@ struct VFIOCCWDevice {
     uint64_t async_cmd_region_size;
     uint64_t async_cmd_region_offset;
     struct ccw_cmd_region *async_cmd_region;
+    uint64_t schib_region_size;
+    uint64_t schib_region_offset;
+    struct ccw_schib_region *schib_region;
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
@@ -116,6 +119,51 @@ again:
     }
 }
 
+static IOInstEnding vfio_ccw_handle_store(SubchDev *sch)
+{
+    S390CCWDevice *cdev = sch->driver_data;
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    SCHIB *schib = &sch->curr_status;
+    struct ccw_schib_region *region = vcdev->schib_region;
+    SCHIB *s;
+    int ret;
+
+    /* schib region not available so nothing else to do */
+    if (!region) {
+        return IOINST_CC_EXPECTED;
+    }
+
+    memset(region, 0, sizeof(*region));
+    ret = pread(vcdev->vdev.fd, region, vcdev->schib_region_size,
+                vcdev->schib_region_offset);
+
+    if (ret == -1) {
+        /*
+         * Device is probably damaged, but store subchannel does not
+         * have a nonzero cc defined for this scenario.  Log an error,
+         * and presume things are otherwise fine.
+         */
+        error_report("vfio-ccw: store region read failed with errno=%d", errno);
+        return IOINST_CC_EXPECTED;
+    }
+
+    /*
+     * Selectively copy path-related bits of the SCHIB,
+     * rather than copying the entire struct.
+     */
+    s = (SCHIB *)region->schib_area;
+    schib->pmcw.pnom = s->pmcw.pnom;
+    schib->pmcw.lpum = s->pmcw.lpum;
+    schib->pmcw.pam = s->pmcw.pam;
+    schib->pmcw.pom = s->pmcw.pom;
+
+    if (s->scsw.flags & SCSW_FLAGS_MASK_PNO) {
+        schib->scsw.flags |= SCSW_FLAGS_MASK_PNO;
+    }
+
+    return IOINST_CC_EXPECTED;
+}
+
 static int vfio_ccw_handle_clear(SubchDev *sch)
 {
     S390CCWDevice *cdev = sch->driver_data;
@@ -382,10 +430,23 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         vcdev->async_cmd_region = g_malloc0(info->size);
     }
 
+    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
+                                   VFIO_REGION_SUBTYPE_CCW_SCHIB, &info);
+    if (!ret) {
+        vcdev->schib_region_size = info->size;
+        if (sizeof(*vcdev->schib_region) != vcdev->schib_region_size) {
+            error_setg(errp, "vfio: Unexpected size of the schib region");
+            goto out_err;
+        }
+        vcdev->schib_region_offset = info->offset;
+        vcdev->schib_region = g_malloc(info->size);
+    }
+
     g_free(info);
     return;
 
 out_err:
+    g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
     g_free(info);
@@ -394,6 +455,7 @@ out_err:
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
+    g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
 }
@@ -569,6 +631,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     cdc->handle_request = vfio_ccw_handle_request;
     cdc->handle_halt = vfio_ccw_handle_halt;
     cdc->handle_clear = vfio_ccw_handle_clear;
+    cdc->handle_store = vfio_ccw_handle_store;
 }
 
 static const TypeInfo vfio_ccw_info = {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index f46bcafb16c3..7e3a5e743314 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -218,6 +218,7 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sub);
 
 int s390_ccw_halt(SubchDev *sch);
 int s390_ccw_clear(SubchDev *sch);
+IOInstEnding s390_ccw_store(SubchDev *sch);
 
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
@@ -242,7 +243,7 @@ SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
 void css_conditional_io_interrupt(SubchDev *sch);
-int css_do_stsch(SubchDev *sch, SCHIB *schib);
+IOInstEnding css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *schib);
 IOInstEnding css_do_xsch(SubchDev *sch);
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 7f27bc2f5314..d8e08b5f4cd9 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -37,6 +37,7 @@ typedef struct S390CCWDeviceClass {
     IOInstEnding (*handle_request) (SubchDev *sch);
     int (*handle_halt) (SubchDev *sch);
     int (*handle_clear) (SubchDev *sch);
+    IOInstEnding (*handle_store) (SubchDev *sch);
 } S390CCWDeviceClass;
 
 #endif
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 7a14c52c123b..a412926d2780 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -292,8 +292,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     sch = css_find_subch(m, cssid, ssid, schid);
     if (sch) {
         if (css_subch_visible(sch)) {
-            css_do_stsch(sch, &schib);
-            cc = 0;
+            cc = css_do_stsch(sch, &schib);
         } else {
             /* Indicate no more subchannels in this css/ss */
             cc = 3;
-- 
2.25.4


