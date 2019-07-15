Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB178C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C0420665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C0420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn74f-0000Nu-Me
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 15:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49628)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hn73p-0005Jt-N1
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hn73e-0000Ww-DM
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:54:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59861 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hn73e-0000Vt-3a
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:54:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B360B1A20B1;
 Mon, 15 Jul 2019 21:53:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 8AD531A20A4;
 Mon, 15 Jul 2019 21:53:39 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 21:53:26 +0200
Message-Id: <1563220406-5202-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563220406-5202-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1563220406-5202-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.1 v3 5/5] target/mips: Fix emulation of
 MSA pack instructions on big endian hosts
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
Cc: arikalo@wavecomp.com, sw@weilnetz.de, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix emulation of MSA pack instructions on big endian hosts.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/msa_helper.c | 66 ------------------------------------------------
 1 file changed, 66 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index a383c40..4098842 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2113,39 +2113,6 @@ void helper_msa_pckev_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
     switch (df) {
     case DF_BYTE:
-        pwd->b[15] = pws->b[14];
-        pwd->b[13] = pws->b[10];
-        pwd->b[11] = pws->b[6];
-        pwd->b[9]  = pws->b[2];
-        pwd->b[7]  = pwt->b[14];
-        pwd->b[5]  = pwt->b[10];
-        pwd->b[3]  = pwt->b[6];
-        pwd->b[1]  = pwt->b[2];
-        pwd->b[14] = pws->b[12];
-        pwd->b[10] = pws->b[4];
-        pwd->b[6]  = pwt->b[12];
-        pwd->b[2]  = pwt->b[4];
-        pwd->b[12] = pws->b[8];
-        pwd->b[4]  = pwt->b[8];
-        pwd->b[8]  = pws->b[0];
-        pwd->b[0]  = pwt->b[0];
-        break;
-    case DF_HALF:
-        pwd->h[7] = pws->h[6];
-        pwd->h[5] = pws->h[2];
-        pwd->h[3] = pwt->h[6];
-        pwd->h[1] = pwt->h[2];
-        pwd->h[6] = pws->h[4];
-        pwd->h[2] = pwt->h[4];
-        pwd->h[4] = pws->h[0];
-        pwd->h[0] = pwt->h[0];
-        break;
-    case DF_WORD:
-        pwd->w[3] = pws->w[2];
-        pwd->w[1] = pwt->w[2];
-        pwd->w[2] = pws->w[0];
-        pwd->w[0] = pwt->w[0];
-        break;
     case DF_DOUBLE:
         pwd->d[1] = pws->d[0];
         pwd->d[0] = pwt->d[0];
@@ -2164,39 +2131,6 @@ void helper_msa_pckod_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
     switch (df) {
     case DF_BYTE:
-        pwd->b[0]  = pwt->b[1];
-        pwd->b[2]  = pwt->b[5];
-        pwd->b[4]  = pwt->b[9];
-        pwd->b[6]  = pwt->b[13];
-        pwd->b[8]  = pws->b[1];
-        pwd->b[10] = pws->b[5];
-        pwd->b[12] = pws->b[9];
-        pwd->b[14] = pws->b[13];
-        pwd->b[1]  = pwt->b[3];
-        pwd->b[5]  = pwt->b[11];
-        pwd->b[9]  = pws->b[3];
-        pwd->b[13] = pws->b[11];
-        pwd->b[3]  = pwt->b[7];
-        pwd->b[11] = pws->b[7];
-        pwd->b[7]  = pwt->b[15];
-        pwd->b[15] = pws->b[15];
-        break;
-    case DF_HALF:
-        pwd->h[0] = pwt->h[1];
-        pwd->h[2] = pwt->h[5];
-        pwd->h[4] = pws->h[1];
-        pwd->h[6] = pws->h[5];
-        pwd->h[1] = pwt->h[3];
-        pwd->h[5] = pws->h[3];
-        pwd->h[3] = pwt->h[7];
-        pwd->h[7] = pws->h[7];
-        break;
-    case DF_WORD:
-        pwd->w[0] = pwt->w[1];
-        pwd->w[2] = pws->w[1];
-        pwd->w[1] = pwt->w[3];
-        pwd->w[3] = pws->w[3];
-        break;
     case DF_DOUBLE:
         pwd->d[0] = pwt->d[1];
         pwd->d[1] = pws->d[1];
-- 
2.7.4


