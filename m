Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08245C2D0E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFDD20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3GOUiY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFDD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYXp-0006e7-VB
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKT-00076K-3n
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKR-0001fG-Iy
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:12 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730]:45394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKR-0001f0-El
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:11 -0400
Received: by mail-qk1-x730.google.com with SMTP id c145so8137522qke.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WKDXF12eCfqBVh1t7+XUM9Jd9M2ESQhEyFamPNrVDo4=;
 b=p3GOUiY8BPNk0kEheILZlfCInV3V1aOu6wkxcHBiRtL1+73fhHqc6SHWXd5lOTyAuB
 +p6hft87tWgFeVnhiQjyKzGaYT0VZgfgwKbFSwSVqZk0YdWFYWM7NwHL5r1OW2KUlV98
 08JTNORqp/uGzCwmemvMdTWugBrgz96vpYWZFIDftcIO2Q9B7j+ftv8t2GjOXphk8I42
 MnLbPTZ7UvUODLg/9QhpDmllEiiHdsPhIGEeMiem1OZHtrdf0dR0xs7wTzhWWJjwhcSV
 UiLcvB7HGwH2PvktAvqNMwFt2+MJcc436l5CfuC1ysd/DNo5/TuFFUyTBUocyXmo4r01
 UYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WKDXF12eCfqBVh1t7+XUM9Jd9M2ESQhEyFamPNrVDo4=;
 b=FQ7NTKQM/z2CN3rkt8etbVR/mCi+q+3M9kH2NwpdmTjXUnrnMFvWn4Upi3e+6mjJbm
 XIelQb7c8iyropdx6RxUSYe7SPeapYIReZ4n9hDOubm3rGOzT5ERttPnTYQpHY+nBtAx
 3ZflrlPEcJrxH2hXw+qAeyjPlWFaQI1DZnMp6pXonMWbtxYHjks52DeFkFumYm1n4tdB
 Dfgx0frVxe2wkcWrmbLnrwxbyJ+e62XNfRhBxIP18UO7bx8ZnP1CMCpiIeve6oZShdvk
 RxXAmbGe09xGj9/x9oWJsKmtMyw6dBRBGD2H9xVm+u75J0vQi5GNCSCxMg2QLndbLUTW
 svKw==
X-Gm-Message-State: ANhLgQ044mId4fPYpNiT6dTPX3tlBQaapEfSgF+8IBWp9vmd7zdAVTAS
 cgZPVuB1VU/TiFjtk7YSPb/nhZ637N8duQ==
X-Google-Smtp-Source: ADFU+vur2jydqqUMf3iBdO6Ms7iNUhr2RU5B5jExYTCmguMG20mxeCt2EIcrfGsifSKqGh0+Jb5JfA==
X-Received: by 2002:a37:7002:: with SMTP id l2mr10338297qkc.372.1585251490553; 
 Thu, 26 Mar 2020 12:38:10 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:09 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 27/74] sparc: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:09 -0400
Message-Id: <20200326193156.4322-28-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::730
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
Cc: robert.foley@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 richard.henderson@linaro.org, Fabien Chouteau <chouteau@adacore.com>,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/sparc/leon3.c      | 2 +-
 hw/sparc/sun4m.c      | 8 ++++----
 hw/sparc64/sparc64.c  | 4 ++--
 target/sparc/helper.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 8f024dab7b..00d1efd430 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -132,7 +132,7 @@ static void main_cpu_reset(void *opaque)
 
     cpu_reset(cpu);
 
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     env->pc     = s->entry;
     env->npc    = s->entry + 4;
     env->regbase[6] = s->sp;
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 36ee1a0a3d..1533ee117a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -192,7 +192,7 @@ static void cpu_kick_irq(SPARCCPU *cpu)
     CPUSPARCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     cpu_check_irqs(env);
     qemu_cpu_kick(cs);
 }
@@ -223,7 +223,7 @@ static void main_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
 
     cpu_reset(cs);
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
 }
 
 static void secondary_cpu_reset(void *opaque)
@@ -232,7 +232,7 @@ static void secondary_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
 
     cpu_reset(cs);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 }
 
 static void cpu_halt_signal(void *opaque, int irq, int level)
@@ -832,7 +832,7 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
     } else {
         qemu_register_reset(secondary_cpu_reset, cpu);
         cs = CPU(cpu);
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
     }
     *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
     env->prom_addr = prom_addr;
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 100b2fab17..fe9c678459 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -101,7 +101,7 @@ static void cpu_kick_irq(SPARCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUSPARCState *env = &cpu->env;
 
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     cpu_check_irqs(env);
     qemu_cpu_kick(cs);
 }
@@ -116,7 +116,7 @@ void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level)
         if (!(env->ivec_status & 0x20)) {
             trace_sparc64_cpu_ivec_raise_irq(irq);
             cs = CPU(cpu);
-            cs->halted = 0;
+            cpu_halted_set(cs, 0);
             env->interrupt_index = TT_IVEC;
             env->ivec_status |= 0x20;
             env->ivec_data[0] = (0x1f << 6) | irq;
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 07d87efa4e..90dfb1e92f 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -244,7 +244,7 @@ void helper_power_down(CPUSPARCState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     env->pc = env->npc;
     env->npc = env->pc + 4;
-- 
2.17.1


