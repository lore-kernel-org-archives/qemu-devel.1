Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D2C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448FD20851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eE4zt0pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448FD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQ8D-0001SF-8P
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60652)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOfB-0000d9-8V
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOeq-0005xC-2c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOep-0004ok-JI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id x15so9958768wmj.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gPYLikUR5ZuBlGRaNvlfd3hHYV0xbs6/Y2luBsY5Vwk=;
 b=eE4zt0pjr4qx+BpFhkcAeCPI92isygBNkRHQOVy999Vh5uXYpNFftLMZoQmQ5gpdWQ
 ruSIFkMcyogHbozDht+ZcMyzhZCiDNnhmP51dPEV47m7WfgXtWWJP8UB1/dk3c0JPEhg
 grRM/dGpilLzXbS9x7zv2GvF3MNwHjeO3b39tCxDPCTLRNizFVemAzB3+XPGOvJBcbfB
 nHZcSCQq/noQdayFX5fei3IPJiOkIcmd3XZ84y1fp2Ctoe+69IRs76k72L7hFe01DS/K
 /rw9pg0FbyWHB+ZsXerAkg+0gSE6VJWw+MDwZMPN+b4f+devMO+gJt6BUMHIKoAeL+lo
 uPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gPYLikUR5ZuBlGRaNvlfd3hHYV0xbs6/Y2luBsY5Vwk=;
 b=q6OUFB555oz6k3axINtOfwnwqYE4MOSizlUxBtH83CyxUqZcRZ+aavC/UC5ckehbDQ
 LDNnWe2T0fSR2qtvAd+V4VFBrjGU1ppX99vd2O8hqn0qRyxr8pqMc62KOF6Njp0Bf8I9
 Gb10KwC5zYsJoMNURZCYV41Wwai1wfykYz9P7rFvI0Xj5wEN9kcV0oqnqtiBEcx/4soh
 c5lafhMvlS6m5klbNW+kk6TwHE+D9gL8v49dFYL4+CVBDGJW1RDQN4Rwpcglju0kChAA
 bSuMUfTA01WJdsUwloImv/IaNQV+bXgxD82s1q2aDNxJGAXpRWPwsTeLuSVfh+tBRzxS
 7Pcg==
X-Gm-Message-State: APjAAAWDJj23LGAmoh8r6OJPeZyatM8Lj+0ueelEI9aVIH3G9cg2OITy
 j8aHwjdqBQ/pcFZyt5Jxas04O5USLsA7uA==
X-Google-Smtp-Source: APXvYqyADXbFI6wtcV1KdMkNyK7YN9y59zR/3cRaeqHGqNEcgIWjB3ag4S96nmu4ncOaZx0zA1fkDQ==
X-Received: by 2002:a05:600c:c6:: with SMTP id
 u6mr3589411wmm.153.1560428126721; 
 Thu, 13 Jun 2019 05:15:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:33 +0100
Message-Id: <20190613121433.5246-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 48/48] target/arm: Fix short-vector increment
 behaviour
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

For VFP short vectors, the VFP registers are divided into a
series of banks: for single-precision these are s0-s7, s8-s15,
s16-s23 and s24-s31; for double-precision they are d0-d3,
d4-d7, ... d28-d31. Some banks are "scalar" meaning that
use of a register within them triggers a pure-scalar or
mixed vector-scalar operation rather than a full vector
operation. The scalar banks are s0-s7, d0-d3 and d16-d19.
When using a bank as part of a vector operation, we
iterate through it, increasing the register number by
the specified stride each time, and wrapping around to
the beginning of the bank.

Unfortunately our calculation of the "increment" part of this
was incorrect:
 vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask)
will only do the intended thing if bank_mask has exactly
one set high bit. For instance for doubles (bank_mask = 0xc),
if we start with vd = 6 and delta_d = 2 then vd is updated
to 12 rather than the intended 4.

This only causes problems in the unlikely case that the
starting register is not the first in its bank: if the
register number doesn't have to wrap around then the
expression happens to give the right answer.

Fix this bug by abstracting out the "check whether register
is in a scalar bank" and "advance register within bank"
operations to utility functions which use the right
bit masking operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 100 ++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 8216dba796e..709fc65374d 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1139,6 +1139,42 @@ typedef void VFPGen3OpDPFn(TCGv_i64 vd,
 typedef void VFPGen2OpSPFn(TCGv_i32 vd, TCGv_i32 vm);
 typedef void VFPGen2OpDPFn(TCGv_i64 vd, TCGv_i64 vm);
 
+/*
+ * Return true if the specified S reg is in a scalar bank
+ * (ie if it is s0..s7)
+ */
+static inline bool vfp_sreg_is_scalar(int reg)
+{
+    return (reg & 0x18) == 0;
+}
+
+/*
+ * Return true if the specified D reg is in a scalar bank
+ * (ie if it is d0..d3 or d16..d19)
+ */
+static inline bool vfp_dreg_is_scalar(int reg)
+{
+    return (reg & 0xc) == 0;
+}
+
+/*
+ * Advance the S reg number forwards by delta within its bank
+ * (ie increment the low 3 bits but leave the rest the same)
+ */
+static inline int vfp_advance_sreg(int reg, int delta)
+{
+    return ((reg + delta) & 0x7) | (reg & ~0x7);
+}
+
+/*
+ * Advance the D reg number forwards by delta within its bank
+ * (ie increment the low 2 bits but leave the rest the same)
+ */
+static inline int vfp_advance_dreg(int reg, int delta)
+{
+    return ((reg + delta) & 0x3) | (reg & ~0x3);
+}
+
 /*
  * Perform a 3-operand VFP data processing instruction. fn is the
  * callback to do the actual operation; this function deals with the
@@ -1149,7 +1185,6 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
 {
     uint32_t delta_m = 0;
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i32 f0, f1, fd;
     TCGv_ptr fpst;
@@ -1164,16 +1199,14 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     }
 
     if (veclen > 0) {
-        bank_mask = 0x18;
-
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_sreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
             delta_d = s->vec_stride + 1;
 
-            if ((vm & bank_mask) == 0) {
+            if (vfp_sreg_is_scalar(vm)) {
                 /* mixed scalar/vector */
                 delta_m = 0;
             } else {
@@ -1204,11 +1237,11 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
-        vn = ((vn + delta_d) & (bank_mask - 1)) | (vn & bank_mask);
+        vd = vfp_advance_sreg(vd, delta_d);
+        vn = vfp_advance_sreg(vn, delta_d);
         neon_load_reg32(f0, vn);
         if (delta_m) {
-            vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+            vm = vfp_advance_sreg(vm, delta_m);
             neon_load_reg32(f1, vm);
         }
     }
