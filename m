Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C182C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341352074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeGJp4tK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341352074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihab-0007QW-Df
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHx-0004Bx-3D
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHp-0003CK-94
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuHDY/V/hc5LJklJaHXuQSCUC3XA1DHvn8lDejzuBzo=;
 b=WeGJp4tKnTsYrnD73rf/L5MjQE3b+gJ6XC0q5dw9ins1ivCObHvbRvzOatkIT67y8XDmTq
 Z45SkAOfuIBg8dlPp1C3hQIoWAUP3TF45UwdIH3zh0da61nlRIRF4dwvHXOzxlcROu7fOT
 KRmEeTNdO7/K6Q99Vijng0rACPD/kIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-18qtfnBSOKe_24zUyZs9Yg-1; Tue, 09 Jun 2020 12:39:38 -0400
X-MC-Unique: 18qtfnBSOKe_24zUyZs9Yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE8E918FE863
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0D965D9E4;
 Tue,  9 Jun 2020 16:39:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8DE741138461; Tue,  9 Jun 2020 18:39:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/39] qdev: Convert uses of qdev_set_parent_bus() manually
Date: Tue,  9 Jun 2020 18:39:05 +0200
Message-Id: <20200609163932.1566209-13-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Same transformation as in the previous commit.  Manual, because
convincing Coccinelle to transform these cases is somewhere between
not worthwhile and infeasible (at least for me).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/prep.c |  3 +--
 hw/ppc/pnv.c       |  6 ++----
 hw/s390x/sclp.c    | 10 ++++------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index c821ef889d..42c7e63a60 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -268,7 +268,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
     /* TODO Remove once realize propagates to child devices. */
-    object_property_set_bool(OBJECT(&s->pci_dev), true, "realized", errp);
+    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
 }
 
 static void raven_pcihost_initfn(Object *obj)
@@ -308,7 +308,6 @@ static void raven_pcihost_initfn(Object *obj)
 
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DEVICE);
     pci_dev = DEVICE(&s->pci_dev);
-    qdev_set_parent_bus(pci_dev, BUS(&s->pci_bus));
     object_property_set_int(OBJECT(&s->pci_dev), PCI_DEVFN(0, 0), "addr",
                             NULL);
     qdev_prop_set_bit(pci_dev, "multifunction", false);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8562af3fe0..e0588285a2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1212,12 +1212,11 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(phb), i, "index", &error_fatal);
         object_property_set_int(OBJECT(phb), chip->chip_id, "chip-id",
                                 &error_fatal);
-        object_property_set_bool(OBJECT(phb), true, "realized", &local_err);
+        qdev_realize(DEVICE(phb), NULL, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
-        qdev_set_parent_bus(DEVICE(phb), sysbus_get_default());
 
         /* Populate the XSCOM address space. */
         pnv_xscom_add_subregion(chip,
@@ -1422,12 +1421,11 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
             object_property_set_int(obj, PNV_PHB4_DEVICE_ID, "device-id",
                                     &error_fatal);
             object_property_set_link(obj, OBJECT(stack), "stack", &error_abort);
-            object_property_set_bool(obj, true, "realized", &local_err);
+            qdev_realize(DEVICE(obj), NULL, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
                 return;
             }
-            qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
 
             /* Populate the XSCOM address space. */
             pnv_xscom_add_subregion(chip,
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 20aca30ac4..40e27a8cb4 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -333,17 +333,15 @@ static void sclp_realize(DeviceState *dev, Error **errp)
     uint64_t hw_limit;
     int ret;
 
-    object_property_set_bool(OBJECT(sclp->event_facility), true, "realized",
-                             &err);
-    if (err) {
-        goto out;
-    }
     /*
      * qdev_device_add searches the sysbus for TYPE_SCLP_EVENTS_BUS. As long
      * as we can't find a fitting bus via the qom tree, we have to add the
      * event facility to the sysbus, so e.g. a sclp console can be created.
      */
-    qdev_set_parent_bus(DEVICE(sclp->event_facility), sysbus_get_default());
+    qdev_realize(DEVICE(sclp->event_facility), NULL, &err);
+    if (err) {
+        goto out;
+    }
 
     ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
     if (ret == -E2BIG) {
-- 
2.26.2


