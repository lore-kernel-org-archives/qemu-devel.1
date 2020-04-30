Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A7AC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C982070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpzFXvZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C982070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE9N-0002ro-I0
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDei-0002wW-AN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe9-0001Xw-70
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:28 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDe8-0001Pf-KC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id b11so8175767wrs.6
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5klmBHdlClTeVpJIdEUrHQO54WVC2YmubdzvqAQfLWA=;
 b=GpzFXvZjcwH76ow0++1XCsz8p1z2bAvghtPIITnFHaRqYADPT4xqVDS5x3VyiKD0fw
 cdt8Bi6E8qA2CrCgurzthgZG+4LvOmqcmI0rHzQgsQifWWA8w0T7k7lTurHbXA8fqO24
 8HMJPxcGsgODMTF/8IZDeHQyNhC6PNZlIMuSyXcID+9heUYJbyy7AFT19P5ypPQfnasc
 MP9nzIGLBs83KAaEZXOb5aFtP0b2CqFGW/etR5g1P4I960D2FBdVJ7C9SNrQTKVhVoZj
 yIZFm0YfaUYAztulDGtqGBxoy+w/g0kcqthtyuCWHYF3CAHLaOTetUtBpMkPHAW/Qemk
 kM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5klmBHdlClTeVpJIdEUrHQO54WVC2YmubdzvqAQfLWA=;
 b=kBnnVOivwl31osA40CZWn4OzJmBa76jv5WXve+MPFpGmyzLlCdb9QzaXXXjWqQPyB/
 DjuzonrsZWfLMjEh6Xhe94F4QZkX4/inzhFJYW7OrcmuGyf/zbnKRHoFCm0v3DmfMDK5
 7jXfp5Xq/1sln9V+lO++1bVh76Sif/zem0vbshZtvGOJY4/da9PKeGS8yIixI5GcU1MZ
 gcHYiszfDKuVQRrZybpKeaIyBAJsRRNvMO+m9PS0JveIHHzVvlSFnQAScJ40AO+zU+oc
 Nisrs8QNZGfCqEC9EkcddmWW1mdW9emGCbQgzGQYoqJMc5k8LAOLmGt+r4U9qrJ5ifiI
 p47A==
X-Gm-Message-State: AGi0PuabVpHS/RFDdihmjnbTQEeefkRWRgwr7PIecfLiviM5KAVqpo95
 SjsNNUak4PoUVIIhjW+Azjidlg==
X-Google-Smtp-Source: APiQypKawx0f9UTpXG5h7fHXH70ktMll3dFViU/2w726hVv4bo9wFUoBBvfSOlFM5R+SmFantA4lwQ==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr5446452wrr.160.1588270250619; 
 Thu, 30 Apr 2020 11:10:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 35/36] target/arm: Convert Neon fp
 VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS to decodetree
Date: Thu, 30 Apr 2020 19:10:02 +0100
Message-Id: <20200430181003.21682-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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

Convert the Neon fp VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS 3-reg-same
insns to decodetree. (These are all the remaining non-accumulation
instructions in this group.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 60 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 42 ++---------------------
 target/arm/neon-dp.decode       |  6 ++++
 3 files changed, 68 insertions(+), 40 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 29a3f7677c7..00b0b252e13 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1394,6 +1394,8 @@ DO_3S_FP(VCGE, gen_helper_neon_cge_f32, false)
 DO_3S_FP(VCGT, gen_helper_neon_cgt_f32, false)
 DO_3S_FP(VACGE, gen_helper_neon_acge_f32, false)
 DO_3S_FP(VACGT, gen_helper_neon_acgt_f32, false)
+DO_3S_FP(VMAX, gen_helper_vfp_maxs, false)
+DO_3S_FP(VMIN, gen_helper_vfp_mins, false)
 
 static void gen_VMLA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
                             TCGv_ptr fpstatus)
@@ -1412,6 +1414,64 @@ static void gen_VMLS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
 DO_3S_FP(VMLA, gen_VMLA_fp_3s, true)
 DO_3S_FP(VMLS, gen_VMLS_fp_3s, true)
 
