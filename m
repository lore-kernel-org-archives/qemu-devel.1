Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5524C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8506320870
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0YWYJqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8506320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDso-00078w-KG
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe5-0001XT-HZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdc-0000mx-BE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdb-0000Zt-KH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id r26so3079992wmh.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BlZoUtI4rHnNV/LtPnuuJ8WTY5HEIIJvinnsYBbRVf4=;
 b=f0YWYJqA9qJCNasqX9aNdchkIpMs50vxJHCchlxSqx+ywUOr2etd/foPXEwSEYSe9+
 52BQg3e8pklNpPyIKQ4dUaJCios3FFQCzvgrMsZV6Q0F4pMPsmvkDGyDvORHupXz9Tsj
 vpk+AoMXVrGrdgKuU+1IM6zlFS5oO5LbD1QpsaO5actSYYG33jXOmV7Fvhh0vbtiAhdt
 oiHjwYLDwNHbR5TNAw2GakZuTKk1d6ViogKCaee5OfNFt/uP6hQcLgQiSD/LrHOh2ZBM
 9znAX8hlSCaJIFfA7MirBGGze7zlUuVK4Ke/la6fL7bWVmk1YPqJdjYHUOTfME9h70Ph
 uMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BlZoUtI4rHnNV/LtPnuuJ8WTY5HEIIJvinnsYBbRVf4=;
 b=I8WJih0rGkXTF6cf6CAOaWTFDrLKoLuYMaQ7CUgSMEbgTnqBPrgbxsHqN2xao3Ax7X
 7Xugc5zOSJEEHwVZajZjBE7fBULI+V3860wKmtyDKtLga/SSpV34BcSszjDz1kphhA8E
 lSSFX/BctaXij0kqsAUNTQTgUJ1QUM7rcPXT/SxWzhorTU9E00vgvECDiVUiJiKYo9hh
 w03hfTIvNiejgOuNBk8dfExqZ1Cv6neG34lsk8cIIUbOB0HUV2J84ZNMXOxJfOekhBlz
 MRC13NfcdLo8rZt8NLmbtC4QdgPsfVBhWCf1pNjEeGAqqZTEoRMtfGQCGt8j9uRXnqf3
 28tA==
X-Gm-Message-State: AGi0PuaYM/jEDmmmEVa+tZ5Y/AtZlR3SZud8SgN/STvfyKFJ9s+NIGSu
 5Pf5EpcXjoSWgmKaQu8Oayvv2Q==
X-Google-Smtp-Source: APiQypI3p8Ng/Ic1CBKgjA51QSxapzDw1N8Apij/EIm/9uYtbX+4qXcYc6oG37xd9KvSBtObVN47cA==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr4296418wmd.95.1588270215581; 
 Thu, 30 Apr 2020 11:10:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/36] target/arm: Convert VFM[AS]L (vector) to decodetree
Date: Thu, 30 Apr 2020 19:09:34 +0100
Message-Id: <20200430181003.21682-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFM[AS]L (vector) insns to decodetree.  This is the last
insn in the legacy decoder for the 3same_ext group, so we can
delete the legacy decoder function for the group entirely.

Note that in disas_thumb2_insn() the parts of this encoding space
where the decodetree decoder returns false will correctly be directed
to illegal_op by the "(insn & (1 << 28))" check so they won't fall
into disas_coproc_insn() by mistake.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 31 +++++++++++
 target/arm/translate.c          | 92 +--------------------------------
 target/arm/neon-shared.decode   |  6 +++
 3 files changed, 38 insertions(+), 91 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 6537506c5b6..6c58abc54b5 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -136,3 +136,34 @@ static bool trans_VDOT(DisasContext *s, arg_VDOT *a)
                        opr_sz, opr_sz, 0, fn_gvec);
     return true;
 }
