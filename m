Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81741C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A98B2222F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB/6B2P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A98B2222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQymS-0006Hq-AS
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 16:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQyfb-0008Jl-Tm
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 16:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQyfW-0007Mf-W1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 16:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602274029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xh9nJS3bCn0qGVP8FsGlWpOpJZ1/8BJ4mYezCiWBNJM=;
 b=VB/6B2P04DvCe+BkBbFrVn22V84vcV2RHvU/HJFHgrYcOC8N2VMBgcuv/n5gJnC3tiiydd
 9t310nvttWl3FqkfgQL34DpAJ4J4BZnZWyVHIloA/wXBLePCHJOa9vrxOB9oUHEQya6W9r
 MLVmPNkrMy1YYTA3dVQgyYBLHLKqAjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-T9Khud8sNCyQqPakLM-Puw-1; Fri, 09 Oct 2020 16:07:03 -0400
X-MC-Unique: T9Khud8sNCyQqPakLM-Puw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51B0A2ED6;
 Fri,  9 Oct 2020 20:07:02 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1085360BE2;
 Fri,  9 Oct 2020 20:07:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vmbus: Don't make QOM property registration conditional
Date: Fri,  9 Oct 2020 16:07:01 -0400
Message-Id: <20201009200701.1830060-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having properties registered conditionally makes QOM type
introspection difficult.  Instead of skipping registration of the
"instanceid" property, always register the property but validate
its value against the instance id required by the class.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Note: due to the lack of concrete vmbus-dev subclasses in the
QEMU tree, this patch couldn't be tested.
---
 hw/hyperv/vmbus.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 896e981f85..481d7e8d3c 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2371,6 +2371,14 @@ static void vmbus_dev_realize(DeviceState *dev, Error **errp)
 
     assert(!qemu_uuid_is_null(&vdev->instanceid));
 
+    if (!qemu_uuid_is_null(&vdc->instanceid)) {
+        /* Class wants to only have a single instance with a fixed UUID */
+        if (!qemu_uuid_is_equal(&vdev->instanceid, &vdc->instanceid)) {
+            error_setg(&err, "instance id can't be changed");
+            goto error_out;
+        }
+    }
+
     /* Check for instance id collision for this class id */
     QTAILQ_FOREACH(child, &BUS(vmbus)->children, sibling) {
         VMBusDevice *child_dev = VMBUS_DEVICE(child->child);
@@ -2437,18 +2445,22 @@ static void vmbus_dev_unrealize(DeviceState *dev)
     free_channels(vdev);
 }
 
+static Property vmbus_dev_props[] = {
+    DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+
 static void vmbus_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *kdev = DEVICE_CLASS(klass);
+    device_class_set_props(kdev, vmbus_dev_props);
     kdev->bus_type = TYPE_VMBUS;
     kdev->realize = vmbus_dev_realize;
     kdev->unrealize = vmbus_dev_unrealize;
     kdev->reset = vmbus_dev_reset;
 }
 
-static Property vmbus_dev_instanceid =
-                        DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid);
-
 static void vmbus_dev_instance_init(Object *obj)
 {
     VMBusDevice *vdev = VMBUS_DEVICE(obj);
@@ -2457,8 +2469,6 @@ static void vmbus_dev_instance_init(Object *obj)
     if (!qemu_uuid_is_null(&vdc->instanceid)) {
         /* Class wants to only have a single instance with a fixed UUID */
         vdev->instanceid = vdc->instanceid;
-    } else {
-        qdev_property_add_static(DEVICE(vdev), &vmbus_dev_instanceid);
     }
 }
 
-- 
2.26.2


