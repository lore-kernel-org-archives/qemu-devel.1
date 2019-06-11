Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D3FC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0DD20673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDv3GQGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0DD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafHK-0004ii-JT
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQR-0007fa-RU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQL-0007t7-Qk
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQL-0007gR-Dz
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so12477164wrm.8
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ArclSEoRm2zBs6YVh3NYURVc6boo9wJxlzan6nD1jCM=;
 b=MDv3GQGDV37DbvwmtT3ayV+ug4cRNFprEwYhiO9vyIq/QSwpVWWDXY4P4uyH78y0oA
 BfB6mX0lss1ov48mInGJnxc6sV1kg7SUDkil+BdmQbD7bJWJaVtTJfiNK2Zt5xu4YhhM
 rRUU84N1eqSubhzPGH7IcSO43r6fcFGT3I/M69rUUsyTEsb7uBJ4Skjx53P72HQqKwEq
 w+g6UNQXZ5P8YdaBK/yn22mjp0uzwE8O8Ycej9T3Q5bfcHIHoFeo7zZonLAYX8w94PcI
 ozrCeiAosJJPlMxcoNCNffbx7sy46nubkOrw1TkpKktGZWrt17e7GkZlVxu/acHfsg/M
 0Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ArclSEoRm2zBs6YVh3NYURVc6boo9wJxlzan6nD1jCM=;
 b=obTOplNsR6m8xpuuARcITgIpks+gEUHTKKWVcjvaAMWupl90SPb9TNYSSJJ8hzSuR9
 Ec3WreOjs1qzDizXKKaVzgIsOsB4e2qAOEw1CsoDWYjCJNY8bZ+tEtd9z7F+cYb+9tje
 f9Vs1GG+dFWn7UV8nUoXH4ReGk9iAE0uJBffkRTzCJQ0tZ1hEaDPLpGBF9gcs9HqsKkX
 1pD7PGmoF5XvTWIP68S41sQE4mw+PiX0ts2vBgpIdskE1uFfd0E/K71NDGrrJpc6eLrl
 0JxiC9SxT7qzTqHkxop3y71StHJpJkmB2a8c6IkG4pKjxc1sJMQJy1e/fbOSdvk2x85S
 iToQ==
X-Gm-Message-State: APjAAAWzrD1HAKI7+YNtd4cMiGL5D7u3FT8zz8/b022yZB3UCbyfC4IU
 vPwy9urjJCBy6Ha454vYozt/Pg==
X-Google-Smtp-Source: APXvYqyx4CattQKl99YU0yMP2TI4ixz54oaylVr+9sIwu4ONbdK9gsKwQ+zq0cc+EBY6duAljK1c6g==
X-Received: by 2002:a5d:5510:: with SMTP id b16mr14634904wrv.267.1560250467310; 
 Tue, 11 Jun 2019 03:54:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:40 +0100
Message-Id: <20190611105351.9871-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 31/42] target/arm: Convert VSQRT to
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

Convert the VSQRT instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 20 ++++++++++++++++++++
 target/arm/translate.c         | 14 +-------------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 6e06b2a130a..ae2f77a873b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1908,3 +1908,23 @@ static bool trans_VNEG_dp(DisasContext *s, arg_VNEG_dp *a)
 {
     return do_vfp_2op_dp(s, gen_helper_vfp_negd, a->vd, a->vm);
 }
+
+static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
+{
+    gen_helper_vfp_sqrts(vd, vm, cpu_env);
+}
+
+static bool trans_VSQRT_sp(DisasContext *s, arg_VSQRT_sp *a)
+{
+    return do_vfp_2op_sp(s, gen_VSQRT_sp, a->vd, a->vm);
+}
+
+static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
+{
+    gen_helper_vfp_sqrtd(vd, vm, cpu_env);
+}
+
+static bool trans_VSQRT_dp(DisasContext *s, arg_VSQRT_dp *a)
+{
+    return do_vfp_2op_dp(s, gen_VSQRT_dp, a->vd, a->vm);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b0eecb6ca8f..ce805f0ab28 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1390,14 +1390,6 @@ static inline void gen_vfp_neg(int dp)
         gen_helper_vfp_negs(cpu_F0s, cpu_F0s);
 }
 
-static inline void gen_vfp_sqrt(int dp)
-{
-    if (dp)
-        gen_helper_vfp_sqrtd(cpu_F0d, cpu_F0d, cpu_env);
-    else
-        gen_helper_vfp_sqrts(cpu_F0s, cpu_F0s, cpu_env);
-}
-
 static inline void gen_vfp_cmp(int dp)
 {
     if (dp)
@@ -3098,7 +3090,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 1 ... 2:
+                case 1 ... 3:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3112,7 +3104,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
                 case 0x00: /* vmov */
-                case 0x03: /* vsqrt */
                     break;
 
                 case 0x04: /* vcvtb.f64.f16, vcvtb.f32.f16 */
@@ -3290,9 +3281,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 0: /* cpy */
                         /* no-op */
                         break;
-                    case 3: /* sqrt */
-                        gen_vfp_sqrt(dp);
-                        break;
                     case 4: /* vcvtb.f32.f16, vcvtb.f64.f16 */
                     {
                         TCGv_ptr fpst = get_fpstatus_ptr(false);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 79e41963be4..2780e1ed9ea 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -166,3 +166,8 @@ VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 .... \
              vd=%vd_sp vm=%vm_sp
 VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+VSQRT_sp     ---- 1110 1.11 0001 .... 1010 11.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VSQRT_dp     ---- 1110 1.11 0001 .... 1011 11.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1


