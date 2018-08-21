Received: from eggs.gnu.org ([2001:4830:134:3::10]:50979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fs7cl-0003RE-LI
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fs7ci-0000Zh-FS
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fs7ch-0000ZC-PE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id f1-v6so8524574pgq.12
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:27:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 21 Aug 2018 07:26:59 -0700
Message-Id: <20180821142704.18783-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/5] tcg: Reorg 128-bit atomic operations
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

Changes since v1:
  * Fixed some errors in the lesser used paths (Emilio).
  * Dropped the target/s390x changes for now, as they conflict
    with other patches in-flight on list.
  * Raise EXCP_ATOMIC at translate time for AArch64, if needed.


r~


Richard Henderson (5):
  tcg: Split CONFIG_ATOMIC128
  target/i386: Convert to HAVE_CMPXCHG128
  target/arm: Convert to HAVE_CMPXCHG128
  target/arm: Check HAVE_CMPXCHG128 at transate time
  target/ppc: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128

 accel/tcg/atomic_template.h |  20 ++-
 include/qemu/atomic128.h    | 155 ++++++++++++++++++++++
 target/ppc/helper.h         |   2 +-
 tcg/tcg.h                   |  16 ++-
 accel/tcg/cputlb.c          |   3 +-
 accel/tcg/user-exec.c       |   5 +-
 target/arm/helper-a64.c     | 251 ++++++++++++++++++------------------
 target/arm/translate-a64.c  |  38 +++---
 target/i386/mem_helper.c    |   9 +-
 target/ppc/mem_helper.c     |  33 ++++-
 target/ppc/translate.c      | 115 +++++++++--------
 configure                   |  19 +++
 12 files changed, 443 insertions(+), 223 deletions(-)
 create mode 100644 include/qemu/atomic128.h

-- 
2.17.1
