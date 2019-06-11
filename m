Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A08C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF86520896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWjiRNZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF86520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafW3-0003vL-RU
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39971)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQd-0007sv-JZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQW-00084D-2w
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQV-0007l2-Q0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id c6so2405626wml.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kVKIoFWbneLBSnXC8j5sTcaVOKy6BEkeJ62qtn6SHIs=;
 b=xWjiRNZnt1lI5dWIBti/RuGrGxAlYXLsV72Fmz61JROZ62gL7oB5orPXBizWMufHjz
 wRq+IJVuLnPUK7bnNUBO7+tW9O0dC5jcJwe3qwLdsLTpWehJTogXjDPeQCfx3VRB6YlO
 4Wgi/Jh0mdexxa4+8xsJg+SiRHbbyLXRHkPlECEuRT0w5R8zaM0CP3oorBugoauK/DpT
 0mdcBJugt3EpVa9TxrVPAYmoG8kZU8TQ30V3qtz6AqrP6PQK7PxAeCK29tOgwvKY5saC
 rLmRcec3ATtsKtIvYIgW9UDqjvBqXdMbowSWvY1UROtrKibJZRzFaNWQR7zJt+zEBHGO
 CRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kVKIoFWbneLBSnXC8j5sTcaVOKy6BEkeJ62qtn6SHIs=;
 b=BnybPvghP41Cfdu6qAxOg68eDWJYKAtmuWI1v4YkMwPLJ+5+DnmK3epNwyuYMddVQj
 Yd0P8zqdBsPgEVd1VLGTjikB2OGV+Y7OuJmGi+GWR2u284buzPu4fHxFe7tZrrl/afoo
 UHnAimaRjlvVo8IPj8/mjx/aH/TLm48DH3KL51q3ZQtRGbd/R26TZIQPJCeHMaK8beKg
 CxnaJH/JxUepQ872AUyThvoJEOTyoTCLMtmGvXEVdCxdrQ1PLKrlrU/CYGwMrXz7F6zU
 UzdUnHVM9g+nQ3AgAco9EJhdrYLXG0TMLJh297Knvx/seugjONRZfrWIRKrADNComRxY
 8jlw==
X-Gm-Message-State: APjAAAVbSxcckguMrcX+Bs45r3Gzz/8wRVQaWJvC7uIRuLNs1MJgsdQO
 BmTYbq/gIL4R3tHZ303ycylpreWqK+zb5g==
X-Google-Smtp-Source: APXvYqxzdPdgzne4bBbKweDqoIJJO+vGv4Cq/0z9PaM0MNQZmHQKzMz4ke2gg8KurHIMn52x8yy+LQ==
X-Received: by 2002:a1c:9dc4:: with SMTP id g187mr15866026wme.86.1560250474395; 
 Tue, 11 Jun 2019 03:54:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:47 +0100
Message-Id: <20190611105351.9871-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 38/42] target/arm: Convert integer-to-float
 insns to decodetree
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

Convert the VCVT integer-to-float instructions to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 58 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 12 +------
 target/arm/vfp.decode          |  6 ++++
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index c50093776b6..cc3f61d9c41 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2368,3 +2368,61 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     tcg_temp_free_i64(vm);
     return true;
 }
+
+static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
+{
+    TCGv_i32 vm;
+    TCGv_ptr fpst;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    neon_load_reg32(vm, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    if (a->s) {
+        /* i32 -> f32 */
+        gen_helper_vfp_sitos(vm, vm, fpst);
+    } else {
+        /* u32 -> f32 */
+        gen_helper_vfp_uitos(vm, vm, fpst);
+    }
+    neon_store_reg32(vm, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
+{
+    TCGv_i32 vm;
+    TCGv_i64 vd;
+    TCGv_ptr fpst;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    vd = tcg_temp_new_i64();
+    neon_load_reg32(vm, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    if (a->s) {
+        /* i32 -> f64 */
+        gen_helper_vfp_sitod(vd, vm, fpst);
+    } else {
+        /* u32 -> f64 */
+        gen_helper_vfp_uitod(vd, vm, fpst);
+    }
+    neon_store_reg64(vd, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_i64(vd);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 05ee76da77c..1e28308aa6a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 15:
+                case 0 ... 17:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3063,10 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x10: /* vcvt.fxx.u32 */
-                case 0x11: /* vcvt.fxx.s32 */
-                    rm_is_dp = false;
-                    break;
                 case 0x18: /* vcvtr.u32.fxx */
                 case 0x19: /* vcvtz.u32.fxx */
                 case 0x1a: /* vcvtr.s32.fxx */
@@ -3181,12 +3177,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 16: /* fuito */
-                        gen_vfp_uito(dp, 0);
-                        break;
-                    case 17: /* fsito */
-                        gen_vfp_sito(dp, 0);
-                        break;
                     case 19: /* vjcvt */
                         gen_helper_vjcvt(cpu_F0s, cpu_F0d, cpu_env);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 56b8b4e6046..6da9a7913da 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -214,3 +214,9 @@ VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 .... \
              vd=%vd_dp vm=%vm_sp
 VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+# VCVT from integer to floating point: Vm always single; Vd depends on size
+VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
+             vd=%vd_dp vm=%vm_sp
-- 
2.20.1


