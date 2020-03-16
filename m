Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE649C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F8420674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or4KTwQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F8420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvDj-0002lk-KL
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuqO-0002LI-H8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuqM-0002nc-Lj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuqM-0002le-Gm
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSVtvfrX1T1hW1+GelbNbTHoIYbtGWi72bTWri8Gs/8=;
 b=Or4KTwQN52/3TDeizn72uUrxp4v0ZvC3BqHypsNRL3wrr4z+d8gmTqptvY2nbFJIzEzfyS
 vSRwtxe03uLnMOLGEJfFB62OPvjd6D2Fcg1Nvt9lwppu+DhqAdZPZlprWS7iiokUCPPjyj
 LhVTUZy8mqqaoaTxrfSPrrP9FlZrXPA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-wkdutSsoNsePiGTRPUOfKw-1; Mon, 16 Mar 2020 14:52:03 -0400
X-MC-Unique: wkdutSsoNsePiGTRPUOfKw-1
Received: by mail-wr1-f70.google.com with SMTP id n11so8983803wrs.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NVKGwUr8B+LaX+EC0RuZtqH9nmzRuKTSjfiL8jyxkwg=;
 b=AP+W79cmOQHyP8jvFrbXZOEwjRDZ9h27AhRBO0wvXLxShZlegIgoJgeiFWeKvcWmIv
 KOGf/vJ8Idpk+Osnb7ma/E24Xoki7PBkdCRxWEXtYufmX/tehQE4M5WPe/4f568hrVPT
 7HTINbrCAzDaoR9Mg37hEuY05EKjAgS/6FKQOKNDEsZh3VHGehY5Tnp+Fj0f54ndoaC/
 GUWzKKAFDm25pKhx81K78K2cHlrPRbZJio3FfmYkPJN2o0g5qsjJ1f4I2Na8Yh+k0f9t
 9XjRm9wWIqo5U4Cn609TFnW2VIeTnqthiEnbNFRr/7cbWugGwBi5WadHtoJ3UKSrqzGf
 rjUQ==
X-Gm-Message-State: ANhLgQ2tvFaEcPpSBNSc1x7ZvnB4fP2FJFPailfuq4Yu3KIENLzIIJ49
 ymdIAJKaCUqTuijkvVZWyLF0TzwKteHMz4WYh6vwtHwmSagd2u5t+4gbVeL1b9GtcrpBhfIFNv2
 p5/hI99Q9f8uUh0w=
X-Received: by 2002:a5d:5342:: with SMTP id t2mr809135wrv.104.1584384722417;
 Mon, 16 Mar 2020 11:52:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsuN9M61MjtWTG++Ov/Gb/CrTvbKKAALU/K6Gwtg6c2cjeo0USA/J3BloXn6JNSH9n1Eo5nKg==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr809112wrv.104.1584384722219;
 Mon, 16 Mar 2020 11:52:02 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id h15sm982743wrw.97.2020.03.16.11.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:52:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 22/25] hw/arm/stm32: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 16 Mar 2020 19:50:03 +0100
Message-Id: <20200316185006.576-23-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:STM32F205" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The scripts/coccinelle/memory-region-housekeeping.cocci reported:
* TODO [[view:./hw/arm/stm32f205_soc.c::face=3Dovl-face1::linb=3D96::colb=
=3D4::cole=3D26][potential use of memory_region_init_rom*() in  ./hw/arm/st=
m32f205_soc.c::96]]
* TODO [[view:./hw/arm/stm32f405_soc.c::face=3Dovl-face1::linb=3D98::colb=
=3D4::cole=3D26][potential use of memory_region_init_rom*() in  ./hw/arm/st=
m32f405_soc.c::98]]

We can indeed replace the memory_region_init_ram() and
memory_region_set_readonly() calls by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/stm32f205_soc.c | 4 +---
 hw/arm/stm32f405_soc.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 627fd446f5..2de56275b7 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -93,12 +93,10 @@ static void stm32f205_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *flash_alias =3D g_new(MemoryRegion, 1);
=20
-    memory_region_init_ram(flash, NULL, "STM32F205.flash", FLASH_SIZE,
+    memory_region_init_rom(flash, NULL, "STM32F205.flash", FLASH_SIZE,
                            &error_fatal);
     memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
                              flash, 0, FLASH_SIZE);
-
-    memory_region_set_readonly(flash, true);
     memory_region_set_readonly(flash_alias, true);
=20
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 9bcad97853..b8fca13f95 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -95,7 +95,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     Error *err =3D NULL;
     int i;
=20
-    memory_region_init_ram(&s->flash, NULL, "STM32F405.flash", FLASH_SIZE,
+    memory_region_init_rom(&s->flash, NULL, "STM32F405.flash", FLASH_SIZE,
                            &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
@@ -103,8 +103,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     }
     memory_region_init_alias(&s->flash_alias, NULL, "STM32F405.flash.alias=
",
                              &s->flash, 0, FLASH_SIZE);
-
-    memory_region_set_readonly(&s->flash, true);
     memory_region_set_readonly(&s->flash_alias, true);
=20
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->fla=
sh);
--=20
2.21.1


