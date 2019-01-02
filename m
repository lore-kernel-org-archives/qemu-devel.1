Received: from eggs.gnu.org ([208.118.235.92]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gecbq-0005rC-U4
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gecbm-0007oQ-Tf
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:14:42 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  2 Jan 2019 09:14:14 +0000
Message-Id: <20190102091423.21155-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v5 0/9] target/ppc: prepare for conversion to
 TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

This patchset is an attempt at trying to improve the VMX (Altivec) instruction
performance by laying the groundwork for use of the new TCG vector operations.

Patches 1 and 2 fix a sign-extension error discovered in EXTRACT_SHELPER and an
associated typo in the SIMM5 macro which were discovered whilst testing Richard's
follow-on TCG vector improvements patchset.

In order to use TCG vector operations, the registers must be accessible from cpu_env
whilst currently they are accessed via arrays of static TCG globals. Patches 3-5
are therefore mechanical patches which introduce access helpers for FPR, AVR and VSR
registers using the supplied TCGv_i64 parameter.

Once this is done, patch 6 enables us to remove the static TCG global arrays and updates
the access helpers to read/write to the relevant fields in cpu_env directly.

Patches 7 and 8 perform the legwork required to enable VSX instructions to be converted
to use TCG vector operations in future by rearranging the FP, VMX and VSX registers into
a single aligned VSR register array (the scope of this patchset is VMX only).

Patch 9 removes the AVR* macros and replaces them with the corresponding Vsr* macros
since they are equivalent.

Finally thanks to Richard for taking the time to answer some of my (mostly beginner)
questions related to TCG.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v5:
- Fix up KVM-enabled builds on PPC host due to missing conversion of target/ppc/kvm.c

v4:
- Rebase onto master
- Add extra R-B tags from Richard
- Leave HI_IDX/LO_IDX in int_helper.c in patch 9 (similarly named macros are also
  used in other files so let's ensure there is no confusion)
- Add cpu_fpr_ptr(), cpu_vsrl_ptr() and cpu_avr_ptr() as suggested by Richard in
  patch 8

v3:
- Rebase onto master, drop RFC prefix, alter subject line
- Add A-B tags from David
- Add SIMM5/EXTRACT_HELPER macro fix patches to the start of the series
- Drop patch 4 from previous patchset (delay AVR register writeback) as it should
  not be required.
- Remove extra get_fpr() accidentally added to GEN_FLOAT macros in patch 3
- Fix temporary leak when VMX/VSX not enabled in patches 4 and 5
- Add patch to remove AVR* macros, replacing them with Vsr* macros
- Drop patches converting logical, add and sub instructions to TCG vector ops (let
  Richard incorporate this into his TCG vector improvements patchset)

v2:
- Rebase onto master
- Add comment explaining rationale for FPR helpers in description for patch 1
- Add R-B tags from Richard
- Add patch 3 to delay AVR register writeback as spotted by Richard
- Add patches 6 and 7 to merge FPR, VMX and VSX registers into the vsr array
  to facilitate conversion of VSX instructions to vector operations later
- Fix accidental bug whereby the conversion of get_vsr()/set_vsr() to access
  data from cpu_env was incorrectly squashed into patch 3
- Move set_fpr() further down in gen_fsqrts() and gen_frsqrtes() in patch 1

Mark Cave-Ayland (9):
  target/ppc: fix typo in SIMM5 extraction helper
  target/ppc: switch EXTRACT_HELPER macros over to use
    sextract32/extract32
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
  target/ppc: replace AVR* macros with Vsr* macros

 linux-user/ppc/signal.c             |  28 +-
 target/ppc/arch_dump.c              |  15 +-
 target/ppc/cpu.h                    |  42 +-
 target/ppc/gdbstub.c                |   8 +-
 target/ppc/int_helper.c             |  86 ++--
 target/ppc/internal.h               |  39 +-
 target/ppc/kvm.c                    |  24 +-
 target/ppc/machine.c                |  72 ++-
 target/ppc/monitor.c                |   4 +-
 target/ppc/translate.c              |  73 ++-
 target/ppc/translate/dfp-impl.inc.c |   2 +-
 target/ppc/translate/fp-impl.inc.c  | 486 +++++++++++++++-----
 target/ppc/translate/vmx-impl.inc.c | 154 +++++--
 target/ppc/translate/vsx-impl.inc.c | 862 ++++++++++++++++++++++++++----------
 target/ppc/translate_init.inc.c     |  26 +-
 15 files changed, 1374 insertions(+), 547 deletions(-)

-- 
2.11.0
