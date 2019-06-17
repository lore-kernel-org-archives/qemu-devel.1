Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ECFC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7492084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOa/8E80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7492084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hct4A-0007Mf-7O
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsib-0003pt-QL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsia-0008IE-4p
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiY-0008GH-12
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so10221267wrm.8
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XQkVe31Ovdke7xC6FzEOvXi21mGhZtU8Ng0JD22wlkQ=;
 b=eOa/8E80JgOxlJuatwXBP6e03N5ShYOJFjZJb8obfEmQMryRRxfPPctSW+f7lpNoiK
 qjcLxnTTwjRWVqMSykf62ggWgxQrOhIoLBEdeVHz8aklOEcgJngCu6NMyKMcCtuQkfNe
 BYY9HOHSOWUdcjWsOks3BE0BtzM+ehTq9OQwNriDZLVFhQgPP+gAgpgSOmeC3GJMT1f+
 GzcUMY/9k5zOHMHzFWatwM9gAQqS4XNwHOwJKK/KId5IeVSLYks2JjfkeuTl2NPJF8LM
 nLDZ3WSeomhY8ghQCIUtE9nTCWusecJhGgX4WnbAK7f5E/gqh0h/H9FmumoTbFdMP0Sz
 NcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XQkVe31Ovdke7xC6FzEOvXi21mGhZtU8Ng0JD22wlkQ=;
 b=by8TaMW/QRQCM9MQMT7dSc68eeRIbgFYVQSf8z5pion3GhjQvPUEwuW851l0clP+Ip
 0lp09ay4V3jPn7LGAE6L0gt+TyROK0Qpdv6TUFwjzx1u+/uX+Jsta9gxPBgED8YyTyG5
 GGCkrj+G/pY6FArIKiLj3RBQRdVRj5sSTCUZ8bP9NlO4h+PZsIyZyLSFIOD3UEHfGdCq
 jKUHjz8XElt2GQHnep5PgYPM0xanZi2/tcrBH/W+XMGce/hzclLrL6QvOw8FajiQbJ6L
 dt45nbVleB1wWNaGX7d+8d1z+6b9GXaYbEHCBOSe5vpjc6apIMhtJcj9BidkSdy82MKe
 9LNA==
X-Gm-Message-State: APjAAAWupFzconG5BS/tfLy3CPtAWbo77cPy182RhQQLoyRhaI/xPAQD
 auzNFIFnHWWfc/8eP4QIbF8wfHTE/LA+yQ==
X-Google-Smtp-Source: APXvYqwWrTt/ztMEgJnJmope5LwQv1MdrXqj+yEOGK41Mh8Ej89Ec8lk2mndTwCd0wGXWID6wJB2aw==
X-Received: by 2002:a5d:52c8:: with SMTP id r8mr8459149wrv.250.1560782080347; 
 Mon, 17 Jun 2019 07:34:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:12 +0100
Message-Id: <20190617143412.5734-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 24/24] target/arm: Only implement doubles if the
 FPU supports them
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

The architecture permits FPUs which have only single-precision
support, not double-precision; Cortex-M4 and Cortex-M33 are
both like that. Add the necessary checks on the MVFR0 FPDP
field so that we UNDEF any double-precision instructions on
CPUs like this.

Note that even if FPDP==0 the insns like VMOV-to/from-gpreg,
VLDM/VSTM, VLDR/VSTR which take double precision registers
still exist.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190614104457.24703-3-peter.maydell@linaro.org
---
 target/arm/cpu.h               |  6 +++
 target/arm/translate-vfp.inc.c | 84 ++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a98c45b1ff0..f9da672be57 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3388,6 +3388,12 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
     return FIELD_EX64(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
+static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports double precision floating point */
+    return FIELD_EX64(id->mvfr0, MVFR0, FPDP) > 0;
+}
+
 /*
  * We always set the FP and SIMD FP16 fields to indicate identical
  * levels of support (assuming SIMD is implemented at all), so
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 390441a1104..348173d6026 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -206,6 +206,11 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
+
+    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     rd = a->vd;
     rn = a->vn;
     rm = a->vm;
@@ -334,6 +339,11 @@ static bool trans_VMINMAXNM(DisasContext *s, arg_VMINMAXNM *a)
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
+
+    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     rd = a->vd;
     rn = a->vn;
     rm = a->vm;
@@ -415,6 +425,11 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
         ((a->vm | a->vd) & 0x10)) {
         return false;
     }
+
+    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     rd = a->vd;
     rm = a->vm;
 
@@ -473,6 +488,11 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     if (dp && !dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
         return false;
     }
+
+    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     rd = a->vd;
     rm = a->vm;
 
@@ -1301,6 +1321,10 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -1446,6 +1470,10 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -1743,6 +1771,10 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -1901,6 +1933,10 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!dc_isar_feature(aa32_fpshvec, s) &&
         (veclen != 0 || s->vec_stride != 0)) {
         return false;
@@ -2041,6 +2077,10 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2110,6 +2150,10 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2172,6 +2216,10 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2228,6 +2276,10 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2285,6 +2337,10 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2340,6 +2396,10 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2364,6 +2424,10 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2388,6 +2452,10 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2438,6 +2506,10 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2474,6 +2546,10 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2563,6 +2639,10 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -2655,6 +2735,10 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
-- 
2.20.1


