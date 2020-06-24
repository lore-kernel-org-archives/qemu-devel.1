Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB462053B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcRckLnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB462053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo16l-0006cC-Be
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0ut-000197-Mj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0uj-00027g-21
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53fidIty5gELKAcDAWZemEXmoEjTJUOu2oihlQHa+rM=;
 b=VcRckLnJSl6uSE/BoZ0RlOFR/+/QnwhYsxFs/Hn/RjscX5Xd1KZYiAy3E6mh2fVXc0AUne
 v5MlxM2HC+IrSWY8EbD04Jst21jPTaN8igAPtAL07NgPy5jaDhgZn9XB5gOdldrK4c4MNU
 sS61fVR++/QpcsrHsd8U/FjHlEJltVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-blj20x7AN6OXhCTffKt73g-1; Wed, 24 Jun 2020 04:37:45 -0400
X-MC-Unique: blj20x7AN6OXhCTffKt73g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4620F800597;
 Wed, 24 Jun 2020 08:37:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EC5E5BACC;
 Wed, 24 Jun 2020 08:37:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE3CC1138485; Wed, 24 Jun 2020 10:37:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/25] aspeed: Fix realize error API violation
Date: Wed, 24 Jun 2020 10:37:35 +0200
Message-Id: <20200624083737.3086768-24-armbru@redhat.com>
In-Reply-To: <20200624083737.3086768-1-armbru@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

aspeed_soc_ast2600_realize() and aspeed_soc_realize() are wrong that
way: they pass &err to object_property_set_int() and
object_property_set_bool() without checking it, and then to
sysbus_realize().  Harmless, because the former can't actually fail
here.

Fix by passing &error_abort instead.

Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/aspeed_ast2600.c | 5 +++--
 hw/arm/aspeed_soc.c     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 4efac02e2b..59a7a1370b 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -383,7 +383,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->spis_num; i++) {
         object_property_set_link(OBJECT(&s->spi[i]), OBJECT(s->dram_mr),
                                  "dram", &error_abort);
-        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
+        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs",
+                                &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err) {
             error_propagate(errp, err);
@@ -434,7 +435,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* Net */
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
-                                 &err);
+                                 &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 03b91bade6..311458aa76 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -333,7 +333,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
-        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
+        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs",
+                                &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err);
         if (err) {
             error_propagate(errp, err);
@@ -384,7 +385,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* Net */
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
-                                 &err);
+                                 &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.26.2


