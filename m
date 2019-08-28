Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1573DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAFE2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMTj6+GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAFE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Fz-0000kF-Hb
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gs-0003xX-AN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gq-0000i2-9X
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Go-0000fC-Ub
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id d1so226674pgp.4
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sXpbzk4XyeAvgkyELetXWo1a4Xmvrd+/ykw0k9l5t7I=;
 b=CMTj6+GHWPzs68ULrhbI44cIyFv4/xbbuBXa7TRuQijsXp7rCrjEUgYvivg+Nw1/Ru
 LcnOoeIn1ImyL22J3LFJqcaX2Upr9xv48OyhbiP9KUkNxAETBeLnyjcLVugvA5UMzE9q
 6jBjHvwHztx4YiT+eIUzY+FB29AX5fZaaKtXtedfVguJDImXllG+NwSbMy/T3cmlVsM6
 TQbzupbQprSJ3gz8hcOPnYsNdnnhPBOIYCakqntSQSCRHJhi69ZPP+BHk/S4HEtoTvqV
 Wa5Qp70NdZoNCzb2RPTCwhSgFwoiDTPek3lSg3tt5kvSvxRkQMMwgstQ2Slvwb1Kcci2
 9MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sXpbzk4XyeAvgkyELetXWo1a4Xmvrd+/ykw0k9l5t7I=;
 b=JQrUVIF+qM8b+t7iCCvxPl8wiw1fRTqEZt8Xr/3qUZzjfNxLDHZa1zHA2TcqD1ngvu
 7p6FUpw1h/pLjcQJJyq2rd5NYJVOdQBw3ePDr/HWTYPH6C9kpdnTj1lDDHV4ASm7EObX
 nzPe/TIny0GteE3/W0rcVyqcRxSxbKQsgovefXxEC1EO9zmGCYGE1DyXvehxyYEifQSA
 Jp6z9+OJwvD7y6mTXLvjQLK1gn0K4dNfYtw5Pb2zLrUmHw+uLmFjVoG7oAFGR4RxXm3F
 zHLohmI+WNhyEkXPgCpfzVSqzAPZzkuT2mKZ/TXtOwgkUVktujGd89agbFHplmBx/PB8
 lqEA==
X-Gm-Message-State: APjAAAXdCOrQb9OQQAoy8JYhIj1unCqFaFXAYKeUdPyNhz2onG9YEh7P
 82Yy6ra43JSWPlVTmKYieMVFsa063Hg=
X-Google-Smtp-Source: APXvYqwixP0b6vUzFhn3ni3JwcFcaPhfYVZ3clYHE/27d80QeRgyjBkNfmizm/QfA+Zkrei1cz17xQ==
X-Received: by 2002:a63:a302:: with SMTP id s2mr4800116pge.125.1567019172264; 
 Wed, 28 Aug 2019 12:06:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:44 -0700
Message-Id: <20190828190456.30315-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 57/69] target/arm: Convert T16,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Fix cps architecture checks.  Rename s/v6m/v7m/g
---
 target/arm/translate.c | 84 +++++++++++++++++++-----------------------
 target/arm/t16.decode  | 12 ++++++
 2 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d06ec48ab9..1dacae1a5b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7470,6 +7470,11 @@ static int negate(DisasContext *s, int x)
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
@@ -10245,7 +10250,7 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
 {
     uint32_t mask, val;
 
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+    if (!ENABLE_ARCH_6 || arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
     }
     if (IS_USER(s)) {
@@ -10279,6 +10284,36 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
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
@@ -10885,51 +10920,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


