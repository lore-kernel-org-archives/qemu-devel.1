Received: from eggs.gnu.org ([2001:4830:134:3::10]:51516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW14-0003Wq-8t
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW10-0005MD-0A
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:22 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:37451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddW0z-0005LL-QS
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:17 -0400
Received: by mail-pg0-x241.google.com with SMTP id 83so904176pgb.4
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:23:17 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	q199sm1335819pfq.135.2017.08.03.23.23.14 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 23:23:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 23:23:08 -0700
Message-Id: <20170804062314.12594-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 0/6] tcg/i386 haswell improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We can implement extract and deposit fairly efficiently with
the bmi2 pext and pdep instructions.

I did wonder about using bextr and tcg_reg_alloc_new to
allocate the register required to hold the parameters.  But
pdep allows the mask to be stored in the constant pool, and
there's the chance that the mask could be re-used, either
by another extract or by a deposit.

I have not yet done any profiling on this yet.


r~


Richard Henderson (6):
  tcg: Add tcg_reg_alloc_new
  disas/i386: Fix disassembly of two-byte vex prefixes
  disas/i386: Add disassembly of vex.0f38.f5
  disas/i386: Add disassembly of rorx
  tcg/i386: Use pext for extract
  tcg/i386: Use pdep for deposit

 tcg/i386/tcg-target.h     |  10 ++-
 tcg/tcg.h                 |   1 +
 disas/i386.c              |  29 ++++--
 tcg/i386/tcg-target.inc.c | 223 +++++++++++++++++++++++++++++++++++-----------
 tcg/tcg.c                 |  58 +++++++++---
 5 files changed, 246 insertions(+), 75 deletions(-)

-- 
2.13.3
