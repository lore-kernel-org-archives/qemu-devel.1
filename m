Received: from eggs.gnu.org ([2001:4830:134:3::10]:35707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dt2w6-0001So-U1
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 22:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dt2w2-0007i5-16
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 22:34:26 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:44197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dt2w1-0007hv-RB
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 22:34:21 -0400
Received: by mail-pf0-x22b.google.com with SMTP id e1so2327085pfk.1
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 19:34:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Sep 2017 19:34:11 -0700
Message-Id: <20170916023417.14599-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/6] TCG vectorization and example conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Now addressing the complex vector op issue.  I now expose TCGv_vec
to target front-ends, but opaque wrt the vector size.  One can thus
compose vector operations, as demonstrated in target/arm/.

The actual host vector length now becomes an argument to the *_vec
opcodes.  It's a little awkward, but does prevent an explosion of
opcode values.

All R-b dropped because all patches rewritten or heavily modified.

Whacha think?


r~


Richard Henderson (6):
  tcg: Add types and operations for host vectors
  tcg: Add vector expanders
  target/arm: Align vector registers
  target/arm: Use vector infrastructure for aa64 add/sub/logic
  tcg/i386: Add vector operations
  tcg/aarch64: Add vector operations

 Makefile.target              |   2 +-
 accel/tcg/tcg-runtime.h      |  24 ++
 target/arm/cpu.h             |   2 +-
 tcg/aarch64/tcg-target.h     |  20 +-
 tcg/i386/tcg-target.h        |  36 +-
 tcg/tcg-gvec-desc.h          |  49 +++
 tcg/tcg-op-gvec.h            | 143 ++++++++
 tcg/tcg-op.h                 |  26 ++
 tcg/tcg-opc.h                |  37 ++
 tcg/tcg.h                    |  34 ++
 accel/tcg/tcg-runtime-gvec.c | 255 +++++++++++++
 target/arm/translate-a64.c   | 216 +++++++----
 tcg/aarch64/tcg-target.inc.c | 340 ++++++++++++++---
 tcg/i386/tcg-target.inc.c    | 423 ++++++++++++++++++---
 tcg/tcg-op-gvec.c            | 853 +++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op.c                 | 234 ++++++++++++
 tcg/tcg.c                    |  77 +++-
 accel/tcg/Makefile.objs      |   2 +-
 tcg/README                   |  46 +++
 19 files changed, 2651 insertions(+), 168 deletions(-)
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 accel/tcg/tcg-runtime-gvec.c
 create mode 100644 tcg/tcg-op-gvec.c

-- 
2.13.5
