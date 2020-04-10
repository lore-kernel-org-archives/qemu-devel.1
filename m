Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324BAC2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 21:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC6A206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 21:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjOSl4CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC6A206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jN0za-0000sJ-3y
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 17:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thatlemon@gmail.com>) id 1jN0yo-0000Rj-Bk
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 17:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thatlemon@gmail.com>) id 1jN0yn-0008Iv-09
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 17:14:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1jN0ym-0008IL-Qk
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 17:14:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id a201so3709420wme.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=7NaCZfGbnI+t2U7Xbj8v0zNXcOrVcmVpjg9+zAdGUk8=;
 b=WjOSl4CDZrrZWqEZCqvKHUYcCRmkutYHktJKyzvZ1jMsHrh/YwkBIVptTUuBW6JcP9
 Vbnre9Ltbi6YUa4lfpSb/ZxDXPsoNHitQo1ji7VLgtiy2B5jQVki59BSweoZQYOxvYRU
 CNC6HBL684/iCrCB3B+04ZMEM/DNfAqP6IzL8WRcNL9yUcK3Qnr6KtL3TM3xhAPGOFN0
 JkNPidSflTCU/X5RWtoM9S7xScsX29uMkv+C5iNg6diiteWQJU7grIejEWxxULT4KUye
 3AUgyWGVeGRg7fBSAUmiJ3rBD8FHW9FEsA0Hkhb37IpedWA4gqxzl+syTI0fBjzNDeE2
 HRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=7NaCZfGbnI+t2U7Xbj8v0zNXcOrVcmVpjg9+zAdGUk8=;
 b=lYJISPyK2uGwe2Bki3vGAuTuWulpPtOR7VJuTb6QuJq7U+rQ8Xt0RXAE93+5cLwTZ5
 EIT3RFbi/ThKYdQ7jG3uCVi3QRYa1lhNc4PyujB9dwvujG16qYEFzRFRzCSq/lzIR39A
 U1ilTr6pZfLErh9SVsHOwdz57ghkuE2zPFXBqQzUYgGJmeOcNhZb8tzx8QGFAxiJh4I6
 xHkZ41/bNBVG6UeCFqi2PDRXWmdmMg6F2wXPykOtOECqw1zd12FhELIZLSgiQcmYWdMz
 nBtCczXFEL1TsirtW9z9P4HiqXBa03KKY+HZCyuZ4+eaQn+uXBRBoCRUBjG4CgDO+arn
 SLLA==
X-Gm-Message-State: AGi0PuZN3g8lDQx13yBQOTVpvR9oRbpBmcr/7jmhj7V121ZbTQ6w1Vuu
 HrYgMFcCsI2SntKoD6EC/wQ=
X-Google-Smtp-Source: APiQypK0JO8AFDGHsAJWQfeQX8KMPXq/qot27XUs/F1Ns7AlUMtSoB5Y6hVGsGRhNnyJY5P8NJs/rw==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr6917518wmc.69.1586553262959; 
 Fri, 10 Apr 2020 14:14:22 -0700 (PDT)
Received: from [192.168.1.199] ([93.55.111.29])
 by smtp.gmail.com with ESMTPSA id n18sm4088066wmk.6.2020.04.10.14.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 14:14:22 -0700 (PDT)
To: qemu-devel@nongnu.org, laurent@vivier.eu, richard.henderson@linaro.org
From: LemonBoy <thatlemon@gmail.com>
Subject: [PATCH] linux-user/sparc64: Translate flushw opcode
Message-ID: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
Date: Fri, 10 Apr 2020 23:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

From 11d0cfe58d12e0f191b435ade88622cfceb2098a Mon Sep 17 00:00:00 2001
From: LemonBoy <thatlemon@gmail.com>
Date: Fri, 10 Apr 2020 22:55:26 +0200
Subject: [PATCH] linux-user/sparc64: Translate flushw opcode

The ifdef logic should unconditionally compile in the `xop == 0x2b` case
when targeting sparc64.

Fix the handling of window spill traps by keeping cansave into account
when calculating the new CWP.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
 bsd-user/main.c             | 4 +++-
 linux-user/sparc/cpu_loop.c | 4 +++-
 target/sparc/translate.c    | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 770c2b267a..d6b1c997e3 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -413,7 +413,9 @@ static void save_window(CPUSPARCState *env)
     save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
     env->wim = new_wim;
 #else
-    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
+    /* cansave is zero if the spill trap handler is triggered by `save` and */
+    /* nonzero if triggered by a `flushw` */
+    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
     env->cansave++;
     env->canrestore--;
 #endif
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7645cc04ca..20a7401126 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -69,7 +69,9 @@ static void save_window(CPUSPARCState *env)
     save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
     env->wim = new_wim;
 #else
-    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
+    /* cansave is zero if the spill trap handler is triggered by `save` and */
+    /* nonzero if triggered by a `flushw` */
+    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
     env->cansave++;
     env->canrestore--;
 #endif
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9416a551cf..1a4efd4ed6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 #endif
                 gen_store_gpr(dc, rd, cpu_tmp0);
                 break;
+#endif
+#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
             } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
 #ifdef TARGET_SPARC64
                 gen_helper_flushw(cpu_env);
-- 
2.20.1


