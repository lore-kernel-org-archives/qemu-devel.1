Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89669C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5308D207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="EWUzfWfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5308D207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm15I-0005MF-CV
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jm14i-0004lf-18
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:23:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jm14g-0003X1-E0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:23:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so7465226wru.6
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jrtc27.com; s=gmail.jrtc27.user;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JRRajxzTamdBT9+1rzxFUuGVADWvlG2jM5oN0hXK2r4=;
 b=EWUzfWfA9ZciY/8Pf4des8G5tzExTyBmRXQtb2F4rOd2LSvHY3VtYk8LKEZe7XQwyo
 gyKqzsoR6klunD75+5Ud5OgYQl27ysLRn6j8vjedUll6Q+v7Qz1hnZ/60+thv5pqJPx/
 jvg7F+vZfZaCsfp3ZFuhwhYve7GGSAjVthCQqzh9Tv2cdFiZ5AHIBoSX5PzQUAAKUPQw
 ug5cPh277bTifYPmZE3vnuk7ZNDZW38qr4/Jd/PhH+u+KLczPpykywBnlenoW71avT88
 R+2DJozDeCMKSEhtt8RdWh8JUiOHgXMjRVVNz6S9R4Bd3bYfLiMCZKDF2/Mw8s8o/PfH
 54CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JRRajxzTamdBT9+1rzxFUuGVADWvlG2jM5oN0hXK2r4=;
 b=okvd8KaWE3GAWZDigb9yRnMyNwtHa/Lv1KQQFmM8XJ8TxyYP2+BFuLNEkvgOkvVAx+
 RCOroKYsQcIjQho/dkswpOd9Ke9FJgkXQIIZNYXcMwAfaGnW53iJD12MXyRtFnpxhKEG
 vXatrB2Woxf7wV6Ao6kF/0x3kLPobH6kpsr8i9n6YyeXa3KJSJhXoqDh3DMNQPkdkC6P
 Uva02aNsJ4rIvr97pCnWXtPLxFoGvqLTRB3TSSiGB7ZDXDNAu2Rn6muwcVG27HfjgyTP
 fExI9O5g0ld4eJF2inzSBBKV+/qM3LWTiOXm5Zn5E6hNlasYFSztOZ8SpeFKUgX8o039
 VH5w==
X-Gm-Message-State: AOAM533XdTwAD0av0wEyhnnoyo+vGb8mw14NTH/LIVcu/+RTBY54A5Yc
 g70VIGNwAU0719fnaCKVlhpb3g==
X-Google-Smtp-Source: ABdhPJwgow/wNWpaDS6YrSp2jR6h4Nnw63nZnjeULv79PiQjwaqEKEXBVnlgBVEFCEC6IgcCqYKQcQ==
X-Received: by 2002:adf:ec4e:: with SMTP id w14mr269869wrn.280.1592511828637; 
 Thu, 18 Jun 2020 13:23:48 -0700 (PDT)
Received: from Jessicas-MacBook.local (trinity-students-nat.trin.cam.ac.uk.
 [131.111.193.104])
 by smtp.gmail.com with ESMTPSA id c143sm11065586wmd.1.2020.06.18.13.23.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Jun 2020 13:23:47 -0700 (PDT)
Received: by Jessicas-MacBook.local (Postfix, from userid 501)
 id 2AFFA207586B45; Thu, 18 Jun 2020 21:23:47 +0100 (BST)
From: Jessica Clarke <jrtc27@jrtc27.com>
To: qemu-riscv@nongnu.org
Subject: [PATCH v2] riscv: plic: Honour source priorities
Date: Thu, 18 Jun 2020 21:23:43 +0100
Message-Id: <20200618202343.20455-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200618193556.19459-1-jrtc27@jrtc27.com>
References: <20200618193556.19459-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=jrtc27@jrtc27.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The source priorities can be used to order sources with respect to other
sources, not just as a way to enable/disable them based off a threshold.
We must therefore always claim the highest-priority source, rather than
the first source we find.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
Changes since v1:

 * Initialise max_prio to plic->target_priority[addrid] rather than 0,
   allowing the target priority comparison to be dropped and covered by
   the max_prio comparison.

 hw/riscv/sifive_plic.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 4f216c5585..d91e82b8ab 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -166,6 +166,9 @@ static void sifive_plic_update(SiFivePLICState *plic)
 static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
 {
     int i, j;
+    uint32_t max_irq = 0;
+    uint32_t max_prio = plic->target_priority[addrid];
+
     for (i = 0; i < plic->bitfield_words; i++) {
         uint32_t pending_enabled_not_claimed =
             (plic->pending[i] & ~plic->claimed[i]) &
@@ -177,14 +180,18 @@ static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
             int irq = (i << 5) + j;
             uint32_t prio = plic->source_priority[irq];
             int enabled = pending_enabled_not_claimed & (1 << j);
-            if (enabled && prio > plic->target_priority[addrid]) {
-                sifive_plic_set_pending(plic, irq, false);
-                sifive_plic_set_claimed(plic, irq, true);
-                return irq;
+            if (enabled && prio > max_prio) {
+                max_irq = irq;
+                max_prio = prio;
             }
         }
     }
-    return 0;
+
+    if (max_irq) {
+        sifive_plic_set_pending(plic, max_irq, false);
+        sifive_plic_set_claimed(plic, max_irq, true);
+    }
+    return max_irq;
 }

 static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
--
2.20.1


