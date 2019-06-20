Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE200C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B713D20675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B713D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdxV8-0001SK-0H
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 09:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52662)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hdxOL-0004XC-2k
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hdxOB-0003Rg-OQ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:46:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36132 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hdxO8-0003Mx-01
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:46:06 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0DB9A1A4643;
 Thu, 20 Jun 2019 15:45:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id C62F41A46C0;
 Thu, 20 Jun 2019 15:45:55 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 15:45:47 +0200
Message-Id: <1561038349-17105-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561038349-17105-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561038349-17105-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 2/4] target/mips: Fix emulation of
 ILVOD.<B|H|W> on big endian host
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

Fix emulation of ILVOD.<B|H|W> on big endian host by applying
mapping of data element indexes from one endian to another.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 target/mips/msa_helper.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 215d8af..9f411c1 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1825,6 +1825,24 @@ void helper_msa_ilvod_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
     switch (df) {
     case DF_BYTE:
+#if defined(TARGET_WORDS_BIGENDIAN)
+        pwd->b[7]  = pwt->b[6];
+        pwd->b[6]  = pws->b[6];
+        pwd->b[5]  = pwt->b[4];
+        pwd->b[4]  = pws->b[4];
+        pwd->b[3]  = pwt->b[2];
+        pwd->b[2]  = pws->b[2];
+        pwd->b[1]  = pwt->b[0];
+        pwd->b[0]  = pws->b[0];
+        pwd->b[15] = pwt->b[14];
+        pwd->b[14] = pws->b[14];
+        pwd->b[13] = pwt->b[12];
+        pwd->b[12] = pws->b[12];
+        pwd->b[11] = pwt->b[10];
+        pwd->b[10] = pws->b[10];
+        pwd->b[9]  = pwt->b[8];
+        pwd->b[8]  = pws->b[8];
+#else
         pwd->b[0]  = pwt->b[1];
         pwd->b[1]  = pws->b[1];
         pwd->b[2]  = pwt->b[3];
@@ -1841,8 +1859,19 @@ void helper_msa_ilvod_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         pwd->b[13] = pws->b[13];
         pwd->b[14] = pwt->b[15];
         pwd->b[15] = pws->b[15];
+#endif
         break;
     case DF_HALF:
+#if defined(TARGET_WORDS_BIGENDIAN)
+        pwd->h[3] = pwt->h[2];
+        pwd->h[2] = pws->h[2];
+        pwd->h[1] = pwt->h[0];
+        pwd->h[0] = pws->h[0];
+        pwd->h[7] = pwt->h[6];
+        pwd->h[6] = pws->h[6];
+        pwd->h[5] = pwt->h[4];
+        pwd->h[4] = pws->h[4];
+#else
         pwd->h[0] = pwt->h[1];
         pwd->h[1] = pws->h[1];
         pwd->h[2] = pwt->h[3];
@@ -1851,12 +1880,20 @@ void helper_msa_ilvod_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         pwd->h[5] = pws->h[5];
         pwd->h[6] = pwt->h[7];
         pwd->h[7] = pws->h[7];
+#endif
         break;
     case DF_WORD:
+#if defined(TARGET_WORDS_BIGENDIAN)
+        pwd->w[1] = pwt->w[0];
+        pwd->w[0] = pws->w[0];
+        pwd->w[3] = pwt->w[2];
+        pwd->w[2] = pws->w[2];
+#else
         pwd->w[0] = pwt->w[1];
         pwd->w[1] = pws->w[1];
         pwd->w[2] = pwt->w[3];
         pwd->w[3] = pws->w[3];
+#endif
         break;
     case DF_DOUBLE:
         pwd->d[0] = pwt->d[1];
-- 
2.7.4


