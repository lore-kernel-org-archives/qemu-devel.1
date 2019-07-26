Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A230C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7DA21842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQ3jutNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7DA21842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Zm-0005F4-Hv
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59456)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nr-0007DA-Hp
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nl-0001CH-Ec
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:57 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nk-00011l-1d
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:53 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so25119044pgj.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qeYs/8P06sT88x1fm+VX2RboOfuM1870Y9rpmWOvTNY=;
 b=yQ3jutNBhJLz4jBCk1TzF98u6da0i8ITj42pLZcF/8tNMCnmPEK/FGue1OrihmFZzA
 wRMe4XhlTsudTRVI05ErFLXxAz+QvaxTWFX1IXDFdhgYghGQNWS/k1DWBJ3SfGFWIdRj
 eGEZJuixaTHCGaelA6nYHa3q0VtOyBpgblzUNZ9F0B49DAcTlkOhfvs+cK85hPrrG0xm
 rDrg/ZlN+CVVN3vD38GbYwA5hxY8dvMb4/gJeEVWeMz79Ifhm/ZHaA1Sg+OjOYAJBluB
 odItBAJ8OqixFNdVmPKEczhf+HWQ7BcQlF5k9TRB3BWqHztzn6NT8mQglN/kOpVLtg1r
 H1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qeYs/8P06sT88x1fm+VX2RboOfuM1870Y9rpmWOvTNY=;
 b=rcnByn3W3kL+sZCW5TxwO1wRc9LMVIlmZ5yjTs2Rh7/m5jH9NkVN2pAHZwShsQlDuh
 x6gi3pCQPfOpQdv368loPHCvNhD5B9Z1BCcXcmDOIYLsWJ+Y/gg5dcZz+3M7RWGshzPR
 fApB/Q2o5Tdn+/mp5xJHlev+QwKK7GeSQfBY+Q5kg9bFozOtybbMrU4+f7P86lBfFIEU
 MDH7LpJMxr5bS/kujq05mxY4wkN7nYxXOmsKvqOrP7rC9ZHAOTnZCcwtYom/Ct8NYQX8
 dUUBqj+AQjMwsKVqH5tON+l6n9hoQWtt+1EUU0ewksdZACstBUBYcSB1c90EsXj5cnG4
 IiEA==
X-Gm-Message-State: APjAAAXL3rrVd+gcnVP/5GCaGN1o2Y/bwx4hJA5P1CYg8+EvDN+DL6dm
 JREKVHWS2vPeKmbWcoMA80PTZbDE22Q=
X-Google-Smtp-Source: APXvYqxKJDbn7SwD0+5ZWTdy4GmoIFg0GR78Yzy0RBwVJPjYxL2TKRTeDtC6Q/pi8eEvRGgn55czUA==
X-Received: by 2002:a17:90a:30aa:: with SMTP id
 h39mr99848190pjb.32.1564163500297; 
 Fri, 26 Jul 2019 10:51:40 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:20 -0700
Message-Id: <20190726175032.6769-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 55/67] target/arm: Convert T16,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 85 ++++++++++++++++++++----------------------
 target/arm/t16.decode  | 12 ++++++
 2 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9c8e11bd3a..8f2adbbc7d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7531,6 +7531,11 @@ static int negate(DisasContext *s, int x)
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
@@ -10163,6 +10168,9 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
 {
     uint32_t mask, val;
 
+    if (ENABLE_ARCH_6 && arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
     if (IS_USER(s)) {
         /* Implemented as NOP in user mode.  */
         return true;
@@ -10193,6 +10201,36 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
     return true;
 }
 
+static bool trans_CPS_v6m(DisasContext *s, arg_CPS_v6m *a)
+{
+    TCGv_i32 tmp, addr;
+
+    if (!(ENABLE_ARCH_6 && arm_dc_feature(s, ARM_FEATURE_M))) {
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
@@ -10793,51 +10831,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
index 1b47e804bf..f43ea6ce20 100644
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
+  CPS_v6m       1011 0110 011 im:1 00 I:1 F:1
+  CPS           1011 0110 011 . 0 A:1 I:1 F:1   &cps mode=0 M=0 %imod
+}
-- 
2.17.1


