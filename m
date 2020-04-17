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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D6C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3C520780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqXPKC35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3C520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWOw-0003gw-Pc
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNk-0002iQ-5T
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNi-0005NO-Va
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:32 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPWNi-0005Lw-Nj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:30 -0400
Received: by mail-lj1-x244.google.com with SMTP id z26so3134735ljz.11
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j6qAH/yc9ASWu022edKXnrycRFAgkzUAnHYobHnSqsw=;
 b=dqXPKC359jSI4EApqsfrPY1xSRvW+3EEL7xTo4WcjXKn1pTYLRjAHgjr97aTEjm6vs
 L/llYbh367vpzBMihjUY4B1bgXhbq+1cFlbAhhktlr8sNtDKiWvTO71REjPhCOqMkRl6
 UEJ62x+GTZYpg+mOiYIX9LDdiBOrmuq8qhk/JmcpnCedR0kFKXR6Tsk0rsj5wNhZ/u5B
 DiCD64KG+RCpNjWIpa7CUWRLAaQron8jeQsrnhb8XUl7A99t1NjU8cC/InxCoCSiSmbi
 UBsp0yemeyU+yqdW3pQkmODNepqSWMy9hz2qfPUTLetS4L5BIb6Dw0T6q63MoRatDTQM
 EUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j6qAH/yc9ASWu022edKXnrycRFAgkzUAnHYobHnSqsw=;
 b=JK7k1TR8RbE/yGsAlxKs7xGd87VHa4Z2l+hU5MxQKYEeB+sBcmKuU7hbnV8Lkd1NGN
 VxY7qTaBJSRZBIAF91UuxQjjmC1rlR88w067a5Is8ALgfWsvJEOVthC4+cIWvbbXtO4y
 swgHDknhw8tGwGQoY/W77dmntrPSEM7wTQO9ZYXNp4iR4A97cS0YSaj/A44qwxhcw+zd
 pWrRA0DTT3w6K65BqjyLh5IO92Rut0ZCRQ0BWdaoPgwx7Ftf8KBf99+ar3+71YYIYplE
 0Ctfxf7+8MYaargbYPY8QwL1ZgkpR7hE6U/+P71mJsJ44QxWBN+JSLLFMEL51zG75rlL
 Wtmg==
X-Gm-Message-State: AGi0PubQ44KPKEO+OnDcMkclp8M0igcqiogHs9k9MxhN9lP80Ocrbjmp
 sPXhF72pGU9LN6DpXALcXh34PM/+NTO+Qw==
X-Google-Smtp-Source: APiQypLSg9SB9K5Paqtq2nr1NTgZRvRIPbzXnRnJb33wPJ3q/Z8+xg/GLMOzaDK98dYaHLkJNBYUhg==
X-Received: by 2002:a2e:9752:: with SMTP id f18mr3084673ljj.181.1587150629170; 
 Fri, 17 Apr 2020 12:10:29 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 6sm18697919lfy.97.2020.04.17.12.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 12:10:28 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/6] target/microblaze: Add the unaligned-exceptions
 property
Date: Fri, 17 Apr 2020 21:10:20 +0200
Message-Id: <20200417191022.5247-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417191022.5247-1-edgar.iglesias@gmail.com>
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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

Add the unaligned-exceptions property to control if the core
traps unaligned memory accesses.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 4 ++++
 target/microblaze/cpu.h       | 1 +
 target/microblaze/translate.c | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 7a40e2fbad..a850c7b23c 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -209,6 +209,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  PVR2_IOPB_BUS_EXC_MASK : 0) |
                         (cpu->cfg.illegal_opcode_exception ?
                                                 PVR2_ILL_OPCODE_EXC_MASK : 0) |
+                        (cpu->cfg.unaligned_exceptions ?
+                                                PVR2_UNALIGNED_EXC_MASK : 0) |
                         (cpu->cfg.opcode_0_illegal ?
                                                  PVR2_OPCODE_0x0_ILL_MASK : 0);
 
@@ -282,6 +284,8 @@ static Property mb_properties[] = {
                      cfg.illegal_opcode_exception, false),
     DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
                      cfg.div_zero_exception, false),
+    DEFINE_PROP_BOOL("unaligned-exceptions", MicroBlazeCPU,
+                     cfg.unaligned_exceptions, false),
     DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3c07f9b3f7..ef9081db40 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -306,6 +306,7 @@ struct MicroBlazeCPU {
         bool illegal_opcode_exception;
         bool opcode_0_illegal;
         bool div_zero_exception;
+        bool unaligned_exceptions;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b4a78551ef..20b7427811 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -995,7 +995,7 @@ static void dec_load(DisasContext *dc)
     v = tcg_temp_new_i32();
     tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
 
-    if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
         TCGv_i32 t0 = tcg_const_i32(0);
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
@@ -1110,7 +1110,7 @@ static void dec_store(DisasContext *dc)
     tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
 
     /* Verify alignment if needed.  */
-    if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
         TCGv_i32 t1 = tcg_const_i32(1);
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
-- 
2.20.1


