Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E028CC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BDF2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BDF2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdt9W-0005l9-1F
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hdsu0-0000I9-3p
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hdstw-0001Hk-Ni
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:58:39 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50671 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hdstw-0000zD-EZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:58:36 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id AA7DC1A466B;
 Thu, 20 Jun 2019 10:58:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 7D2811A244D;
 Thu, 20 Jun 2019 10:58:20 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 10:58:02 +0200
Message-Id: <1561021082-15383-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561021082-15383-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561021082-15383-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 4/4] target/mips: Fix emulation of ILVR.<B|H|W>
 on big endian host
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix emulation of ILVR.<B|H|W> on big endian host by applying
mapping of data element indexes from one endian to another.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/msa_helper.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 458c840..7a9bfb3 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2001,6 +2001,24 @@ void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
     switch (df) {
     case DF_BYTE:
+#if defined(TARGET_WORDS_BIGENDIAN)
+        pwd->b[8]  = pws->b[0];
+        pwd->b[9]  = pwt->b[0];
+        pwd->b[10] = pws->b[1];
+        pwd->b[11] = pwt->b[1];
+        pwd->b[12] = pws->b[2];
+        pwd->b[13] = pwt->b[2];
+        pwd->b[14] = pws->b[3];
+        pwd->b[15] = pwt->b[3];
+        pwd->b[0]  = pws->b[4];
+        pwd->b[1]  = pwt->b[4];
+        pwd->b[2]  = pws->b[5];
+        pwd->b[3]  = pwt->b[5];
+        pwd->b[4]  = pws->b[6];
+        pwd->b[5]  = pwt->b[6];
+        pwd->b[6]  = pws->b[7];
+        pwd->b[7]  = pwt->b[7];
+#else
         pwd->b[15] = pws->b[7];
         pwd->b[14] = pwt->b[7];
         pwd->b[13] = pws->b[6];
@@ -2017,8 +2035,19 @@ void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         pwd->b[2]  = pwt->b[1];
         pwd->b[1]  = pws->b[0];
         pwd->b[0]  = pwt->b[0];
+#endif
         break;
     case DF_HALF:
+#if defined(TARGET_WORDS_BIGENDIAN)
+        pwd->h[4] = pws->h[0];
+        pwd->h[5] = pwt->h[0];
+        pwd->h[6] = pws->h[1];
+        pwd->h[7] = pwt->h[1];
+        pwd->h[0] = pws->h[2];
+        pwd->h[1] = pwt->h[2];
+        pwd->h[2] = pws->h[3];
+        pwd->h[3] = pwt->h[3];
+#else
         pwd->h[7] = pws->h[3];
         pwd->h[6] = pwt->h[3];
         pwd->h[5] = pws->h[2];
@@ -2027,12 +2056,20 @@ void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         pwd->h[2] = pwt->h[1];
         pwd->h[1] = pws->h[0];
         pwd->h[0] = pwt->h[0];
+#endif
         break;
     case DF_WORD:
+#if defined(TARGET_WORDS_BIGENDIAN)
+        pwd->w[2] = pws->w[0];
+        pwd->w[3] = pwt->w[0];
+        pwd->w[0] = pws->w[1];
+        pwd->w[1] = pwt->w[1];
+#else
         pwd->w[3] = pws->w[1];
         pwd->w[2] = pwt->w[1];
         pwd->w[1] = pws->w[0];
         pwd->w[0] = pwt->w[0];
+#endif
         break;
     case DF_DOUBLE:
         pwd->d[1] = pws->d[0];
-- 
2.7.4


