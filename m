Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD5C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F0C20673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWJ2XzSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F0C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haf5s-0003jB-4n
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39580)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQN-0007Y1-9l
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQK-0007qb-KA
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQK-0007lw-9Q
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id z23so2381268wma.4
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8DDr7wU5Mf7FhJNHoQYd6MgxVhRgKHpZJzl/r4VHltc=;
 b=sWJ2XzSXfgOq+HIiZxOjagrZLTKeBuNbzyT1ZEMWS1B3XcZYRuCWS4DG0t/5Rmcmrf
 Hs1rqcUGn7W8KOxqzpaF7WU5nI+pgqY0VP8FVmEwFYIYN2Aq8CPCbinDVjC5s4qoftRS
 Yw5X2JLClSRNtH8JTIbHoqC7+f1hl1gI3ljq1sByRq/wL0kVheS/AExR6iJp2SbgnWTk
 2MdgGNVqjqDv8sKwNc8TWC7E0ahjclVhDvtdjfaZhQryBDeMpxJWN4i/V8TzrKN9mCrb
 8kv5GcvvEG0D+CIl+LVT4KbryBrGz4wtDNj00Rk96Ubm3Vf+AHBFIAEu4ztgivxxyZGe
 B05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8DDr7wU5Mf7FhJNHoQYd6MgxVhRgKHpZJzl/r4VHltc=;
 b=gExMgTPqMRM15jbtUmlEufsn6tfVTsz3ZIrswSNisGEXBezWvb12rA6SCPDufQqT7R
 U/KSjp/cYq1ePM55knn9uPhw31+pRx3i+pX7OIJfFqs82AfyyqynQJdz/KoqYUxdrQeM
 xhOzoAeqR5YBXhBwAMbxPLboPxKBCSwSV4iklh3t3d9yf0SjFgSElcYPqy317tpZ10Pg
 YTfh1ehpG4Rz0fAOgvggJZfIhEG4rPigfCk8zIuuOk6HEusFSMWh89zLfGSonKa1mIEg
 S3Hvg9xrc02fPRJGWkTDLWHUoHGWuUOG9Xat7liwM/Ob34XP6kqJ9DjeFk5Ys7rGPnj+
 qwnA==
X-Gm-Message-State: APjAAAVRsrIywA5fuoe2Faq4uGaTZ8pAWcOaokKmMx3fepD6r341Pu+P
 tOcHY72yVrBD/mNUWP0tlfTIPq+IM+WHhg==
X-Google-Smtp-Source: APXvYqxXET+CDJoOXQi7nHPPUzYJOzfajDWiMOCHqp/VvlrQv+UmT1tTit2r1n0N3ic2Pnik8tXJPA==
X-Received: by 2002:a1c:e009:: with SMTP id x9mr17209422wmg.5.1560250475482;
 Tue, 11 Jun 2019 03:54:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:48 +0100
Message-Id: <20190611105351.9871-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 39/42] target/arm: Convert VJCVT to
 decodetree
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

Convert the VJCVT instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 28 ++++++++++++++++++++++++++++
 target/arm/translate.c         | 12 +-----------
 target/arm/vfp.decode          |  4 ++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index cc3f61d9c41..161f0fdd888 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2426,3 +2426,31 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
+{
+    TCGv_i32 vd;
+    TCGv_i64 vm;
+
+    if (!dc_isar_feature(aa32_jscvt, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i64();
+    vd = tcg_temp_new_i32();
+    neon_load_reg64(vm, a->vm);
+    gen_helper_vjcvt(vd, vm, cpu_env);
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i64(vm);
+    tcg_temp_free_i32(vd);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1e28308aa6a..99b436ad6f7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 17:
+                case 0 ... 19:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3085,13 +3085,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     rm_is_dp = false;
                     break;
 
-                case 0x13: /* vjcvt */
-                    if (!dp || !dc_isar_feature(aa32_jscvt, s)) {
-                        return 1;
-                    }
-                    rd_is_dp = false;
-                    break;
-
                 default:
                     return 1;
                 }
@@ -3177,9 +3170,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 19: /* vjcvt */
-                        gen_helper_vjcvt(cpu_F0s, cpu_F0d, cpu_env);
-                        break;
                     case 20: /* fshto */
                         gen_vfp_shto(dp, 16 - rm, 0);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 6da9a7913da..1a7c9b533de 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -220,3 +220,7 @@ VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
              vd=%vd_dp vm=%vm_sp
+
+# VJCVT is always dp to sp
+VJCVT        ---- 1110 1.11 1001 .... 1011 11.0 .... \
+             vd=%vd_sp vm=%vm_dp
-- 
2.20.1


