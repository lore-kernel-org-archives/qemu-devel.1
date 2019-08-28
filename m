Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7874AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7A82173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHC7+M6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7A82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34J6-0003oZ-Cz
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H6-00048w-J4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H2-0000qN-He
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:43847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33H1-0000nl-3P
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id 4so388729pld.10
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o8JoQg7nIgQDPaTkLH+nSqJkD4bKhobBAH7LTYEZxrk=;
 b=NHC7+M6myA6feaow8W9JrU4sOasU5/M9Ry6++rHR3Qf2joDZZAjOlrwyHxNHmGOMhw
 WNpO5yEpH3/12OCcdFHNKTuPZdcvxM9TP52jsj+YUTYWVI951jWAPwUt1QJVT6wkUQBu
 DedXtsqLqvuNGjvvHsZBZPpa6vCIIwIoyHO+41fJb8UmcN3qq/2ePJHPD8l6q7Jvgb/s
 ATXL1mpcdzfVBtaP+HkIECCUhAEcAq2odX87EaYmUmEnrmjOpyt1JVycVpuZ/kprGvE0
 Ksl75NvWiOr4btIGizZ2zvtPQkuw5zn4GK2mBN1K+8wCD44/PyWVy9FUfzbrFoRXx4WV
 c74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o8JoQg7nIgQDPaTkLH+nSqJkD4bKhobBAH7LTYEZxrk=;
 b=dDzLsi3psci/IY/TA1rqxN4ufB/WiKKoTV11JHfrtgkuzkK6VzHKVHk4leXZ5g8zj/
 YFLEg24pRKp6CwUeAzHDBuKsYOX0RKb+1bVbpNPkPGEfVDdIuJtmAXFiJnGUlFsjS0IV
 FCTGzE6yE2nV82l0H6F3R3US4OvakDTVnGp83YtlMOvh702l7VnNsvgDqBRat9Qsw7QF
 x1vEEI+nnEBLZd5Ce4mHHsWoMOLIr2jrn+yVoMxQ8Yb4YZr82Z+ZTHz0SOst1Ni8gEQ5
 UTGOpq1O5h5TrRPvTFXBf6et2iXtzJ2sbckw6vr2lWih3YP07ifBOellZrEfLdvebmMV
 +Lmg==
X-Gm-Message-State: APjAAAVtHuCkq9yGPRTXCx0+hp+LvLJV+w+PRQs8Wai2NNtCA10MeskT
 iVUixVX38iO7VPdI4vSfkli1ly2pwdw=
X-Google-Smtp-Source: APXvYqzudfvFW4Xs7QfETMsqqqcPFbuFW+Iix1qxnyb+1qG0dMbm7Q/GaKjEfhDJQ/ST9TXtqDK63g==
X-Received: by 2002:a17:902:eb:: with SMTP id a98mr5544096pla.75.1567019184572; 
 Wed, 28 Aug 2019 12:06:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:54 -0700
Message-Id: <20190828190456.30315-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62e
Subject: [Qemu-devel] [PATCH v3 67/69] target/arm: Convert T16, long branches
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 85 ++++++++++++++++++------------------------
 target/arm/t16.decode  |  7 ++++
 2 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 574a791461..424a8354c1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10114,6 +10114,40 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+static bool trans_BL_BLX_prefix(DisasContext *s, arg_BL_BLX_prefix *a)
+{
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    tcg_gen_movi_i32(cpu_R[14], read_pc(s) + (a->imm << 12));
+    return true;
+}
+
+static bool trans_BL_suffix(DisasContext *s, arg_BL_suffix *a)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    tcg_gen_addi_i32(tmp, cpu_R[14], (a->imm << 1) | 1);
+    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
+    gen_bx(s, tmp);
+    return true;
+}
+
+static bool trans_BLX_suffix(DisasContext *s, arg_BLX_suffix *a)
+{
+    TCGv_i32 tmp;
+
+    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    tmp = tcg_temp_new_i32();
+    tcg_gen_addi_i32(tmp, cpu_R[14], a->imm << 1);
+    tcg_gen_andi_i32(tmp, tmp, 0xfffffffc);
+    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
+    gen_bx(s, tmp);
+    return true;
+}
+
 static bool op_tbranch(DisasContext *s, arg_tbranch *a, bool half)
 {
     TCGv_i32 addr, tmp;
@@ -10713,10 +10747,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    int32_t offset;
-    TCGv_i32 tmp;
-    TCGv_i32 tmp2;
-
     if (disas_t16(s, insn)) {
         return;
     }
@@ -10735,53 +10765,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 11: /* misc, in decodetree */
     case 12: /* load/store multiple, in decodetree */
     case 13: /* conditional branch or swi, in decodetree */
-        goto illegal_op;
-
     case 14:
-        if (insn & (1 << 11)) {
-            /* thumb_insn_is_16bit() ensures we can't get here for
-             * a Thumb2 CPU, so this must be a thumb1 split BL/BLX:
-             * 0b1110_1xxx_xxxx_xxxx : BLX suffix (or UNDEF)
-             */
-            assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
-            ARCH(5);
-            offset = ((insn & 0x7ff) << 1);
-            tmp = load_reg(s, 14);
-            tcg_gen_addi_i32(tmp, tmp, offset);
-            tcg_gen_andi_i32(tmp, tmp, 0xfffffffc);
-
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
-            store_reg(s, 14, tmp2);
-            gen_bx(s, tmp);
-            break;
-        }
-        /* unconditional branch, in decodetree */
-        goto illegal_op;
-
     case 15:
-        /* thumb_insn_is_16bit() ensures we can't get here for
-         * a Thumb2 CPU, so this must be a thumb1 split BL/BLX.
-         */
-        assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
-
-        if (insn & (1 << 11)) {
-            /* 0b1111_1xxx_xxxx_xxxx : BL suffix */
-            offset = ((insn & 0x7ff) << 1) | 1;
-            tmp = load_reg(s, 14);
-            tcg_gen_addi_i32(tmp, tmp, offset);
-
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
-            store_reg(s, 14, tmp2);
-            gen_bx(s, tmp);
-        } else {
-            /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix */
-            uint32_t uoffset = ((int32_t)insn << 21) >> 9;
-
-            tcg_gen_movi_i32(cpu_R[14], read_pc(s) + uoffset);
-        }
-        break;
+        /* branches, in decodetree */
+        goto illegal_op;
     }
     return;
 illegal_op:
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index a4c89dba61..43b9a267a1 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -272,3 +272,10 @@ LDM_t16         1011 110 ......... \
 %imm11_0x2      0:s11 !function=times_2
 
 B               11100 ...........               &i imm=%imm11_0x2
+
+# thumb_insn_is_16bit() ensures we won't be decoding these as
+# T16 instructions for a Thumb2 CPU, so these patterns must be
+# a Thumb1 split BL/BLX.
+BLX_suffix      11101 imm:11                    &i
+BL_BLX_prefix   11110 imm:s11                   &i
+BL_suffix       11111 imm:11                    &i
-- 
2.17.1


