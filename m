Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BDBC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD5C2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJkouCQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD5C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbP4b-0008PP-Qk
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58961)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdH-0007xu-Gl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdE-0004HY-T6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:34055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdA-0004Ai-4D
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id w9so6495644wmd.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4+VW3JoxXuJ1NoxNJ7ljWo6K8LodZM2jZoja5e7yMec=;
 b=YJkouCQaIiZbZia6XQdveXD5o/cvCdlZKocXJQW4D6vfBwYf8rS3hMlgrzKyS9PfPo
 Ksc5cN1wKGpBpP8bBMnMgagUrdBVUfsANwkNKE1KOH5y2wIUd8+wRiUey/Hl0ku91EDR
 WhboPCAs9ABWfR7IYr3vx+KrUCYoiUh87Xr8jXhld0BrcbZbenxt+Q3NjGlJ9wrW7RhJ
 39TQhS1R9CmNfkZPvqFjGDXDaAbHjyBKuFZ5fZGVHvpQyU0MbNDEiz/FyV8WFzC7A8R3
 HYlchRFxe3LJ9l3wHgp4Johcrqv51xs/vi5kifiVdR1AagKF1CeBlA+Wxmu4d/2OrFdf
 SRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4+VW3JoxXuJ1NoxNJ7ljWo6K8LodZM2jZoja5e7yMec=;
 b=m8gSbn682ituhcYCQVzKEOzQSm+5spYeBFxM08ayI+LwtHwrNHUxhJ8H5lSMDply5H
 pq/N5FBzWXs1ecPa49N3oK71K9c4EjsbYY8lMJ+uazkjhM5TjKzVyQ5gtiIJ2RX0d4on
 K0Jh+6Pn7/wVf0+pK9h/7gsAXPWj6ORj8DotN7WI0q5yjPLq4R4JgXbSA5pZc27NLy7S
 Vb/ePh1iOzKGVB/meHgiNCnGhz6ft7gi6c54MFOR/0XC1WFlci0i1RCnpbLNPNWI2x0Z
 pOu1PwANvH04q8vUYthFAuqInra5EU4FiujHHoyY0G4V/Zp+GWCIV7Z9htlBagfWFvpA
 mZOQ==
X-Gm-Message-State: APjAAAWDDfptyEnaQ9Oy3TyNkdxZI9AwznCg07lkeg8nyuXxhCEDftM5
 af/YecrdPS/O8r1/brIZPMJhI8RE+qaR2w==
X-Google-Smtp-Source: APXvYqzT304f7l8U5ITWIxDyZt3MlUPtrT0riKemngfrv4Zv7G3HUeCx677fn3P6/pma/9V5vLhH6g==
X-Received: by 2002:a1c:4484:: with SMTP id r126mr3672362wma.27.1560428097741; 
 Thu, 13 Jun 2019 05:14:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:05 +0100
Message-Id: <20190613121433.5246-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 20/48] target/arm: Convert VFP two-register
 transfer insns to decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP two-register transfer instructions to decodetree
(in the v8 Arm ARM these are the "Advanced SIMD and floating-point
64-bit move" encoding group).

Again, we expand out the sequences involving gen_vfp_msr() and
gen_msr_vfp().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 70 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 46 +---------------------
 target/arm/vfp.decode          |  5 +++
 3 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 74c10f9024b..5f081221b83 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -783,3 +783,73 @@ static bool trans_VMOV_single(DisasContext *s, arg_VMOV_single *a)
 
     return true;
 }
