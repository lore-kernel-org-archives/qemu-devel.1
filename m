Received: from eggs.gnu.org ([209.51.188.92]:34982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8Ic-0003D9-7f
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8Ib-0005ZI-4D
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:06:58 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu8Ia-0005YA-ML
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:06:57 -0500
Received: by mail-pl1-x643.google.com with SMTP id y10so2416733plp.0
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 20:06:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 13 Feb 2019 20:06:48 -0800
Message-Id: <20190214040652.4811-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org

We've talked about this before, caching state to reduce the
amount of computation that happens looking up each TB.

I know that Peter has been concerned that we would not be able to 
reliably maintain all of the places that need to be updates to
keep this up-to-date.

Well, modulo dirty tricks within linux-user, it appears as if
exception delivery and return, plus after every TB-ending write
to a system register is sufficient.

There seems to be a noticable improvement, although wall-time
is harder to come by -- all of my system-level measurements
include user input, and my user-level measurements seem to be
too small to matter.


r~


Richard Henderson (4):
  target/arm: Split out recompute_hflags et al
  target/arm: Rebuild hflags at el changes and MSR writes
  target/arm: Assert hflags is correct in cpu_get_tb_cpu_state
  target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 target/arm/cpu.h           |  22 ++-
 target/arm/helper.h        |   3 +
 target/arm/internals.h     |   4 +
 linux-user/syscall.c       |   1 +
 target/arm/cpu.c           |   1 +
 target/arm/helper-a64.c    |   3 +
 target/arm/helper.c        | 267 ++++++++++++++++++++++---------------
 target/arm/machine.c       |   1 +
 target/arm/op_helper.c     |   1 +
 target/arm/translate-a64.c |   6 +-
 target/arm/translate.c     |  14 +-
 11 files changed, 204 insertions(+), 119 deletions(-)

-- 
2.17.1
