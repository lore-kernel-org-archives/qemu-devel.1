Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13137C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD20207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1LYJ7Ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD20207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefNa-0008Le-TT
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKF-0002S7-Gm
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKE-0006uw-Hd
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MxXmEuiHjIpKQSTmv7tL+icq13YA6JgXfJeOezxKDQ=;
 b=E1LYJ7Ao+NUVwt4M6balMg8XqdeoY+njckCCZp3AIk3oKloCY4MKSSzam6kunp5X8YyTGS
 XKNfdGFOIrSCD51ATSP8eHd5kPrfkbGXYwCaji5bOWzmx3JwX+ORXObwotXPl1SaQ+3Y4Y
 cE2cNF9Oviblbo7oToHVZZHZDaKKUMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-z0fX8RNRPLm_rX8W8I89Ag-1; Fri, 29 May 2020 09:45:27 -0400
X-MC-Unique: z0fX8RNRPLm_rX8W8I89Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 092D6107ACF3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0EDB2B6F9
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E249B11358BC; Fri, 29 May 2020 15:45:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/58] qdev: Convert to qbus_realize(), qbus_unrealize()
Date: Fri, 29 May 2020 15:44:31 +0200
Message-Id: <20200529134523.8477-7-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm going to convert device realization to qdev_realize() with the
help of Coccinelle.  Convert bus realization to qbus_realize() first,
to get it out of Coccinelle's way.  Readability improves.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev.c | 10 +++-------
 hw/pci/pci.c   |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f2c5cee278..b7355fbcd0 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1024,9 +1024,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         resettable_state_clear(&dev->reset);
 
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-            object_property_set_bool(OBJECT(bus), true, "realized",
-                                         &local_err);
-            if (local_err != NULL) {
+            if (!qbus_realize(bus, errp)) {
                 goto child_realize_fail;
             }
         }
@@ -1051,8 +1049,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 
     } else if (!value && dev->realized) {
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-            object_property_set_bool(OBJECT(bus), false, "realized",
-                                     &error_abort);
+            qbus_unrealize(bus);
         }
         if (qdev_get_vmsd(dev)) {
             vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
@@ -1070,8 +1067,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 
 child_realize_fail:
     QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-        object_property_set_bool(OBJECT(bus), false, "realized",
-                                 &error_abort);
+        qbus_unrealize(bus);
     }
 
     if (qdev_get_vmsd(dev)) {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 70c66965f5..6947c741c3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -456,7 +456,7 @@ void pci_root_bus_cleanup(PCIBus *bus)
 {
     pci_bus_uninit(bus);
     /* the caller of the unplug hotplug handler will delete this device */
-    object_property_set_bool(OBJECT(bus), false, "realized", &error_abort);
+    qbus_unrealize(BUS(bus));
 }
 
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
-- 
2.21.3


