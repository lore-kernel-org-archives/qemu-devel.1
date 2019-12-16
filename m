Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C8C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A9B20700
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH6a9wr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A9B20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igofy-00016f-2e
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFm-0007r6-KT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFl-0008Io-BQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:30 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFl-0008Hz-4M
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id b72so4201057wme.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Xurk8bwctWtGSWDzsj4cIGJHvhLZxcMqw0xL6BAXFU0=;
 b=FH6a9wr0f+i24p5NOGyLNzvoiE+WuCv9veZsf23orkPio2f1cZmIpyZXtOA9eAgY58
 4fi38AR2mvSjAV0RK0z/shyIM5kX3dqzSdkl8yEgcm1v5y67/syHZbSBfkTcbcVwYjZb
 AmpjSiDJI903CdIUMt8WskKpOnS1GLU50yJhIg+wqd9eqvWvHHAWol46Wk8n/6ylPWIe
 UDnU0d0vZa3pNPaxdbpjGxfMsa6I6f+S0ldcdEIj2ikhO7w3JeZJCYKfIgKHZmdCov5a
 2O84xLtz0+TOEWieD9OY8o47jOINSQHZBaqABG8yicRECJd/7hulQJet0Vii0O5gMuM0
 NBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xurk8bwctWtGSWDzsj4cIGJHvhLZxcMqw0xL6BAXFU0=;
 b=PZ7M6kFPZM1Akk2Ak1b8KYb9RtAH4F2gAh9okfatpplHdYKdmcWc+PoyKi1ReqrAn9
 Ib1yAHpvYgBPtvwUq7ZZMTi+O0BrUfBgqRuaEdXxYeyhm2BTcUqaIVgtB/nkgn4mtqba
 CLDWjvxsZvyrTfcFNpLL1+dXvISaRAchjOf7pS36Gm6rWjisClqbZeoq/7FrTHyYhgV/
 kLXl7V7NHAjEd2ttfKyn0JUXTjyh+WkDIS/BeXQsIAWuIaaYr5gMKc2q4+dQz71Am3H6
 9BGfmdaLDdMjYJGpt6NMWV6F4KMCNdmrZ7wS7OxiM5FvEM2//x4276yEnPn80MtaQ6fO
 GD6Q==
X-Gm-Message-State: APjAAAXRc0dVJJth/KXuUdpvgAxZL5AkALc8EscCw6l+LwbKMDLOrQDV
 0IEl8gIyNn53PPILADc2G3xWsGQz65q24w==
X-Google-Smtp-Source: APXvYqziwhmSa8u1Tsi0tfxvGsAKymCrh25ka5osAHocbi2CKltYESO0tvwN3cLUdcR7z2feooeROQ==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr28812610wmc.36.1576494567902; 
 Mon, 16 Dec 2019 03:09:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/34] aspeed: Change the "nic" property definition
Date: Mon, 16 Dec 2019 11:08:49 +0000
Message-Id: <20191216110904.30815-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

From: Cédric Le Goater <clg@kaod.org>

The Aspeed MII model has a link pointing to its associated FTGMAC100
NIC in the machine.

Change the "nic" property definition so that it explicitly sets the
pointer. The property isn't optional : not being able to set the link
is a bug and QEMU should rather abort than exit in this case.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-18-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast2600.c |  5 ++---
 hw/net/ftgmac100.c      | 19 +++++++++----------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 810fd7de0c0..be88005dab8 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -183,9 +183,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
         sysbus_init_child_obj(obj, "mii[*]", &s->mii[i], sizeof(s->mii[i]),
                               TYPE_ASPEED_MII);
-        object_property_add_const_link(OBJECT(&s->mii[i]), "nic",
-                                       OBJECT(&s->ftgmac100[i]),
-                                       &error_abort);
     }
 
     sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
@@ -441,6 +438,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
 
+        object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac100[i]),
+                                 "nic", &error_abort);
         object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
                                  &err);
         if (err) {
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index eb8b441461a..86ac25894a8 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1204,17 +1204,8 @@ static void aspeed_mii_realize(DeviceState *dev, Error **errp)
 {
     AspeedMiiState *s = ASPEED_MII(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    Object *obj;
-    Error *local_err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "nic", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'nic' not found: ");
-        return;
-    }
-
-    s->nic = FTGMAC100(obj);
+    assert(s->nic);
 
     memory_region_init_io(&s->iomem, OBJECT(dev), &aspeed_mii_ops, s,
                           TYPE_ASPEED_MII, 0x8);
@@ -1231,6 +1222,13 @@ static const VMStateDescription vmstate_aspeed_mii = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static Property aspeed_mii_properties[] = {
+    DEFINE_PROP_LINK("nic", AspeedMiiState, nic, TYPE_FTGMAC100,
+                     FTGMAC100State *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void aspeed_mii_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1239,6 +1237,7 @@ static void aspeed_mii_class_init(ObjectClass *klass, void *data)
     dc->reset = aspeed_mii_reset;
     dc->realize = aspeed_mii_realize;
     dc->desc = "Aspeed MII controller";
+    dc->props = aspeed_mii_properties;
 }
 
 static const TypeInfo aspeed_mii_info = {
-- 
2.20.1


