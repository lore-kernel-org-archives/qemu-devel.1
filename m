Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB871C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739082078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1SWI8hX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739082078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDP3-0000xK-Nd
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMK-0004Tx-Ou
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:56 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:50254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMJ-0006NX-55
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:56 -0400
Received: by mail-pj1-x1041.google.com with SMTP id k71so3699370pje.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q4s8uQ+E02Te+avH0/ZNYFIiJ5640p//BWC6Tu6+uwc=;
 b=W1SWI8hXo18ZI38I9SXUNcs58ah2Q1LaarvMseSoXphMyZO1OGkUh4uqWAzrScU/lO
 udcmsdD0fWMlvvqMmI6izvpABduWmUag1cT5GM5Hr5aGzUd50Zhv7kZvsS4wW/p35SX4
 f3M+FmRH9FR0Fzc0/T7Oc+TDtiojGWexTAcFfPo9/rkT79DIbQQvDeYZJu96nM2fgjHa
 sWlGjcaTn0BcNluKMhddvWhw7o9U8YDdYiqgNfUOOGdzfrOi6dpUNTkVCZQZISn4Yij9
 avr3RyO+hCWnjadFSQ1egC4PBXOumAHjdhUcrhmsMp6MAnboj78c2H2J7MlYC2LEBDpf
 t/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q4s8uQ+E02Te+avH0/ZNYFIiJ5640p//BWC6Tu6+uwc=;
 b=rLSeFuNuxSDpNz3kMlLYiSte6TACeeehA5PiUWymIApimkO/nMX5XhKsaTfrQXaig/
 TQhEhwwlzcEdz6QEm/Pr4MM/RnUx2BR5VcDktBMzDudqm5S6yKvGm9PmIjDKeh9pHsJ7
 gJWntSY4AW4MX9o79dCjbZex0Hjrcw/vc9+uAig+ABGbS45o+/74JkuJplk6epRMgiEb
 4HheYviF7dgN1RNgMSB6hKz3Z0xEsdL7YGx1YT0lI5Isk3fsNZ+2wryj0CV8cSbKGBrR
 EITFACvgcKCpuxdH7tyT6zRBO0iNt46QffApp/Xb8+PqV4RwKMtMWiTah7rlh8G0IGsH
 ZrlQ==
X-Gm-Message-State: AOAM531nosqOQvi2SDpPyLyq7sQKFPwib1m5T3rlf9JzKtjrHTTErj1h
 PvI+EH8+n0fe7TkMYinR//NeL7EH
X-Google-Smtp-Source: ABdhPJy6nUcZKqg7487/goSQny3xy6y1l3c8IdroNtz7Xh8ahTz0prHZSMXwf6IWY2jr2U7sPQ+wCA==
X-Received: by 2002:a17:902:a70e:: with SMTP id
 w14mr19866248plq.259.1594465673726; 
 Sat, 11 Jul 2020 04:07:53 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:52 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/22] target/xtensa: move FSR/FCR register accessors
Date: Sat, 11 Jul 2020 04:06:42 -0700
Message-Id: <20200711110655.20287-8-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move FSR/FCR register accessors from core opcodes to FPU2000 opcodes as
they are FPU2000-specific.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 64 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 47951acd1669..1b643881e6e9 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2813,18 +2813,6 @@ static void translate_wur(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(cpu_UR[par[0]], arg[0].in);
 }
 
-static void translate_wur_fpu2k_fcr(DisasContext *dc, const OpcodeArg arg[],
-                                    const uint32_t par[])
-{
-    gen_helper_wur_fpu2k_fcr(cpu_env, arg[0].in);
-}
-
-static void translate_wur_fsr(DisasContext *dc, const OpcodeArg arg[],
-                              const uint32_t par[])
-{
-    tcg_gen_andi_i32(cpu_UR[par[0]], arg[0].in, 0xffffff80);
-}
-
 static void translate_xor(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
@@ -4665,16 +4653,6 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "rur.expstate",
         .translate = translate_rur,
         .par = (const uint32_t[]){EXPSTATE},
-    }, {
-        .name = "rur.fcr",
-        .translate = translate_rur,
-        .par = (const uint32_t[]){FCR},
-        .coprocessor = 0x1,
-    }, {
-        .name = "rur.fsr",
-        .translate = translate_rur,
-        .par = (const uint32_t[]){FSR},
-        .coprocessor = 0x1,
     }, {
         .name = "rur.threadptr",
         .translate = translate_rur,
@@ -5581,16 +5559,6 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "wur.expstate",
         .translate = translate_wur,
         .par = (const uint32_t[]){EXPSTATE},
-    }, {
-        .name = "wur.fcr",
-        .translate = translate_wur_fpu2k_fcr,
-        .par = (const uint32_t[]){FCR},
-        .coprocessor = 0x1,
-    }, {
-        .name = "wur.fsr",
-        .translate = translate_wur_fsr,
-        .par = (const uint32_t[]){FSR},
-        .coprocessor = 0x1,
     }, {
         .name = "wur.threadptr",
         .translate = translate_wur,
@@ -6510,6 +6478,18 @@ static void translate_wfr_s(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(arg[0].out, arg[1].in);
 }
 
+static void translate_wur_fpu2k_fcr(DisasContext *dc, const OpcodeArg arg[],
+                                    const uint32_t par[])
+{
+    gen_helper_wur_fpu2k_fcr(cpu_env, arg[0].in);
+}
+
+static void translate_wur_fpu2k_fsr(DisasContext *dc, const OpcodeArg arg[],
+                                    const uint32_t par[])
+{
+    tcg_gen_andi_i32(cpu_UR[par[0]], arg[0].in, 0xffffff80);
+}
+
 static const XtensaOpcodeOps fpu2000_ops[] = {
     {
         .name = "abs.s",
@@ -6632,6 +6612,16 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_nearest_even, false},
         .coprocessor = 0x1,
+    }, {
+        .name = "rur.fcr",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){FCR},
+        .coprocessor = 0x1,
+    }, {
+        .name = "rur.fsr",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){FSR},
+        .coprocessor = 0x1,
     }, {
         .name = "ssi",
         .translate = translate_ldsti,
@@ -6699,6 +6689,16 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "wfr",
         .translate = translate_wfr_s,
         .coprocessor = 0x1,
+    }, {
+        .name = "wur.fcr",
+        .translate = translate_wur_fpu2k_fcr,
+        .par = (const uint32_t[]){FCR},
+        .coprocessor = 0x1,
+    }, {
+        .name = "wur.fsr",
+        .translate = translate_wur_fpu2k_fsr,
+        .par = (const uint32_t[]){FSR},
+        .coprocessor = 0x1,
     },
 };
 
-- 
2.20.1


