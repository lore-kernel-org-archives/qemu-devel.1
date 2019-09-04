Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A61C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BD920828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSddaqDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BD920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cgO-00080B-Ow
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9X-0006A1-Vn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9W-0006lB-B0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:19 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:42625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9W-0006kd-3P
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:18 -0400
Received: by mail-pl1-x630.google.com with SMTP id y1so84045plp.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ddiXQUCU6+mV9b5HLraEW0nl5fo+95ic0hgqPUZ1sNk=;
 b=MSddaqDmsvrs+IxiQ14B8VDMy7wNo0Vt2EYZJek1dggV55FDVT0x5GlL6VdgzTMJbF
 MZ6ITu1ZxAt5wF9NnqfKZpC6cXe4iABpMf06vO7spIL72gfM9Lc6mRq/0qL5rz7Zta8o
 uU/E/rUhTLzMwppzep0CN4Jr40qIEdDorlKLqkavJ17VNaBxRLyhEXDlQGvmDKc3Vcw3
 ktnpyndyd+qQQ53KAKQZScG1vw2/ljECNAYMposijavMiD6+tdYUJ52B/bxkPVy8195T
 fgPqz5owYB9BVfwXfz7Dri6xE9W0MTkUMexTNelWBJOjUo8Gh078podmqKKDxF5PGfwp
 HvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ddiXQUCU6+mV9b5HLraEW0nl5fo+95ic0hgqPUZ1sNk=;
 b=pj1aJHC05FpLTjxWuJVl0gt2t60+F516VfNwyPv1L79maAOPcGm893l0K+h8ZGwIIl
 etFkfO1qb6GB52a49Lk4uVgXGSLF6Pl/mw6T5sFiDjpLw/owAW4K6b0W7VSR21/gLciW
 5F+Ve0L0QSdwWJJ6j1SzBbymcSqaTQMy8JGKGaaAYqAmYSKYJTqpggaW5o0NdlGq1DE5
 GZFLIOZzcIpZ4IaTFr/TgOdEV2ig5LZl3rfMJdR3nNk5fEZ4dmefVxEAtkGHyQj7ApCU
 7xBeMyExOAiA2/NN84IpPAW3hgda8/N6TJQFx1V/z9CsDiVJQPgC5uB6sQEkWFPXsQcJ
 2WpQ==
X-Gm-Message-State: APjAAAVxuVCRGAQHVLz2r1eIbjZ1uaASHYjg0mrfa2gCLW+ms5in0VtU
 SkVkG5UFp+JbWTQ4FEo7SLlh3SE1KUg=
X-Google-Smtp-Source: APXvYqwkZjoiyyWMGTdG56oMaWgURYtLJW7ZrM7zvQcaTbXF+PbxrKS8lAM0gaOySDvqIJp7lpZ+pQ==
X-Received: by 2002:a17:902:ab96:: with SMTP id
 f22mr43907220plr.147.1567629916793; 
 Wed, 04 Sep 2019 13:45:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:45:00 -0700
Message-Id: <20190904204507.32457-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
Subject: [Qemu-devel] [PULL 06/13] target/openrisc: Add VR2 and AVR special
 processor registers
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the CPUCFG bits to arch v1.3.
Include support for AVRP for cpu "any".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h        | 11 +++++++----
 target/openrisc/cpu.c        |  8 ++++++--
 target/openrisc/sys_helper.c |  6 ++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 18d7445e74..71c5959828 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -96,11 +96,12 @@ enum {
     CPUCFGR_OF32S = (1 << 7),
     CPUCFGR_OF64S = (1 << 8),
     CPUCFGR_OV64S = (1 << 9),
-    /* CPUCFGR_ND = (1 << 10), */
-    /* CPUCFGR_AVRP = (1 << 11), */
+    CPUCFGR_ND = (1 << 10),
+    CPUCFGR_AVRP = (1 << 11),
     CPUCFGR_EVBARP = (1 << 12),
-    /* CPUCFGR_ISRP = (1 << 13), */
-    /* CPUCFGR_AECSRP = (1 << 14), */
+    CPUCFGR_ISRP = (1 << 13),
+    CPUCFGR_AECSRP = (1 << 14),
+    CPUCFGR_OF64A32S = (1 << 15),
 };
 
 /* DMMU configure register */
@@ -280,6 +281,8 @@ typedef struct CPUOpenRISCState {
 
     /* Fields from here on are preserved across CPU reset. */
     uint32_t vr;              /* Version register */
+    uint32_t vr2;             /* Version register 2 */
+    uint32_t avr;             /* Architecture version register */
     uint32_t upr;             /* Unit presence register */
     uint32_t cpucfgr;         /* CPU configure register */
     uint32_t dmmucfgr;        /* DMMU configure register */
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index d9f447e90c..9f566ad883 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -126,9 +126,13 @@ static void openrisc_any_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
-    cpu->env.vr = 0x13000000;
+    cpu->env.vr = 0x13000040;   /* Obsolete VER + UVRP for new SPRs */
+    cpu->env.vr2 = 0;           /* No version specific id */
+    cpu->env.avr = 0x01010000;  /* Architecture v1.1 */
+
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;
-    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_EVBARP;
+    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S |
+                       CPUCFGR_AVRP | CPUCFGR_EVBARP;
 
     /* 1Way, TLB_SIZE entries.  */
     cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2))
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index a2b1f52294..cf8e637b08 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -210,6 +210,12 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
     case TO_SPR(0, 4): /* IMMUCFGR */
         return env->immucfgr;
 
+    case TO_SPR(0, 9): /* VR2 */
+        return env->vr2;
+
+    case TO_SPR(0, 10): /* AVR */
+        return env->avr;
+
     case TO_SPR(0, 11): /* EVBAR */
         return env->evbar;
 
-- 
2.17.1


