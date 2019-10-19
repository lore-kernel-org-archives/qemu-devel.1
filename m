Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09600CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88BF20872
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFiqlYfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88BF20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyb2-00058N-TM
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRe-0000N2-2U
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRc-0005cg-RU
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRc-0005cR-LS; Sat, 19 Oct 2019 19:47:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id v17so9293640wml.4;
 Sat, 19 Oct 2019 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t7hE2pbrub3AVEyc/oyjS4UfKKd4rj51NgMEOKFwXuo=;
 b=BFiqlYfHurAD4oF18R9w4sddxFJxMhYyTp07v52acGbmFLL6ijI/6Qxnuf6WJ6eYXh
 xvIaYeou6w2D87k7Bn8lAG/i2pzPQ9NaSyIahJB8nR3OT2xujB4hWoQjoqwtzVg4TqgB
 9tDeY/fj7y+byjBTPsnZyS992eUUJ9VfDktMXN6wy7jmsj8AvqGoJoKdBtC3OaBg+8Jk
 aBhgZp57FTLnjD8nI+lYD+7jRePVrXMGS8j3ElSAmqLWrb1CEzP+cwDCry8hlK4EMyHl
 Fpvfg+J4Zfq+Z6fKcQai4qlPK6r/sNMFkFUKed2lUCYFQJ63WeGzJegOZG8fT/1eWxoD
 OgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=t7hE2pbrub3AVEyc/oyjS4UfKKd4rj51NgMEOKFwXuo=;
 b=hjZmr4QRIh0YEuLlzlz077I4lXo1Y7OCblWEhGdt8lPQ9RsZrS8muZw545i8slcaaZ
 WasCJL/jJWW0S/B6tqsLc1orLWKW2RMLiJrGLqS/Ez7rxDEguDEzFRRB4SralKFeoBXr
 Un25aLQWMj1WtwwXdL8tdwb2BZeTxM/vcTqa5cZuh4gTJOHbG+dYI7bG+kYnH0C1ojjc
 jbWZjeg95JBVvqPOljxkcZQueVaQx5AsqsvceJP5mjsPV9GVxx7xXjQ8IabXcDqDJQwf
 JvJBJqZ/7/7NCQ/nBgZbfRyvk2sPoUtDv9lr2BtUeIBrvsFs9OimBmKzDFXLRV8yQXs9
 9Mkg==
X-Gm-Message-State: APjAAAVT0jYWjwV0YtOYZXlKw+7W2WZejM4iDyjirFABKBkbqVNBYcCS
 NMnixOQeD4WU2PK7sAvpPXa2m0OF
X-Google-Smtp-Source: APXvYqzpWnjlcXtzlmFfKR1N9DGo6jcA7bC2qkg2M9spZoNI+9M3hXPwPeA3U5WPALFqe5Z7w6sSIQ==
X-Received: by 2002:a1c:658a:: with SMTP id
 z132mr12769528wmb.174.1571528855548; 
 Sat, 19 Oct 2019 16:47:35 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/16] hw/arm/raspi: Use AddressSpace when using
 arm_boot::write_secondary_boot
Date: Sun, 20 Oct 2019 01:47:09 +0200
Message-Id: <20191019234715.25750-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

write_secondary_boot() is used in SMP configurations where the
CPU address space might not be the main System Bus.
The rom_add_blob_fixed_as() function allow us to specify an
address space. Use it to write each boot blob in the corresponding
CPU address space.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a12459bc41..569d85c11a 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -60,12 +60,14 @@ static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
     QEMU_BUILD_BUG_ON((BOARDSETUP_ADDR & 0xf) != 0
                       || (BOARDSETUP_ADDR >> 4) >= 0x100);
 
-    rom_add_blob_fixed("raspi_smpboot", smpboot, sizeof(smpboot),
-                       info->smp_loader_start);
+    rom_add_blob_fixed_as("raspi_smpboot", smpboot, sizeof(smpboot),
+                          info->smp_loader_start,
+                          arm_boot_address_space(cpu, info));
 }
 
 static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *info)
 {
+    AddressSpace *as = arm_boot_address_space(cpu, info);
     /* Unlike the AArch32 version we don't need to call the board setup hook.
      * The mechanism for doing the spin-table is also entirely different.
      * We must have four 64-bit fields at absolute addresses
@@ -92,10 +94,10 @@ static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *info)
         0, 0, 0, 0
     };
 
-    rom_add_blob_fixed("raspi_smpboot", smpboot, sizeof(smpboot),
-                       info->smp_loader_start);
-    rom_add_blob_fixed("raspi_spintables", spintables, sizeof(spintables),
-                       SPINTABLE_ADDR);
+    rom_add_blob_fixed_as("raspi_smpboot", smpboot, sizeof(smpboot),
+                          info->smp_loader_start, as);
+    rom_add_blob_fixed_as("raspi_spintables", spintables, sizeof(spintables),
+                          SPINTABLE_ADDR, as);
 }
 
 static void write_board_setup(ARMCPU *cpu, const struct arm_boot_info *info)
-- 
2.21.0


