Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3406C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C66420780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElPON/mI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C66420780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWSD-0007q2-Kk
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNh-0002fT-J1
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNg-0005IW-6D
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:29 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPWNf-0005HB-TW
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:28 -0400
Received: by mail-lj1-x242.google.com with SMTP id m8so3189522lji.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2x2mJH31KlGYiU2wu4PSoZqahVuM0TdaRfwUNuf81eo=;
 b=ElPON/mIvPA2n2q3lUm+ykax6vitPr2lkTceEDS1GVOds0dgZ7ahsN9ZeXLQ+zOwZs
 bYmRVk0oVT9mXCDAPwNedNCXuRd8MshYnka5hSoxC1bgphkPcrzigJtiUti1bwKOJc4s
 mPQK12bwS3R+hpbCu56pZJ25xKP5Gwl0a5ka75dLOaXe5UOQo98hKHic/vHooObhPkNK
 fs01ZVBQGjKvqUNE8zPDZWahikaHuII1B7hMIUwnziM2FPvQrsAk3BwYcqCtrOXsEHyt
 Yaou5+4m/IQhIyQzUQ+tt91yXwDXTCB+zfNXeOnNk+7K1u9LZ/rXlR+MJP/0nALTVVSe
 Oorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2x2mJH31KlGYiU2wu4PSoZqahVuM0TdaRfwUNuf81eo=;
 b=huY85e5fWOIhmziDBIsUKBqOmIdgL3EKtizKcIHT1eqtgWwLM/GfFhwVJKsfDoI8fY
 C57l/Db+1jnGvsbSTQNlPfTMC4nanLVs6BeHcu9eV5f8pbLYlqPJ/DC3h39JWgmGFtjZ
 w4mWPgHwGABTAGE5i5WWIZJ1kUTUc8UV1UHZ7t4eX3mlREQhm+yfUwQ8RjapICaf79ef
 hCO4QX60BnljSfMb6VRWc0BbT6jt3tBXe0YL5s/urjuK3VbPmsOMF+LKaoa60mEiuQNf
 3HRpEtXr4ml1E/Op6t+U2SVie8VJjvAt3oI0VhsG1pGhQHq0g0C0EcizuZcghcnGkkRD
 +LyQ==
X-Gm-Message-State: AGi0PubXh6QncIKNE3xU7ZsvlXI+vbdECeyfonaf4Txkm0O5VYzFfcmR
 2N0ZGHRWoWVEbMQbdsnQH5d5dC1Xju9Vzw==
X-Google-Smtp-Source: APiQypLedWpga3PNMupgadifDgKxRR/25Ve3e9f7aa+VLkeaB5jNvS5RDWmLa70ANHDEryoKBNoTwQ==
X-Received: by 2002:a2e:8290:: with SMTP id y16mr3083016ljg.186.1587150626413; 
 Fri, 17 Apr 2020 12:10:26 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id t24sm21828574lfk.90.2020.04.17.12.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 12:10:25 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/6] target/microblaze: Add the ill-opcode-exception
 property
Date: Fri, 17 Apr 2020 21:10:18 +0200
Message-Id: <20200417191022.5247-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417191022.5247-1-edgar.iglesias@gmail.com>
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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

Add the ill-opcode-exception property to control if illegal
instructions will raise exceptions.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 4 ++++
 target/microblaze/cpu.h       | 1 +
 target/microblaze/translate.c | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 1044120702..36c20d9724 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -207,6 +207,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  PVR2_DOPB_BUS_EXC_MASK : 0) |
                         (cpu->cfg.iopb_bus_exception ?
                                                  PVR2_IOPB_BUS_EXC_MASK : 0) |
+                        (cpu->cfg.illegal_opcode_exception ?
+                                                PVR2_ILL_OPCODE_EXC_MASK : 0) |
                         (cpu->cfg.opcode_0_illegal ?
                                                  PVR2_OPCODE_0x0_ILL_MASK : 0);
 
@@ -276,6 +278,8 @@ static Property mb_properties[] = {
     /* Enables bus exceptions on failed instruction fetches.  */
     DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
                      cfg.iopb_bus_exception, false),
+    DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
+                     cfg.illegal_opcode_exception, false),
     DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d51587b342..71d7317a58 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -303,6 +303,7 @@ struct MicroBlazeCPU {
         bool endi;
         bool dopb_bus_exception;
         bool iopb_bus_exception;
+        bool illegal_opcode_exception;
         bool opcode_0_illegal;
         char *version;
         uint8_t pvr;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 222632b670..b4a78551ef 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -185,7 +185,7 @@ static void write_carryi(DisasContext *dc, bool carry)
 static bool trap_illegal(DisasContext *dc, bool cond)
 {
     if (cond && (dc->tb_flags & MSR_EE_FLAG)
-        && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
+        && dc->cpu->cfg.illegal_opcode_exception) {
         tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
-- 
2.20.1