+static bool trans_VMAXNM_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
+            return false;
+    }
+
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same_fp(s, a, gen_helper_vfp_maxnums, false);
+}
+
+static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
+            return false;
+    }
+
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same_fp(s, a, gen_helper_vfp_minnums, false);
+}
+
+static void gen_VRECPS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm)
+{
+    gen_helper_recps_f32(vd, vn, vm, cpu_env);
+}
+
+static bool trans_VRECPS_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same_32(s, a, gen_VRECPS_fp_3s);
+}
+
+static void gen_VRSQRTS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm)
+{
+    gen_helper_rsqrts_f32(vd, vn, vm, cpu_env);
+}
+
+static bool trans_VRSQRTS_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same_32(s, a, gen_VRSQRTS_fp_3s);
+}
+
 static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 {
     /* FP operations handled pairwise 32 bits at a time */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c68dbe126eb..d34a96e9018 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4788,6 +4788,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_FLOAT_MULTIPLY:
         case NEON_3R_FLOAT_CMP:
         case NEON_3R_FLOAT_ACMP:
+        case NEON_3R_FLOAT_MINMAX:
+        case NEON_3R_FLOAT_MISC:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4797,17 +4799,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         switch (op) {
-        case NEON_3R_FLOAT_MINMAX:
-            if (u) {
-                return 1; /* VPMIN/VPMAX handled by decodetree */
-            }
-            break;
-        case NEON_3R_FLOAT_MISC:
-            /* VMAXNM/VMINNM in ARMv8 */
-            if (u && !arm_dc_feature(s, ARM_FEATURE_V8)) {
-                return 1;
-            }
-            break;
         case NEON_3R_VFM_VQRDMLSH:
             if (!dc_isar_feature(aa32_simdfmac, s)) {
                 return 1;
@@ -4823,35 +4814,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         tmp = neon_load_reg(rn, pass);
         tmp2 = neon_load_reg(rm, pass);
         switch (op) {
-        case NEON_3R_FLOAT_MINMAX:
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            if (size == 0) {
-                gen_helper_vfp_maxs(tmp, tmp, tmp2, fpstatus);
-            } else {
-                gen_helper_vfp_mins(tmp, tmp, tmp2, fpstatus);
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
-        case NEON_3R_FLOAT_MISC:
-            if (u) {
-                /* VMAXNM/VMINNM */
-                TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                if (size == 0) {
-                    gen_helper_vfp_maxnums(tmp, tmp, tmp2, fpstatus);
-                } else {
-                    gen_helper_vfp_minnums(tmp, tmp, tmp2, fpstatus);
-                }
-                tcg_temp_free_ptr(fpstatus);
-            } else {
-                if (size == 0) {
-                    gen_helper_recps_f32(tmp, tmp, tmp2, cpu_env);
-                } else {
-                    gen_helper_rsqrts_f32(tmp, tmp, tmp2, cpu_env);
-              }
-            }
-            break;
         case NEON_3R_VFM_VQRDMLSH:
         {
             /* VFMA, VFMS: fused multiply-add */
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index e90c7a9afe9..c4a90e70753 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -173,5 +173,11 @@ VCGE_fp_3s       1111 001 1 0 . 0 . .... .... 1110 ... 0 .... @3same_fp
 VACGE_fp_3s      1111 001 1 0 . 0 . .... .... 1110 ... 1 .... @3same_fp
 VCGT_fp_3s       1111 001 1 0 . 1 . .... .... 1110 ... 0 .... @3same_fp
 VACGT_fp_3s      1111 001 1 0 . 1 . .... .... 1110 ... 1 .... @3same_fp
+VMAX_fp_3s       1111 001 0 0 . 0 . .... .... 1111 ... 0 .... @3same_fp
+VMIN_fp_3s       1111 001 0 0 . 1 . .... .... 1111 ... 0 .... @3same_fp
 VPMAX_fp_3s      1111 001 1 0 . 0 . .... .... 1111 ... 0 .... @3same_fp_q0
 VPMIN_fp_3s      1111 001 1 0 . 1 . .... .... 1111 ... 0 .... @3same_fp_q0
+VRECPS_fp_3s     1111 001 0 0 . 0 . .... .... 1111 ... 1 .... @3same_fp
+VRSQRTS_fp_3s    1111 001 0 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
+VMAXNM_fp_3s     1111 001 1 0 . 0 . .... .... 1111 ... 1 .... @3same_fp
+VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
-- 
2.20.1


