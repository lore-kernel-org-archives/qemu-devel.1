Received: from eggs.gnu.org ([209.51.188.92]:40038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWP-0008K7-En
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWO-0007dC-9r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:40779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWO-0007cW-2i
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id c207so3461582pfc.7
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:04 -1000
Message-Id: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/38] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Based-on: tcg-next, which at present is only tcg_gen_extract2.

The dupm patches have been on list before, with a larger context
of supporting tcg/ppc.  The rest of the set was written to support
David's s390 vector patches.  In particular:

(1) Add vector absolute value.
(2) Add vector shift by non-constant scalar.
(3) Add vector shift by vector.
(4) Add vector select.
(5) Be more precise in handling target-specific vector expansions.

And then there's a set of bugs that I encountered while working
on this across x86, aa64, and ppc hosts.  Tested primarily with
aa64 as the guest, via RISU.


r~


David Hildenbrand (1):
  tcg: Implement tcg_gen_gvec_3i()

Richard Henderson (37):
  target/arm: Fill in .opc for cmtst_op
  tcg: Assert fixed_reg is read-only
  tcg: Return bool success from tcg_out_mov
  tcg: Support cross-class moves without instruction support
  tcg: Allow add_vec, sub_vec, neg_vec, not_vec to be expanded
  tcg: Promote tcg_out_{dup,dupi}_vec to backend interface
  tcg: Manually expand INDEX_op_dup_vec
  tcg: Add tcg_out_dupm_vec to the backend interface
  tcg/i386: Implement tcg_out_dupm_vec
  tcg/aarch64: Implement tcg_out_dupm_vec
  tcg: Add INDEX_op_dup_mem_vec
  tcg: Add gvec expanders for variable shift
  tcg/i386: Support vector variable shift opcodes
  tcg/aarch64: Support vector variable shift opcodes
  tcg: Specify optional vector requirements with a list
  tcg: Add gvec expanders for vector shift by scalar
  tcg/i386: Support vector scalar shift opcodes
  tcg: Add support for integer absolute value
  tcg: Add support for vector absolute value
  target/arm: Use tcg_gen_abs_i64 and tcg_gen_gvec_abs
  target/cris: Use tcg_gen_abs_tl
  target/ppc: Use tcg_gen_abs_tl
  target/s390x: Use tcg_gen_abs_i64
  target/xtensa: Use tcg_gen_abs_i32
  tcg/i386: Support vector absolute value
  tcg/aarch64: Support vector absolute value
  tcg: Add support for vector comparison select
  tcg/i386: Support vector comparison select value
  tcg/aarch64: Support vector comparison select value
  target/ppc: Use vector variable shifts for VS{L,R,RA}{B,H,W,D}
  target/arm: Vectorize USHL and SSHL
  tcg/aarch64: Do not advertise minmax for MO_64
  tcg: Do not recreate INDEX_op_neg_vec unless supported
  tcg: Introduce do_op3_nofail for vector expansion
  tcg: Expand vector minmax using cmp+cmpsel
  tcg/aarch64: Use MVNI for expansion of dupi
  tcg/aarch64: Use ORRI and BICI for vector logical operations

 accel/tcg/tcg-runtime.h             |  20 +
 target/arm/helper.h                 |  17 +-
 target/arm/translate.h              |   6 +
 target/ppc/helper.h                 |  24 +-
 tcg/aarch64/tcg-target.h            |   4 +-
 tcg/aarch64/tcg-target.opc.h        |   2 +
 tcg/i386/tcg-target.h               |   6 +-
 tcg/i386/tcg-target.opc.h           |   1 -
 tcg/tcg-op-gvec.h                   |  60 +-
 tcg/tcg-op.h                        |  16 +
 tcg/tcg-opc.h                       |   3 +
 tcg/tcg.h                           |  20 +
 accel/tcg/tcg-runtime-gvec.c        | 180 ++++++
 target/arm/neon_helper.c            |  38 --
 target/arm/translate-a64.c          |  59 +-
 target/arm/translate-sve.c          |   9 +-
 target/arm/translate.c              | 432 ++++++++++---
 target/arm/vec_helper.c             | 176 ++++++
 target/cris/translate.c             |   9 +-
 target/ppc/int_helper.c             |   6 +-
 target/ppc/translate.c              |  80 +--
 target/ppc/translate/vmx-impl.inc.c | 175 +++++-
 target/s390x/translate.c            |   8 +-
 target/xtensa/translate.c           |   9 +-
 tcg/aarch64/tcg-target.inc.c        | 227 ++++++-
 tcg/arm/tcg-target.inc.c            |   7 +-
 tcg/i386/tcg-target.inc.c           | 176 +++++-
 tcg/mips/tcg-target.inc.c           |   3 +-
 tcg/optimize.c                      |   8 +-
 tcg/ppc/tcg-target.inc.c            |   3 +-
 tcg/riscv/tcg-target.inc.c          |   5 +-
 tcg/s390/tcg-target.inc.c           |   3 +-
 tcg/sparc/tcg-target.inc.c          |   3 +-
 tcg/tcg-op-gvec.c                   | 917 +++++++++++++++++++++++-----
 tcg/tcg-op-vec.c                    | 259 +++++++-
 tcg/tcg-op.c                        |  20 +
 tcg/tcg.c                           | 256 ++++++--
 tcg/tci/tcg-target.inc.c            |   3 +-
 tcg/README                          |  16 +
 39 files changed, 2699 insertions(+), 567 deletions(-)

-- 
2.17.1
