Received: from eggs.gnu.org ([2001:4830:134:3::10]:52841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92s-0001dq-CL
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92o-0002n3-I3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:57 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:45372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92n-0001sS-VN
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:54 -0500
Received: by mail-pg1-x534.google.com with SMTP id y4so7328373pgc.12
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:37 -0800
Message-Id: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/34] tcg, target/ppc vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This implements some of the things that I talked about with Mark
this morning / yesterday.  In particular:

(0) Implement expanders for nand, nor, eqv logical operations.

(1) Implement saturating arithmetic for the tcg backend.

    While I had expanders for these, they always went to helpers.
    It's easy enough to expand byte and half-word operations for x86.
    Beyond that, 32 and 64-bit operations can be expanded with integers.

(2) Implement minmax arithmetic for the tcg backend.

    While I had integral minmax operations, I had not yet added
    any vector expanders for this.  (The integral stuff came in
    for atomic minmax.)

(3) Trivial conversions to minmax for target/arm.

(4) Patches 11-18 are identical to Mark's.

(5) Patches 19-25 implement splat and logicals for VMX and VSX.

    VSX is no more difficult than VMX for these.  It does seem to be
    just about everything that we can do for VSX at the momement.

(6) Patches 26-33 implement saturating arithmetic for VMX.

(7) Patch 34 implements minmax arithmetic for VMX.

I've tested the new operations via aarch64 guest, as that's the set
of risu test cases I've got handy.  The rest is untested so far.


r~


Mark Cave-Ayland (8):
  target/ppc: introduce get_fpr() and set_fpr() helpers for FP register
    access
  target/ppc: introduce get_avr64() and set_avr64() helpers for VMX
    register access
  target/ppc: introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()
    helpers for VSR register access
  target/ppc: switch FPR, VMX and VSX helpers to access data directly
    from cpu_env
  target/ppc: merge ppc_vsr_t and ppc_avr_t union types
  target/ppc: move FP and VMX registers into aligned vsr register array
  target/ppc: convert VMX logical instructions to use vector operations
  target/ppc: convert vaddu[b,h,w,d] and vsubu[b,h,w,d] over to use
    vector operations

Richard Henderson (26):
  tcg: Add logical simplifications during gvec expand
  target/arm: Rely on optimization within tcg_gen_gvec_or
  tcg: Add gvec expanders for nand, nor, eqv
  tcg: Add write_aofs to GVecGen4
  tcg: Add opcodes for vector saturated arithmetic
  tcg/i386: Implement vector saturating arithmetic
  tcg: Add opcodes for vector minmax arithmetic
  tcg/i386: Implement vector minmax arithmetic
  target/arm: Use vector minmax expanders for aarch64
  target/arm: Use vector minmax expanders for aarch32
  target/ppc: convert vspltis[bhw] to use vector operations
  target/ppc: convert vsplt[bhw] to use vector operations
  target/ppc: nand, nor, eqv are now generic vector operations
  target/ppc: convert VSX logical operations to vector operations
  target/ppc: convert xxspltib to vector operations
  target/ppc: convert xxspltw to vector operations
  target/ppc: convert xxsel to vector operations
  target/ppc: Pass integer to helper_mtvscr
  target/ppc: Use helper_mtvscr for reset and gdb
  target/ppc: Remove vscr_nj and vscr_sat
  target/ppc: Add helper_mfvscr
  target/ppc: Use mtvscr/mfvscr for vmstate
  target/ppc: Add set_vscr_sat
  target/ppc: Split out VSCR_SAT to a vector field
  target/ppc: convert vadd*s and vsub*s to vector operations
  target/ppc: convert vmin* and vmax* to vector operations

 accel/tcg/tcg-runtime.h             |  23 +
 target/ppc/cpu.h                    |  30 +-
 target/ppc/helper.h                 |  57 +-
 target/ppc/internal.h               |  29 +-
 tcg/aarch64/tcg-target.h            |   2 +
 tcg/i386/tcg-target.h               |   2 +
 tcg/tcg-op-gvec.h                   |  18 +
 tcg/tcg-op.h                        |  11 +
 tcg/tcg-opc.h                       |   8 +
 tcg/tcg.h                           |   2 +
 accel/tcg/tcg-runtime-gvec.c        | 257 +++++++++
 linux-user/ppc/signal.c             |  24 +-
 target/arm/translate-a64.c          |  41 +-
 target/arm/translate-sve.c          |   6 +-
 target/arm/translate.c              |  37 +-
 target/ppc/arch_dump.c              |  15 +-
 target/ppc/gdbstub.c                |   8 +-
 target/ppc/int_helper.c             | 194 +++----
 target/ppc/machine.c                | 116 +++-
 target/ppc/monitor.c                |   4 +-
 target/ppc/translate.c              |  74 ++-
 target/ppc/translate/dfp-impl.inc.c |   2 +-
 target/ppc/translate/fp-impl.inc.c  | 490 ++++++++++++----
 target/ppc/translate/vmx-impl.inc.c | 349 +++++++-----
 target/ppc/translate/vsx-impl.inc.c | 834 +++++++++++++++++++---------
 target/ppc/translate_init.inc.c     |  31 +-
 tcg/i386/tcg-target.inc.c           | 106 ++++
 tcg/tcg-op-gvec.c                   | 305 ++++++++--
 tcg/tcg-op-vec.c                    |  75 ++-
 tcg/tcg.c                           |  10 +
 30 files changed, 2275 insertions(+), 885 deletions(-)

-- 
2.17.2
