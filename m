Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C7C31E54
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF892133D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh8slPvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF892133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcW7y-0003Ft-Uy
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 10:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3k-0001B1-Au
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3h-0006Vt-Oc
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:03 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hcW3f-0006S9-Oi
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:01 -0400
Received: by mail-pg1-x544.google.com with SMTP id n2so4278578pgp.11
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=0MqVozo2FcpsM5UIMBcKfqeELOfw9A1xwN8au1paC1o=;
 b=Qh8slPvAwDndbnzbKXxO+ODFwVN8neMbx/0NSiR02tsHlhuwx4MRbenKMeszdEVRY4
 UKwfwLIBPvHM32gfUJWwT5qtHcwMaISUoWYJQ3UCeyXIPbrRpP91D3nwp/1CbXJoKC2s
 RvFB30QUH9YbWo8NQXaG8To4/aNRMIxUJxvM6S0wpGxvb435fp5EY99Rjf78wYXtws36
 rlWbnnSOb+fEuNDPeHydd3RWs9HY0EUyvGP1preqSSl5876sebgFcF6fz9y/bRjPG+Nc
 uZqCimhF3vo1WU9wTrXCCcRn0yzhUlX+aUnYdLpT1EZZNRvfe4DHxMNbW6WbkAEPb3+3
 VVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=0MqVozo2FcpsM5UIMBcKfqeELOfw9A1xwN8au1paC1o=;
 b=oFWG0VJqzu8Fq/6tJffrxv58/EpzRq3lztgOqcD9EB31s23Au/jwC3lmKBNcbjrJ6W
 RX3wskt3u9gxKRLbvTgifm5zYtexTIC2sakvYzbTVAhm7Ia97wapDYB4lHzzb1q1rARD
 YlM5mRrXO4VQITJkyyjCC2sSX25SrnsRU4At0kqcK/2xnlmB1u8/mJt/PduvKH04DovQ
 VrKG1ARzemBsOC7ygjXzPIGfp3MOQDxZDuvnTSsg3but/iVySs337UZcRn0ch9VK22bY
 Wiol7L2zJg/nKOQiGzIlyY394l8XzpumAISIZ6jX2wqrc3hEfg8X4LHlzYEP+BRVDIzH
 EqHA==
X-Gm-Message-State: APjAAAVbIMA1DJFYCfFw8hRykmTgitJYFvBmQvzd7Zl06tSnkcJLJXsk
 4VU5ZdlFGP0SLWvpqgnrquO+/vXY
X-Google-Smtp-Source: APXvYqyVKgD85cMYVY16zofSLxOtj1ndyGR0zi229udhRKhObTmuJ71F1pO+TYI4JDbfVZK+zcECQw==
X-Received: by 2002:a17:90a:cb87:: with SMTP id
 a7mr22012804pju.130.1560694977257; 
 Sun, 16 Jun 2019 07:22:57 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id m41sm11779672pje.18.2019.06.16.07.22.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 07:22:56 -0700 (PDT)
Date: Sun, 16 Jun 2019 23:22:53 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <20190616142253.GA71203@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 2/6] Cascade m68k_features by
 m680xx_cpu_initfn() to improve readability
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

The m680XX_cpu_initfn functions have been rearranged to cascade starting from
the base 68000, so that the 68010 then inherits from this, and so on until the
68060.

This makes it simpler to track features since in most cases the m68k were
product enhancements on each other, with only a few instructions being retired.

Because each cpu class inherits the previous CPU class, then for example
the 68020 also has the feature 68010, and 68000 and so on upto the 68060.

- Added 68010 cpu class, and moved correct features into 68000/68010.
- Added m68k_unset_feature to allow removing a feature in the inheritence
- Created real m68030_cpu_initfn to replace the macro define
  for more obvious calling/future expansion

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
---
 target/m68k/cpu.c | 58 +++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index cc770a8042..f3246d6e72 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -42,6 +42,11 @@ static void m68k_set_feature(CPUM68KState *env, int feature)
     env->features |= (1u << feature);
 }
 
