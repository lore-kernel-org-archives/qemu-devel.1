Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F9ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC1D206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brs8qxFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC1D206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJycX-0005Ne-JS
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2E-0006n0-OK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2D-0005F5-E1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy2C-0005Ce-Sm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so19188014wrv.7
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LYziuWTaDyCvsXZWL+7dYTQAPkm19wADCHnlP8tL2bI=;
 b=brs8qxFczQtTd/1c2IMBukmhANpiz8431JaxL0m9HQOdhzQUK7mHLY3XI6mSuSj8zE
 kc7kAE/EZMWbMAs9y3el0MIUQGljPoTEgE5GYBfn/ssxFhgNsYJpW07ox3nj98pnZxf2
 kj9EZo3GGN8uSwObZiDpWgtYDrjMxAmJojgTs49PX/gr91nY+VMwHuAVa38qnkZwaJA0
 69lzulNLbnF2J3zrYfEWdBvC8oQ12lWWT5d7IDPpumVa+tY5HWyizIDA30LiVb+pp8aG
 wUoh4kGNbj0Fe1UdfgEa1AmpakXUvqMsBkd4nHutk52kfNOgAYSxLNNmZJ3hmjMsl1/A
 ufiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LYziuWTaDyCvsXZWL+7dYTQAPkm19wADCHnlP8tL2bI=;
 b=f0N0trPzCW9fYlxlBDvrht/z5QqXzAj0psJNmxz3uGEuBTr+BLgzFyo7hp7IEdcLcv
 H+ERdPiCne9/xBOWu5eFELFs9yyb5NR6x2glGwJHVszGBaBLALJDBzJbQmdkp7aH40t4
 aR5/bw2hXSmPif5yZDvO1Pl12fg3UtSiEz1owfL4ljtHEKWE2nhofMM4ZMWR51d8tOAV
 NpKuciTzUoFwnfmwoN7JyURS19NzP6Kt/5O+UejfjanH06GWR7SCUPnFRe48BtF8Oy00
 X0fQ+JKceyALL1nyrE+rNIdIKvkjfNaIAYJ8tgaSKM/AKc3VNlWKmbDYxJojv4xG4HWS
 525A==
X-Gm-Message-State: APjAAAWnSQLl3BB8G/pWH2VgsQPzr9Ln1bqyrgRWok8WSkzkZzz7c1gG
 ut+s8vlptOdnellWUBX96ZoIlw==
X-Google-Smtp-Source: APXvYqzbG/yK4d1iUIgfsX3LKUxHkYDRmbUoKvmNQrhRqYWcNqgk7nPxE9hwD0ZZ3kDlNCbTHWFftA==
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr11019845wrn.258.1571050622889; 
 Mon, 14 Oct 2019 03:57:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm17067030wmm.0.2019.10.14.03.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 482951FFB1;
 Mon, 14 Oct 2019 11:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 26/55] target/sh4: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:19 +0100
Message-Id: <20191014104948.4291-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

There is a small wrinkle with the gUSA instruction. The translator
effectively treats a (known) gUSA sequence as a single instruction.
For the purposes of the plugin we end up with a long multi-instruction
qemu_plugin_insn.

If the known sequence isn't detected we shall never run this
translation anyway.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sh4/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5a7d8c4535..922785e225 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1917,7 +1917,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 
     /* Read all of the insns for the region.  */
     for (i = 0; i < max_insns; ++i) {
-        insns[i] = cpu_lduw_code(env, pc + i * 2);
+        insns[i] = translator_lduw(env, pc + i * 2);
     }
 
     ld_adr = ld_dst = ld_mop = -1;
@@ -2332,7 +2332,7 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 #endif
 
-    ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+    ctx->opcode = translator_lduw(env, ctx->base.pc_next);
     decode_opc(ctx);
     ctx->base.pc_next += 2;
 }
-- 
2.20.1


