Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689DC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1682083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1682083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEcJY-0005Ap-Ib
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:12:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEcI1-00044i-1t
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEcHy-000539-NW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:11:01 -0400
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:39889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEcHt-0004xN-GK
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:57 -0400
Received: from player759.ha.ovh.net (unknown [10.109.159.140])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5C5311BA3DE
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 18:10:45 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player759.ha.ovh.net (Postfix) with ESMTPSA id 319DD4B4AA1A;
	Thu, 11 Apr 2019 16:10:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 18:10:13 +0200
Message-Id: <20190411161013.4514-4-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411161013.4514-1-clg@kaod.org>
References: <20190411161013.4514-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 7423339561133050641
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.38.119
Subject: [Qemu-devel] [PATCH 3/3] aspeed: use sysbus_init_child_obj() to
 initialize children
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411161013.xTtElbqAcmvzSaCGGlrCBrtAUr3EqY9tEbAZOJSa-18@z>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed_soc.c | 50 ++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 9b601709e93c..110956828c44 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -212,12 +212,11 @@ static void aspeed_soc_init(Object *obj)
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
     int i;
=20
-    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
-    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
+    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cpu),
+                            sc->info->cpu_type, &error_abort, NULL);
=20
-    object_initialize(&s->scu, sizeof(s->scu), TYPE_ASPEED_SCU);
-    object_property_add_child(obj, "scu", OBJECT(&s->scu), NULL);
-    qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
+    sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
+                          TYPE_ASPEED_SCU);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->info->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
@@ -227,36 +226,29 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key", &error_abort);
=20
-    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
-    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
-    qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
+    sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic),
+                          TYPE_ASPEED_VIC);
=20
-    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_T=
IMER);
-    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), N=
ULL);
+    sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
+                          sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
                                    OBJECT(&s->scu), &error_abort);
-    qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
=20
-    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
-    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
-    qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
+    sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
+                          TYPE_ASPEED_I2C);
=20
-    object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
-    object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
-    qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
+    sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
+                          sc->info->fmc_typename);
     object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
                               &error_abort);
=20
     for (i =3D 0; i < sc->info->spis_num; i++) {
-        object_initialize(&s->spi[i], sizeof(s->spi[i]),
-                          sc->info->spi_typename[i]);
-        object_property_add_child(obj, "spi[*]", OBJECT(&s->spi[i]), NUL=
L);
-        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
+                              sizeof(s->spi[i]), sc->info->spi_typename[=
i]);
     }
=20
-    object_initialize(&s->sdmc, sizeof(s->sdmc), TYPE_ASPEED_SDMC);
-    object_property_add_child(obj, "sdmc", OBJECT(&s->sdmc), NULL);
-    qdev_set_parent_bus(DEVICE(&s->sdmc), sysbus_get_default());
+    sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc)=
,
+                          TYPE_ASPEED_SDMC);
     qdev_prop_set_uint32(DEVICE(&s->sdmc), "silicon-rev",
                          sc->info->silicon_rev);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
@@ -265,16 +257,14 @@ static void aspeed_soc_init(Object *obj)
                               "max-ram-size", &error_abort);
=20
     for (i =3D 0; i < sc->info->wdts_num; i++) {
-        object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_WDT=
);
-        object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), NUL=
L);
-        qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
+                              sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
         qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
                                     sc->info->silicon_rev);
     }
=20
-    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC10=
0);
-    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100), N=
ULL);
-    qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());
+    sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
+                          sizeof(s->ftgmac100), TYPE_FTGMAC100);
 }
=20
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
--=20
2.20.1


