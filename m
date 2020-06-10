Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90DEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13C7207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfNOMtJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13C7207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitPT-00020b-Uj
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitM9-0004wG-MW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:32:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitM6-0003oG-HY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cx3xj/4fX2YH/B/jEecpvXqVnOEd+qsDGCB+bkD5rwk=;
 b=MfNOMtJd6jAWXLTsqu0VeW/Oncnp41kLPfAXbWwHImkj/bnDnhOpmoxdPUewDwTUBm+Z59
 nSJTK2eneBxhQegYZKw9KlSAauKQ5uRlaf9tF7zaESMoKQiB/dSaWDbNSNqypIFMCIAGdZ
 JbZC3h7YaApYx462PTe4EHDzQSDRplE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-CQmU8riYMbeI17fPtCfD5g-1; Wed, 10 Jun 2020 01:32:51 -0400
X-MC-Unique: CQmU8riYMbeI17fPtCfD5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD1091883600
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:32:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EB5D5C1D2;
 Wed, 10 Jun 2020 05:32:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BDB581138539; Wed, 10 Jun 2020 07:32:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 06/58] qdev: Convert to qbus_realize(),
 qbus_unrealize()
Date: Wed, 10 Jun 2020 07:31:55 +0200
Message-Id: <20200610053247.1583243-7-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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


