Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58FBC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD0722D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD0722D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RX4-0005Bs-Lq
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0RVp-0003iS-CO
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0RVo-0008CL-B4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:57 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:61425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i0RVo-00086g-0P
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:22:56 -0400
IronPort-SDR: Hg97n1o4R3Y25WRnPKpoiXEQp1G8WmLlVZdGJQDcACh/J8BP6bgq/AAcB0IsJeqd8DshZ8tGqm
 9D1kEv7roJkT9RdzM3XhPi7i1LZk6/9vApQdxTtnZbpBb44rllzsFF/1q1swaj79G9ghTphWb2
 leT9Da+BzieGL0Sk99D4/hJdKUNmanQk+dOdbO1FjUq0ZvO6PuBnnWJmO8iozXCYiBC7RjJG+a
 PhDCEtO0QGKfC6ydglqBVrSjscw92SkGNJJgZEEJdvlmFjeswmFDodZKahjXmJqw8Dtms79ngf
 L2U=
X-IronPort-AV: E=Sophos;i="5.64,412,1559548800"; d="scan'208";a="42443949"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 21 Aug 2019 06:22:55 -0800
IronPort-SDR: kwh3JegEK9nawQtU17/Guc9T3VG1YyBqgu0KVzt/g2Ci4A2hPJKePX3wSyLgEbj9/qaOwhXYr5
 DI6zUNyedInbXo3VTC6iFNzVYZexgkg4bVs9T1i377PFwIF8N8Jhun+sr5kd06tR09WYCGXlp4
 9OEgG7pkOYcXFiAYQ54vxg+jOnmpMBqgQdKpA3yN5Nfcjcyu/TYO63bGhcuy3wLsu+fxtwbeqm
 GvZ9kHlx8IoaCsWmDqGkYcD8BFzsJ+jCZIn1regdGU3dlpMVUp+mr6RpAaRMuI+OVpwHK0xtey
 b6g=
From: Sandra Loosemore <sandra@codesourcery.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 08:21:51 -0600
Message-ID: <20190821142151.19995-3-sandra@codesourcery.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821142151.19995-1-sandra@codesourcery.com>
References: <20190821142151.19995-1-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.129.153
Subject: [Qemu-devel] [PATCH 2/2] target/m68k: Fix bug in semihosted exit
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
status 0; it was incorrectly using the value of D0 (which
contains the HOSTED_EXIT request number) instead of D1.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
---
 target/m68k/m68k-semi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 8e5fbfc..f189c92 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -194,8 +194,8 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
     args = env->dregs[1];
     switch (nr) {
     case HOSTED_EXIT:
-        gdb_exit(env, env->dregs[0]);
-        exit(env->dregs[0]);
+        gdb_exit(env, env->dregs[1]);
+        exit(env->dregs[1]);
     case HOSTED_OPEN:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.8.1


