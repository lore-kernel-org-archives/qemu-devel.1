Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41761C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167722083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvqDhxVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167722083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwbj-00036a-Bm
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:55:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTs-0004CF-Ep
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTp-0003h7-Gs
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTn-000358-JW
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so3297472wrw.13
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VVY23NUYf6hml3iiJOP9cZFQC9OmaRTh9VCnK8KY7K8=;
	b=QvqDhxVrlbh0pyQTtEEIgOgaAoYZt1PrMWJoF5V1NSZ29w7FONx02btRnQRugrOkG4
	0ppGv77XbSMCSVViSUA7hfrCeRzi17nS9gdG5KQl3N4FOyqpDs2TVYnRbGEa3XLLFuqR
	7XNyOI3OmpJPFqQ+HDqhlLyaI65yvflktXU60YYDz6BZ4ZQIoCOY/Afq8haEjkxAY7u/
	dc3+IqE0OQ2dAXTeb3cwPY9DPVZCgDVMfcdvcbB/oM+exk+RfVbsuZgJ3j+us8nTk3oi
	oUw8rUo9BJaQIkyjCap75uNZ9jesMy0o9IIWv1otch06YKFH/qHDDUq89I/vFwN7ZVbw
	pCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=VVY23NUYf6hml3iiJOP9cZFQC9OmaRTh9VCnK8KY7K8=;
	b=HFhC5uAFmNvtjCZHzsEJdv8Yd31sVDK20JVfAxz7EGjsvGIStJYs8gV/HD81GpPINC
	Khuvlq2CSiXxUekH2RkpTAII2jI2s6nLkA7F+VBO/708tDZf3hHLasO3xFccVs1fVYEr
	Z7WZfL1gSwfAiD9U7tWQ4/cvPDyqgqwm0GnbqYKDmJf5264tY+3sKnYuAk39Ljayjwch
	foP9i2Rz+vq7dKYUt0pD8LDDkYEaTeLV6GqTgUiZYdILovcpT+4KOMxLrmKxqf9cqgd6
	5Ehq9qF+DWpi97zEPuJKmt7YcDZFVjEhke5FXO5XNcWpcFuxhz3hbAYwM/o34UVmCnN5
	gxew==
X-Gm-Message-State: APjAAAVxv3T7iyIMe0ez46xHpumVKnjB/uMnMb6ylmQMg8XoO5LbP5sd
	lNCZSrt21de/Fe6H0HlncQUa2KU63oV9QA==
X-Google-Smtp-Source: APXvYqzeesYm4Jrb1GF9cH79ZSrzOwl5OZ4CBfp1qPdmTu2QLwByLIg7uWKU6OCPy4BsUED343Ltdw==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr13044625wrw.26.1559843194725; 
	Thu, 06 Jun 2019 10:46:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:48 +0100
Message-Id: <20190606174609.20487-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 21/42] target/arm: Convert VFP VNMLA to
 decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP VNMLA instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 19 +------------------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 1d7100debe4..8532bf4abcd 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1383,3 +1383,37 @@ static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
 }
+
+static void gen_VNMLA_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /* VNMLA: -fd + -(fn * fm) */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_muls(tmp, vn, vm, fpst);
+    gen_helper_vfp_negs(tmp, tmp);
+    gen_helper_vfp_negs(vd, vd);
+    gen_helper_vfp_adds(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VNMLA_sp(DisasContext *s, arg_VNMLA_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_VNMLA_sp, a->vd, a->vn, a->vm, true);
+}
+
+static void gen_VNMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
+{
+    /* VNMLA: -fd + (fn * fm) */
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_helper_vfp_muld(tmp, vn, vm, fpst);
+    gen_helper_vfp_negd(tmp, tmp);
+    gen_helper_vfp_negd(vd, vd);
+    gen_helper_vfp_addd(vd, vd, tmp, fpst);
+    tcg_temp_free_i64(tmp);
+}
+
+static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index bb86c603712..73b30ed33d1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1393,16 +1393,6 @@ VFP_OP2(div)
 
 #undef VFP_OP2
 
-static inline void gen_vfp_F1_neg(int dp)
-{
-    /* Like gen_vfp_neg() but put result in F1 */
-    if (dp) {
-        gen_helper_vfp_negd(cpu_F1d, cpu_F0d);
-    } else {
-        gen_helper_vfp_negs(cpu_F1s, cpu_F0s);
-    }
-}
-
 static inline void gen_vfp_abs(int dp)
 {
     if (dp)
@@ -3122,7 +3112,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 2:
+            case 0 ... 3:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3308,13 +3298,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 3: /* VNMLA: -fd + -(fn * fm) */
-                    gen_vfp_mul(dp);
-                    gen_vfp_F1_neg(dp);
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_neg(dp);
-                    gen_vfp_add(dp);
-                    break;
                 case 4: /* mul: fn * fm */
                     gen_vfp_mul(dp);
                     break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 08e4f427408..c50d2c3ebf3 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -112,3 +112,8 @@ VNMLS_sp     ---- 1110 0.01 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


