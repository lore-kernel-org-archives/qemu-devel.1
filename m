Received: from eggs.gnu.org ([2001:4830:134:3::10]:60102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGW-0004UU-6s
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGR-0003q4-Dr
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:47 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:42252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGQ-0003oE-WE
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:43 -0400
Received: by mail-pf1-x42b.google.com with SMTP id l9-v6so5641008pff.9
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:25 -0700
Message-Id: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RFC PATCH 00/13] target/arm: Derive cpu id regs from
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is something we talked about in the context of enabling sve in
system mode.  We don't want to replicate info between these two locations.

I'm not 100% happy with this, thus the RFC.  In particular, there are
several places in id_isar0, id_isar2, and id_isar4 that expose micro-
architectural details of the cpus.  We cannot infer these values.
We'll not be able to replicate the exact id values without additional
changes.

But I'll also note that with ARM_FEATURE_SWP, we're now at 60 feature
bits, which means that we only have 4 remaining before we have to come
up with another solution there.

I do wonder if we should instead introduce some little inline functions
to test each of the current feature bits, and once that's done convert
those to test cpu->id_* bits.

Most, but not all, of the feature bits would go away.  We'd have the
exact id values one would expect for a given cpu without having to
replicate the info.

Thoughts, one way or the other?


r~


Richard Henderson (13):
  target/arm: Add ARM_FEATURE_SWP
  target/arm: Derive id_isar0 from features
  target/arm: Derive id_isar1 from features
  target/arm: Derive id_isar2 from features
  target/arm: Derive id_isar3 from features
  target/arm: Derive id_isar4 from features
  target/arm: Derive id_isar5 and id_isar6 from features
  target/arm: Derive id_pfr0 from features
  target/arm: Derive id_pfr1 from features
  target/arm: Derive id_aa64isar0 from features
  target/arm: Derive id_aa64isar1 from features
  target/arm: Derive id_aa64pfr0 from features
  target/arm: Remove assertions from resolve_id_regs

 target/arm/cpu.h       |   1 +
 linux-user/elfload.c   |   3 +-
 target/arm/cpu.c       | 381 +++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c |   4 +
 4 files changed, 388 insertions(+), 1 deletion(-)

-- 
2.17.1
