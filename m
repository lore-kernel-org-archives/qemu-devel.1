Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B793C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA7E218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTfBpe1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA7E218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Qb-00026q-12
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NH-0004ef-UJ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NG-0000SC-LP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:23 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:34268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NG-0000Ie-EK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id b13so24857640pfo.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CWeGp5OQUiIGgb4lAKmE1/GSBVlKuVNMscwa0w65aPo=;
 b=xTfBpe1rZ6GuS2QfdzU8bs9Re1n0GUAJM1+XQA1ASnIsbzridR8mOS00jnSQAHk9mo
 DuD/zuGaytI5sUDsuMxjZODVhnUnBWh2p1uNBMWfCk+PWctmmLmQwqiZHXL1o5lwzhP4
 Cre6HEt86GyL7IjgR4mV02t4nIRKOM9ZZbOEdSuNwXZRpSQFYThyOL7MBQpDj07GReGq
 ZWWNr9phIylsPRitJvVShLev9Bz+1K1pzlKaQ57EFYAQOMGIRowrl+7bs1IwrNtk7PiB
 cxJ12yg+4VmtZx1acuPL87KJ0O7k48YWTfNy3HB16IwyGw3RataNFNezXKMFF2xQhSRP
 CgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CWeGp5OQUiIGgb4lAKmE1/GSBVlKuVNMscwa0w65aPo=;
 b=AL1+70L9gsv8jXWV0Iw5NgSTT/zvIxEwny3u9SX7Oh/1eCHKOSQcSawolHd5nmih6J
 VAdUoZUAWU2c8rhVQQy2Twy0Tpaupej6GMrBFYvwoMqqMdYSY+OngTfIw2f1vjNe9lch
 42WTJFaxffEC8MqdBwZdhNaNtT/8D5/BKP/QU0UxBcgWsb23lzBb5v//1HbPYZztZ9Vp
 cU0XC8lKP+9rq+CBMHi7YamOmf8W7HfjT+CAwf3G8F1kaGFDuvZg5fPsMgOIqe85Pp9+
 cFNlmUd2qeNi//oO59COQjceOmhVlmjJ7yC6/OSzZz//aOrqFdlIGbtKSTgSTPA3+g0p
 n/NA==
X-Gm-Message-State: APjAAAVN4e7vojwCGHGqNFRpQo0X0JKkVpM2Wcaj6qwi9vxwQBWGCeP+
 wRkanI5icYYx0RWgoOB13yxPFdM3FtI=
X-Google-Smtp-Source: APXvYqzJt9sI6NF3cHvR95gH6MgzcC1mDWZSQHgRh4XkPJvhL4+O0ZTbJaDrcJyqkwgAiE7Ee1JUNw==
X-Received: by 2002:a62:1c5:: with SMTP id 188mr22560468pfb.26.1564163475850; 
 Fri, 26 Jul 2019 10:51:15 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:00 -0700
Message-Id: <20190726175032.6769-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::434
Subject: [Qemu-devel] [PATCH 35/67] target/arm: Convert SETEND
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 22 +++++++++++++---------
 target/arm/a32-uncond.decode |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8dbe189df7..1d07caa62a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10135,6 +10135,18 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
     return true;
 }
 
+static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
+{
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+    if (a->E != (s->be_data == MO_BE)) {
+        gen_helper_setend(cpu_env);
+        s->base.is_jmp = DISAS_UPDATE;
+    }
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10220,15 +10232,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             return; /* v7MP: Unallocated memory hint: must NOP */
         }
 
-        if ((insn & 0x0ffffdff) == 0x01010000) {
-            ARCH(6);
-            /* setend */
-            if (((insn >> 9) & 1) != !!(s->be_data == MO_BE)) {
-                gen_helper_setend(cpu_env);
-                s->base.is_jmp = DISAS_UPDATE;
-            }
-            return;
-        } else if ((insn & 0x0e000f00) == 0x0c000100) {
+        if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
                 if (extract32(s->c15_cpar, 1, 1)) {
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index eb1c55b330..d5ed48f0fd 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -24,6 +24,7 @@
 
 &empty           !extern
 &i               !extern imm
+&setend          E
 
 # Branch with Link and Exchange
 
@@ -50,3 +51,6 @@ DSB              1111 0101 0111 1111 1111 0000 0100 ----
 DMB              1111 0101 0111 1111 1111 0000 0101 ----
 ISB              1111 0101 0111 1111 1111 0000 0110 ----
 SB               1111 0101 0111 1111 1111 0000 0111 0000
+
+# Set Endianness
+SETEND           1111 0001 0000 0001 0000 00 E:1 0 0000 0000  &setend
-- 
2.17.1


