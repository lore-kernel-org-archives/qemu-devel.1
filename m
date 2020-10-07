Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA026C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447D820782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faFaBFZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447D820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ89H-0007U6-4J
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ84N-0001Xx-2S
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ84H-0001i3-5F
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602071832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ai/kbtMb/L/VAFzZtCExa/yUmMY/NsTeSEW84RTLTn0=;
 b=faFaBFZFSvFiDKoR5resnrCSqbVaEuz8U5hHda657EXFEBWRgV3JKAnNhndkPejeswBrnT
 rOf07seFjjCQQKkNVDaBmrIsrhWm/WfTci1+jX4GU5tjTpz9O7y3zFU6uD4eQOj+s1zvAH
 rNdkGJzwK8zkjXOB3ar+UhxWvtfXI2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-yKtfqVZvObWN7HIvLXdjTg-1; Wed, 07 Oct 2020 07:57:09 -0400
X-MC-Unique: yKtfqVZvObWN7HIvLXdjTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81ACB1007464;
 Wed,  7 Oct 2020 11:57:08 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22A7D55783;
 Wed,  7 Oct 2020 11:57:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/17] qdev: add "check if address free" callback for buses
Date: Wed,  7 Oct 2020 07:56:51 -0400
Message-Id: <20201007115700.707938-9-pbonzini@redhat.com>
In-Reply-To: <20201007115700.707938-1-pbonzini@redhat.com>
References: <20201007115700.707938-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check if an address is free on the bus before plugging in the
device.  This makes it possible to do the check without any
side effects, and to detect the problem early without having
to do it in the realize callback.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201006123904.610658-5-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 17 +++++++++++++++--
 hw/net/virtio-net.c    |  2 +-
 hw/sd/core.c           |  3 ++-
 include/hw/qdev-core.h | 13 ++++++++++++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 96772a15bd..74db78df36 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -94,13 +94,23 @@ static void bus_add_child(BusState *bus, DeviceState *child)
                              0);
 }
 
-void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
+static bool bus_check_address(BusState *bus, DeviceState *child, Error **errp)
+{
+    BusClass *bc = BUS_GET_CLASS(bus);
+    return !bc->check_address || bc->check_address(bus, child, errp);
+}
+
+bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
 {
     BusState *old_parent_bus = dev->parent_bus;
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
     assert(dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type));
 
+    if (!bus_check_address(bus, dev, errp)) {
+        return false;
+    }
+
     if (old_parent_bus) {
         trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev)),
             old_parent_bus, object_get_typename(OBJECT(old_parent_bus)),
@@ -126,6 +136,7 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
         object_unref(OBJECT(old_parent_bus));
         object_unref(OBJECT(dev));
     }
+    return true;
 }
 
 DeviceState *qdev_new(const char *name)
@@ -371,7 +382,9 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     assert(!dev->realized && !dev->parent_bus);
 
     if (bus) {
-        qdev_set_parent_bus(dev, bus);
+        if (!qdev_set_parent_bus(dev, bus, errp)) {
+            return false;
+        }
     } else {
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7bf27b9db7..268cecc498 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3142,7 +3142,7 @@ static bool failover_replug_primary(VirtIONet *n, Error **errp)
         error_setg(errp, "virtio_net: couldn't find primary bus");
         return false;
     }
-    qdev_set_parent_bus(n->primary_dev, n->primary_bus);
+    qdev_set_parent_bus(n->primary_dev, n->primary_bus, &error_abort);
     n->primary_should_be_hidden = false;
     if (!qemu_opt_set_bool(n->primary_device_opts,
                            "partially_hotplugged", true, errp)) {
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 957d116f1a..08c93b5903 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -23,6 +23,7 @@
 #include "hw/qdev-core.h"
 #include "hw/sd/sd.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "trace.h"
 
 static inline const char *sdbus_name(SDBus *sdbus)
@@ -240,7 +241,7 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
     readonly = sc->get_readonly(card);
 
     sdbus_set_inserted(from, false);
-    qdev_set_parent_bus(DEVICE(card), &to->qbus);
+    qdev_set_parent_bus(DEVICE(card), &to->qbus, &error_abort);
     sdbus_set_inserted(to, true);
     sdbus_set_readonly(to, readonly);
 }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 72064f4dd4..14d476c587 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -210,13 +210,24 @@ struct BusClass {
     /* FIXME first arg should be BusState */
     void (*print_dev)(Monitor *mon, DeviceState *dev, int indent);
     char *(*get_dev_path)(DeviceState *dev);
+
     /*
      * This callback is used to create Open Firmware device path in accordance
      * with OF spec http://forthworks.com/standards/of1275.pdf. Individual bus
      * bindings can be found at http://playground.sun.com/1275/bindings/.
      */
     char *(*get_fw_dev_path)(DeviceState *dev);
+
     void (*reset)(BusState *bus);
+
+    /*
+     * Return whether the device can be added to @bus,
+     * based on the address that was set (via device properties)
+     * before realize.  If not, on return @errp contains the
+     * human-readable error message.
+     */
+    bool (*check_address)(BusState *bus, DeviceState *dev, Error **errp);
+
     BusRealize realize;
     BusUnrealize unrealize;
 
@@ -788,7 +799,7 @@ const char *qdev_fw_name(DeviceState *dev);
 Object *qdev_get_machine(void);
 
 /* FIXME: make this a link<> */
-void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
+bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
 extern bool qdev_hotplug;
 extern bool qdev_hot_removed;
-- 
2.26.2



