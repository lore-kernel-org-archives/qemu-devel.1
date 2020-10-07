Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE541C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E8620760
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2uowbmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E8620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQGFB-00048q-9d
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 16:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBo-0000JC-Uh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBn-0000fA-0E
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id d3so4020306wma.4
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WdyVXUc2deHqtDmYixw/LLsWT34INAaf3aGNIyqajvQ=;
 b=c2uowbmMmArlc5W/H31QV7rRo4wS/DXVGcHBYVeXfaUbZnzGcHVBGt8Wx3sBtlkrSM
 avXSsbGFOP3Iop0DIxuApBsCGoUhrIAKM81krjzXTMuAt6bXKZCCTwCWOmlYF9g85Tak
 As8nQ5HZrld48/IdlDv0/4Xp7WuzEavKqd9mGNlaVdRpltxkW7OCrXhNXpvTptnQIqX6
 SBAK8PCr8/FLx5bxhAMWkmn532j2CF1HHF78thDabBjZcXWP33cl7evjrx3mAPmaZZ+x
 arSACOFoXBI84t61ZAn/lECvYf1IF8LPYYD7JSt7U0ADsNmPQcVENHOAi6DdP6nHU0qy
 336A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WdyVXUc2deHqtDmYixw/LLsWT34INAaf3aGNIyqajvQ=;
 b=dxbXB3paTFO68DLeO47ZtnYC+OMmHwcDmwnQx5/HWkgCLjdieB5HITFz0toCUgj7K+
 d4z+clvQ1eCQ4gO7nkeOYS48lnvUkfYAouIn9Jd+0T+VJXaOFl2yuUFn6IyVLU6cIidJ
 8zA5WtW0CQRLbrHokvImY7JaQbBgO39YZlRNcjM1xxgLg1WQoz0MgW5/rNA1hsmyCTNE
 QozVV+EqgdTo22MySeDDBbEMWzGSR3mR68bRfQm0CBSCU5xHpoxZ3sYUdaVxleR1Glf6
 dRU4iTW8WLXgqx8u3uKNiTCYsftiVufGw8ZVreyPuSrjvCF2i3jHY7oOWkzR6TGW6kVa
 mSLg==
X-Gm-Message-State: AOAM533ZyKhXtcsatpEI08F4pBb0YEwjMQmffD2AOisUAKf8LM/Y9S7G
 Kv3wmL6JscGzssiN3JmkrBmJ/tZ8r1c=
X-Google-Smtp-Source: ABdhPJzj8GbBmUo8GHDFtNnSySFQAVmn/mxFvfb7LK6JGfKMxjq0lpuPGxQV3GlCD+oThB2Zi/60CQ==
X-Received: by 2002:a1c:8088:: with SMTP id b130mr4895175wmd.132.1602103049666; 
 Wed, 07 Oct 2020 13:37:29 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id d2sm4359083wro.34.2020.10.07.13.37.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 13:37:29 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>
Date: Wed,  7 Oct 2020 22:37:18 +0200
Message-Id: <1602103041-32017-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com, f4bug@amsat.org,
 jiaxun.yang@flygoat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 hpoussin@reactos.org, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove function definitions via macros to achieve better code clarity.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 63 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index f851723..b3c7154 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1666,25 +1666,54 @@ uint64_t helper_float_nmsub_ps(CPUMIPSState *env, uint64_t fdt0,
 }
 
 
-#define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-                                         uint ## bits ## _t fs,         \
-                                         uint ## bits ## _t ft,         \
-                                         uint ## bits ## _t fd)         \
-{                                                                       \
-    uint ## bits ## _t fdret;                                           \
-                                                                        \
-    fdret = float ## bits ## _muladd(fs, ft, fd, muladd_arg,            \
-                                     &env->active_fpu.fp_status);       \
-    update_fcr31(env, GETPC());                                         \
-    return fdret;                                                       \
+uint32_t helper_float_maddf_s(CPUMIPSState *env, uint32_t fs,
+                              uint32_t ft, uint32_t fd)
+{
+    uint32_t fdret;
+
+    fdret = float32_muladd(fs, ft, fd, 0,
+                           &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_maddf_d(CPUMIPSState *env, uint64_t fs,
+                              uint64_t ft, uint64_t fd)
+{
+    uint64_t fdret;
+
+    fdret = float64_muladd(fs, ft, fd, 0,
+                           &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_msubf_s(CPUMIPSState *env, uint32_t fs,
+                              uint32_t ft, uint32_t fd)
+{
+    uint32_t fdret;
+
+    fdret = float32_muladd(fs, ft, fd, float_muladd_negate_product,
+                           &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_msubf_d(CPUMIPSState *env, uint64_t fs,
+                              uint64_t ft, uint64_t fd)
+{
+    uint64_t fdret;
+
+    fdret = float64_muladd(fs, ft, fd, float_muladd_negate_product,
+                           &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
 }
 
-FLOAT_FMADDSUB(maddf_s, 32, 0)
-FLOAT_FMADDSUB(maddf_d, 64, 0)
-FLOAT_FMADDSUB(msubf_s, 32, float_muladd_negate_product)
-FLOAT_FMADDSUB(msubf_d, 64, float_muladd_negate_product)
-#undef FLOAT_FMADDSUB
 
 /* compare operations */
 #define FOP_COND_D(op, cond)                                   \
-- 
2.7.4


