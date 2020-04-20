Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3650C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DFB20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR2EZtfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DFB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQacx-0000MG-MI
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36592 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabU-0006vH-0i
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:08 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabM-00043m-Rw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:07 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44107)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQabM-00041d-Fc
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:00 -0400
Received: by mail-lf1-x143.google.com with SMTP id 131so8709597lfh.11
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2HDCg3KLDgunzJYC54IcgJKaF3QV6tINgDH3Q/dGrkM=;
 b=CR2EZtfbxLNJ2F8qXKNHrVTiMIFoOuOBuoQFotuEvEgF4KVCIiQrEvpUOQNKBpNBbi
 u2H60vi1UshSF9mg1+4BFrcft/Yk21jIN60glBQ6tAMAtIjEfeYVK6qIaztCcr3epa0t
 Sa9vTevJtRdvM5WRTGpEsMFdm04D+vZlzN3Pa1q7p96P0vicjeFHAnesclEGNA9vl45A
 TGnsnvJR7EpyTEM6BsDBtxeqTDKSl5eGjNYDfw1f5uMSJE3WpyNddjldCSR7YFgt92Yf
 vW51uWakc7lYVV4g/hohbIE7n5RgjtGYUdpyLmQvIO5J5o9hEk1jHU7qP5y8x9AhpkqN
 CnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2HDCg3KLDgunzJYC54IcgJKaF3QV6tINgDH3Q/dGrkM=;
 b=nmAU1tSekMyD5/9r7kUkM4b3D5coL31XzK5+sOtqtmNNZR9FxxTU3eiqe726IqvFMd
 OvIr1Ii+rSVBwLq9OmxfuwQIrwswvk9P8v09jri6PkAgY4JaeWR0XZqWC4grpeS0rkMq
 MFwuvCyRG43gevVTBMxYwdoZSaishrszX+QJ2Hf1tNrTQrhZoAU4tslHpyXvAbbEfm15
 7f84CmIbMUZepZnvJDpJf+6k66Up4cf2V0nydHn+sIdEH21nUCkIU4/sZSPh4pr4NSd5
 9MqATg+nP03dprOibQhFYuD6g0huZkgfAsvF8YI3QeP4944h5VBSmkwSIok5qPUS+QOd
 IFCg==
X-Gm-Message-State: AGi0PuaEd1sr/kccPjeJR0X8nLanSE99hyqxOVsPaL1xektP/fDg9pHJ
 x93+wErTkE2fkKiz/L78viWx8hnpg0I=
X-Google-Smtp-Source: APiQypKxOvwCTZMti5ipX7sxOF3DR/E6VK8ltmGjj7AYvxE2tl2unNlmKDCTSXGK4RbfnCpm8afonw==
X-Received: by 2002:a19:f611:: with SMTP id x17mr11621650lfe.51.1587405178562; 
 Mon, 20 Apr 2020 10:52:58 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id s30sm56768lfc.93.2020.04.20.10.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 10:52:57 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] target/microblaze: Add the pvr-user1 property
Date: Mon, 20 Apr 2020 19:52:49 +0200
Message-Id: <20200420175250.25777-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420175250.25777-1-edgar.iglesias@gmail.com>
References: <20200420175250.25777-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::143
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the pvr-user1 property to control the user-defined
PVR0 User1 field.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 4 +++-
 target/microblaze/cpu.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 10d90c64dd..53027846c4 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -193,7 +193,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
                         (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
                         (version_code << PVR0_VERSION_SHIFT) |
-                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0);
+                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
+                        cpu->cfg.pvr_user1;
 
     env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
                         (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
@@ -292,6 +293,7 @@ static Property mb_properties[] = {
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
     DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
+    DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index ef9081db40..7bb5a3d6c6 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -307,6 +307,7 @@ struct MicroBlazeCPU {
         bool opcode_0_illegal;
         bool div_zero_exception;
         bool unaligned_exceptions;
+        uint8_t pvr_user1;
         char *version;
         uint8_t pvr;
     } cfg;
-- 
2.20.1


