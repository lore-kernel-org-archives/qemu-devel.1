Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B0C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A0522D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A0522D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RX6-0005Dh-CA
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0RVo-0003hl-K1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0RVn-00089d-J5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:56 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:61425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i0RVn-00086g-6O
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:55 -0400
IronPort-SDR: jaz8WVTE0zJHhfkhLcNvP3/ddiVQqB7AoYzOgbeI2rK740uFDaRS1znFrWZ2Aw75sNEhGRn7OU
 K+K/4fvvnY4d8EweK//xbuPMIgIKjnhqRkJOIOhukCd5jyhK4TgAj58rPyyi8jEzybc50zfggA
 S9dyeVj3dU40Sd0frljEODlf0YGTKW8oeJ+gtHyA7agVudG0shtqrSsVANv9WJVhMzudewrKVN
 GeiHD6TMdaQc/0MAR+tpn6Ac3V/AYogf+nUljhQygSN7VfabRPIJK1J/e0l47nqCEcF3y+Q+yS
 f5g=
X-IronPort-AV: E=Sophos;i="5.64,412,1559548800"; d="scan'208";a="42443946"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 21 Aug 2019 06:22:52 -0800
IronPort-SDR: JteUtEH+uM3Y+MSNDjjJbfEMq63QzdboWj+vssHRxr+abkecI4QhIpe+et5iBsOPto+wCxrspL
 QnHL60D3x7bW4Aw/9VN1F2PeH6snGJanLVQsr5nGAR8IaMSAoDSKqX1f9QDyaREJLugAMUnN8t
 mQ1lCB1NNTe8WU5VcxaH/WXv8MRyovAeKOK5zvqa1P20GWMauhoC/BV/Z054oVqwv9TY2Yu/jL
 Hn3Qu26UD1wQHEMbx2/Y84M8B/HRN3yPUea2P/PoJQctdfSaqNgaIXBnvjhGhGD/6bYR7jUAju
 UAQ=
From: Sandra Loosemore <sandra@codesourcery.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 08:21:50 -0600
Message-ID: <20190821142151.19995-2-sandra@codesourcery.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821142151.19995-1-sandra@codesourcery.com>
References: <20190821142151.19995-1-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.129.153
Subject: [Qemu-devel] [PATCH 1/2] target/nios2: Fix bug in semihosted exit
 handling
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

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
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


