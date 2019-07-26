Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2FAC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373E921842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHWanicV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373E921842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Xd-0006cJ-Kf
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58576)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NJ-0004mR-G3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NG-0000T7-V4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:43562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NG-0000Le-PY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id 4so18030666pld.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Sh9+ZbJZjCNeBfWv5489FRe5+z+odNhGeCbGO+HiiUM=;
 b=nHWanicVGZ+qNGihaHKG85M750QwrldYoN11uKvwbnjDBGSisIypWdoJ8JzDCR1u8b
 KoI3yYYEHzlQenCMcv8EathuGgc1N6OyaNpRpZaOZ3IQwcC07IZv1yZIO3ZuNO3KqlG9
 OVQpMgFzohzX/SDfTeEylpQoxoRVzecAnZL31DbEugHVwn8QZO+K0J9j1f5JfbaTk+4V
 npXHQhVC8tU7092et4/ZyCSr5+cwCli+L5yBk+f6FBBq3xPk9S2PzPKviS3oZBW2dx80
 MrVj6hlxh/0AafF9knjwQ1qenR1yijqamnUl2bOZtul8DTo0HVf3mfxv7StYGfihh9su
 MaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Sh9+ZbJZjCNeBfWv5489FRe5+z+odNhGeCbGO+HiiUM=;
 b=UeSoj+YHJTGr5XU+hBG522E/XOPg48a7KP1bLUtTpC50tX5z+Xa+sgYsY7TkbFbtSs
 vl3rICTExVmf8FXVCvItlVXUgeCeWoUvQi+9L96JH91lWlseXxA09GNTfVezJkL3upOW
 eXzSSJlt/T4W+iJxb0Q0c23CriAJinSvlwBzI2R9DXeWuPp0sZTsF58VN9+/67372KyZ
 YCovWDsPtWegDl6x8PHyRQmQKeN6k+uoO7QWGnxiFyQqmuPyjCozpqMatmIzYXwloUqg
 /rIbY+fQFWD3m5jqwFAZbozOsD+X/nkOThDQc9UiAbLVSadFldQ9Z6g2kLuJAm7mwrUD
 7dog==
X-Gm-Message-State: APjAAAV8tOxqV6YuczMza0Makmqrne+X5s+Roo7hey8OulEG/iXSZsGr
 VixGGoxgLQTaUgOTS48X7haJRFlX8M0=
X-Google-Smtp-Source: APXvYqxfHbmUqGJxpwiPSzfAndD92HU5BHC5sSX17Nd4apBq1jRWjPtSsCLrt0P2GebS5WE4IAy6xw==
X-Received: by 2002:a17:902:704a:: with SMTP id
 h10mr95313561plt.337.1564163478965; 
 Fri, 26 Jul 2019 10:51:18 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:03 -0700
Message-Id: <20190726175032.6769-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: [Qemu-devel] [PATCH 38/67] target/arm: Convert Table Branch
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
 target/arm/translate.c | 62 +++++++++++++++++++++++-------------------
 target/arm/t32.decode  |  8 +++++-
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 87cbadc6cb..9c6623fb6b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9979,6 +9979,37 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+static bool op_tbranch(DisasContext *s, arg_tbranch *a, bool half)
+{
+    TCGv_i32 addr, tmp;
+
+    tmp = load_reg(s, a->rm);
+    if (half) {
+        tcg_gen_add_i32(tmp, tmp, tmp);
+    }
+    addr = load_reg(s, a->rn);
+    tcg_gen_add_i32(addr, addr, tmp);
+
+    gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
+                    half ? MO_UW | s->be_data : MO_UB);
+    tcg_temp_free_i32(addr);
+
+    tcg_gen_add_i32(tmp, tmp, tmp);
+    tcg_gen_addi_i32(tmp, tmp, s->pc_read);
+    store_reg(s, 15, tmp);
+    return true;
+}
+
+static bool trans_TBB(DisasContext *s, arg_tbranch *a)
+{
+    return op_tbranch(s, a, false);
+}
+
+static bool trans_TBH(DisasContext *s, arg_tbranch *a)
+{
+    return op_tbranch(s, a, true);
+}
+
 /*
  * Supervisor call
  */
@@ -10358,9 +10389,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rm, rs;
-    TCGv_i32 tmp;
-    TCGv_i32 addr;
+    uint32_t rd, rn, rs;
     int op;
 
     /*
@@ -10406,7 +10435,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     rn = (insn >> 16) & 0xf;
     rs = (insn >> 12) & 0xf;
     rd = (insn >> 8) & 0xf;
-    rm = insn & 0xf;
     switch ((insn >> 25) & 0xf) {
     case 0: case 1: case 2: case 3:
         /* 16-bit instructions.  Should never happen.  */
@@ -10479,30 +10507,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 /* Load/store exclusive, in decodetree */
                 goto illegal_op;
             } else if ((insn & (7 << 5)) == 0) {
-                /* Table Branch.  */
-                if (rn == 15) {
-                    addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc_read);
-                } else {
-                    addr = load_reg(s, rn);
-                }
-                tmp = load_reg(s, rm);
-                tcg_gen_add_i32(addr, addr, tmp);
-                if (insn & (1 << 4)) {
-                    /* tbh */
-                    tcg_gen_add_i32(addr, addr, tmp);
-                    tcg_temp_free_i32(tmp);
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-                } else { /* tbb */
-                    tcg_temp_free_i32(tmp);
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
-                }
-                tcg_temp_free_i32(addr);
-                tcg_gen_shli_i32(tmp, tmp, 1);
-                tcg_gen_addi_i32(tmp, tmp, s->pc_read);
-                store_reg(s, 15, tmp);
+                /* Table Branch, in decodetree */
+                goto illegal_op;
             } else {
                 /* Load/store exclusive, load-acq/store-rel, in decodetree */
                 goto illegal_op;
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index f8d8660466..17e6dae688 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -487,7 +487,7 @@ LDRD_ri_t32      1110 1001 .101 .... .... .... ........    @ldstd_ri8 w=0 p=1
 STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
 LDRD_ri_t32      1110 1001 .111 .... .... .... ........    @ldstd_ri8 w=1 p=1
 
-# Load/Store Exclusive and Load-Acquire/Store-Release
+# Load/Store Exclusive, Load-Acquire/Store-Release, and Table Branch
 
 @strex_i         .... .... .... rn:4 rt:4 rd:4 .... .... \
                  &strex rt2=15 imm=%imm8x4
@@ -531,6 +531,12 @@ LDA              1110 1000 1101 .... .... 1111 1010 1111      @ldrex_0
 LDAB             1110 1000 1101 .... .... 1111 1000 1111      @ldrex_0
 LDAH             1110 1000 1101 .... .... 1111 1001 1111      @ldrex_0
 
+&tbranch         rn rm
+@tbranch         .... .... .... rn:4 .... .... .... rm:4      &tbranch
+
+TBB              1110 1000 1101 .... 1111 0000 0000 ....      @tbranch
+TBH              1110 1000 1101 .... 1111 0000 0001 ....      @tbranch
+
 # Parallel addition and subtraction
 
 SADD8            1111 1010 1000 .... 1111 .... 0000 ....      @rndm
-- 
2.17.1


