Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA4C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A5820838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDYsSvVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A5820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW1j-0001vI-FV
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoK-0000g7-30
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoH-0002t0-2k
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:27 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoG-0002oW-SQ; Wed, 05 Feb 2020 20:18:25 -0500
Received: by mail-wm1-x342.google.com with SMTP id s10so4480604wmh.3;
 Wed, 05 Feb 2020 17:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CaYU6v4i3WvFRx68YJRb27EPqhasUqGFaQXAfnDzbnU=;
 b=oDYsSvVoAnK+fleW203J5v18J7cLt0lZECznvNdNzWHYwf6AoYx0zPeKcEhNhl+S7d
 4/AykB4FWmhq364XXS7MA2Jx0CiZZNH2cV3JjNvTY2QQicLniLVo/ksKHkjrlPZHnkD0
 9Nmw9jQY57b7CicbOmHbDphaDDkxtdbxaNbcnh1Bs4Po6DRU2metifkWcywQXudSe4vS
 moi2bReNTSegKX3mEcAAdqwKsChLkp4MUKIQRcziIloEAaS7VWM+Z6/Fr1JklFWCV/Iz
 YM1dALyw1Sgy+KNHzt87Cna0dfM/nXRrP2Fkx/8HSZSyoacR3CMdGxG2wjDZOA40nSu3
 M/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CaYU6v4i3WvFRx68YJRb27EPqhasUqGFaQXAfnDzbnU=;
 b=c6mi6bw4IgT1X16vHzhz9QxqcNtPC/K5BrYBDSvUb2A3xFba9ghSkvwIoBqPP/1Fb9
 4/oqiKCPgv+dF8JUjhLzos5lPQ8NqWKCmYIYnEaZ+WUsmHLW+8eglHNOKhMFDZB/5ChD
 BE1WVD5dj5WHPxWK3xNOwBx6r0FQwGitk01Y/2rzQnz/tZBrvQi8S6PGHcVIqI1kS/fr
 h1+7RFCh/ALQc/MRoqpuzOenhLDNLzABsGf6tDWR2vRNirhurivoILo3NKpANRZRd7X1
 mgmxUMSpLs08bjuI8SDyZI+qtadTFgCuNDkkIXLmaMi2i6X5k3hjuETz0EbKWhQpFIJQ
 4sCA==
X-Gm-Message-State: APjAAAU/PMm6DrbzQK59B4ShYViai7U87sc33LC2WswbxCLtiE6omof0
 BrGEz2Rsa1pv8mBtW588IPCKQhuh
X-Google-Smtp-Source: APXvYqzZ5zvun2rf/MRbfVb6wGacrQyyXjG3h5Sd4V+ASNme0bESYeS6kY1H3TNM5YASsqSP+FHvlg==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr638752wma.24.1580951903726; 
 Wed, 05 Feb 2020 17:18:23 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/30] hw/arm/raspi: Extract the board model from the board
 revision
Date: Thu,  6 Feb 2020 02:17:37 +0100
Message-Id: <20200206011756.2413-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The board revision encode the model type. Add a helper
to extract the model, and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 43f8b1d677..a104393cb2 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -100,6 +100,20 @@ static const char *board_soc_type(uint32_t board_rev)
     return soc_types[proc_id];
 }
 
+static const char *board_type(uint32_t board_rev)
+{
+    static const char *types[] = {
+        "A", "B", "A+", "B+", "2B", "Alpha", "CM1", NULL, "3B", "Zero",
+        "CM3", NULL, "Zero W", "3B+", "3A+", NULL, "CM3+", "4B",
+    };
+    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
+    int bt = FIELD_EX32(board_rev, REV_CODE, TYPE);
+    if (bt >= ARRAY_SIZE(types) || !types[bt]) {
+        return "Unknown";
+    }
+    return types[bt];
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -286,7 +300,7 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
     uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
     rmc->board_rev = board_rev;
-    mc->desc = "Raspberry Pi 2B";
+    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
@@ -307,7 +321,7 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
     uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
     rmc->board_rev = board_rev;
-    mc->desc = "Raspberry Pi 3B";
+    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
-- 
2.21.1


