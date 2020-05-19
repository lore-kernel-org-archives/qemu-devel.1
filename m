Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F0A2081A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZH0nw6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F0A2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb428-0001is-Dw
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3fE-0001k4-15
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44986
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f3-0003Xs-Rg
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptwwl55bjfrJBje2UsLOnTAyzYF6FHZIeoupySQ10DI=;
 b=UZH0nw6GM7BHJwEYP0yl9UnNeVhooMtjxeyX3waI/RRdFe0uk2tXL/BPA86zQnCF0A3o/z
 u6zFi/L7H1Yd19qF/LRErsAx6QiSY3a+sXtLDbZBCPeTrtnvJTulzx+OhCpEwNoiVhsWPh
 9W3oxOhPbHNQL+uS/5oEGoQclQC2Ark=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-8jJvtNz2PEalcQ26JtkJiQ-1; Tue, 19 May 2020 10:56:01 -0400
X-MC-Unique: 8jJvtNz2PEalcQ26JtkJiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C08CA1800D42;
 Tue, 19 May 2020 14:56:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8D545C1C8;
 Tue, 19 May 2020 14:55:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 367841135220; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/55] macio: Convert use of qdev_set_parent_bus()
Date: Tue, 19 May 2020 16:55:31 +0200
Message-Id: <20200519145551.22836-36-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 berrange@redhat.com, ehabkost@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert qdev_set_parent_bus()/realize to qdev_realize(); recent commit
"qdev: New qdev_new(), qdev_realize(), etc." explains why.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/macio/macio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index a2698e4a20..1a07ca2ca5 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -100,7 +100,6 @@ static void macio_init_child_obj(MacIOState *s, const char *childname,
 {
     object_initialize_child_with_props(OBJECT(s), childname, child, childsize,
                                        childtype, &error_abort, NULL);
-    qdev_set_parent_bus(DEVICE(child), BUS(&s->macio_bus));
 }
 
 static void macio_common_realize(PCIDevice *d, Error **errp)
@@ -109,7 +108,7 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     SysBusDevice *sysbus_dev;
     Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->dbdma), true, "realized", &err);
+    qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -125,7 +124,7 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
-    object_property_set_bool(OBJECT(&s->escc), true, "realized", &err);
+    qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -148,7 +147,7 @@ static void macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
     object_property_set_link(OBJECT(ide), OBJECT(&s->dbdma), "dbdma", errp);
     macio_ide_register_dma(ide);
 
-    object_property_set_bool(OBJECT(ide), true, "realized", errp);
+    qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
 }
 
 static void macio_oldworld_realize(PCIDevice *d, Error **errp)
@@ -167,7 +166,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
 
     qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                          s->frequency);
-    object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
+    qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -184,7 +183,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
                                                        OLDWORLD_ESCCA_IRQ));
 
-    object_property_set_bool(OBJECT(&os->nvram), true, "realized", &err);
+    qdev_realize(DEVICE(&os->nvram), BUS(&s->macio_bus), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -348,7 +347,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
                                  &error_abort);
         memory_region_add_subregion(&s->bar, 0x50,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
-        object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &err);
+        qdev_realize(DEVICE(&ns->gpio), BUS(&s->macio_bus), &err);
 
         /* PMU */
         object_initialize_child(OBJECT(s), "pmu", &s->pmu, TYPE_VIA_PMU);
-- 
2.21.1


