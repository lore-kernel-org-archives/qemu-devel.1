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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BED4C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF4B20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEKsPha5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF4B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQack-0008R6-GX
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36542 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabJ-0006dv-V6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:58 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabJ-0003x3-3o
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:57 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33653)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQabI-0003tl-NW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:56 -0400
Received: by mail-lj1-x244.google.com with SMTP id w20so4716095ljj.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jZokMyQsNznnsjTzWlvQibgi/xwwIy5eNYMrDnjS46c=;
 b=YEKsPha5nFuMnYkf6c23MWpXSe04vZ7TEMmqcJoAD4v0aejItRGwMOgdfZAGvcmenO
 77akDOqF11dNazQiHrGnRAUDyoh/eEEf0KqeezKLTfy4Ia+AXp/N1Nz+3keV8yFo9sAI
 Kbw+lnFvI/4KdFPHpc1cofZ46rU/3UjTLoGx4cgYRKK7ml8Ej8FTZSY+/V2WlxRwS2Vj
 o8zydhWSfdUOCpRdhpDwGNugjXquhrSLpwXp9s8BFqG8VpZGgCB3VmOXbNYZPZLPbM+h
 0o98mRRspcCRnMdDPMRZ2A0xNFOVKdQt+XYgNzP7lp+3yHePp9pT1DyKydB7dVAeA2DU
 zICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jZokMyQsNznnsjTzWlvQibgi/xwwIy5eNYMrDnjS46c=;
 b=AmlxuGR5gHm9Zo6rGjF3dgovWO0EE3eibpn+ybKBeyEo8zceyF/eljvmPpZ/mPw9At
 Lr+ZzwB8LKUZP/y9ViSAbQxc5k9WbCBZ3iM8k/xKbcr2Us1jeeeaFzdTm68OYcOcUm5T
 8VyQaKhUVofDyO1F/7nFC/XS5oqhxqaakW4L+uCGxP8RMZmoyZ4y+MbbkqDzTxFooDSr
 ejtIdMSkf1KF25uP33cGO/3VsEU1X/+R6suQeywviyVkhvW96TKh8q5AJ5RXEKuNgDBv
 hSwlAPjcSqwvZDeUzM9dvRVSdiSkGp91yBpyOvKmaIfMZ9J9siIXTuswF2a9ENNkThas
 crpw==
X-Gm-Message-State: AGi0PuYiyomd8QwMzUBt1eDnBnXmAe8QIEK/x7K2Jxqem77WkmvvfoXT
 8T1vElo/OnHEDiEPVjbIRYtIfRc50og=
X-Google-Smtp-Source: APiQypJ4FZzTSxDQuBZ3ht4kYrh27Nw6xpaLEyKdLK7QoOyrJP4KeYiSMoz1KZQONgfNSSqM+uFW2g==
X-Received: by 2002:a2e:b4c2:: with SMTP id r2mr6437955ljm.143.1587405174796; 
 Mon, 20 Apr 2020 10:52:54 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id x11sm126954ljj.15.2020.04.20.10.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 10:52:54 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] target/microblaze: Add the ill-opcode-exception
 property
Date: Mon, 20 Apr 2020 19:52:46 +0200
Message-Id: <20200420175250.25777-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420175250.25777-1-edgar.iglesias@gmail.com>
References: <20200420175250.25777-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
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


