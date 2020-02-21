Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D71CC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B6F222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I59Vr6sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B6F222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CEP-0004zb-Rm
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5C8l-00062E-9E
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5C8i-0007wm-US
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5C8i-0007wN-OW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582306260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=afJ5QT7JVzOtThcnGpLQB0AFRR8aew0iyQodV15f1pQ=;
 b=I59Vr6sJAabXg48GywPjpA/pQlKo9W3YqdnuODeL+VrvqTcYpdtc4SL1RVUc9q8CXfYi3N
 qFUYkPFsiSTAdhL3dH6fQoKH7r2u9wfqrkURPQdnE83CMfoJgOb4szdHX8t9p+UryOrteU
 +ndSD2h4oUnybvdlYrAXGuKg2XHKjwI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-dlyVfWeBPuyqVqI-arndyg-1; Fri, 21 Feb 2020 12:30:58 -0500
X-MC-Unique: dlyVfWeBPuyqVqI-arndyg-1
Received: by mail-wr1-f69.google.com with SMTP id z15so1333238wrw.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fc5MkCFdS3Or+k1ZhQt3xGzx43hkZES9oGLOhGzJcLc=;
 b=QIGgKKFOv3zjAAt6ZRq4f11qqY4HDpW6dh3Bo3Ho7KjvNYojw+H5WX8SEB7rnScx/d
 +VOFVOwoDoE687Gbt9NX2CTIG+iJRW9eq2JzNVh5bE0SdYNWM+ZLPYgDK0owegsgiaA/
 lw0l9iHJeHtYKUtowIAME1GjZdfh9dVPnvvOeOGdZC4bHO1W1Xbj58i+tKYkP1+RBQ15
 /K7RnaoFfcMIwQnZU9ejRoqDvCHKs8fm+KtA6Q9laMGNaQr4CdsKWvYH1RIIYX4VJwVW
 FdvIjDBGVyjzgw4t00+TlSMqxlgmkZmvMzbe5RTT9BH+WSOqv9LSR1x8T/o5xon+RiFl
 lbTA==
X-Gm-Message-State: APjAAAWMFLzDtvLiIZoRBpkTpijBN57sKTYXJRCw0FNpPFsz5ETyBQMl
 0OClXOYiSjrW7bqG+bZ9DVHtibqukbs9vVsCuZ1kDHP17/C4Mh3jTd9kjRt7hLJ2PVnZQwIi/BO
 PNq+dMmJJhcWYYPY=
X-Received: by 2002:a05:6000:118e:: with SMTP id
 g14mr52664572wrx.39.1582306256924; 
 Fri, 21 Feb 2020 09:30:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjhXndrol42jRI6VSKf8OKkOybYlXmNYGlliC9ipyAqSi46spch1TCPAR30w+hrejrKIHiSw==
X-Received: by 2002:a05:6000:118e:: with SMTP id
 g14mr52664528wrx.39.1582306256497; 
 Fri, 21 Feb 2020 09:30:56 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm5000871wrv.78.2020.02.21.09.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 09:30:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] hw/arm: Let devices own the MemoryRegion they create
Date: Fri, 21 Feb 2020 18:30:44 +0100
Message-Id: <20200221173049.18134-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221173049.18134-1-philmd@redhat.com>
References: <20200221173049.18134-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid orphean memory regions being added in the /unattached
QOM container, use the memory_region_owner_nonnull.cocci script
to set the correct ownership.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/exynos4210.c    | 14 +++++++-------
 hw/arm/fsl-imx25.c     | 14 +++++++-------
 hw/arm/fsl-imx31.c     | 10 +++++-----
 hw/arm/fsl-imx6.c      | 10 +++++-----
 hw/arm/fsl-imx6ul.c    | 14 +++++++-------
 hw/arm/msf2-soc.c      |  8 ++++----
 hw/arm/nrf51_soc.c     |  2 +-
 hw/arm/stm32f205_soc.c | 10 +++++-----
 hw/arm/stm32f405_soc.c | 13 +++++++------
 hw/arm/xlnx-zynqmp.c   | 13 ++++++-------
 10 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 59a27bdd68..d4b05336ee 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -305,28 +305,28 @@ static void exynos4210_realize(DeviceState *socdev, E=
rror **errp)
     /*** Memory ***/
