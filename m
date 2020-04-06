Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74124C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431BD206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/n+hqSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431BD206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVxm-0006IF-Gc
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqu-0001gk-3j
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqs-0001uP-Uq
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqs-0001rg-NK; Mon, 06 Apr 2020 13:48:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id t203so295216wmt.2;
 Mon, 06 Apr 2020 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rNOvzQC0gAZiW9IjgvdXICw1FeldG6faD6QdyriSpSA=;
 b=c/n+hqSXSD6F6qaxpMdMSonWyATO4kGyDsDvE11hkpNqZ0OPTKvxYdOVbUH3k5V2SS
 lED/ZjO82uWDhIadKnSNfPzHeHYQ97t0rVysBln+5mK6p6CnDQ23khn41btWsXbdOJw3
 2yIuiacSdkmj8zgTb3LNK7J/L82w95dwpTlsVoC9ogTWXUgcE1kD7uVs/VeN4T7Ratt1
 mzG3Sd8f1FZYj/OnB+yxNyI33xb/rRLtBLoTf+8cprwyiRKrhHJQfZ3Iq30fpSjUreJS
 Fw8UAB+rmF2PAfM8rauQHLYrp7UZ+6+Ec1yONYhC1mfx8Mv9axnQE1Y09snZ2q9T9EVR
 8+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rNOvzQC0gAZiW9IjgvdXICw1FeldG6faD6QdyriSpSA=;
 b=Y5gyDZM55u3xIKO9E90qCCP0F559maLu2DDwrBR+xDvFVHOcMwBNxd7s6r11cc+HHP
 JbFv7Ht50AFDTier3pICZ3DDi9mIpKqP+qtLT5spa8OyUndHhOleSwNbxzS01OFBKNX8
 DHjLj1U0ONDl/lotFMxRnZ5GiyUNuEoqUKPNecr2Wbb09sxjuUxOk/1UbFzNodb4l4sl
 A6TpO5ZWNEda39t4PNdfJJU6xj9cUvFmQmDQDp2DeWkNelWup3xDFHSv7uJoedkMJ8Tt
 EgVF6C9I+P0l3IlSIH/r+lgnjJZgqH3OAALamA06bCC8Q7TPkyATe5ezNliZjTQ+KKeI
 eZ5w==
X-Gm-Message-State: AGi0PubFUcoysPnqTqbK1BmqNvuGVQ5TZ23dgXPBX5o7T5AOXPcNOihD
 xCFtRgxKmjSEqulgLvSFkgxDVubKB+U=
X-Google-Smtp-Source: APiQypL9/PAZAZx2YLBV7/WulVIyVHdmTkkoC6dnaM5jWrOOcO7PK46zPUuGlo7S9o1MUoqdwO1h3w==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr171274wmi.1.1586195281403;
 Mon, 06 Apr 2020 10:48:01 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 11/54] hw/arm/msf2-soc: Store MemoryRegion in
 MSF2State
Date: Mon,  6 Apr 2020 19:47:00 +0200
Message-Id: <20200406174743.16956-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:SmartFusion2" <qemu-arm@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/msf2-soc.c
  >>> possible moves from m2sxxx_soc_initfn() to m2sxxx_soc_realize() in ./hw/arm/msf2-soc.c:86

While reviewing we notice storing the MemoryRegion in the device
state, we'll be able to later automatically simplify the error
propagation calls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/msf2-soc.h |  4 ++++
 hw/arm/msf2-soc.c         | 18 +++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index 3cfe5c76ee..e4c5110036 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -50,6 +50,10 @@ typedef struct MSF2State {
 
     ARMv7MState armv7m;
 
+    MemoryRegion sram;
+    MemoryRegion nvm;
+    MemoryRegion nvm_alias;
+
     char *cpu_type;
     char *part_name;
     uint64_t envm_size;
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 588d643b8d..e448b0ab74 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -90,13 +90,9 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
-
     MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *nvm = g_new(MemoryRegion, 1);
-    MemoryRegion *nvm_alias = g_new(MemoryRegion, 1);
-    MemoryRegion *sram = g_new(MemoryRegion, 1);
 
-    memory_region_init_rom(nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_size,
+    memory_region_init_rom(&s->nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_size,
                            &error_fatal);
     /*
      * On power-on, the eNVM region 0x60000000 is automatically
@@ -104,15 +100,15 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
      * start address (0x0). We do not support remapping other eNVM,
      * eSRAM and DDR regions by guest(via Sysreg) currently.
      */
-    memory_region_init_alias(nvm_alias, OBJECT(dev_soc), "MSF2.eNVM", nvm, 0,
-                             s->envm_size);
+    memory_region_init_alias(&s->nvm_alias, OBJECT(dev_soc), "MSF2.eNVM",
+                             &s->nvm, 0, s->envm_size);
 
-    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, nvm);
-    memory_region_add_subregion(system_memory, 0, nvm_alias);
+    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, &s->nvm);
+    memory_region_add_subregion(system_memory, 0, &s->nvm_alias);
 
-    memory_region_init_ram(sram, NULL, "MSF2.eSRAM", s->esram_size,
+    memory_region_init_ram(&s->sram, NULL, "MSF2.eSRAM", s->esram_size,
                            &error_fatal);
-    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 81);
-- 
2.21.1


