Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862D7C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB2420815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB2420815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUw4W-0000tP-F3
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 12:32:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hUvx3-0002p3-9u
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hUvsi-0007NU-UR
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:20:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35909 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hUvsi-0006sj-N2
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:20:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 56FA51A4800;
	Sun, 26 May 2019 18:19:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 381621A49F6;
	Sun, 26 May 2019 18:19:16 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 18:19:00 +0200
Message-Id: <1558887551-32137-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558887551-32137-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1558887551-32137-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 01/12] target/mips: Make the results of
 DIV_<U|S>.<B|H|W|D> the same as on hardware
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

MSA instructions DIV_<U|S>.<B|H|W|D> when dividing by zero,
didn't return the same value when executed on a referent hardware
(FPGA MIPS 64 r6, little endian) and when executed on QEMU, which
is not a real bug, because the result when dividing by zero is
UNPREDICTABLE [1] (page 141, 142).

[1] MIPS Architecture for Programmers
    Volume IV-j: The MIPS64 SIMD
    Architecture Module, Revision 1.12

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1554207110-9113-2-git-send-email-mateja.marjanovic@rt-rk.com>
---
 target/mips/msa_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index c74e3cd..596190b 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -641,14 +641,15 @@ static inline int64_t msa_div_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     if (arg1 == DF_MIN_INT(df) && arg2 == -1) {
         return DF_MIN_INT(df);
     }
-    return arg2 ? arg1 / arg2 : 0;
+    return arg2 ? arg1 / arg2
+                : arg1 >= 0 ? -1 : 1;
 }
 
 static inline int64_t msa_div_u_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     uint64_t u_arg1 = UNSIGNED(arg1, df);
     uint64_t u_arg2 = UNSIGNED(arg2, df);
-    return u_arg2 ? u_arg1 / u_arg2 : 0;
+    return arg2 ? u_arg1 / u_arg2 : -1;
 }
 
 static inline int64_t msa_mod_s_df(uint32_t df, int64_t arg1, int64_t arg2)
-- 
2.7.4


