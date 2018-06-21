Received: from eggs.gnu.org ([2001:4830:134:3::10]:54934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fW3Vl-0000r4-LT
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fW3Vi-0004Kz-HM
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:45 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fW3Vi-0004Kb-2r
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:42 -0400
Received: by mail-pl0-x241.google.com with SMTP id s24-v6so2050104plq.6
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 10:36:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Jun 2018 07:36:33 -1000
Message-Id: <20180621173635.21537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] linux-user: Change mmap_lock to rwlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, cota@braap.org, qemu-arm@nongnu.org

The objective here is to avoid serializing the first-fault
and no-fault aarch64 sve loads.

When I first thought of this, we still had tb_lock protecting
code generation and merely needed mmap_lock to prevent mapping
changes while doing so.  Now (or very soon), tb_lock is gone
and user-only code generation dual-purposes the mmap_lock for
the code generation lock.

There are two other legacy users of mmap_lock within linux-user,
for ppc and mips.  I believe these are dead code from before these
ports were converted to use tcg atomics.

Thoughts?


r~


Based-on: <20180621143715.27176-1-richard.henderson@linaro.org> [tcg-next]
Based-on: <20180621015359.12018-1-richard.henderson@linaro.org> [v5 SVE]


Richard Henderson (2):
  exec: Split mmap_lock to mmap_rdlock/mmap_wrlock
  linux-user: Use pthread_rwlock_t for mmap_rd/wrlock

 include/exec/exec-all.h    |  6 ++--
 accel/tcg/cpu-exec.c       |  8 ++---
 accel/tcg/translate-all.c  |  4 +--
 bsd-user/mmap.c            | 18 +++++++++---
 exec.c                     |  6 ++--
 linux-user/elfload.c       |  2 +-
 linux-user/mips/cpu_loop.c |  2 +-
 linux-user/mmap.c          | 60 +++++++++++++++++++++++++-------------
 linux-user/ppc/cpu_loop.c  |  2 +-
 linux-user/syscall.c       |  4 +--
 target/arm/sve_helper.c    | 10 ++-----
 target/xtensa/op_helper.c  |  2 +-
 12 files changed, 76 insertions(+), 48 deletions(-)

-- 
2.17.1
