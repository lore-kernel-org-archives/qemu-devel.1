Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01129C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF0A20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MulPUpNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF0A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDukE-0006TI-V3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXm-0003hx-VJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXl-0002El-AS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:50 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtXk-0001zm-Ft
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id t13so12653886wmi.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UdceRZMx4YDGn36m/TuGYIDWW+EU+85/3c2Xpq92Mq4=;
 b=MulPUpNL8G/3/1U06g8BTkaE+/mzMxNTnL2VmFXU8p7nCCYilNDJvsQWkcXAQijNCM
 89wsw19RD1O8qdK1qOHJqwreYyG6IaR/ooK4lju1Xq4ZHPDqoaGcky05pZ2h73FFhGar
 Kuj/1lPL7i0j0umFV6f5/BjZM9dS3OcyE60bDKdz4VHIQ13ALq3xEjeWKlYbWyITquao
 AaulHVfT/M0+CDdXXhUJsHfXnEJQF7dik0XM8jGXIh5R/LHNxOMAEL+O3YgLf79SOOgy
 9W+K3G97GnNYB+vA1GyG+zVBlc7nagtS0yvlMIw33/uTrNgOUxq6cj6gpgjb1D1Oo6T3
 otZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UdceRZMx4YDGn36m/TuGYIDWW+EU+85/3c2Xpq92Mq4=;
 b=dihgJ+TUyUkzg5HSzG1HWTLMqjf+uXMkYu19mZw3PK9Ypl/wB/jlYC93iMdvo+BH6n
 G7HuCpZtdrgcbKLTCUidVtKJdY2tJckyMcq3V9Hwt1ZebYuH6GRQ0zG36UCdWmvBBfb1
 yY3ka4SyzwMVE+bulbQDl2S6I+1hkA3CV/q5AAKh4iBN1RRU7TOb1sPu+Uryk9uSCAuz
 DVEVrC+taNArITT0BV+bSSjw6eJn2ObOgX0YqkYiDJY02RwMRaWqAtqjRmjaUq4sYZZT
 QwVUcr8pO3WcwotBAdqKRmU2shMMPD8ZGGdnnSS7QuZaWY3JiCvSg/ufyp5NKrpauvWa
 3Tkw==
X-Gm-Message-State: ANhLgQ0tgbC6Y6AgHlSgo4YmGF2DKHMmAv5LaLR1+uCtn5Mt+bkCvUTg
 qDygQU5uhbaeeRUcQz7FOqNbhA==
X-Google-Smtp-Source: ADFU+vv2jDKSKL3Rarpps/8WQFaa6eZxefrGPoWqJveV/Uz99vq/uO5cqjYJ/pwH76k52abi5IkyjQ==
X-Received: by 2002:a7b:c454:: with SMTP id l20mr154054wmi.189.1584379722327; 
 Mon, 16 Mar 2020 10:28:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm440424wme.32.2020.03.16.10.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:28:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0010B1FFA5;
 Mon, 16 Mar 2020 17:21:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 17/28] target/arm: default SVE length to 64 bytes for
 linux-user
Date: Mon, 16 Mar 2020 17:21:44 +0000
Message-Id: <20200316172155.971-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel chooses the default of 64 bytes for SVE registers on
the basis that it is the largest size on known hardware that won't
grow the signal frame. We still honour the sve-max-vq property and
userspace can expand the number of lanes by calling PR_SVE_SET_VL.

This should not make any difference to SVE enabled software as the SVE
is of course vector length agnostic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - tweak zcr_el[1] instead
v7
  - better form
---
 target/arm/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3623ecefbd9..0909ce86a12 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -195,9 +195,10 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
         /* and to the SVE instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
-        /* with maximum vector length */
-        env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
-                             cpu->sve_max_vq - 1 : 0;
+        /* with reasonable vector length */
+        if (cpu_isar_feature(aa64_sve, cpu)) {
+            env->vfp.zcr_el[1] = MIN(cpu->sve_max_vq - 1, 3);
+        }
         /*
          * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
          * turning on both here will produce smaller code and otherwise
-- 
2.20.1


