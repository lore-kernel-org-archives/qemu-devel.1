Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2786C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91327207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QX+8Jkvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91327207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3z6-0003R3-Kn
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3fD-0001hg-5W
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25928
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f3-0003Xe-Ng
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoKCgjkwQdyz3n/NTGq54J96p1D9/vv16smhJgTy9AE=;
 b=QX+8JkvdFP8yvMfs3ipRm8DiaTru2WFT2re4Yyk5gO8nuT1rMvZtlvqr85ht6Vg2B8VD+N
 h58TQn3zyNEZ07AFrjyxPdLrJLcru/W8wOER1u+GRMqIvW2EEeQyLwUi/RyPjU9/Dhcc2P
 wZFk7M6OQASJi7U0XdVtO0LMmx0Yx0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-Kt08UygCOH2mVyO6m_iToA-1; Tue, 19 May 2020 10:56:02 -0400
X-MC-Unique: Kt08UygCOH2mVyO6m_iToA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1799100960F
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:56:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0476060BEC;
 Tue, 19 May 2020 14:55:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EFBC11358D9; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/55] usb: Eliminate usb_try_create_simple()
Date: Tue, 19 May 2020 16:55:24 +0200
Message-Id: <20200519145551.22836-29-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

usb_try_create_simple() is qdev_try_new() and qdev_realize_and_unref()
with more verbose error messages.  Of its two users, one ignores
errors, and the other asserts they are impossible.

Make them use qdev_try_new() and qdev_realize_and_unref() directly,
and eliminate usb_try_create_simple

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/usb/bus.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 5c4d31614e..a81aee2051 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -318,35 +318,22 @@ USBDevice *usb_new(const char *name)
     return USB_DEVICE(qdev_new(name));
 }
 
+static USBDevice *usb_try_new(const char *name)
+{
+    return USB_DEVICE(qdev_try_new(name));
+}
+
 bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-static USBDevice *usb_try_create_simple(USBBus *bus, const char *name,
-                                        Error **errp)
-{
-    Error *err = NULL;
-    DeviceState *dev;
-
-    dev = qdev_try_new(name);
-    if (!dev) {
-        error_setg(errp, "Failed to create USB device '%s'", name);
-        return NULL;
-    }
-    qdev_realize_and_unref(dev, &bus->qbus, &err);
-    if (err) {
-        error_propagate_prepend(errp, err,
-                                "Failed to initialize USB device '%s': ",
-                                name);
-        return NULL;
-    }
-    return USB_DEVICE(dev);
-}
-
 USBDevice *usb_create_simple(USBBus *bus, const char *name)
 {
-    return usb_try_create_simple(bus, name, &error_abort);
+    USBDevice *dev = usb_new(name);
+
+    usb_realize_and_unref(dev, bus, &error_abort);
+    return dev;
 }
 
 static void usb_fill_port(USBPort *port, void *opaque, int index,
@@ -426,6 +413,7 @@ void usb_claim_port(USBDevice *dev, Error **errp)
 {
     USBBus *bus = usb_bus_from_device(dev);
     USBPort *port;
+    USBDevice *hub;
 
     assert(dev->port == NULL);
 
@@ -443,7 +431,10 @@ void usb_claim_port(USBDevice *dev, Error **errp)
     } else {
         if (bus->nfree == 1 && strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
             /* Create a new hub and chain it on */
-            usb_try_create_simple(bus, "usb-hub", NULL);
+            hub = usb_try_new("usb-hub");
+            if (hub) {
+                usb_realize_and_unref(hub, bus, NULL);
+            }
         }
         if (bus->nfree == 0) {
             error_setg(errp, "tried to attach usb device %s to a bus "
-- 
2.21.1


