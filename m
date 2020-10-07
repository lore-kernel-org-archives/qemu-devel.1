Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41130C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DAB2076B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjU/asJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DAB2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQGH9-000650-NW
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 16:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBp-0000Jp-Iq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBn-0000fJ-S8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id d3so4020340wma.4
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r3/rSCh3jhq16EB/hphjSjdQbSC7ReeHLcOA6oj1Fv0=;
 b=HjU/asJ4DXc3+hwFqPPD3/S7b3ChVsUju82hsMo7gpLA0wOuOP9TPl0es2uNQuoOeq
 9Pok0bBetgKIYIFtgDn0fzRC9QnbQBTftjeUwNi6IPIwIhoqc76r+Tj5EO+8grZAoxi3
 KnoFCDqo/DDWEoomIKxrQxF5xC5y90Fxke+EhVbcjhmLzFl9JFlbhf0EHX52HWlD1Bd1
 l2nEAJ44FbVQhLMfX5UpF3ifkJ0cN/Uuuh0YyH9zoClptUFNFdTls9f3yWdTRL4dwdw9
 3kCNsBq0JdCeq21bZSdr9vfs1EhISfWiAhAUrLV+V7alQSCB+Z+IR9oMnq4WhLruFrgd
 v70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=r3/rSCh3jhq16EB/hphjSjdQbSC7ReeHLcOA6oj1Fv0=;
 b=Yaez0PDMTz+CzEgVHkC3P92FaNMpexsXhhXeDK4gl7sU9Pfthq++YygvNOpmEH46wI
 YyvZnSoOmGw68wYSaHwGYFmoyDu6ii+H7+kzLcB3SRvByekRAEifYsi5vvuv7fT6Z/8Q
 dfse6dFIQaB3DIyeQneQ7EkWHAEce3uyP1PZteZbsvaGIK3xAIYbX1cSIAlgnucLQJNx
 YWFmfaxwAMznSi5ldHTjB+x17Q8DeLssxr0C1g9Fecmg8sYM1O4Micx3jESj46EIi7wO
 WoUg8lNqw9z0vtx/oRpmbGb2wAo12deL2Djvr/mVz1xvzlfNqCtJIBSSYIOxAvIP7fIW
 fqbQ==
X-Gm-Message-State: AOAM532BqRIzU6ZT/kkcRn0+UgAyIBKIzSB1nkf+VcF8kVOSbYUYo2ci
 0fb40HcW90GgBrJ/OQVcxF/oYrJAOq8=
X-Google-Smtp-Source: ABdhPJxKl7SetxXIvcgISz+oCiMhfPi5pjTbUfVA3fYz+CqT/3dRYGRCdRJaoTNsmpcMg0a1EX0Pqg==
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr5008690wmf.152.1602103050465; 
 Wed, 07 Oct 2020 13:37:30 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id d2sm4359083wro.34.2020.10.07.13.37.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 13:37:30 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] target/mips: Demacro helpers for
 <MAX|MAXA|MIN|MINA>.<D|S>
Date: Wed,  7 Oct 2020 22:37:19 +0200
Message-Id: <1602103041-32017-4-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
 target/mips/fpu_helper.c | 104 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 81 insertions(+), 23 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index b3c7154..6cc956c 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1475,29 +1475,87 @@ uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
     return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
-#define FLOAT_MINMAX(name, bits, minmaxfunc)                            \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-                                         uint ## bits ## _t fs,         \
-                                         uint ## bits ## _t ft)         \
-{                                                                       \
-    uint ## bits ## _t fdret;                                           \
-                                                                        \
-    fdret = float ## bits ## _ ## minmaxfunc(fs, ft,                    \
-                                           &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                         \
-    return fdret;                                                       \
-}
-
-FLOAT_MINMAX(max_s, 32, maxnum)
-FLOAT_MINMAX(max_d, 64, maxnum)
-FLOAT_MINMAX(maxa_s, 32, maxnummag)
-FLOAT_MINMAX(maxa_d, 64, maxnummag)
-
-FLOAT_MINMAX(min_s, 32, minnum)
-FLOAT_MINMAX(min_d, 64, minnum)
-FLOAT_MINMAX(mina_s, 32, minnummag)
-FLOAT_MINMAX(mina_d, 64, minnummag)
-#undef FLOAT_MINMAX
+
+uint32_t helper_float_max_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_maxnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_max_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_maxnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_maxa_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_maxnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_maxa_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_maxnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_min_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_minnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_min_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_minnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_mina_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_minnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_mina_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_minnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
 
 /* ternary operations */
 
-- 
2.7.4


