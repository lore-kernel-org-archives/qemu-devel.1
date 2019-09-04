Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08275C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B1922CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9LNCLqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B1922CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bna-0008Iv-H0
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0w-0005XQ-5C
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0s-00039o-4V
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:22 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0r-00035G-MG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:17 -0400
Received: by mail-pg1-x541.google.com with SMTP id d10so7223689pgo.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fMRa2kGO1W6JycMdagL8+nOz15aN9a5pAkRiDJ3RJXk=;
 b=t9LNCLqqeK9QG+WOaFCZF8UD/ZNxAlbiKE59zZVqeg29cGvwLhpNXZ9Mk2/VZaDhIL
 Yk4rKljlbV+t7T/mB04uEEBWJPUjYPyUYiZTJfaFDTpFZdIpNDZQeuuRA6kRb/SNCb0C
 ast6nklDU97wbUjwBw6OY/gxbN1geFzoYvIX5ijd18aYNlM6NeSBJ+PNxKPR5ucTsmnh
 VujDO4DhgUB/VuuHNb8C4QLHI+3tuzyFOR61UqJKTxBxsEtjN/4CjJODcdC5H6s+r7MN
 Br5hQJA9OxydauMkXJ+5pkk3Gd4ilpWk37mnMAt7fdW8yaOeP1qqPXSBh5iF+4CDYcnL
 2pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fMRa2kGO1W6JycMdagL8+nOz15aN9a5pAkRiDJ3RJXk=;
 b=RXbJAUnjGlvrzk/d6wmDl98HxgLF5vj07NBYkdBKz69MIMwFtpZGWg6Yog3ftLPgJD
 lZzyPorR2n0ek/6TIPG3NrjMKAlfnoEaVIYNHlu06OO2NXx9SENkRKlgk8n8wwzQ+R8W
 3CNeprxS++h2uY5O0a/VePLn+8jNe5eZnslw3/vG/t3De9aGcb0l+TgvsalrSjGGTyQN
 QK/WIh5AL6zAYplYieqTmSsqv2B0TgxGYtlRfm6kk/z7tATlXxcLQz6DzXiSI6we/NpO
 UoJuyMsQUWzRMlUv9iCoHUncqCAVrmrQRzWGOC66jugZayc1N4h00sFyI2PwvzAEvKiy
 e4+A==
X-Gm-Message-State: APjAAAW9567M18ieJvp2U0AIa9PVFaa8xnPP87s1ixay2KCHAZwRCm9A
 NJ8MCiOYzX++wo7K+agkG7d7fGg0434=
X-Google-Smtp-Source: APXvYqyD1mqj7A/UT4YyQN+pinDnU3X/x7LgvR+J9dc01QHRx2AzmcZHQdfxGmoxIUXvTPMCwL1ydA==
X-Received: by 2002:a65:6557:: with SMTP id a23mr36594161pgw.439.1567625533378; 
 Wed, 04 Sep 2019 12:32:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:47 -0700
Message-Id: <20190904193059.26202-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v4 57/69] target/arm: Convert T16,
 Change processor state
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a check for ARMv6 in trans_CPS.  We had this correct in
the T16 path, but had previously forgotten the check on the
A32 and T32 paths.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Fix cps architecture checks.  Rename s/v6m/v7m/g
---
 target/arm/translate.c | 84 +++++++++++++++++++-----------------------
 target/arm/t16.decode  | 12 ++++++
 2 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 09c05de320..ce394ddb00 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7496,6 +7496,11 @@ static int negate(DisasContext *s, int x)
     return -x;
 }
 
+static int plus_2(DisasContext *s, int x)
+{
+    return x + 2;
+}
+
 static int times_2(DisasContext *s, int x)
 {
     return x * 2;
@@ -10268,7 +10273,7 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
 {
     uint32_t mask, val;
 
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+    if (!ENABLE_ARCH_6 || arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
     }
     if (IS_USER(s)) {
@@ -10302,6 +10307,36 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
     return true;
 }
 
+static bool trans_CPS_v7m(DisasContext *s, arg_CPS_v7m *a)
+{
+    TCGv_i32 tmp, addr;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    if (IS_USER(s)) {
+        /* Implemented as NOP in user mode.  */
+        return true;
+    }
+
+    tmp = tcg_const_i32(a->im);
+    /* FAULTMASK */
+    if (a->F) {
+        addr = tcg_const_i32(19);
+        gen_helper_v7m_msr(cpu_env, addr, tmp);
+        tcg_temp_free_i32(addr);
+    }
+    /* PRIMASK */
+    if (a->I) {
+        addr = tcg_const_i32(16);
+        gen_helper_v7m_msr(cpu_env, addr, tmp);
+        tcg_temp_free_i32(addr);
+    }
+    tcg_temp_free_i32(tmp);
+    gen_lookup_tb(s);
+    return true;
+}
+
 /*
  * Clear-Exclusive, Barriers
  */
@@ -10908,51 +10943,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             break;
         }
 
-        case 6:
-            switch ((insn >> 5) & 7) {
-            case 2:
-                /* setend */
-                ARCH(6);
-                if (((insn >> 3) & 1) != !!(s->be_data == MO_BE)) {
-                    gen_helper_setend(cpu_env);
-                    s->base.is_jmp = DISAS_UPDATE;
-                }
-                break;
-            case 3:
-                /* cps */
-                ARCH(6);
-                if (IS_USER(s)) {
-                    break;
-                }
-                if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                    tmp = tcg_const_i32((insn & (1 << 4)) != 0);
-                    /* FAULTMASK */
-                    if (insn & 1) {
-                        addr = tcg_const_i32(19);
-                        gen_helper_v7m_msr(cpu_env, addr, tmp);
-                        tcg_temp_free_i32(addr);
-                    }
-                    /* PRIMASK */
-                    if (insn & 2) {
-                        addr = tcg_const_i32(16);
-                        gen_helper_v7m_msr(cpu_env, addr, tmp);
-                        tcg_temp_free_i32(addr);
-                    }
-                    tcg_temp_free_i32(tmp);
-                    gen_lookup_tb(s);
-                } else {
-                    if (insn & (1 << 4)) {
-                        shift = CPSR_A | CPSR_I | CPSR_F;
-                    } else {
-                        shift = 0;
-                    }
-                    gen_set_psr_im(s, ((insn & 7) << 6), 0, shift);
-                }
-                break;
-            default:
-                goto undef;
-            }
-            break;
+        case 6: /* setend, cps; in decodetree */
+            goto illegal_op;
 
         default:
             goto undef;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index b5b5086e8a..032902a1f4 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -29,6 +29,8 @@
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 &ldst_block      !extern rn i b u w list
+&setend          !extern E
+&cps             !extern mode imod M A I F
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -183,3 +185,13 @@ SXTAH           1011 0010 00 ... ...            @extend
 SXTAB           1011 0010 01 ... ...            @extend
 UXTAH           1011 0010 10 ... ...            @extend
 UXTAB           1011 0010 11 ... ...            @extend
+
+# Change processor state
+
+%imod           4:1 !function=plus_2
+
+SETEND          1011 0110 010 1 E:1 000         &setend
+{
+  CPS           1011 0110 011 . 0 A:1 I:1 F:1   &cps mode=0 M=0 %imod
+  CPS_v7m       1011 0110 011 im:1 00 I:1 F:1
+}
-- 
2.17.1


