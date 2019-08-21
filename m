Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E022214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E022214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Vd3-0000q4-Eu
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0Ul0-0003Ng-3e
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0Uky-0005Q8-D5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:49 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:13357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i0Uky-0005KR-4X
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:48 -0400
IronPort-SDR: mMk/178bEhjfPxnXcVEpDQFhPQDF25KQIduSBTapHiQ9KJyUGueNW39tuizfPew/RUmOX1qrsk
 F/JumlHbYxD3Ffli/peWqL5FMM6p8+cPif8nghFt11lnsvp6qA3nSqN1l2n3pNzzyiU3RMMMYU
 J9LKLLs/6LlwBSPVxHhIEPNQ8VOag4roIEp5CfNuA1s6jPJoYz5CdQ8YdVNrzSZ0hiH4uHzvqJ
 cMsKssJfEYuKQJp0oXPUTyu4SYkIcYqmLtzunrOW3g05SDVmh0OSG1KQ03s/+F3gmrUuSQOD1X
 EPE=
X-IronPort-AV: E=Sophos;i="5.64,412,1559548800"; d="scan'208";a="40657528"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 21 Aug 2019 09:50:47 -0800
IronPort-SDR: fR6Nskbae+WoPyVgvYJTlkBPQsF5qFiXcNSd+Rk0bN4EahWXa8lZSiNmgNXWNVcUpx7XnkQT0d
 QJoS7mVEmBJ2kPWDG9K93KbaRp/rfKbD9q2psIv73RIglGt3VY6yd3z7T8s+mADMeNYHcGbb5b
 wN039HxVcQg4HHveigD75k2C5QWzwQP88bwaa4RV/EFXGvTpYKH1UmzMYCDTjfkK9m4kLnNm3w
 cF0NpQiWeAAigrvsDGFR8K/7TcJBY+QN0lfbq4682JZcdJZFIk1nmWaxzGcF97lQ96/VWVNi1J
 m3Y=
From: Sandra Loosemore <sandra@codesourcery.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 11:50:28 -0600
Message-ID: <20190821175029.21868-2-sandra@codesourcery.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821175029.21868-1-sandra@codesourcery.com>
References: <20190821175029.21868-1-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.137.252
Subject: [Qemu-devel] [PATCH V2 1/2] target/nios2: Fix bug in semihosted
 exit handling
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes a bug that caused semihosted exit to always return
status 0; it was incorrectly using the value of register R_ARG0 (which
contains the HOSTED_EXIT request number) instead of register R_ARG1.

Note that per the newlib documentation for the nios2 semihosting protocol

https://www.sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/nios2/nios2-semi.txt;h=ded3a093c03dbae84cb95b4cd45bc3e0d751eda2;hb=HEAD

for the HOSTED_EXIT syscall the parameter is passed directly in the register
instead of in a parameter block pointed to by the register.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 target/nios2/nios2-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index d7a80dd..06c0861 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -215,8 +215,8 @@ void do_nios2_semihosting(CPUNios2State *env)
     args = env->regs[R_ARG1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env, env->regs[R_ARG0]);
-        exit(env->regs[R_ARG0]);
+        gdb_exit(env, env->regs[R_ARG1]);
+        exit(env->regs[R_ARG1]);
     case HOSTED_OPEN:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.8.1


