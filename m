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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BD9C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7C92133D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr/6PQM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7C92133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcWFW-0000Go-2X
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 10:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34858)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3u-0001Cd-LH
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3s-0006dU-N5
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:14 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hcW3o-0006XJ-3f
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:23:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id d126so4220016pfd.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=ixK+HG8MWcRi5mr2H4lCo9+/w2jNd7ou3OyXwpaUUEo=;
 b=mr/6PQM3z/cTpvELcqxAjox7eo9pjxXmf9Hn3FRQg48Od5WxierJdGoIlFPXBDlj6S
 pGnQ9ghKdY28PScByHNpWFtWvvZs0w+3bVq2gl1phpi/og1jMIfjCrWWWRKHu+lWWYQC
 p3bumlAqHdXCBWWtxwgK7IUlyuUXM005uLlPakbzoVUpmKvY6gUVe8+9CjzSe+t7vpxN
 LHGLnfxNVPZ/8lwhL1ArX8+Xugka4sAQrNs0OxS0Yu63pwfeEi6Vcdu052cYWt9eGg0Y
 fti3ed4WmjGCXLVbGRMs6hYZb04UKQ2U/dMePw4o6gxqtnQUWV/gqInEM+zkltjmML3k
 ZeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=ixK+HG8MWcRi5mr2H4lCo9+/w2jNd7ou3OyXwpaUUEo=;
 b=SB+/CWPfP5Zn11EHsSrl4JkYjO7Hu4EYi9tx8Ax7c+WdM5EAcapE280FIij4xKJuHG
 V3tZwJHimUrxx8osVwEtS+SEsfEUI1ZMFPfVKZG0Zt7rh4XUAvKtUEDkPOy3n8gj6FeD
 rqdBCSImTu5zbCNJzh0THxrOI840OWno9wEs04Ibqr2HLkEhAiczBBv73MWyZlD1sCWo
 KcCauwdvndcew6gaFG6XPY4fvw3OuIqwpvP/vdR1aLR6ByVPVdf2DuJJfs01z7eLp1Lm
 qyPMzoeJyZLeoTkC51tLXEj0S7auAICOSnGGqEKnl6JFHZbgr8RDdoR2lZOj82sh5GxS
 g9xQ==
X-Gm-Message-State: APjAAAXq1RInCiv5gWnvaEMxBuiB8pNGP5fhLRdntpM9S5GGR9dcD+1s
 PFx+f6/c+OwmjWSUKXwFDeCprV2f
X-Google-Smtp-Source: APXvYqy1dI50a4YRV/HR+wokDO1t+lUNYmkbHw5yYX2NGVE8J2Ozg4w5iKXZLTiro/rs73P0zA/1Yg==
X-Received: by 2002:a17:90a:cb81:: with SMTP id
 a1mr20769306pju.81.1560694983671; 
 Sun, 16 Jun 2019 07:23:03 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id f15sm11861537pje.17.2019.06.16.07.23.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 07:23:03 -0700 (PDT)
Date: Sun, 16 Jun 2019 23:23:00 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <20190616142300.GA71207@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 4/6] Add missing BUSCR/PCR CR defines,
 and BUSCR/PCR/CAAR CR to m68k_move_to/from
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

The BUSCR/PCR CR defines were missing for 68060, and the move_to/from helper
functions were also missing a decode for the 68060 M68K_CR_CAAR CR register.

Added missing defines, and respective decodes for all three CR registers to
the helpers.

Although this patch defines them, the implementation is empty in this patch
and these registers will result in a cpu abort - which is the default prior
to this patch.

This patch aims to reach full coverage of all CR registers within the helpers.

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
---
 target/m68k/cpu.h    |  4 ++++
 target/m68k/helper.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b5b3db01c9..2386419c42 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -411,6 +411,10 @@ typedef enum {
 #define M68K_CR_DACR0    0x006
 #define M68K_CR_DACR1    0x007
 
+/* MC68060 */
+#define M68K_CR_BUSCR    0x008
+#define M68K_CR_PCR      0x808
+
 #define M68K_FPIAR_SHIFT  0
 #define M68K_FPIAR        (1 << M68K_FPIAR_SHIFT)
 #define M68K_FPSR_SHIFT   1
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5483ce9837..47b352c9c9 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -257,6 +257,14 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
     case M68K_CR_DTT1:
         env->mmu.ttr[M68K_DTTR1] = val;
         return;
+    /* Unimplemented Registers */
+    case M68K_CR_CAAR:
+    case M68K_CR_PCR:
+    case M68K_CR_BUSCR:
+        cpu_abort(CPU(cpu),
+                  "Unimplemented control register write 0x%x = 0x%x\n",
+                  reg, val);
+        return;
     }
     cpu_abort(CPU(cpu), "Unimplemented control register write 0x%x = 0x%x\n",
               reg, val);
@@ -312,6 +320,12 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
     /* MC68040/MC68LC040 */
     case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
         return env->mmu.ttr[M68K_DTTR1];
+    /* Unimplemented Registers */
+    case M68K_CR_CAAR:
+    case M68K_CR_PCR:
+    case M68K_CR_BUSCR:
+        cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
+                  reg);
     }
     cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
               reg);
-- 
2.21.0



