Received: from eggs.gnu.org ([2001:4830:134:3::10]:43648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4wx-0001fu-Fi
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gP4wu-0004z1-CT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:15 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:36736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gP4wt-0004yi-V5
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:16:12 -0500
Received: by mail-pf1-x435.google.com with SMTP id b85so926792pfc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 04:16:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 20 Nov 2018 13:15:53 +0100
Message-Id: <20181120121558.7660-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] tcg: Make bswap support in qemu_ld/st
 optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

Having to support bswap in the guest memory operations at times
requires an irritating number of temporaries.  Better to allow
the bswap operations to be expanded outside of the memory ops
and let register allocation do its thing.

This is something that I've been planning to do for some time,
to aid i386 and arm32 especially.  But I've been prompted again
by the nacent risc-v backend, for which this would be especially
irritating to have to open-code.

Alistair, for convenience I've pushed this to 

  https://github.com/rth7680/qemu.git tcg-next-for-4.0


r~


Richard Henderson (5):
  tcg: Add TCG_TARGET_HAS_MEMORY_BSWAP
  tcg/optimize: Optimize bswap
  tcg/i386: Set TCG_TARGET_HAS_MEMORY_BSWAP with have_movbe
  tcg/aarch64: Set TCG_TARGET_HAS_MEMORY_BSWAP to false
  tcg/arm: Set TCG_TARGET_HAS_MEMORY_BSWAP to false

 tcg/aarch64/tcg-target.h     |   1 +
 tcg/arm/tcg-target.h         |   1 +
 tcg/i386/tcg-target.h        |   3 +
 tcg/mips/tcg-target.h        |   1 +
 tcg/ppc/tcg-target.h         |   1 +
 tcg/s390/tcg-target.h        |   1 +
 tcg/sparc/tcg-target.h       |   1 +
 tcg/tci/tcg-target.h         |   2 +
 tcg/aarch64/tcg-target.inc.c |  63 +++--------
 tcg/arm/tcg-target.inc.c     | 198 +++++++++--------------------------
 tcg/i386/tcg-target.inc.c    | 112 +++++++-------------
 tcg/optimize.c               |  12 +++
 tcg/tcg-op.c                 | 118 ++++++++++++++++++++-
 13 files changed, 234 insertions(+), 280 deletions(-)

-- 
2.17.2
