Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413F0C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB1F218A6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB1F218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj38I-0000fP-R7
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hj37d-0000GJ-OV
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hj37c-0002t7-RU
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:54:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48651 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hj37c-0002BB-Ko
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:54:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id BAF9E1A21D6;
 Thu,  4 Jul 2019 16:52:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id A18031A2143;
 Thu,  4 Jul 2019 16:52:59 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 16:52:46 +0200
Message-Id: <1562251966-19318-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.1] linux-user: Fix structure
 target_ucontext for MIPS
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Dragan Mladjenovic <dmladjenovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Structure ucontext for MIPS is defined in the following way in
Linux kernel:

(arch/mips/include/uapi/asm/ucontext.h, lines 54-64)

struct ucontext {
    /* Historic fields matching asm-generic */
    unsigned long       uc_flags;
    struct ucontext     *uc_link;
    stack_t             uc_stack;
    struct sigcontext   uc_mcontext;
    sigset_t            uc_sigmask;

    /* Extended context structures may follow ucontext */
    unsigned long long	uc_extcontext[0];
};

Fix the structure target_sigset_t for MIPS to reflect the definition
above, except the correction for field uc_extcontext, which will
follow at some later time.

Fixes: 94c5495d

Reported-by: Dragan Mladjenovic <dmladjenovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/mips/signal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index 6aa303e..455a8a2 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -71,10 +71,9 @@ struct sigframe {
 };
 
 struct target_ucontext {
-    target_ulong tuc_flags;
-    target_ulong tuc_link;
+    abi_ulong tuc_flags;
+    abi_ulong tuc_link;
     target_stack_t tuc_stack;
-    target_ulong pad0;
     struct target_sigcontext tuc_mcontext;
     target_sigset_t tuc_sigmask;
 };
-- 
2.7.4