=20
     /* Chip-ID and OMR */
-    memory_region_init_io(&s->chipid_mem, NULL, &exynos4210_chipid_and_omr=
_ops,
-        NULL, "exynos4210.chipid", sizeof(chipid_and_omr));
+    memory_region_init_io(&s->chipid_mem, OBJECT(socdev),
+                          &exynos4210_chipid_and_omr_ops, NULL,
+                          "exynos4210.chipid", sizeof(chipid_and_omr));
     memory_region_add_subregion(system_mem, EXYNOS4210_CHIPID_ADDR,
                                 &s->chipid_mem);
=20
     /* Internal ROM */
-    memory_region_init_ram(&s->irom_mem, NULL, "exynos4210.irom",
+    memory_region_init_ram(&s->irom_mem, OBJECT(socdev), "exynos4210.irom"=
,
                            EXYNOS4210_IROM_SIZE, &error_fatal);
     memory_region_set_readonly(&s->irom_mem, true);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_BASE_ADDR,
                                 &s->irom_mem);
     /* mirror of iROM */
-    memory_region_init_alias(&s->irom_alias_mem, NULL, "exynos4210.irom_al=
ias",
-                             &s->irom_mem,
-                             0,
+    memory_region_init_alias(&s->irom_alias_mem, OBJECT(socdev),
+                             "exynos4210.irom_alias", &s->irom_mem, 0,
                              EXYNOS4210_IROM_SIZE);
     memory_region_set_readonly(&s->irom_alias_mem, true);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_MIRROR_BASE_AD=
DR,
                                 &s->irom_alias_mem);
=20
     /* Internal RAM */
-    memory_region_init_ram(&s->iram_mem, NULL, "exynos4210.iram",
+    memory_region_init_ram(&s->iram_mem, OBJECT(socdev), "exynos4210.iram"=
,
                            EXYNOS4210_IRAM_SIZE, &error_fatal);
     memory_region_add_subregion(system_mem, EXYNOS4210_IRAM_BASE_ADDR,
                                 &s->iram_mem);
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index da3471b395..a77c873cfe 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -247,16 +247,16 @@ static void fsl_imx25_realize(DeviceState *dev, Error=
 **errp)
     }
=20
     /* initialize 2 x 16 KB ROM */
-    memory_region_init_rom(&s->rom[0], NULL,
-                           "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
+    memory_region_init_rom(&s->rom[0], OBJECT(dev), "imx25.rom0",
+                           FSL_IMX25_ROM0_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM0_ADDR,
                                 &s->rom[0]);
-    memory_region_init_rom(&s->rom[1], NULL,
-                           "imx25.rom1", FSL_IMX25_ROM1_SIZE, &err);
+    memory_region_init_rom(&s->rom[1], OBJECT(dev), "imx25.rom1",
+                           FSL_IMX25_ROM1_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -265,8 +265,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error *=
*errp)
                                 &s->rom[1]);
=20
     /* initialize internal RAM (128 KB) */
-    memory_region_init_ram(&s->iram, NULL, "imx25.iram", FSL_IMX25_IRAM_SI=
ZE,
-                           &err);
+    memory_region_init_ram(&s->iram, OBJECT(dev), "imx25.iram",
+                           FSL_IMX25_IRAM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -275,7 +275,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error *=
*errp)
                                 &s->iram);
=20
     /* internal RAM (128 KB) is aliased over 128 MB - 128 KB */
