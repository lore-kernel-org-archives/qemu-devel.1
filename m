Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E51EC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1522083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeLu15oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1522083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrVw-00043f-HW
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLrUA-0002MY-NR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLrU7-0007BD-Ok
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:26:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601054775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUpo1DJesgvRqw3d+/1xweFRc1qsON2eoPTXlfvGNrs=;
 b=EeLu15oZ7QvmhkR/QOOKeVAc1W3fLkoJ1O/qjbpwMem/+k6hBSod9Is7EZ3i3z2pJmMZKa
 VGlrSrP4S8ZtowAjJ6STBi/lukJk9ZNm3xlZptpGXcumjFGOBEasqvEmXgZnLzrJ3q6NZo
 gPIqc/8aw/fBq6CM4yIqxKNWtwckoeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-rqt3pe73M-eZ3_RKk1IEZQ-1; Fri, 25 Sep 2020 13:26:13 -0400
X-MC-Unique: rqt3pe73M-eZ3_RKk1IEZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48CFA10BBED5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 17:26:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC8A25D9F3;
 Fri, 25 Sep 2020 17:26:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/10] scsi/scsi-bus: scsi_device_find: don't return
 unrealized devices
Date: Fri, 25 Sep 2020 13:26:01 -0400
Message-Id: <20200925172604.2142227-8-pbonzini@redhat.com>
In-Reply-To: <20200925172604.2142227-1-pbonzini@redhat.com>
References: <20200925172604.2142227-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@redhat.com, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

The device core first places a device on the bus and then realizes it.
Make scsi_device_find avoid returing such devices to avoid
races in drivers that use an iothread (currently virtio-scsi)

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1812399

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-7-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 83 +++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 4ab9811cd8..7599113efe 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -24,6 +24,55 @@ static void scsi_target_free_buf(SCSIRequest *req);
 
 static int next_scsi_bus;
 
+static SCSIDevice *do_scsi_device_find(SCSIBus *bus,
+                                       int channel, int id, int lun,
+                                       bool include_unrealized)
+{
+    BusChild *kid;
+    SCSIDevice *retval = NULL;
+
+    QTAILQ_FOREACH_RCU(kid, &bus->qbus.children, sibling) {
+        DeviceState *qdev = kid->child;
+        SCSIDevice *dev = SCSI_DEVICE(qdev);
+
+        if (dev->channel == channel && dev->id == id) {
+            if (dev->lun == lun) {
+                retval = dev;
+                break;
+            }
+
+            /*
+             * If we don't find exact match (channel/bus/lun),
+             * we will return the first device which matches channel/bus
+             */
+
+            if (!retval) {
+                retval = dev;
+            }
+        }
+    }
+
+    /*
+     * This function might run on the IO thread and we might race against
+     * main thread hot-plugging the device.
+     * We assume that as soon as .realized is set to true we can let
+     * the user access the device.
+     */
+
+    if (retval && !include_unrealized &&
+        !qatomic_load_acquire(&retval->qdev.realized)) {
+        retval = NULL;
+    }
+
+    return retval;
+}
+
+SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
+{
+    RCU_READ_LOCK_GUARD();
+    return do_scsi_device_find(bus, channel, id, lun, false);
+}
+
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
 {
     SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
@@ -137,7 +186,10 @@ static bool scsi_bus_is_address_free(SCSIBus *bus,
 				     int channel, int target, int lun,
 				     SCSIDevice **p_dev)
 {
-    SCSIDevice *d = scsi_device_find(bus, channel, target, lun);
+    SCSIDevice *d;
+
+    RCU_READ_LOCK_GUARD();
+    d = do_scsi_device_find(bus, channel, target, lun, true);
     if (d && d->lun == lun) {
         if (p_dev) {
             *p_dev = d;
@@ -1570,35 +1622,6 @@ static char *scsibus_get_fw_dev_path(DeviceState *dev)
                            qdev_fw_name(dev), d->id, d->lun);
 }
 
-SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
-{
-    BusChild *kid;
-    SCSIDevice *target_dev = NULL;
-
-    RCU_READ_LOCK_GUARD();
-    QTAILQ_FOREACH_RCU(kid, &bus->qbus.children, sibling) {
-        DeviceState *qdev = kid->child;
-        SCSIDevice *dev = SCSI_DEVICE(qdev);
-
-        if (dev->channel == channel && dev->id == id) {
-            if (dev->lun == lun) {
-                return dev;
-            }
-
-            /*
-             * If we don't find exact match (channel/bus/lun),
-             * we will return the first device which matches channel/bus
-             */
-
-            if (!target_dev) {
-                target_dev = dev;
-            }
-        }
-    }
-
-    return target_dev;
-}
-
 /* SCSI request list.  For simplicity, pv points to the whole device */
 
 static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
-- 
2.26.2