+
+static bool trans_VFML(DisasContext *s, arg_VFML *a)
+{
+    int opr_sz;
+
+    if (!dc_isar_feature(aa32_fhm, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (a->vd & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    opr_sz = (1 + a->q) * 8;
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(a->q, a->vn),
+                       vfp_reg_offset(a->q, a->vm),
+                       cpu_env, opr_sz, opr_sz, a->s, /* is_2 == 0 */
+                       gen_helper_gvec_fmlal_a32);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1190ad17cfd..caa18c8c56c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7032,84 +7032,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     return 0;
 }
 
-/* Advanced SIMD three registers of the same length extension.
- *  31           25    23  22    20   16   12  11   10   9    8        3     0
- * +---------------+-----+---+-----+----+----+---+----+---+----+---------+----+
- * | 1 1 1 1 1 1 0 | op1 | D | op2 | Vn | Vd | 1 | o3 | 0 | o4 | N Q M U | Vm |
- * +---------------+-----+---+-----+----+----+---+----+---+----+---------+----+
- */
-static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
-{
-    gen_helper_gvec_3 *fn_gvec = NULL;
-    gen_helper_gvec_3_ptr *fn_gvec_ptr = NULL;
-    int rd, rn, rm, opr_sz;
-    int data = 0;
-    int off_rn, off_rm;
-    bool is_long = false, q = extract32(insn, 6, 1);
-    bool ptr_is_env = false;
-
-    if ((insn & 0xff300f10) == 0xfc200810) {
-        /* VFM[AS]L -- 1111 1100 S.10 .... .... 1000 .Q.1 .... */
-        int is_s = extract32(insn, 23, 1);
-        if (!dc_isar_feature(aa32_fhm, s)) {
-            return 1;
-        }
-        is_long = true;
-        data = is_s; /* is_2 == 0 */
-        fn_gvec_ptr = gen_helper_gvec_fmlal_a32;
-        ptr_is_env = true;
-    } else {
-        return 1;
-    }
-
-    VFP_DREG_D(rd, insn);
-    if (rd & q) {
-        return 1;
-    }
-    if (q || !is_long) {
-        VFP_DREG_N(rn, insn);
-        VFP_DREG_M(rm, insn);
-        if ((rn | rm) & q & !is_long) {
-            return 1;
-        }
-        off_rn = vfp_reg_offset(1, rn);
-        off_rm = vfp_reg_offset(1, rm);
-    } else {
-        rn = VFP_SREG_N(insn);
-        rm = VFP_SREG_M(insn);
-        off_rn = vfp_reg_offset(0, rn);
-        off_rm = vfp_reg_offset(0, rm);
-    }
-
-    if (s->fp_excp_el) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
-                           syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
-        return 0;
-    }
-    if (!s->vfp_enabled) {
-        return 1;
-    }
-
-    opr_sz = (1 + q) * 8;
-    if (fn_gvec_ptr) {
-        TCGv_ptr ptr;
-        if (ptr_is_env) {
-            ptr = cpu_env;
-        } else {
-            ptr = get_fpstatus_ptr(1);
-        }
-        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd), off_rn, off_rm, ptr,
-                           opr_sz, opr_sz, data, fn_gvec_ptr);
-        if (!ptr_is_env) {
-            tcg_temp_free_ptr(ptr);
-        }
-    } else {
-        tcg_gen_gvec_3_ool(vfp_reg_offset(1, rd), off_rn, off_rm,
-                           opr_sz, opr_sz, data, fn_gvec);
-    }
-    return 0;
-}
-
 /* Advanced SIMD two registers and a scalar extension.
  *  31             24   23  22   20   16   12  11   10   9    8        3     0
  * +-----------------+----+---+----+----+----+---+----+---+----+---------+----+
@@ -10956,12 +10878,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     }
                 }
             }
-        } else if ((insn & 0x0e000a00) == 0x0c000800
-                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
-            if (disas_neon_insn_3same_ext(s, insn)) {
-                goto illegal_op;
-            }
-            return;
         } else if ((insn & 0x0f000a00) == 0x0e000800
                    && arm_dc_feature(s, ARM_FEATURE_V8)) {
             if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
@@ -11145,15 +11061,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
             break;
         }
-        if ((insn & 0xfe000a00) == 0xfc000800
+        if ((insn & 0xff000a00) == 0xfe000800
             && arm_dc_feature(s, ARM_FEATURE_V8)) {
             /* The Thumb2 and ARM encodings are identical.  */
-            if (disas_neon_insn_3same_ext(s, insn)) {
-                goto illegal_op;
-            }
-        } else if ((insn & 0xff000a00) == 0xfe000800
-                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
-            /* The Thumb2 and ARM encodings are identical.  */
             if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
                 goto illegal_op;
             }
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index c9c641905d3..90cd5c871e2 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -43,3 +43,9 @@ VCADD          1111 110 rot:1 1 . 0 size:1 .... .... 1000 . q:1 . 0 .... \
 # VUDOT and VSDOT
 VDOT           1111 110 00 . 10 .... .... 1101 . q:1 . u:1 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+# VFM[AS]L
+VFML           1111 110 0 s:1 . 10 .... .... 1000 . 0 . 1 .... \
+               vm=%vm_sp vn=%vn_sp vd=%vd_dp q=0
+VFML           1111 110 0 s:1 . 10 .... .... 1000 . 1 . 1 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp q=1
-- 
2.20.1


