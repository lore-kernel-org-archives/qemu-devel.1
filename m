Received: from eggs.gnu.org ([2001:4830:134:3::10]:46905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPTfS-0004LI-Pr
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPTfN-0003KC-Oj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:03:02 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:52298)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPTfN-0003Jh-82
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:02:57 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<87bmpbx9r9.fsf@linaro.org>
Date: Mon, 26 Jun 2017 16:02:47 +0300
In-Reply-To: <87bmpbx9r9.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Mon, 26 Jun 2017 12:34:50 +0100")
Message-ID: <8737am9a14.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v9 00/26] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Alex Benn=C3=A9e writes:

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

>> This series proposes a generic (target-agnostic) instruction translation
>> framework.
>>=20
>> It basically provides a generic main loop for instruction disassembly, w=
hich
>> calls target-specific functions when necessary. This generalization makes
>> inserting new code in the main loop easier, and helps in keeping all tar=
gets in
>> synch as to the contents of it.
>>=20
>> This series also paves the way towards adding events to trace guest code
>> execution (BBLs and instructions).
>>=20
>> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits=
 in the
>> current organization, but will port the rest when this series gets
>> merged.

> I started going through this but I found a number of problems. There are
> some merge failures against master due to recent changes (moving tcg
> into accel, the UPDATE/JUMP lockup fixes in ARM). I also ran into a
> number of compile failures which I've sent some fixup patches to.

> However the series does need to complete a clean compile on all arches
> (SoftMMU & linux-user) even though the porting to the new framework is
> partial.

> FWIW you can find my tree with fixups and other attempts to fixup
> compilation @ :

>   https://github.com/stsquad/qemu/tree/review/generic-tcg-v9

I've integrated them and I'm now compiling for all targets to make sure it
passes.

Thanks a lot,
  Lluis


>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>>=20
>> Changes in v9
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Further increase inter-mail sleep time during sending.
>>=20
>>=20
>> Changes in v8
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Increase inter-mail sleep time during sending (list keeps refusing som=
e emails
>> due to an excessive send rate).
>>=20
>>=20
>> Changes in v7
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Change BreakpointHitType (BH_*) for BreakpointCheckType (BC_*).
>> * Move target-specific translation functions to a struct (TranslatorOps).
>> * Split target-specific changes into multiple patches.
>> * Rebase on edf8bc9842.
>>=20
>>=20
>> Changes in v6
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Rebase on upstream master (64175afc69).
>> * Reorder fields in DisasContextBase to minimize padding [Richard Hender=
son].
>>=20
>>=20
>> Changes in v5
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Remove stray uses of "restrict" keyword.
>>=20
>>=20
>> Changes in v4
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Document new macro QTAILQ_FOREACH_CONTINUE [Peter Maydell].
>> * Fix coding style errors reported by checkpatch.
>> * Remove use of "restrict" in added functions; it makes older gcc versio=
ns barf
>> about compilation errors.
>>=20
>>=20
>> Changes in v3
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Rebase on 0737f32daf.
>>=20
>>=20
>> Changes in v2
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Port ARM and AARCH64 targets.
>> * Fold single-stepping checks into "max_insns" [Richard Henderson].
>> * Move instruction start marks to target code [Richard Henderson].
>> * Add target hook for TB start.
>> * Check for TCG temporary leaks.
>> * Move instruction disassembly into a target hook.
>> * Make breakpoint_hit() return an enum to accomodate target's needs (ARM=
).
>>=20
>>=20
>> Llu=C3=ADs Vilanova (26):
>> Pass generic CPUState to gen_intermediate_code()
>> queue: Add macro for incremental traversal
>> cpu-exec: Avoid global variables in icount-related functions
>> target: [tcg] Add generic translation framework
>> target: [tcg] Redefine DISAS_* onto the generic translation framework (D=
J_*)
>> target: [tcg,i386] Port to DisasContextBase
>> target: [tcg,i386] Refactor init_disas_context
>> target: [tcg,i386] Refactor init_globals
>> target: [tcg,i386] Refactor insn_start
>> target: [tcg,i386] Refactor breakpoint_check
>> target: [tcg,i386] Refactor disas_insn
>> target: [tcg,i386] Refactor tb_stop
>> target: [tcg,i386] Refactor disas_flags
>> target: [tcg,i386] Replace DISAS_* with DJ_*
>> target: [tcg,i386] Port to generic translation framework
>> target: [tcg,arm] Replace DISAS_* with DJ_*
>> target: [tcg,arm] Port to DisasContextBase
>> target: [tcg,arm] Port to init_disas_context
>> target: [tcg,arm] Port to init_globals
>> target: [tcg,arm] Port to tb_start
>> target: [tcg,arm] Port to insn_start
>> target: [tcg,arm] Port to breakpoint_check
>> target: [tcg,arm] Port to disas_insn
>> target: [tcg,arm] Port to tb_stop
>> target: [tcg,arm] Port to disas_flags
>> target: [tcg,arm] Port to generic translation framework
>>=20
>>=20
>> Makefile.target                |    1
>> include/exec/exec-all.h        |   13 +
>> include/exec/gen-icount.h      |    8 -
>> include/exec/translate-block.h |  125 ++++++++++
>> include/qemu/queue.h           |   12 +
>> include/qom/cpu.h              |   22 ++
>> target/alpha/translate.c       |   25 +-
>> target/arm/translate-a64.c     |  312 ++++++++++++-------------
>> target/arm/translate.c         |  503 ++++++++++++++++++++++------------=
------
>> target/arm/translate.h         |   38 ++-
>> target/cris/translate.c        |   26 +-
>> target/hppa/translate.c        |    6
>> target/i386/translate.c        |  353 +++++++++++++++-------------
>> target/lm32/translate.c        |   36 +--
>> target/m68k/translate.c        |   24 +-
>> target/microblaze/translate.c  |   28 +-
>> target/mips/translate.c        |   41 ++-
>> target/moxie/translate.c       |   16 +
>> target/nios2/translate.c       |    6
>> target/openrisc/translate.c    |   25 +-
>> target/ppc/translate.c         |   21 +-
>> target/ppc/translate_init.c    |   32 +--
>> target/s390x/translate.c       |   22 +-
>> target/sh4/translate.c         |   21 +-
>> target/sparc/translate.c       |   17 +
>> target/tilegx/translate.c      |    9 -
>> target/tricore/translate.c     |   11 -
>> target/unicore32/translate.c   |   26 +-
>> target/xtensa/translate.c      |   39 ++-
>> translate-all.c                |    2
>> translate-block.c              |  185 +++++++++++++++
>> 31 files changed, 1212 insertions(+), 793 deletions(-)
>> create mode 100644 include/exec/translate-block.h
>> create mode 100644 translate-block.c
>>=20
>>=20
>> To: qemu-devel@nongnu.org
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> --
> Alex Benn=C3=A9e