-    memory_region_init_alias(&s->iram_alias, NULL, "imx25.iram_alias",
+    memory_region_init_alias(&s->iram_alias, OBJECT(dev), "imx25.iram_alia=
s",
                              &s->iram, 0, FSL_IMX25_IRAM_ALIAS_SIZE);
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_IRAM_ALIAS_=
ADDR,
                                 &s->iram_alias);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 55e90d104b..d5057ea49b 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -206,7 +206,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error *=
*errp)
     }
=20
     /* On a real system, the first 16k is a `secure boot rom' */
-    memory_region_init_rom(&s->secure_rom, NULL, "imx31.secure_rom",
+    memory_region_init_rom(&s->secure_rom, OBJECT(dev), "imx31.secure_rom"=
,
                            FSL_IMX31_SECURE_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -216,7 +216,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error *=
*errp)
                                 &s->secure_rom);
=20
     /* There is also a 16k ROM */
-    memory_region_init_rom(&s->rom, NULL, "imx31.rom",
+    memory_region_init_rom(&s->rom, OBJECT(dev), "imx31.rom",
                            FSL_IMX31_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -226,8 +226,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error *=
*errp)
                                 &s->rom);
=20
     /* initialize internal RAM (16 KB) */
-    memory_region_init_ram(&s->iram, NULL, "imx31.iram", FSL_IMX31_IRAM_SI=
ZE,
-                           &err);
+    memory_region_init_ram(&s->iram, OBJECT(dev), "imx31.iram",
+                           FSL_IMX31_IRAM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -236,7 +236,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error *=
*errp)
                                 &s->iram);
=20
     /* internal RAM (16 KB) is aliased over 256 MB - 16 KB */
-    memory_region_init_alias(&s->iram_alias, NULL, "imx31.iram_alias",
+    memory_region_init_alias(&s->iram_alias, OBJECT(dev), "imx31.iram_alia=
s",
                              &s->iram, 0, FSL_IMX31_IRAM_ALIAS_SIZE);
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_IRAM_ALIAS_=
ADDR,
                                 &s->iram_alias);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ecc62855f2..ecbd7ce399 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -405,7 +405,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **=
errp)
     }
=20
     /* ROM memory */
-    memory_region_init_rom(&s->rom, NULL, "imx6.rom",
+    memory_region_init_rom(&s->rom, OBJECT(dev), "imx6.rom",
                            FSL_IMX6_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -415,7 +415,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **=
errp)
                                 &s->rom);
=20
     /* CAAM memory */
-    memory_region_init_rom(&s->caam, NULL, "imx6.caam",
+    memory_region_init_rom(&s->caam, OBJECT(dev), "imx6.caam",
                            FSL_IMX6_CAAM_MEM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -425,8 +425,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **=
errp)
                                 &s->caam);
=20
     /* OCRAM memory */
-    memory_region_init_ram(&s->ocram, NULL, "imx6.ocram", FSL_IMX6_OCRAM_S=
IZE,
-                           &err);
+    memory_region_init_ram(&s->ocram, OBJECT(dev), "imx6.ocram",
+                           FSL_IMX6_OCRAM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -435,7 +435,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **=
errp)
                                 &s->ocram);
=20
     /* internal OCRAM (256 KB) is aliased over 1 MB */
-    memory_region_init_alias(&s->ocram_alias, NULL, "imx6.ocram_alias",
+    memory_region_init_alias(&s->ocram_alias, OBJECT(dev), "imx6.ocram_ali=
as",
                              &s->ocram, 0, FSL_IMX6_OCRAM_ALIAS_SIZE);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_OCRAM_ALIAS_=
ADDR,
                                 &s->ocram_alias);
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index c405b68d1d..ddb6655678 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -543,7 +543,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error =
**errp)
     /*
      * ROM memory
      */
-    memory_region_init_rom(&s->rom, NULL, "imx6ul.rom",
+    memory_region_init_rom(&s->rom, OBJECT(dev), "imx6ul.rom",
                            FSL_IMX6UL_ROM_SIZE, &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_ROM_ADDR,
                                 &s->rom);
@@ -551,7 +551,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error =
**errp)
     /*
      * CAAM memory
      */
