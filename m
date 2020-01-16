Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A563C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E23220663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E23220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tachyum.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is3nF-0001tn-M8
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mkysel@tachyum.com>) id 1is3me-0000lj-W8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mkysel@tachyum.com>) id 1is3md-0008GQ-UU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:57:56 -0500
Received: from mail.tachyum.com ([66.160.133.170]:61530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mkysel@tachyum.com>) id 1is3md-0008FG-PG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:57:55 -0500
Received: from THQ-IP-EX1.tachyum.com (relayhost.tachyum.com [10.7.1.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.tachyum.com (Postfix) with ESMTPS id D4CE523B;
 Thu, 16 Jan 2020 03:57:55 -0800 (PST)
Received: from tachyum-sk-server.tachyum.com (10.7.241.13) by
 THQ-IP-EX1.tachyum.com (10.7.1.6) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1779.2; Thu, 16
 Jan 2020 03:57:44 -0800
From: Matus Kysel <mkysel@tachyum.com>
To: 
Subject: [PATCH] Handling SIGSETXID used by glibc NPTL setuid/setgid
Date: Thu, 16 Jan 2020 12:57:00 +0100
Message-ID: <20200116115700.127951-1-mkysel@tachyum.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.241.13]
X-ClientProxiedBy: THQ-IP-EX1.tachyum.com (10.7.1.6) To THQ-IP-EX1.tachyum.com
 (10.7.1.6)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.160.133.170
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Matus Kysel <mkysel@tachyum.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Used same style to handle another glibc reserved signal SIGSETXID (33), 
that is used by glibc NPTL setuid/setgid functions. This should fix problems
with application using those functions and failing with error
"qemu:handle_cpu_signal received signal outside vCPU context".

Signed-off-by: Matus Kysel <mkysel@tachyum.com>
---
 linux-user/signal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 0128bde4d2..c59221fd0a 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -66,11 +66,16 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
     [SIGPWR] = TARGET_SIGPWR,
     [SIGSYS] = TARGET_SIGSYS,
     /* next signals stay the same */
-    /* Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
-       host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
-       To fix this properly we need to do manual signal delivery multiplexed
-       over a single host signal.  */
+    /*
+     * Nasty hack: Swap SIGRTMIN and SIGRTMIN + 1 with SIGRTMAX and SIGRTMAX - 1
+     * to avoid overlap with host libpthread (NPTL glibc) signals.
+     * This assumes no one actually uses SIGRTMAX and SIGRTMAX - 1 :-/
+     * To fix this properly we need to do manual signal delivery multiplexed
+     * over a single host signal.
+     */
     [__SIGRTMIN] = __SIGRTMAX,
+    [__SIGRTMIN + 1] = __SIGRTMAX - 1,
+    [__SIGRTMAX - 1] = __SIGRTMIN + 1,
     [__SIGRTMAX] = __SIGRTMIN,
 };
 static uint8_t target_to_host_signal_table[_NSIG];
-- 
2.17.1


