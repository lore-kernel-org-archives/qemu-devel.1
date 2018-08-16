Received: from eggs.gnu.org ([2001:4830:134:3::10]:50448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fq8RB-0002IV-3v
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fq8R7-0006hs-P0
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:01 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fq8R7-0006gM-8v
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:54:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id x17-v6so1332455pfh.5
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 19:54:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 15 Aug 2018 19:54:47 -0700
Message-Id: <20180816025452.21358-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] tcg: Reorg 128-bit atomic operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com

The other day Emilio noticed that we weren't setting CONFIG_ATOMIC128
for x86_64, despite forcing -mcx16 on the command-line.  It seems that
gcc has changed behaviour with version 7.

There's a rather long discussion about this:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80878

It does not appear that gcc will ever quite align with our needs here.
I have added a second configure test, and have split the test to be 
used by the rest of QEMU into two compile-time constants.  This lets
us refactor the code a bit and remove some conditional compilation.

In addition, no version of gcc supports __sync_compare_and_swap_16
for aarch64.  Inline some asm for that case.

I've also checked power8, which does support CONFIG_ATOMIC128.

Comments?


r~


Richard Henderson (5):
  tcg: Split CONFIG_ATOMIC128
  target/i386: Convert to HAVE_CMPXCHG128
  target/s390x: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
  target/arm: Convert to HAVE_CMPXCHG128
  target/ppc: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128

 accel/tcg/atomic_template.h |  22 ++-
 include/qemu/atomic128.h    | 162 ++++++++++++++++++++++
 target/ppc/helper.h         |   2 +-
 tcg/tcg.h                   |  29 ++--
 accel/tcg/cputlb.c          |   3 +-
 accel/tcg/user-exec.c       |   5 +-
 target/arm/helper-a64.c     | 259 ++++++++++++++++++------------------
 target/i386/mem_helper.c    |   9 +-
 target/ppc/mem_helper.c     |  33 ++++-
 target/ppc/translate.c      | 115 ++++++++--------
 target/s390x/mem_helper.c   |  87 ++++++------
 configure                   |  19 +++
 12 files changed, 481 insertions(+), 264 deletions(-)
 create mode 100644 include/qemu/atomic128.h

-- 
2.17.1