+
+static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
+{
+    TCGv_i32 tmp;
+
+    /*
+     * VMOV between two general-purpose registers and two single precision
+     * floating point registers
+     */
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (a->op) {
+        /* fpreg to gpreg */
+        tmp = tcg_temp_new_i32();
+        neon_load_reg32(tmp, a->vm);
+        store_reg(s, a->rt, tmp);
+        tmp = tcg_temp_new_i32();
+        neon_load_reg32(tmp, a->vm + 1);
+        store_reg(s, a->rt2, tmp);
+    } else {
+        /* gpreg to fpreg */
+        tmp = load_reg(s, a->rt);
+        neon_store_reg32(tmp, a->vm);
+        tmp = load_reg(s, a->rt2);
+        neon_store_reg32(tmp, a->vm + 1);
+    }
+
+    return true;
+}
+
+static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_sp *a)
+{
+    TCGv_i32 tmp;
+
+    /*
+     * VMOV between two general-purpose registers and one double precision
+     * floating point register
+     */
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (a->op) {
+        /* fpreg to gpreg */
+        tmp = tcg_temp_new_i32();
+        neon_load_reg32(tmp, a->vm * 2);
+        store_reg(s, a->rt, tmp);
+        tmp = tcg_temp_new_i32();
+        neon_load_reg32(tmp, a->vm * 2 + 1);
+        store_reg(s, a->rt2, tmp);
+    } else {
+        /* gpreg to fpreg */
+        tmp = load_reg(s, a->rt);
+        neon_store_reg32(tmp, a->vm * 2);
+        tcg_temp_free_i32(tmp);
+        tmp = load_reg(s, a->rt2);
+        neon_store_reg32(tmp, a->vm * 2 + 1);
+        tcg_temp_free_i32(tmp);
+    }
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3982c870314..eb217af579a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3703,50 +3703,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
     case 0xc:
     case 0xd:
         if ((insn & 0x03e00000) == 0x00400000) {
-            /* two-register transfer */
-            rn = (insn >> 16) & 0xf;
-            rd = (insn >> 12) & 0xf;
-            if (dp) {
-                VFP_DREG_M(rm, insn);
-            } else {
-                rm = VFP_SREG_M(insn);
-            }
-
-            if (insn & ARM_CP_RW_BIT) {
-                /* vfp->arm */
-                if (dp) {
-                    gen_mov_F0_vreg(0, rm * 2);
-                    tmp = gen_vfp_mrs();
-                    store_reg(s, rd, tmp);
-                    gen_mov_F0_vreg(0, rm * 2 + 1);
-                    tmp = gen_vfp_mrs();
-                    store_reg(s, rn, tmp);
-                } else {
-                    gen_mov_F0_vreg(0, rm);
-                    tmp = gen_vfp_mrs();
-                    store_reg(s, rd, tmp);
-                    gen_mov_F0_vreg(0, rm + 1);
-                    tmp = gen_vfp_mrs();
-                    store_reg(s, rn, tmp);
-                }
-            } else {
-                /* arm->vfp */
-                if (dp) {
-                    tmp = load_reg(s, rd);
-                    gen_vfp_msr(tmp);
-                    gen_mov_vreg_F0(0, rm * 2);
-                    tmp = load_reg(s, rn);
-                    gen_vfp_msr(tmp);
-                    gen_mov_vreg_F0(0, rm * 2 + 1);
-                } else {
-                    tmp = load_reg(s, rd);
-                    gen_vfp_msr(tmp);
-                    gen_mov_vreg_F0(0, rm);
-                    tmp = load_reg(s, rn);
-                    gen_vfp_msr(tmp);
-                    gen_mov_vreg_F0(0, rm + 1);
-                }
-            }
+            /* Already handled by decodetree */
+            return 1;
         } else {
             /* Load/store */
             rn = (insn >> 16) & 0xf;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index bb7de403df3..134f1c9ef58 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -66,3 +66,8 @@ VDUP         ---- 1110 1 b:1 q:1 0 .... rt:4 1011 . 0 e:1 1 0000 \
 VMSR_VMRS    ---- 1110 111 l:1 reg:4 rt:4 1010 0001 0000
 VMOV_single  ---- 1110 000 l:1 .... rt:4 1010 . 001 0000 \
              vn=%vn_sp
+
+VMOV_64_sp   ---- 1100 010 op:1 rt2:4 rt:4 1010 00.1 .... \
+             vm=%vm_sp
+VMOV_64_dp   ---- 1100 010 op:1 rt2:4 rt:4 1011 00.1 .... \
+             vm=%vm_dp
-- 
2.20.1


