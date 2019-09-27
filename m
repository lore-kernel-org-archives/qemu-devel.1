Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6306C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBB720863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3ehUJMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBB720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwGS-0005Ch-Ix
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5w-0003VG-Rw
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5u-0006bd-Fy
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:00 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5t-0006aE-L4
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id e5so1467620pls.9
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rx79XawZGOGKLwUeTUnrPs0Kyi9mUgl/u4ZwkL557D8=;
 b=X3ehUJMvQYNgN5E3I7BzldjZNcAqijjYHlRG0D8sVRaKSQKLBe7tbHOR1zVGqMEGkg
 iN2XZ/TyFvFQ4a7Cy0TcFEKX++s111GYVg2KYSKfs8MZkP4W4C+X1gz9gRin9cTmwo7R
 N2unCEUNn8nzgpiAfDsKuQaGMCqOBj07vDUGhLkCFle3APJN7r5lCFSbvODfn8JRrDz1
 cmeYuYFpLPbOFOVYfwdVaVJ2HAu7IT9VT16GjV1p+nx23CzH+a6pUYS4Jx+ZfeR3tIzi
 f9Q28lk7XTgRkC55EGylcT9rGrXv6qoJsLkBQAUlAw+YXaTdMLsySDAyZv6Rq1eVi9yS
 Pb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rx79XawZGOGKLwUeTUnrPs0Kyi9mUgl/u4ZwkL557D8=;
 b=aD2aXCPqaVP6RjsdhIjKi9d21gEJeaST1Jduk3HFZTTHpocN5eRLfHV3UnZDoWv5m9
 4wVmdXvkzS4TaRKUBc4+so29BhH7hVg4Q/aPPnr4Y7XeSs7EK3/yIuXBow/cyoAl6yAj
 0+DcxaGKITsMpQO+xzQ0+okYgvvmMT8ipkvRyCQhW2xXAVKTXdDdfaY5QLQekgG6GYXU
 S+a/UtDdlNAcWiWv+lBaXh+3a7Zd6hbiQl8ugcNk6g0/z5Z7pgMGYMZX4uLu4qCMOJcM
 WR1XT9IM2JvjZGBG+1fLSANmusaKU3hfzDDsPlJgkMp8f0GUtKeG7eVo82zvBHcyZr66
 NoCQ==
X-Gm-Message-State: APjAAAUXUllHjfz2BjPybyR1UnteVig5bxNyHxUKLmU9JAjtLtH3kr4a
 ZdtN1QDSYbOzYFBM0fnWETMurW9O3Xg=
X-Google-Smtp-Source: APXvYqwKqlF7U7FLdfywPymNbPiKIBudOQg3T9trivk/OpAOTzQ2lr+jYik05A5VY3hj1BnDc4hnVQ==
X-Received: by 2002:a17:902:8f88:: with SMTP id
 z8mr6695031plo.232.1569613195850; 
 Fri, 27 Sep 2019 12:39:55 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/18] target/s390x: Remove ILEN_AUTO
Date: Fri, 27 Sep 2019 12:39:22 -0700
Message-Id: <20190927193925.23567-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This setting is no longer used.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h         | 2 --
 target/s390x/excp_helper.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 67126acc99..686cbe41e0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -805,8 +805,6 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
 /* instruction length set by unwind info */
 #define ILEN_UNWIND                 0
-/* automatically detect the instruction length */
-#define ILEN_AUTO                   0xff
 #define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 8ce992e639..c252e9a7d8 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -196,9 +196,6 @@ static void do_program_interrupt(CPUS390XState *env)
     LowCore *lowcore;
     int ilen = env->int_pgm_ilen;
 
-    if (ilen == ILEN_AUTO) {
-        ilen = get_ilen(cpu_ldub_code(env, env->psw.addr));
-    }
     assert(ilen == 2 || ilen == 4 || ilen == 6);
 
     switch (env->int_pgm_code) {
-- 
2.17.1


