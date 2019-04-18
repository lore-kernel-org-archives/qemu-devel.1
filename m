Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934E7C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B9520835
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B9520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH98o-0003Od-FC
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:39:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH943-0007d7-Po
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH8yW-000339-BV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:29:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36766 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hH8yW-00032G-59
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:29:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id AFB471A2468;
	Thu, 18 Apr 2019 17:29:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw310-lin.domain.local (rtrkw310-lin.domain.local
	[10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 8551E1A2435;
	Thu, 18 Apr 2019 17:29:17 +0200 (CEST)
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 17:29:04 +0200
Message-Id: <1555601350-4176-1-git-send-email-mateja.marjanovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v9 0/6] target/mips: Optimize MSA interleave
 instructions
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
Cc: arikalo@wavecomp.com, richard.henderson@linaro.org, philmd@redhat.com,
	amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418152904.W-H-SQBJeL2eOhM2F_gws3OkGMCYtMSzQTzA25tSOXg@z>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Optimize and refactor MSA instructions ILVEV.<B|H|W|D>,
ILVOD.<B|H|W|D>, ILVL.<B|H|W|D> and ILVR.<B|H|W|D>.

v9:
 - Tests were changed, instead of iterating through the
   loop 10 million times and calling the instruction
   once, iterate through the loop 1 million times, and
   call the instruction ten times.
 - Eliminate the hybrid approach in ILVL.<B|H|W|D> and
   ILVR.<B|H|W|D>, because the performance of directly
   using TCG registers is much better than the
   performance of the handler.
 - Change the tables in the commit messages, due to
   modified performance testing program.

v8:
 - Rebased onto current master branch.
 - Inserted Reviewed-by in the applicable commit message.

v7:
 - Use tcg constants, instead of uint64_t constants in
   ILVEV.<B|H> and ILVOD.<B|H> instructions.
 - Refactor gen_ilvod_b and gen_ilvod_h functions. Use
   the shared function gen_ilvod_bh, which has two extra
   arguments mask and shift, because mask and shift are
   the only differences in the implementation of those
   two functions.
   Same applies for gen_ilvev_b and gen_ilvev_h.
 - Use assigning uint64_t constant values to the bit mask,
   instead of shifting the bit mask, in ILVR.<H|W> and
   ILVL.<H|W> instructions.
 - Use only one helper for ILVEV.D and ILVR.D instructions,
   because they are equivalent. 
   Same applies for ILVOD.D and ILVL.D.
 - Minor changes in the commit messages.

v6:
 - Add ILVL.<B|H|W|D> and ILVR.<B|H|W|D> MSA instructions
   with mixed approaches (with helpers and with tcg
   registers).
 - Test the performance for ILVL.<B|H|W|D> and
   ILVR.<B|H|W|D> MSA instructions, with helpers,
   with tcg and with the mixed approach.
 - Use a tcg register instead of an int variable for
   storing a constant value of the mask (for logic
   operations).
 - Eliminate some unnecessary tcg_gen calls.
 - Changes in commit messages and the cover letter.

v5:
 - Use tcg_gen_deposit function.
 - Added performance number for no-deposit and
   with-deposit cases of ILVEV.W.
 - Minor changes in commit messages and the cover letter.

v4:
 - Clean up typing errors.
 - Change the commit message and the cover letter.
 - Fix bug for ILVEV.D, in case where the destination
   and one of the sources are the same register.

v3:
 - Reduce the number of logic operations to a
   minimum.
 - Add comments.

v2:
 - Minor changes in commit messages and the cover letter.

Mateja Marjanovic (6):
  target/mips: Optimize ILVOD.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVEV.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVL.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVR.<B|H|W|D> MSA instructions
  target/mips: Merge implementation of ILVEV.D and ILVR.D
  target/mips: Merge implementation of ILVOD.D and ILVL.D

 target/mips/helper.h     |   4 -
 target/mips/msa_helper.c |  32 ---
 target/mips/translate.c  | 532 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 528 insertions(+), 40 deletions(-)

-- 
2.7.4


