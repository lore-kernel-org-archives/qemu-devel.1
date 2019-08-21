Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09E0C3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C9522DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C9522DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Qsc-0000yO-E2
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aurelien@aurel32.net>) id 1i0Qq3-0008Hf-4X
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aurelien@aurel32.net>) id 1i0Qq2-0008EB-2y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:39:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:44190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aurelien@aurel32.net>)
 id 1i0Qq1-00088I-SY; Wed, 21 Aug 2019 09:39:46 -0400
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::1000])
 by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <aurelien@aurel32.net>)
 id 1i0Qpq-0001HK-8i; Wed, 21 Aug 2019 15:39:34 +0200
Received: from aurel32 by ohm.aurel32.net with local (Exim 4.92.1)
 (envelope-from <aurelien@aurel32.net>)
 id 1i0Qpp-0001wb-HP; Wed, 21 Aug 2019 15:39:33 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 15:39:32 +0200
Message-Id: <20190821133932.7428-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:bc8:30d7:100::1
Subject: [Qemu-devel] [PATCH] target/alpha: fix tlb_fill trap_arg2 value for
 instruction fetch
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
Cc: qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit e41c94529740cc26 ("target/alpha: Convert to CPUClass::tlb_fill")
slightly changed the way the trap_arg2 value is computed in case of TLB
fill. The type of the variable used in the ternary operator has been
changed from an int to an enum. This causes the -1 value to not be
sign-extended to 64-bit in case of an instruction fetch. The trap_arg2
ends up with 0xffffffff instead of 0xffffffffffffffff. Fix that by
changing the -1 into -1LL.

This fixes the execution of user space processes in qemu-system-alpha.

Fixes: e41c94529740cc26
Cc: qemu-stable@nongnu.org
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/alpha/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 93b8e788b1..9e9d880c1a 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -283,7 +283,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         cs->exception_index = EXCP_MMFAULT;
         env->trap_arg0 = addr;
         env->trap_arg1 = fail;
-        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1 : access_type);
+        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1LL : access_type);
         cpu_loop_exit_restore(cs, retaddr);
     }
 
-- 
2.23.0.rc1


