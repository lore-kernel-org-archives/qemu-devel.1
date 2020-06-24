Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A905EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BBD20578
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POqLdYL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BBD20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0xi-0006or-JW
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0ul-0000jW-Ij
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44102
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0ug-00025G-Az
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMK46KJ2cnpUchCFeSEj8pYKe2vweYwRfkLAmNI0C5s=;
 b=POqLdYL5RMsJb1oNX9tlhnVGxnAP6Zso2gPxyTunBu8vAzhMvllTJNAtPOpGldzEyIaxR6
 LYfaMrPyKG+q+U4Q32XS8qTmNWHaryKxKSG/AthxNrACPDngqiasjqRpUReHdSsbi4jIVW
 16zm2ag56hagRq4RMo6o7XjIbnTqk8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-l9-qdw7qPZut6H3ZKWQHIA-1; Wed, 24 Jun 2020 04:37:43 -0400
X-MC-Unique: l9-qdw7qPZut6H3ZKWQHIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC82107ACCA;
 Wed, 24 Jun 2020 08:37:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F0445BACC;
 Wed, 24 Jun 2020 08:37:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A530A113847A; Wed, 24 Jun 2020 10:37:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/25] aspeed: Clean up roundabout error propagation
Date: Wed, 24 Jun 2020 10:37:24 +0200
Message-Id: <20200624083737.3086768-13-armbru@redhat.com>
In-Reply-To: <20200624083737.3086768-1-armbru@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace

        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &local_err);
        error_propagate(&err, local_err);
        if (err) {
            error_propagate(errp, err);
            return;
	}

by

        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
        if (err) {
            error_propagate(errp, err);
            return;
	}

Cc: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed_ast2600.c | 10 ++++------
 hw/arm/aspeed_soc.c     | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 6da687299f..08b3592e36 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -228,7 +228,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     int i;
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    Error *err = NULL, *local_err = NULL;
+    Error *err = NULL;
     qemu_irq irq;
 
     /* IO space */
@@ -394,8 +394,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &local_err);
-        error_propagate(&err, local_err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -446,11 +445,10 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
-        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &local_err);
-        error_propagate(&err, local_err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
         if (err) {
             error_propagate(errp, err);
-           return;
+            return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_ETH1 + i]);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 810cf9b6cc..ec21de50ce 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -218,7 +218,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     int i;
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    Error *err = NULL, *local_err = NULL;
+    Error *err = NULL;
 
     /* IO space */
     create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
@@ -340,8 +340,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
-        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &local_err);
-        error_propagate(&err, local_err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -392,11 +391,10 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
-        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &local_err);
-        error_propagate(&err, local_err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
         if (err) {
             error_propagate(errp, err);
-           return;
+            return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_ETH1 + i]);
-- 
2.26.2