+static void m68k_unset_feature(CPUM68KState *env, int feature)
+{
+    env->features &= (-1u - (1u << feature));
+}
+
 /* CPUClass::reset() */
 static void m68k_cpu_reset(CPUState *s)
 {
@@ -119,6 +124,21 @@ static void m68000_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
 
+
+/*
+ * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
+ */
+static void m68010_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m68000_cpu_initfn(obj);
+    m68k_set_feature(env, M68K_FEATURE_RTD);
+    m68k_set_feature(env, M68K_FEATURE_BKPT);
+}
+
+
 /*
  * Adds BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST, CAS, CAS2,
  *      CHK2, CMP2, DIVSL, DIVUL, EXTB, PACK, TRAPcc, UNPK.
@@ -130,9 +150,7 @@ static void m68020_cpu_initfn(Object *obj)
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
-    m68k_set_feature(env, M68K_FEATURE_M68000);
-    m68k_set_feature(env, M68K_FEATURE_USP);
-    m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
+    m68010_cpu_initfn(obj);
     m68k_set_feature(env, M68K_FEATURE_QUAD_MULDIV);
     m68k_set_feature(env, M68K_FEATURE_BRAL);
     m68k_set_feature(env, M68K_FEATURE_BCCL);
@@ -142,10 +160,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_LONG_MULDIV);
     m68k_set_feature(env, M68K_FEATURE_FPU);
     m68k_set_feature(env, M68K_FEATURE_CAS);
-    m68k_set_feature(env, M68K_FEATURE_BKPT);
-    m68k_set_feature(env, M68K_FEATURE_RTD);
     m68k_set_feature(env, M68K_FEATURE_CHK2);
-    m68k_set_feature(env, M68K_FEATURE_MOVEP);
 }
 
 /*
@@ -156,7 +171,14 @@ static void m68020_cpu_initfn(Object *obj)
  * NOTES:
  *  5. Not valid on MC68EC030
  */
-#define m68030_cpu_initfn m68020_cpu_initfn
+static void m68030_cpu_initfn(Object *obj)
+{
+    M68kCPU *cpu = M68K_CPU(obj);
+    CPUM68KState *env = &cpu->env;
+
+    m68020_cpu_initfn(obj);
+}
+
 
 /*
  * Adds: CINV, CPUSH
@@ -180,7 +202,7 @@ static void m68040_cpu_initfn(Object *obj)
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
-    m68020_cpu_initfn(obj);
+    m68030_cpu_initfn(obj);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
@@ -200,20 +222,11 @@ static void m68060_cpu_initfn(Object *obj)
     M68kCPU *cpu = M68K_CPU(obj);
     CPUM68KState *env = &cpu->env;
 
-    m68k_set_feature(env, M68K_FEATURE_M68000);
-    m68k_set_feature(env, M68K_FEATURE_USP);
-    m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
-    m68k_set_feature(env, M68K_FEATURE_BRAL);
-    m68k_set_feature(env, M68K_FEATURE_BCCL);
-    m68k_set_feature(env, M68K_FEATURE_BITFIELD);
-    m68k_set_feature(env, M68K_FEATURE_EXT_FULL);
-    m68k_set_feature(env, M68K_FEATURE_SCALED_INDEX);
-    m68k_set_feature(env, M68K_FEATURE_LONG_MULDIV);
-    m68k_set_feature(env, M68K_FEATURE_FPU);
-    m68k_set_feature(env, M68K_FEATURE_CAS);
-    m68k_set_feature(env, M68K_FEATURE_BKPT);
-    m68k_set_feature(env, M68K_FEATURE_RTD);
-    m68k_set_feature(env, M68K_FEATURE_CHK2);
+    m68040_cpu_initfn(obj);
+    m68k_unset_feature(env, M68K_FEATURE_MOVEP);
+
+    /* Implemented as a software feature */
+    m68k_unset_feature(env, M68K_FEATURE_QUAD_MULDIV);
 }
 
 static void m5208_cpu_initfn(Object *obj)
@@ -350,6 +363,7 @@ static const TypeInfo m68k_cpus_type_infos[] = {
         .class_init = m68k_cpu_class_init,
     },
     DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("m68010", m68010_cpu_initfn),
     DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
     DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
     DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
-- 
2.21.0



