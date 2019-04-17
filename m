Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D367BC282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6394620674
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6394620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGmgH-0005Wh-Cr
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 11:41:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZD-0000Lo-5z
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hGmZB-0004nR-Uk
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34600 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hGmZB-0004lK-2C
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:33:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 96A411A2473;
	Wed, 17 Apr 2019 17:33:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw310-lin.domain.local (rtrkw310-lin.domain.local
	[10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 726121A2455;
	Wed, 17 Apr 2019 17:33:34 +0200 (CEST)
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 17:33:25 +0200
Message-Id: <1555515206-9352-6-git-send-email-mateja.marjanovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v7 4/6] target/mips: Optimize ILVR.<B|H|W|D>
 MSA instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, richard.henderson@linaro.org, philmd@redhat.com,
	amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417153325._FSjIdD-o0a4BHe8RxdXLjmqcBZsvoJnP8ipUbT9wgU@z>

From 55e222d8139e3dd034069fb512b83fd2541ec067 Mon Sep 17 00:00:00 2001
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Date: Wed, 17 Apr 2019 14:50:55 +0200
Subject: [PATCH v7 5/6] target/mips: Merge implementation of ILVEV.D and ILVR.D

The implementation for ILVEV.D and ILVR.D instructions
is equivalent, so use a single handler for both of them.

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4c7b076..656153a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28961,20 +28961,6 @@ static inline void gen_ilvr_w(CPUMIPSState *env, uint32_t wd,
 }
 
 /*
- * [MSA] ILVR.D wd, ws, wt
- *
- *   Vector Interleave Right (doubleword data elements)
- *
- */
-static inline void gen_ilvr_d(CPUMIPSState *env, uint32_t wd,
-                              uint32_t ws, uint32_t wt)
-{
-    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
-    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
-}
-
-
-/*
  * [MSA] ILVL.H wd, ws, wt
  *
  *   Vector Interleave Left (halfword data elements)
@@ -29197,10 +29183,16 @@ static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
 /*
  * [MSA] ILVEV.D wd, ws, wt
  *
- *   Vector Interleave Even (Doubleword data elements)
+ *   Vector Interleave Even (doubleword data elements)
+ *
+ * [MSA] ILVR.D wd, ws, wt
+ *
+ *   Vector Interleave Right (doubleword data elements)
+ *
+ *  These two instructions are functionally equivalent.
  *
  */
-static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
+static inline void gen_ilvev_ilvr_d(CPUMIPSState *env, uint32_t wd,
                                     uint32_t ws, uint32_t wt)
 {
     tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
@@ -29374,7 +29366,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvr_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvr_d(env, wd, ws, wt);
+            gen_ilvev_ilvr_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
@@ -29404,7 +29396,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvev_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvev_d(env, wd, ws, wt);
+            gen_ilvev_ilvr_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
-- 
2.7.4


