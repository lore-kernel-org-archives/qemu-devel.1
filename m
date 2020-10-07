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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A14C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19E020760
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxLJ6FG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19E020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQGCu-0001Zn-ID
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 16:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBn-0000It-Ua
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBm-0000f4-Dv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id e2so4035475wme.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GafXqa426HzZ2OyxbkkhzXpXgv6Bqp75Rh5uU2w03mw=;
 b=MxLJ6FG793Xg5O6NA/4J1hntNX3P+yt+kgjKoa6+XNNwJfg4pan6YeiA+Dr66YKKr3
 QBnWQpHXeqxET9MEW18wIzIx20nLJaZonQ+wZV6YGTkAY8r40P4AFEcw0A6IIOiN85r8
 SuX5IzzVngwVOohiWViUOooFBG7Dr/eCHDxCvtKjIYe46Riobz1K5UkMmOh9O1ovJg9P
 fNVFikoCFSovH9uNG3JXCS0b5v2GBJ7vXxcTN9tXziFg9syun8AMwvt7xfyq3cyKDyLY
 bP5er4hJkmMgRjOYm1jzaUEng5OkySYHjM9qhjw5mT0KJJR1KqTTrEWNxaqYvUCBtTpc
 5BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GafXqa426HzZ2OyxbkkhzXpXgv6Bqp75Rh5uU2w03mw=;
 b=rPPnDjcaiv5xxEIupo5/vETpXsAfHJwCkbsB0ASjp+rApn+Vq4R8EFR/IhnCI8ZLEb
 PrbJJXsNh2FIR+TaCIG2SaZtVP8Jykr6FDoSJf+qq9x9u0zY4yDV57oRlxMgYjuxc5kW
 92XmDxceb/qAwaNcRXC3lMKiLH9nl0m0pfsUATABYhXjC9cNgYUU/CnrkdSdrc64N2YJ
 7XExlAsxMpAAD+KpK2+OswHQ1uS3k1veuoxyjP/XHuuIL0GEXgShzpPnCfJrTErDBj0b
 pUamss6x4o3hgCWHeKd03GSyt3QvQSz8r4WY3Jmn+hUHldv03k4cfAzXgmNJO6QSQNKj
 JXlQ==
X-Gm-Message-State: AOAM532Y2nT9nGK+0MI5zoExGlkSBaqnutJwRD+qTZyrQde2VHms42Nd
 FSx88utJFBM3f2MiRBjqMxlIEXOSG8c=
X-Google-Smtp-Source: ABdhPJxw9zJ/H8vHFRKX09VYq2XxKeiPTeKkGXC+BQTiJFJwHwhAKIL9A0JS285vL5k0AlTF3U8Y/Q==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr5005318wmc.142.1602103048849; 
 Wed, 07 Oct 2020 13:37:28 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id d2sm4359083wro.34.2020.10.07.13.37.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 13:37:28 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>
Date: Wed,  7 Oct 2020 22:37:17 +0200
Message-Id: <1602103041-32017-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
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
 target/mips/fpu_helper.c | 61 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 56beda4..f851723 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -983,27 +983,46 @@ uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0)
 }
 
 /* unary operations, not modifying fp status  */
-#define FLOAT_UNOP(name)                                       \
-uint64_t helper_float_ ## name ## _d(uint64_t fdt0)                \
-{                                                              \
-    return float64_ ## name(fdt0);                             \
-}                                                              \
-uint32_t helper_float_ ## name ## _s(uint32_t fst0)                \
-{                                                              \
-    return float32_ ## name(fst0);                             \
-}                                                              \
-uint64_t helper_float_ ## name ## _ps(uint64_t fdt0)               \
-{                                                              \
-    uint32_t wt0;                                              \
-    uint32_t wth0;                                             \
-                                                               \
-    wt0 = float32_ ## name(fdt0 & 0XFFFFFFFF);                 \
-    wth0 = float32_ ## name(fdt0 >> 32);                       \
-    return ((uint64_t)wth0 << 32) | wt0;                       \
-}
-FLOAT_UNOP(abs)
-FLOAT_UNOP(chs)
-#undef FLOAT_UNOP
+
+uint64_t helper_float_abs_d(uint64_t fdt0)
+{
+   return float64_abs(fdt0);
+}
+
+uint32_t helper_float_abs_s(uint32_t fst0)
+{
+    return float32_abs(fst0);
+}
+
+uint64_t helper_float_abs_ps(uint64_t fdt0)
+{
+    uint32_t wt0;
+    uint32_t wth0;
+
+    wt0 = float32_abs(fdt0 & 0XFFFFFFFF);
+    wth0 = float32_abs(fdt0 >> 32);
+    return ((uint64_t)wth0 << 32) | wt0;
+}
+
+uint64_t helper_float_chs_d(uint64_t fdt0)
+{
+   return float64_chs(fdt0);
+}
+
+uint32_t helper_float_chs_s(uint32_t fst0)
+{
+    return float32_chs(fst0);
+}
+
+uint64_t helper_float_chs_ps(uint64_t fdt0)
+{
+    uint32_t wt0;
+    uint32_t wth0;
+
+    wt0 = float32_chs(fdt0 & 0XFFFFFFFF);
+    wth0 = float32_chs(fdt0 >> 32);
+    return ((uint64_t)wth0 << 32) | wt0;
+}
 
 /* MIPS specific unary operations */
 uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
-- 
2.7.4


