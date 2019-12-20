Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A591C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34254222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbBrSTaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34254222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJP0-0003Bz-6w
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJFB-00050d-UL
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJFA-0007hU-IE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:05 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJFA-0007dk-9u
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:04 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so9605286wrw.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dTAik/55XqF6jZEApcTun6adu0lplKSvcNyPRiElySM=;
 b=jbBrSTaS/8Jnb7aAX3hzxvXCKcQoCm0mmQ9lhRbfudQxTvEdkSTbxtMgQo2peeoYsB
 DBut85jeI7qeFJOeJaHlDEQX6kuWDW3ijetIxwbIulDbmj+pQ1sUw048Ma/CDfWt0ioQ
 meMV6yabMAZ+vNpeXWHybprgOkdkJjE8PWT9zyJ0DBa/kwPXJwxt2Hs2JLQRMT3sU1jF
 3AmBMawNSES4r28OmyFvaXdRcmvA91M2pYFpI8IONAXzPgtSVUW41dDoP1pl9+0KofXh
 jee94JCEhhs0+nZVeUtjyMPu3KkOU6fVRll3DM+Q8C22+z6JM9616N0Ar3assPWYFw5h
 rfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dTAik/55XqF6jZEApcTun6adu0lplKSvcNyPRiElySM=;
 b=UEk/jZUHKGgZr5OvnZHLgUnF30wUvL730d18H5G7MYmXxB//26NVQq5Aalid4lQwhR
 +k32ePbWAvBhob1VoZbIYz7izx+VT54FFYQc5ZS+DI2b7KsJ9ObXyDlEGPCIr+3jzs0l
 SGvJ+AUFw5FoHsLv8hCcVhnRchMbtQ0QFjYoDqVyevGpMJtqsGn0o2kEDbM5C3F1MilN
 f/WytB9SIxpMmLSFN95ADij9sq7GteMzzTVhg5iJAibLUJa3B0nQlKL5D4Ja94FHTXt9
 /iabpOBvYW+ohPUYHQDw4L9jElJne0hRtGjFCXsJo9x1rF2jCsWx6ybalAC89usuvll7
 4NuQ==
X-Gm-Message-State: APjAAAXvstJTS7BmP9D+XVqPfF171bOgwZsJAU/ubPcbNlAeQr91ZpNI
 rSyPaudtvSAxcfLUXul1yoCb7nasxM7SuA==
X-Google-Smtp-Source: APXvYqy/AasgQHzF4RgNYOlpa4nCvkQsnrgtuONRyDjR09EuFg1SPJWScsjrUxGnZUTF6XEBqBH8fg==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr16799576wrc.84.1576852022990; 
 Fri, 20 Dec 2019 06:27:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.27.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:27:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] arm/arm-powerctl: rebuild hflags after setting CP15 bits
 in arm_set_cpu_on()
Date: Fri, 20 Dec 2019 14:26:44 +0000
Message-Id: <20191220142644.31076-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niek Linnenbank <nieklinnenbank@gmail.com>

After setting CP15 bits in arm_set_cpu_on() the cached hflags must
be rebuild to reflect the changed processor state. Without rebuilding,
the cached hflags would be inconsistent until the next call to
arm_rebuild_hflags(). When QEMU is compiled with debugging enabled
(--enable-debug), this problem is captured shortly after the first
call to arm_set_cpu_on() for CPUs running in ARM 32-bit non-secure mode:

  qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:
  Assertion `flags == rebuild_hflags_internal(env)' failed.
  Aborted (core dumped)

Fixes: 0c7f8c43daf65
Cc: qemu-stable@nongnu.org
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-powerctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index b064513d44a..b75f813b403 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -127,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
         target_cpu->env.regs[0] = info->context_id;
     }
 
+    /* CP15 update requires rebuilding hflags */
+    arm_rebuild_hflags(&target_cpu->env);
+
     /* Start the new CPU at the requested address */
     cpu_set_pc(target_cpu_state, info->entry);
 
-- 
2.20.1


