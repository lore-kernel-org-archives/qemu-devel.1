Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A546FCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A09A206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tR1NLsNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A09A206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYp5u-0008G0-Kq
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp18-0008VO-L9
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:38 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp17-0000Oy-MT
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:38 -0400
Received: by mail-lf1-x143.google.com with SMTP id x73so13229883lfa.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u+u2GTLpTwv9NrMPHkakKvWn/ABYNzXl/Rjh49VH7qg=;
 b=tR1NLsNET1KOND1jVWrydTwAO5Tytz9Schs1DRaimaES0j1AT3+54TVhLEMdeyRYaM
 Z7TkUfd1LsDW2tjvARj2pF4SeszjSECFB4HUZNZHmjs9bh8j+iZVNdJs+fWmStX7nPA1
 7U5/jEfFtTQK+/9Uw8VdFAI5a5v0bplTVJ+MDpqEagLSIrlDpq9uL1MnVTwHec9wwedx
 J1pDNRmXeXB4yBDrAGU2Irja1d7mzdVp3oaN/UYDo5MsBcVltN/iZrVl+9DAyoKpYVqu
 Hn6fIqcILqNgtGc25ttght1XALrZmjth6rPwiEuUoK1hb6t3tWPWyc3Qzp+UKD9iWXO2
 JNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u+u2GTLpTwv9NrMPHkakKvWn/ABYNzXl/Rjh49VH7qg=;
 b=ly6Ly017QbDEQNrI9pG/j+sy/7qPqWMkRtshqMDthl0Yl6GjQartVEZLvvMyeG6AP+
 d84uv4e7+V9w08/RK9Z3cwDUSdZADDqApO+64419YmdGhbfUa+jG9V0fOWSKfMjfADy7
 bJGsgtjhN9oEOBNKQxKMPBPyK9Awh/VsBWn+VJuvTSp3d2geqLZcymONcLFFK6YtnnL0
 c87hHC0sAzr5Z2fUVJrlgUGVGqFpEZZVm2Ez4Rv679qCruqtiUix1RqYFzGdO1qxeEyy
 cyZgaXgS+LvIoYeARyIqUy0rrE4YFs9PUmj9RZzf1NvqcjsbJc92pAh2tI8ugfxzMwtn
 kMsw==
X-Gm-Message-State: AOAM533NSQCsgE/2KELAcW+80yc7p1u6xmlw/sxM3C3LtSQZL9ZOkOH5
 UwE+XxNVrzzQV98H4w2mINOYvaCDeB0=
X-Google-Smtp-Source: ABdhPJzYIqfbpGHBnmTB9PYmJff/M30DsD/cf7AdKY3UixireeWUKL+gqTlQIlkfQp4bjZw01W1iqg==
X-Received: by 2002:ac2:464c:: with SMTP id s12mr17263936lfo.147.1589367215847; 
 Wed, 13 May 2020 03:53:35 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id z64sm15749417lfa.50.2020.05.13.03.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 03:53:35 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/12] target/mips: fpu: Demacro DIV.<D|S|PS>
Date: Wed, 13 May 2020 12:52:59 +0200
Message-Id: <20200513105307.22638-5-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
References: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 449e945166..2759c9989d 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
@@ -1319,6 +1318,42 @@ uint64_t helper_float_mul_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_div_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_div(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_div_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_div(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_div_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_div(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_div(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.20.1


