Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332E6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F385A20737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNRJVrql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F385A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihUp-0005wL-5l
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHs-00049y-Ih
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHn-0003Bv-8n
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cx3xj/4fX2YH/B/jEecpvXqVnOEd+qsDGCB+bkD5rwk=;
 b=dNRJVrqlaIxaCB/R7Zi+oZaWCqoOhDbueLQxhI6I+c4w11ZSoGZ9KUdzSjJku7fiLv9R67
 NVfeBXURnnmpT3E1AeP2cQE/Nywp+0y1QfSIFB3sbC3kkkbD4YzoqLREkL/GBYeRuu7bW2
 fMO7sbqdsmBWDcO9uB1h03ILEeGDklI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-KWDNu4jtOTO101CH6AC1Eg-1; Tue, 09 Jun 2020 12:39:36 -0400
X-MC-Unique: KWDNu4jtOTO101CH6AC1Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C0C0464
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CDE27CCC0;
 Tue,  9 Jun 2020 16:39:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 54E101138539; Tue,  9 Jun 2020 18:39:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/39] qdev: Convert to qbus_realize(), qbus_unrealize()
Date: Tue,  9 Jun 2020 18:38:59 +0200
Message-Id: <20200609163932.1566209-7-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm going to convert device realization to qdev_realize() with the
help of Coccinelle.  Convert bus realization to qbus_realize() first,
to get it out of Coccinelle's way.  Readability improves.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.26.2