-    memory_region_init_rom(&s->caam, NULL, "imx6ul.caam",
+    memory_region_init_rom(&s->caam, OBJECT(dev), "imx6ul.caam",
                            FSL_IMX6UL_CAAM_MEM_SIZE, &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_CAAM_MEM_A=
DDR,
                                 &s->caam);
@@ -559,17 +559,17 @@ static void fsl_imx6ul_realize(DeviceState *dev, Erro=
r **errp)
     /*
      * OCRAM memory
      */
-    memory_region_init_ram(&s->ocram, NULL, "imx6ul.ocram",
-                           FSL_IMX6UL_OCRAM_MEM_SIZE,
-                           &error_abort);
+    memory_region_init_ram(&s->ocram, OBJECT(dev), "imx6ul.ocram",
+                           FSL_IMX6UL_OCRAM_MEM_SIZE, &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_OCRAM_MEM_=
ADDR,
                                 &s->ocram);
=20
     /*
      * internal OCRAM (128 KB) is aliased over 512 KB
      */
-    memory_region_init_alias(&s->ocram_alias, NULL, "imx6ul.ocram_alias",
-                             &s->ocram, 0, FSL_IMX6UL_OCRAM_ALIAS_SIZE);
+    memory_region_init_alias(&s->ocram_alias, OBJECT(dev),
+                             "imx6ul.ocram_alias", &s->ocram, 0,
+                             FSL_IMX6UL_OCRAM_ALIAS_SIZE);
     memory_region_add_subregion(get_system_memory(),
                                 FSL_IMX6UL_OCRAM_ALIAS_ADDR, &s->ocram_ali=
as);
 }
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 8f84692e64..291bf8df43 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -96,7 +96,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Erro=
r **errp)
     MemoryRegion *nvm_alias =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
-    memory_region_init_rom(nvm, NULL, "MSF2.eNVM", s->envm_size,
+    memory_region_init_rom(nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_size=
,
                            &error_fatal);
     /*
      * On power-on, the eNVM region 0x60000000 is automatically
@@ -104,13 +104,13 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, =
Error **errp)
      * start address (0x0). We do not support remapping other eNVM,
      * eSRAM and DDR regions by guest(via Sysreg) currently.
      */
-    memory_region_init_alias(nvm_alias, NULL, "MSF2.eNVM",
-                             nvm, 0, s->envm_size);
+    memory_region_init_alias(nvm_alias, OBJECT(dev_soc), "MSF2.eNVM", nvm,=
 0,
+                             s->envm_size);
=20
     memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, nvm);
     memory_region_add_subregion(system_memory, 0, nvm_alias);
=20
-    memory_region_init_ram(sram, NULL, "MSF2.eSRAM", s->esram_size,
+    memory_region_init_ram(sram, OBJECT(dev_soc), "MSF2.eSRAM", s->esram_s=
ize,
                            &error_fatal);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
=20
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 4817a76ae0..57eff63f0d 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -165,7 +165,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Err=
or **errp)
     }
=20
     /* STUB Peripherals */
-    memory_region_init_io(&s->clock, NULL, &clock_ops, NULL,
+    memory_region_init_io(&s->clock, OBJECT(dev_soc), &clock_ops, NULL,
                           "nrf51_soc.clock", 0x1000);
     memory_region_add_subregion_overlap(&s->container,
                                         NRF51_IOMEM_BASE, &s->clock, -1);
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 627fd446f5..ac6bd66a34 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -93,10 +93,10 @@ static void stm32f205_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *flash_alias =3D g_new(MemoryRegion, 1);
=20
-    memory_region_init_ram(flash, NULL, "STM32F205.flash", FLASH_SIZE,
-                           &error_fatal);
-    memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
-                             flash, 0, FLASH_SIZE);
+    memory_region_init_ram(flash, OBJECT(dev_soc), "STM32F205.flash",
+                           FLASH_SIZE, &error_fatal);
+   memory_region_init_alias(flash_alias, OBJECT(dev_soc),
+                            "STM32F205.flash.alias", flash, 0, FLASH_SIZE)=
;
=20
     memory_region_set_readonly(flash, true);
     memory_region_set_readonly(flash_alias, true);