@@ -1226,7 +1259,6 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
 {
     uint32_t delta_m = 0;
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i64 f0, f1, fd;
     TCGv_ptr fpst;
@@ -1246,16 +1278,14 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     }
 
     if (veclen > 0) {
-        bank_mask = 0xc;
-
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_dreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
             delta_d = (s->vec_stride >> 1) + 1;
 
-            if ((vm & bank_mask) == 0) {
+            if (vfp_dreg_is_scalar(vm)) {
                 /* mixed scalar/vector */
                 delta_m = 0;
             } else {
@@ -1285,11 +1315,11 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
         }
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
-        vn = ((vn + delta_d) & (bank_mask - 1)) | (vn & bank_mask);
+        vd = vfp_advance_dreg(vd, delta_d);
+        vn = vfp_advance_dreg(vn, delta_d);
         neon_load_reg64(f0, vn);
         if (delta_m) {
-            vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+            vm = vfp_advance_dreg(vm, delta_m);
             neon_load_reg64(f1, vm);
         }
     }
@@ -1306,7 +1336,6 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
 {
     uint32_t delta_m = 0;
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i32 f0, fd;
 
@@ -1320,16 +1349,14 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     }
 
     if (veclen > 0) {
-        bank_mask = 0x18;
-
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_sreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
             delta_d = s->vec_stride + 1;
 
-            if ((vm & bank_mask) == 0) {
+            if (vfp_sreg_is_scalar(vm)) {
                 /* mixed scalar/vector */
                 delta_m = 0;
             } else {
@@ -1355,7 +1382,7 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
         if (delta_m == 0) {
             /* single source one-many */
             while (veclen--) {
-                vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+                vd = vfp_advance_sreg(vd, delta_d);
                 neon_store_reg32(fd, vd);
             }
             break;
@@ -1363,8 +1390,8 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
-        vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+        vd = vfp_advance_sreg(vd, delta_d);
+        vm = vfp_advance_sreg(vm, delta_m);
         neon_load_reg32(f0, vm);
     }
 
@@ -1378,7 +1405,6 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
 {
     uint32_t delta_m = 0;
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i64 f0, fd;
 
@@ -1397,16 +1423,14 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     }
 
     if (veclen > 0) {
-        bank_mask = 0xc;
-
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_dreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
             delta_d = (s->vec_stride >> 1) + 1;
 
-            if ((vm & bank_mask) == 0) {
+            if (vfp_dreg_is_scalar(vm)) {
                 /* mixed scalar/vector */
                 delta_m = 0;
             } else {
@@ -1432,7 +1456,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
         if (delta_m == 0) {
             /* single source one-many */
             while (veclen--) {
-                vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+                vd = vfp_advance_dreg(vd, delta_d);
                 neon_store_reg64(fd, vd);
             }
             break;
@@ -1440,8 +1464,8 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
-        vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+        vd = vfp_advance_dreg(vd, delta_d);
+        vd = vfp_advance_dreg(vm, delta_m);
         neon_load_reg64(f0, vm);
     }
 
@@ -1783,7 +1807,6 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_sp *a)
 static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 {
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i32 fd;
     uint32_t n, i, vd;
@@ -1804,9 +1827,8 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
     }
 
     if (veclen > 0) {
-        bank_mask = 0x18;
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_sreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
@@ -1835,7 +1857,7 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+        vd = vfp_advance_sreg(vd, delta_d);
     }
 
     tcg_temp_free_i32(fd);
@@ -1845,7 +1867,6 @@ static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 {
     uint32_t delta_d = 0;
-    uint32_t bank_mask = 0;
     int veclen = s->vec_len;
     TCGv_i64 fd;
     uint32_t n, i, vd;
@@ -1871,9 +1892,8 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     }
 
     if (veclen > 0) {
-        bank_mask = 0xc;
         /* Figure out what type of vector operation this is.  */
-        if ((vd & bank_mask) == 0) {
+        if (vfp_dreg_is_scalar(vd)) {
             /* scalar */
             veclen = 0;
         } else {
@@ -1902,7 +1922,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+        vfp_advance_dreg(vd, delta_d);
     }
 
     tcg_temp_free_i64(fd);
-- 
2.20.1


