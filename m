Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7237C214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPPwyjSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7237C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33Rq-00065b-0j
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G1-0003LE-5T
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fx-0008SL-Ux
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:24 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fx-0008Rc-P1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:21 -0400
Received: by mail-pf1-x443.google.com with SMTP id w2so398846pfi.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0LZRj16kFkT1uXjnCeSfnp3o1Mv4gGpmSHzsaMSrhpQ=;
 b=EPPwyjSP+91CgRvX5JJz2SRb8NFqNtTEWGTSFT+IrNhz2U+O/MppR+NIcwICAZ86Cr
 Wonhno6pWQEIxPwhjLoaZcLz/kiMKiXs2DMJJbzXanONUXE9/Z1/bRgZA/zphCgfLY0b
 3o8B8I5b+uETVCu9bKzwzqPgxNjygKV6ERiEBakZoSGw0vmYfrx3fi+6e/dX9F3vUEa/
 lYIvIn5Ep4VMWRgAiESeKhdGjD93URT5f8ITD+ZuhV0FGtkJAr+hE7bn5dyoyXCiwCxC
 iR+y4KnEBoWZWjISO/QP9Yy3Lk2kvRt64kxYKePVRY0WLHxdhpnz20MkGRfPtf3jLTB4
 wBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0LZRj16kFkT1uXjnCeSfnp3o1Mv4gGpmSHzsaMSrhpQ=;
 b=cIosXs0XALTI1h+7LWLJUx3T21qT3GAKvg6uI2heKz+NGv8zYW0FLB7bFI8TjijJEI
 0QYpsl1kBr49BBio8FR39Qrb+m/jhuvnDxvaWfb6mD7ZKTn+EMHJ3B2Fi3aV3gR/l9Ts
 /Bvz8f+/1aO1ur4pZgCf3tmBRgW2uyHJ1RtLsF4hA0QFnW5wHnkOtRRE8gmDzAAk5P35
 tTNW4erotWlDP9tFXoJMMqAI7xxodTCM+N507JlpE8Cai26yp+ehthSRxzbpuldth5Af
 Dg4lBcxmXDfYtS39UMO9uTgUqYhXa+UGznJkJ6Wp74jmljvq2loWta0QXCdbIcOr1hHT
 Bgqw==
X-Gm-Message-State: APjAAAXtFwI3TzbgpwrtnDvk+wTDfX2U2UkUdxsh5ms7a6UO/eBYnzcB
 GQ5Kc9nm3/YOBBdrTyzIxJQRTlXzdcY=
X-Google-Smtp-Source: APXvYqymNrRr5PHe6rJIUKEvuQoid6M6GB2i6PY+13mUePbjf+hCMKAdzRaqssmZm7i+SUJX2r3w2w==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr4786735pgt.337.1567019120381; 
 Wed, 28 Aug 2019 12:05:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:03 -0700
Message-Id: <20190828190456.30315-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 16/69] target/arm: Convert CLZ
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

Document our choice about the T32 CONSTRAINED UNPREDICTABLE behaviour.
This matches the undocumented choice made by the legacy decoder.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 31 +++++++++++++++----------------
 target/arm/a32.decode  |  4 ++++
 target/arm/t32.decode  |  5 +++++
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d60e859624..c285d4f882 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8464,6 +8464,19 @@ static bool trans_BLX_r(DisasContext *s, arg_BLX_r *a)
     return true;
 }
 
+static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
+{
+    TCGv_i32 tmp;
+
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    tmp = load_reg(s, a->rm);
+    tcg_gen_clzi_i32(tmp, tmp, 32);
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8752,18 +8765,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* MSR/MRS (banked/register) */
             /* All done in decodetree.  Illegal ops already signalled.  */
             g_assert_not_reached();
-        case 0x1:
-            if (op1 == 3) {
-                /* clz */
-                ARCH(5);
-                rd = (insn >> 12) & 0xf;
-                tmp = load_reg(s, rm);
-                tcg_gen_clzi_i32(tmp, tmp, 32);
-                store_reg(s, rd, tmp);
-            } else {
-                goto illegal_op;
-            }
-            break;
+        case 0x1: /* bx, clz */
         case 0x2: /* bxj */
         case 0x3: /* blx */
         case 0x4: /* crc32 */
@@ -10201,13 +10203,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 case 0x08: /* rev */
                 case 0x09: /* rev16 */
                 case 0x0b: /* revsh */
-                case 0x18: /* clz */
                     break;
                 case 0x10: /* sel */
                     if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
                         goto illegal_op;
                     }
                     break;
+                case 0x18: /* clz, in decodetree */
                 case 0x20: /* crc32/crc32c, in decodetree */
                 case 0x21:
                 case 0x22:
@@ -10240,9 +10242,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     tcg_temp_free_i32(tmp3);
                     tcg_temp_free_i32(tmp2);
                     break;
-                case 0x18: /* clz */
-                    tcg_gen_clzi_i32(tmp, tmp, 32);
-                    break;
                 default:
                     g_assert_not_reached();
                 }
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 6cb9c16e2f..182f2b6725 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -29,6 +29,7 @@
 &s_rrrr          s rd rn rm ra
 &rrrr            rd rn rm ra
 &rrr             rd rn rm
+&rr              rd rm
 &r               rm
 &msr_reg         rn r mask
 &mrs_reg         rd r
@@ -197,6 +198,7 @@ CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
 %sysm            8:1 16:4
 
 @rm              ---- .... .... .... .... .... .... rm:4      &r
+@rdm             ---- .... .... .... rd:4 .... .... rm:4      &rr
 
 MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
 MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
@@ -207,3 +209,5 @@ MSR_reg          ---- 0001 0 r:1 10 mask:4 1111 0000 0000 rn:4  &msr_reg
 BX               .... 0001 0010 1111 1111 1111 0001 ....      @rm
 BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
 BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
+
+CLZ              .... 0001 0110 1111 .... 1111 0001 ....      @rdm
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 337706ebbe..67724efe4b 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -26,6 +26,7 @@
 &s_rrrr          !extern s rd rn rm ra
 &rrrr            !extern rd rn rm ra
 &rrr             !extern rd rn rm
+&rr              !extern rd rm
 &r               !extern rm
 &msr_reg         !extern rn r mask
 &mrs_reg         !extern rd r
@@ -126,6 +127,7 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 @rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
 @rn0dm           .... .... .... rn:4 .... rd:4 .... rm:4      &rrrr ra=0
 @rndm            .... .... .... rn:4 .... rd:4 .... rm:4      &rrr
+@rdm             .... .... .... .... .... rd:4 .... rm:4      &rr
 
 {
   MUL            1111 1011 0000 .... 1111 .... 0000 ....      @s0_rn0dm
@@ -180,6 +182,9 @@ CRC32CB          1111 1010 1101 .... 1111 .... 1000 ....      @rndm
 CRC32CH          1111 1010 1101 .... 1111 .... 1001 ....      @rndm
 CRC32CW          1111 1010 1101 .... 1111 .... 1010 ....      @rndm
 
+# Note rn != rm is CONSTRAINED UNPREDICTABLE; we choose to ignore rn.
+CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
+
 # Branches and miscellaneous control
 
 %msr_sysm        4:1 8:4
-- 
2.17.1


