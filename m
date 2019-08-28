Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEBBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5196B217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5196B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i30jN-0005PU-Fm
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30hk-0004IT-1R
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30hi-0003cq-In
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:21:51 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34766 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i30hi-0002ri-Bb
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:21:50 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 742381A214D;
 Wed, 28 Aug 2019 18:20:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 5D9D91A20DB;
 Wed, 28 Aug 2019 18:20:45 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 18:20:39 +0200
Message-Id: <1567009239-11273-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH] target/mips: Fix emulation of ST.W in system
 mode
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

Order of arguments in helper_ret_stl_mmu() invocations was wrong,
apparently caused by misplaced multiline copy-and-paste.

Fixes: 6decc57 "target/mips: Fix MSA instructions ST.<B|H|W|D> on
big endian host"

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/op_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 5874029..e55e300 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -4842,15 +4842,15 @@ void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
     ensure_writable_pages(env, addr, mmu_idx, GETPC());
 #if !defined(CONFIG_USER_ONLY)
 #if !defined(HOST_WORDS_BIGENDIAN)
-    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(), pwd->w[0]);
-    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(), pwd->w[1]);
-    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(), pwd->w[2]);
-    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(), pwd->w[3]);
+    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), pwd->w[0], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), pwd->w[1], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), pwd->w[2], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), pwd->w[3], oi, GETPC());
 #else
-    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), oi, GETPC(), pwd->w[0]);
-    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), oi, GETPC(), pwd->w[1]);
-    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), oi, GETPC(), pwd->w[2]);
-    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), oi, GETPC(), pwd->w[3]);
+    helper_ret_stl_mmu(env, addr + (1 << DF_WORD), pwd->w[0], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (0 << DF_WORD), pwd->w[1], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (3 << DF_WORD), pwd->w[2], oi, GETPC());
+    helper_ret_stl_mmu(env, addr + (2 << DF_WORD), pwd->w[3], oi, GETPC());
 #endif
 #else
 #if !defined(HOST_WORDS_BIGENDIAN)
-- 
2.7.4


