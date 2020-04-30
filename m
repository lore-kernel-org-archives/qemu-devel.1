Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51744C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BCC2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5FX/gXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BCC2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDgQ-0004qy-7O
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdt-0001OG-GX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdX-0000VQ-BX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdW-0000MC-My
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so2975614wmb.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tUEcahS4A8n7HVNrT331LibayVMgWGTo+zYLEgvzurM=;
 b=F5FX/gXY8ZO/bpRl3UCxFjzk+KYebVfENnudP7qMLN+eMPM2CMkmK4+vW2z/11xEYH
 kUSYmSsrglNvXYJFLbL9yr9r/Y0d8n90llEMb1EcPaJRm3A2FYgZk90s+J67+Yqv59vu
 rX557aBJGtbpHSgxY9gOXXtV9qdyD6AyngdMMnr9OTE1HuRNajYAYVBpYSFJfjrIk7MO
 hvD95jijjZRXTI5fxAhnW54AIBp55W69tzJBdx3igLFmw6/GA6X8I578NwAhlK2m64Zv
 yloBuBJUFJFX6wBuxH2aw62MUZxx4AE658Vy9UujhTnnH8RObOF7r1ykUZ4h/AFl2jPZ
 +nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tUEcahS4A8n7HVNrT331LibayVMgWGTo+zYLEgvzurM=;
 b=Z5dHi7/AjCtN+1MrhWsAP98jeqkHjsyFN89LVI6KXyElFhiMxWh9IXdXXwAgJo4IJP
 SFq9Y//a4F2O7zFjcE0Fr3Ktelyyx9u6Z4y+HoIzquqDaAlgeXtaGyZiWk/rO9xcZBQm
 3TQWyDgeK1TPh/IVrdqmrc88mIbGWP6bQIw8yFCYhA5nBtqmH0y/60Dwzzsc3bAhm6s5
 oLtUNsd8P8Gv547rW74hI8MnsJdpTMPqykufISSa+qY8C2qvtfrDyiOl16MaLj5pzvnX
 3NKZS2tSSJihh/OjAoZFNRI9o5JA2VE5DoYrTDHP9Z/ojCe0UM6Xb+XpeAr3c/DfrTak
 qy5w==
X-Gm-Message-State: AGi0PubW5pyCvA937w8zlepTPIifG3U2cr6ISSGrDdp1olM7Jtus/B91
 sk4xdt6BVuIwTORnN9S076TDAmh+JgckAQ==
X-Google-Smtp-Source: APiQypJSlKD9GQWTk693wI4sCHJIcIprU6Ms0mu5k3QVXq1C+y2CSITiwhglr+0AFHjvHG5cpMB4Pw==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr4146097wmi.57.1588270211970; 
 Thu, 30 Apr 2020 11:10:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/36] target/arm: Convert VCMLA (vector) to decodetree
Date: Thu, 30 Apr 2020 19:09:31 +0100
Message-Id: <20200430181003.21682-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

Convert the VCMLA (vector) insns in the 3same extension group to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 37 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 11 +---------
 target/arm/neon-shared.decode   | 11 ++++++++++
 3 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index a33e81ba3ab..0baae1338a3 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -30,3 +30,40 @@
 #include "decode-neon-dp.inc.c"
 #include "decode-neon-ls.inc.c"
 #include "decode-neon-shared.inc.c"
+
+static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
+{
+    int opr_sz;
+    TCGv_ptr fpst;
+    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+
+    if (!dc_isar_feature(aa32_vcma, s)
+        || (!a->size && !dc_isar_feature(aa32_fp16_arith, s))) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    opr_sz = (1 + a->q) * 8;
+    fpst = get_fpstatus_ptr(1);
+    fn_gvec_ptr = a->size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       fpst, opr_sz, opr_sz, a->rot,
+                       fn_gvec_ptr);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index bd766391e9e..17167634e29 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7048,16 +7048,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xfe200f10) == 0xfc200800) {
-        /* VCMLA -- 1111 110R R.1S .... .... 1000 ...0 .... */
-        int size = extract32(insn, 20, 1);
-        data = extract32(insn, 23, 2); /* rot */
-        if (!dc_isar_feature(aa32_vcma, s)
-            || (!size && !dc_isar_feature(aa32_fp16_arith, s))) {
-            return 1;
-        }
-        fn_gvec_ptr = size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
-    } else if ((insn & 0xfea00f10) == 0xfc800800) {
+    if ((insn & 0xfea00f10) == 0xfc800800) {
         /* VCADD -- 1111 110R 1.0S .... .... 1000 ...0 .... */
         int size = extract32(insn, 20, 1);
         data = extract32(insn, 24, 1); /* rot */
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index 3aea7c5e188..d1d707a56d5 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -25,3 +25,14 @@
 # More specifically, this covers:
 # 2reg scalar ext: 0b1111_1110_xxxx_xxxx_xxxx_1x0x_xxxx_xxxx
 # 3same ext:       0b1111_110x_xxxx_xxxx_xxxx_1x0x_xxxx_xxxx
+
+# VFP/Neon register fields; same as vfp.decode
+%vm_dp  5:1 0:4
+%vm_sp  0:4 5:1
+%vn_dp  7:1 16:4
+%vn_sp  16:4 7:1
+%vd_dp  22:1 12:4
+%vd_sp  12:4 22:1
+
+VCMLA          1111 110 rot:2 . 1 size:1 .... .... 1000 . q:1 . 0 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


