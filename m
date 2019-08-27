Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994F0C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682002173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOpq+gNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682002173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2P9v-0000Ej-C9
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1h-00082L-G4
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1g-00075N-9s
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:57 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1g-00074z-43
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id e11so11560083pga.5
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ddiXQUCU6+mV9b5HLraEW0nl5fo+95ic0hgqPUZ1sNk=;
 b=OOpq+gNF/SyLvs5tMKr1GXdkFGiQW1YEnYNFCU2trdRjnRN+EoGm7QuCN6D99/4MXu
 u7hiDZXQzfs6wCLgMRE9hodUgn/7WMjqHWy/hYQKFa3+8+Yly/SnX8+vl9fTRGbo7nJT
 tpT8dyY1EglE0Ij2xC4Hni6Dz2pVHa+NCyzmVDyDO4hCarhKnHdREPOHRUWkR70rLs8t
 qUySnNv4mVodg0qvlR53kPMWONTVzDoJJ8CPM17wVoGc7dbnvkQmRSpmxSxT+PAWUGov
 mfEg9J70pcRRFBmO+dn/imP5WKocLsdNDhZx9JlJpPMPHNVxk494W5EwrjFXmWIxUX1b
 QNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ddiXQUCU6+mV9b5HLraEW0nl5fo+95ic0hgqPUZ1sNk=;
 b=ZXGve59psdGPaaa6MqYWQqPn/RxryA3tbEpMAz81q63iGSPXq1PJCvP5VNc9bKnakI
 GDCjYXS+Y777rc9pFyv8Y1cHJF7PIx5S0LAnqigQjJlN0xtSTOg29wWFok69kY1t5bC7
 EFc7mhNE0aSj3ns/m4RincpgDhGH+ALvPspy4oVuhnjTldjsSSkBCazT0VUWBzYK+VrR
 hhknU6ctjA1/K50FHaWnaUrWmpWI1B3IZRwqg2qr1D8Z7eycByIO30yt2ZxQf2epSkS+
 cFr+e2KJF9d+gplz4MxdAa2eFL0+3dNX5BUyvzzSwEEhR2o4zeOAZJ4ZREivXgu7KguY
 TKAg==
X-Gm-Message-State: APjAAAXqrfcZCdjJmpZZ+42O/AjX6h1b+PxXTblNGw0yOMdz5qbNvhtT
 jXzKkKML0C/yxFhPAJpj7cnm3ei9TYI=
X-Google-Smtp-Source: APXvYqz7m4vUR+rPdGVj9/qpb6+V18CMG7C+JakJ0mwRc5IE9DzxNqXMqBodj++UuEjwmqmCe589cw==
X-Received: by 2002:a63:24a:: with SMTP id 71mr18502088pgc.273.1566864474643; 
 Mon, 26 Aug 2019 17:07:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:07:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:38 -0700
Message-Id: <20190827000745.19645-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 06/13] target/openrisc: Add VR2 and AVR special
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
Cc: shorne@gmail.com
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