@@ -104,7 +104,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
     memory_region_add_subregion(system_memory, 0, flash_alias);
=20
-    memory_region_init_ram(sram, NULL, "STM32F205.sram", SRAM_SIZE,
+    memory_region_init_ram(sram, OBJECT(dev_soc), "STM32F205.sram", SRAM_S=
IZE,
                            &error_fatal);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
=20
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 9bcad97853..4dea1f95ff 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -95,14 +95,15 @@ static void stm32f405_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     Error *err =3D NULL;
     int i;
=20
-    memory_region_init_ram(&s->flash, NULL, "STM32F405.flash", FLASH_SIZE,
-                           &err);
+    memory_region_init_ram(&s->flash, OBJECT(dev_soc), "STM32F405.flash",
+                           FLASH_SIZE, &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
         return;
     }
-    memory_region_init_alias(&s->flash_alias, NULL, "STM32F405.flash.alias=
",
-                             &s->flash, 0, FLASH_SIZE);
+    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
+                             "STM32F405.flash.alias", &s->flash, 0,
+                             FLASH_SIZE);
=20
     memory_region_set_readonly(&s->flash, true);
     memory_region_set_readonly(&s->flash_alias, true);
@@ -110,8 +111,8 @@ static void stm32f405_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->fla=
sh);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
=20
-    memory_region_init_ram(&s->sram, NULL, "STM32F405.sram", SRAM_SIZE,
-                           &err);
+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "STM32F405.sram",
+                           SRAM_SIZE, &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index cab0160ae9..1b28e943cd 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -318,9 +318,9 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error=
 **errp)
         ddr_low_size =3D XLNX_ZYNQMP_MAX_LOW_RAM_SIZE;
         ddr_high_size =3D ram_size - XLNX_ZYNQMP_MAX_LOW_RAM_SIZE;
=20
-        memory_region_init_alias(&s->ddr_ram_high, NULL,
-                                 "ddr-ram-high", s->ddr_ram,
-                                  ddr_low_size, ddr_high_size);
+        memory_region_init_alias(&s->ddr_ram_high, OBJECT(dev),
+                                 "ddr-ram-high", s->ddr_ram, ddr_low_size,
+                                 ddr_high_size);
         memory_region_add_subregion(get_system_memory(),
                                     XLNX_ZYNQMP_HIGH_RAM_START,
                                     &s->ddr_ram_high);
@@ -330,16 +330,15 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
         ddr_low_size =3D ram_size;
     }
=20
-    memory_region_init_alias(&s->ddr_ram_low, NULL,
-                             "ddr-ram-low", s->ddr_ram,
-                              0, ddr_low_size);
+    memory_region_init_alias(&s->ddr_ram_low, OBJECT(dev), "ddr-ram-low",
+                             s->ddr_ram, 0, ddr_low_size);
     memory_region_add_subregion(get_system_memory(), 0, &s->ddr_ram_low);
=20
     /* Create the four OCM banks */
     for (i =3D 0; i < XLNX_ZYNQMP_NUM_OCM_BANKS; i++) {
         char *ocm_name =3D g_strdup_printf("zynqmp.ocm_ram_bank_%d", i);
=20
-        memory_region_init_ram(&s->ocm_ram[i], NULL, ocm_name,
+        memory_region_init_ram(&s->ocm_ram[i], OBJECT(dev), ocm_name,
                                XLNX_ZYNQMP_OCM_RAM_SIZE, &error_fatal);
         memory_region_add_subregion(get_system_memory(),
                                     XLNX_ZYNQMP_OCM_RAM_0_ADDRESS +
--=20
2.21.1


