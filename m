Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB6C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8AE2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jADQD1NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8AE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW9W-0002B0-31
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrK-0002Ms-SB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrJ-0003Is-Qo
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrI-0003Gh-8a; Mon, 06 Apr 2020 13:48:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id e26so277057wmk.5;
 Mon, 06 Apr 2020 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pmelmK+74hZzKF1Ju2OEtzPp85pYogzLjVOdCh3WjgU=;
 b=jADQD1NQCGgy4v5kf6eilYBewiHygFXg8eZDnUOFmgGaPOJQT4OmKpe3JUAR9x94Kd
 CKSbRAQea+4v5qTnRL0xOwb+D+XAMmRlAP95nHqpcH399ZVdb395xdlplmyErIY02cbi
 Qc0rNOpqUet33XO/j0TtbXhIFj+7qBB6nwqYoUpBXbtLGND4HyDU6If30J8H0K/aaYzH
 jlxuQx1AScuDaSRqisFNimm9eMbzwyhaVP600Tr+ulCnQlaPyMUp3ZONzlmNxpKGnXJL
 ubko6JEOYsA47FouRu6UgAHr1V88Qp28d3xa//Z29gQqdsL3DaftmBBxM0zCTS4LSy5J
 kmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pmelmK+74hZzKF1Ju2OEtzPp85pYogzLjVOdCh3WjgU=;
 b=RTFrGGYbgQEGmLpGKMMndJBK4hpWXnvwbihv3+1ATgEAOcAeCHDHK+O9rUa28uSOKG
 JuZdu5uI5mz13O8MNtgkblp9FC/ZQhduMzekO/Sbc4qkdBUR8g/GGz9Uvf8zM1rnvgRM
 n8XC7VwWhPvAdWm6E3ItCgv3LcPNFVyfyYNO0Q372W0c2UZ5+oJsDsI9/Kk7xk8UcC1z
 7pgWOq8zB+WsWGd+pEWNaLyJdxU40OCDw3wkoImDavlVU/eP3EjRBhrNpznhf1hhEa5G
 dGPPFKsynahFSpTn7CPvbyUNROudu6E8JPiSH0UgRiss2SW3HNZNgzjbdltx+uMAPAU+
 P7IA==
X-Gm-Message-State: AGi0PuaCTIy6bZvD7dkwvPR7zyr+MwYGtQhStsZU5Nl7v+e7FYMtUFtw
 z4QQgkU3+TLXV/Gs05MvA1SZXE7jCvQ=
X-Google-Smtp-Source: APiQypJ56Q9Bb/YbAsUf44vQ/MdA+DNYgybbIis+OB4EaivGBK+HVBrfCuQFltZsVaWBww9Iw9eApg==
X-Received: by 2002:a1c:e407:: with SMTP id b7mr209077wmh.32.1586195305891;
 Mon, 06 Apr 2020 10:48:25 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 29/54] hw/arm/allwinner-a10: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:18 +0200
Message-Id: <20200406174743.16956-30-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:Allwinner-a10" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/allwinner-a10.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index f41395734a..db70aa2b88 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -158,14 +158,22 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 
         for (i = 0; i < AW_A10_NUM_USB; i++) {
             object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
-                                     &error_fatal);
+                                     &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                             AW_A10_EHCI_BASE + i * 0x8000);
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                                qdev_get_gpio_in(dev, 39 + i));
 
             object_property_set_bool(OBJECT(&s->ohci[i]), true, "realized",
-                                     &error_fatal);
+                                     &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
                             AW_A10_OHCI_BASE + i * 0x8000);
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
@@ -178,7 +186,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, AW_A10_MMC0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, qdev_get_gpio_in(dev, 32));
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
-                              "sd-bus", &error_abort);
+                              "sd-bus", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /* RTC */
     qdev_init_nofail(DEVICE(&s->rtc));
-- 
2.21.1


