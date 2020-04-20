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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9834C38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8725F20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnClG/dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8725F20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQacn-00009R-PB
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36548 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabK-0006ej-OE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:59 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabK-0003zN-6i
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:58 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33416)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQabJ-0003wT-QL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:57 -0400
Received: by mail-lf1-x141.google.com with SMTP id h6so8762420lfc.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lIa+NYujIRdCQSAiwPsqbHt3vidArGlASBdrTdsfVAk=;
 b=fnClG/dBahvmawmXN38NLbAduafiM52pQLQSpfDtq6eYnnI3DpgxarO0OflMYUhTo9
 3cyQ1H6cV7HXyikHcNo/HlLPlnDAbBXs7NFhbJZPAEW2Go5nvzrg7mrWWU85KfAtswbP
 J3/xqwXN1/v4SwcIE01pw40XhmzpMeYOwMgp+HAx9fF1OjodHuYW/4LxlybC4Hz++g20
 MG6A3Pe8zEFlKVGE3Pd+hK0em3GzqEqdMOX3J/G0DgGf3jSK9E38gRXyGGyBJNW9XP0l
 AoNvzvsmy/3fRADFwaXO+CKRmYExKPze1xK6tvkvUFbJ5W7Mr9Y1BD+aJfi/7uYJKRyF
 8xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lIa+NYujIRdCQSAiwPsqbHt3vidArGlASBdrTdsfVAk=;
 b=fZdJm/XYQhs1C+HiUmslJ6CcT//Pr+ILE4lV8Bk71lfLl0HUB/rI9eFsR+IZhe4VTF
 si78Jp1P3EQsk6abHD7FbAgEo6V+VU5RjOgEAbIm/3tso/R8o8Ji+kL05697EvDLEM2/
 LjAb8yiIdr5Y8a1N1l6Ob6GckfO/nNPY08Y5oOQkYi4hPh2FoUcgpkwjY5GTZGfpz4W3
 cjbb9YmWm5LDyiW78lNeTFbf6IWWqnjue2Ik4Ij7cz5C90+16uK9BsDRaxwpMXp55dMB
 Ipl6D2h3GdUwdazw96/PeYwQGn3g9M/RuAXAiMc+GiP0NYPn7wzeOsCT51x1ZnkQzfqP
 1s5A==
X-Gm-Message-State: AGi0PuayF5ZXD7EXcO3gT02CbqJI+smkwHiJVb5qWsz+Ty5mYe7CRj3i
 C3WTOsH6+FlnqBVIi/mtreodPSQyaAs=
X-Google-Smtp-Source: APiQypLXoGl8Vd/b0aR2Ub1Us6PB/1Bm+gPCDVaBW+Z/6RvWrT/MW6YtC0d3ZwFBhskr1dSEcf0plw==
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr11241063lfi.180.1587405176065; 
 Mon, 20 Apr 2020 10:52:56 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id h7sm120349ljg.37.2020.04.20.10.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 10:52:55 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] target/microblaze: Add the div-zero-exception property
Date: Mon, 20 Apr 2020 19:52:47 +0200
Message-Id: <20200420175250.25777-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420175250.25777-1-edgar.iglesias@gmail.com>
References: <20200420175250.25777-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::141
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

Add the div-zero-exception property to control if the core
traps divizions by zero.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 4 ++++
 target/microblaze/cpu.h       | 1 +
 target/microblaze/op_helper.c | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 36c20d9724..53e80f4e5d 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -207,6 +207,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  PVR2_DOPB_BUS_EXC_MASK : 0) |
                         (cpu->cfg.iopb_bus_exception ?
                                                  PVR2_IOPB_BUS_EXC_MASK : 0) |
+                        (cpu->cfg.div_zero_exception ?
+                                                 PVR2_DIV_ZERO_EXC_MASK : 0) |
                         (cpu->cfg.illegal_opcode_exception ?
                                                 PVR2_ILL_OPCODE_EXC_MASK : 0) |
                         (cpu->cfg.opcode_0_illegal ?
@@ -280,6 +282,8 @@ static Property mb_properties[] = {
                      cfg.iopb_bus_exception, false),
     DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
                      cfg.illegal_opcode_exception, false),
+    DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
+                     cfg.div_zero_exception, false),
     DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 71d7317a58..3c07f9b3f7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -305,6 +305,7 @@ struct MicroBlazeCPU {
         bool iopb_bus_exception;
         bool illegal_opcode_exception;
         bool opcode_0_illegal;
+        bool div_zero_exception;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 18677ddfca..f3b17a95b3 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -132,11 +132,12 @@ uint32_t helper_carry(uint32_t a, uint32_t b, uint32_t cf)
 
 static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
 {
+    MicroBlazeCPU *cpu = env_archcpu(env);
+
     if (b == 0) {
         env->sregs[SR_MSR] |= MSR_DZ;
 
-        if ((env->sregs[SR_MSR] & MSR_EE)
-            && !(env->pvr.regs[2] & PVR2_DIV_ZERO_EXC_MASK)) {
+        if ((env->sregs[SR_MSR] & MSR_EE) && cpu->cfg.div_zero_exception) {
             env->sregs[SR_ESR] = ESR_EC_DIVZERO;
             helper_raise_exception(env, EXCP_HW_EXCP);
         }
-- 
2.20.1


