Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B633C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E4621974
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYNqj7Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E4621974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYxm-0001ZE-C3
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLK-00006u-7u
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLJ-0002BU-46
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:06 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:46578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLI-0002BD-W7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:05 -0400
Received: by mail-qv1-xf41.google.com with SMTP id m2so3682300qvu.13
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gn2vKDOISxQzKy44RYpzzeOAg/5NGEBTOA6wtcYZvN4=;
 b=VYNqj7Ca7sixDpGYMj4s0ON0k8TeueL7Ixj2iEQ5qaZdmqJ+aOnfDnSEXScM3dJGln
 N4cETPw6lGQipk04Hc3L8kj1AFo7mum7mPgSCY1hRBcRZB+dCJ4BdTOxlTXKLDWpg3yt
 FVyDvd8ZG/da1SsKUXltGn5RP9souo3aLH2dx72JTv7OTNtiRySPBrAigFB9krs0AFg6
 cvIv7lMiKw3XRsnEdfRk3jN1JPN9Ho+kT+Nh/go4o18GOQOCD1UIArfFbSkAOH+6WrN/
 weDynpi6C9WE12GyOJlN5CKfHUrxd9qd9ISngvrjC6Qr1XEGnY9lqmI6ZJFH/pMwaAnh
 11YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gn2vKDOISxQzKy44RYpzzeOAg/5NGEBTOA6wtcYZvN4=;
 b=kkhFYrnP+OEixOcxcfsftS5M39HSYwVWdd6R7pUVgemxeF+lgkpYGkBYEaCTY0HbMN
 q9h4A+bx+r43SEzSICB0Cri3k6ZW5dy+tZEOFJSVdExiKdvgT4ixzzTUDUTw9yI8SCYN
 QJNxujAPtrB4WVaOtzXICO8pTJsgMf+RRZXX/BQDfIIvc1NSWD380szPD/ptPhxJ/p2q
 79VrP1Qn5sOn+g42tc9MYv3UR/kvX1LNdHprYC4EQlM2uwksEMnKmbsL/e9x5kBTMDRu
 1wfqntpEpkjd+4cHSFhGP5EMIl82bYEOvlmu8sZqp/V1YOn8PuptyzptuvvPeUCq2opt
 WzLw==
X-Gm-Message-State: ANhLgQ21X3Y266uIBiSIcl4KxFiBu5dKjUifJ240vr7tMv8hhsCzyYQA
 92VBr+2vxFaROvMZ1Ljh97+4tAMCnilJbw==
X-Google-Smtp-Source: ADFU+vveyLMzHzv3D4mKRPIPRdiIUu4nzkcr390Ssqmr1ZKxlgXwghQxK4e5innwxrMRywjabkvyaw==
X-Received: by 2002:a0c:e886:: with SMTP id b6mr10019948qvo.31.1585251543992; 
 Thu, 26 Mar 2020 12:39:03 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:03 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 65/74] mips: convert to cpu_has_work_with_iothread_lock
Date: Thu, 26 Mar 2020 15:31:47 -0400
Message-Id: <20200326193156.4322-66-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/mips/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 761d8aaa54..ec9dde5100 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -58,6 +58,8 @@ static bool mips_cpu_has_work(CPUState *cs)
     bool has_work = false;
     uint32_t interrupt_request = cpu_interrupt_request(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     /*
      * Prior to MIPS Release 6 it is implementation dependent if non-enabled
      * interrupts wake-up the CPU, however most of the implementations only
@@ -193,7 +195,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->has_work = mips_cpu_has_work;
+    cc->has_work_with_iothread_lock = mips_cpu_has_work;
     cc->do_interrupt = mips_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
     cc->dump_state = mips_cpu_dump_state;
-- 
2.17.1


