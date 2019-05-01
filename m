Received: from eggs.gnu.org ([209.51.188.92]:38202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRG-0006Kq-FE
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRB-0002ml-Tn
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:43644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRB-0002mP-N6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id n8so7743370plp.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 30 Apr 2019 22:05:07 -0700
Message-Id: <20190501050536.15580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/29] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changes since v1:
  * Postponing vector select.  I plan to re-work that.
  * Postponing some of the target/* changes.  I plan to submit most of
    those separately via the appropriate trees.  The exception is abs(),
    which I'm still doing here.


r~


David Hildenbrand (1):
  tcg: Implement tcg_gen_gvec_3i()

Philippe Mathieu-Daudé (2):
  target/ppc: Use tcg_gen_abs_i32
  target/tricore: Use tcg_gen_abs_tl

Richard Henderson (26):
  tcg: Do not recreate INDEX_op_neg_vec unless supported
  tcg: Allow add_vec, sub_vec, neg_vec, not_vec to be expanded
  tcg: Specify optional vector requirements with a list
  tcg: Assert fixed_reg is read-only
  tcg: Return bool success from tcg_out_mov
  tcg: Support cross-class moves without instruction support
  tcg: Promote tcg_out_{dup,dupi}_vec to backend interface
  tcg: Manually expand INDEX_op_dup_vec
  tcg: Add tcg_out_dupm_vec to the backend interface
  tcg/i386: Implement tcg_out_dupm_vec
  tcg/aarch64: Implement tcg_out_dupm_vec
  tcg: Add INDEX_op_dup_mem_vec
  tcg: Add gvec expanders for variable shift
  tcg/i386: Support vector variable shift opcodes
  tcg/aarch64: Support vector variable shift opcodes
  tcg: Add gvec expanders for vector shift by scalar
  tcg/i386: Support vector scalar shift opcodes
  tcg: Add support for integer absolute value
  tcg: Add support for vector absolute value
  tcg/i386: Support vector absolute value
  tcg/aarch64: Support vector absolute value
  target/arm: Use tcg_gen_abs_i64 and tcg_gen_gvec_abs
  target/cris: Use tcg_gen_abs_tl
  target/ppc: Use tcg_gen_abs_tl
  target/s390x: Use tcg_gen_abs_i64
  target/xtensa: Use tcg_gen_abs_i32

 accel/tcg/tcg-runtime.h             |  20 +
 target/arm/helper.h                 |   2 -
 tcg/aarch64/tcg-target.h            |   3 +-
 tcg/aarch64/tcg-target.opc.h        |   2 +
 tcg/i386/tcg-target.h               |   5 +-
 tcg/tcg-op-gvec.h                   |  64 +-
 tcg/tcg-op.h                        |  14 +
 tcg/tcg-opc.h                       |   2 +
 tcg/tcg.h                           |  21 +
 accel/tcg/tcg-runtime-gvec.c        | 192 ++++++
 target/arm/neon_helper.c            |   5 -
 target/arm/translate-a64.c          |  41 +-
 target/arm/translate-sve.c          |   9 +-
 target/arm/translate.c              | 144 +++--
 target/cris/translate.c             |   9 +-
 target/ppc/translate.c              |  68 +-
 target/ppc/translate/spe-impl.inc.c |  14 +-
 target/ppc/translate/vmx-impl.inc.c |   7 +-
 target/s390x/translate.c            |   8 +-
 target/tricore/translate.c          |  27 +-
 target/xtensa/translate.c           |   9 +-
 tcg/aarch64/tcg-target.inc.c        | 118 +++-
 tcg/arm/tcg-target.inc.c            |   7 +-
 tcg/i386/tcg-target.inc.c           | 163 ++++-
 tcg/mips/tcg-target.inc.c           |   3 +-
 tcg/optimize.c                      |   8 +-
 tcg/ppc/tcg-target.inc.c            |   3 +-
 tcg/riscv/tcg-target.inc.c          |   5 +-
 tcg/s390/tcg-target.inc.c           |   3 +-
 tcg/sparc/tcg-target.inc.c          |   3 +-
 tcg/tcg-op-gvec.c                   | 935 +++++++++++++++++++++++-----
 tcg/tcg-op-vec.c                    | 270 +++++++-
 tcg/tcg-op.c                        |  20 +
 tcg/tcg.c                           | 262 ++++++--
 tcg/tci/tcg-target.inc.c            |   3 +-
 tcg/README                          |   4 +
 36 files changed, 2002 insertions(+), 471 deletions(-)

-- 
2.17.1
