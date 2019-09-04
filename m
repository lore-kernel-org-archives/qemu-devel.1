Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED234C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BED21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUyxOfky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BED21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bwF-0008No-VN
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b17-0005eK-7T
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b14-0003OB-Fq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:41331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b11-0003Jo-A9
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:29 -0400
Received: by mail-pf1-x42d.google.com with SMTP id b13so7279017pfo.8
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HzFCgBINrkpo6Knja84cWCi2ubxaaPHPuYIHOK9s5JA=;
 b=hUyxOfkyN8Z62KoAleLdJhBgHVDl4tlq7e0FQnUh83gjLqB0DXtswvQliWDEXlb+b/
 6tYgCmMquW0xHO4S1/TK7OXi0/vf2uEZY6WGM5It6sBad2uQm2m7YF5mwFOFp9Vw4ta0
 mHue6gVV2k4I37B8w4SHawvZ27fednISIO43vOoKfJ7kEBIM8xfO8iy/0e88pbu3W+yC
 CCxrK8XH4+IMDkWYGX1Q+l1JG7T0nuA3cJP63Mkzro4XMeyUkYQKYq/eJmnVsLHd6lvc
 vXyiXSGyurO3+jWuT4Xxogjc9QDf9f4DLNWlebiE78/o/sxjgwZieroOFhiadxH31gzB
 E3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HzFCgBINrkpo6Knja84cWCi2ubxaaPHPuYIHOK9s5JA=;
 b=Lew/XT4bBY6Lca3GoKq98junB08+7ctFaNqHv1us9rKrihOPcdRolkhYKXjIU3RLnB
 wnG47iA9VCHycOqnvd/iFNlQktQSV4v6nOQG8MFadmo8KiZKivT2tZcLrRG4loBJ0tYv
 2YtZJlfoF+ByE0Ux0wd/g/Rki4iLY4wFAtDI3zu6UxbFMkoe9VBQwMByeRYvVRDFhmWY
 xzhKP2RA1frKdOToAHqAhUVOSVpWBMhrLEq3NwniUh8tjHtVlzT7W2JmiBoszSpTOQfN
 McdKKbfwQ+Btp/DcPtI2Ez4LGhgR8TqJ/ZIvrkVA+yPQi50rhJ2nRlCJIJHRcsUF+Ypw
 Ld/w==
X-Gm-Message-State: APjAAAWXUeFPA69w/thT4h7fG1jX7q3eOD5HzVhnMSCetC9+dDf4AvED
 56f26smDWq3ggjbRpayvKh/8f7t8PvI=
X-Google-Smtp-Source: APXvYqwzkChEJsuBeNVZXdBbk+R8/f1VRqzqqd2ey1e2iQX3J8sh34wrxor4+Z4CM41fUIk9IsrCfg==
X-Received: by 2002:a62:d143:: with SMTP id t3mr44324988pfl.213.1567625545880; 
 Wed, 04 Sep 2019 12:32:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:57 -0700
Message-Id: <20190904193059.26202-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PATCH v4 67/69] target/arm: Convert T16, long branches
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
index 3238ccbf1e..a99a5c2eef 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10147,6 +10147,40 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
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
@@ -10736,10 +10770,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    int32_t offset;
-    TCGv_i32 tmp;
-    TCGv_i32 tmp2;
-
     if (disas_t16(s, insn)) {
         return;
     }
@@ -10758,53 +10788,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


