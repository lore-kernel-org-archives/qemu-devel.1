Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD88C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AF4206DC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Smf21bwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AF4206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4y5-0006D5-KJ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 17:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4Wa-0002zG-RV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WO-0002iZ-BI
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOm/tm/s7vlLGUaUhM3KYMR3GBBc1c4+MT8F0OlIOdc=;
 b=Smf21bwyLAyJr5nrJTbIRccLr7ZTI6stdXSh/LGwiGOZdD0SzXdHTK7GsQ+TqAUTY+LV+p
 NStQyF3uJn4ZN/cJ3T90Rz0gSZje0XzjJdHMzf54zmc7dYPVe90kEDY5Qca3qh9GVzZChz
 oU7/6bvU4HyjU2unShSNj4hzr/f8UC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Q7iaxMyxPz2KTvxmXot5Ng-1; Mon, 12 Oct 2020 16:34:10 -0400
X-MC-Unique: Q7iaxMyxPz2KTvxmXot5Ng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E07C1029D32
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:34:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE45A73660;
 Mon, 12 Oct 2020 20:34:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/38] scsi/scsi-bus: scsi_device_find: don't return unrealized
 devices
Date: Mon, 12 Oct 2020 16:33:39 -0400
Message-Id: <20201012203343.1105018-35-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
References: <20201012203343.1105018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 16:33:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device core first places a device on the bus and then realizes it.
Make scsi_device_find avoid returing such devices to avoid
races in drivers that use an iothread (currently virtio-scsi)

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1812399

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-7-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201006123904.610658-11-mlevitsk@redhat.com>
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



