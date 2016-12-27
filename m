Received: from eggs.gnu.org ([2001:4830:134:3::10]:37513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLtoU-0006Kp-Iz
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLtoR-00074E-Gt
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:37:18 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:44884)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLtoR-00073G-4G
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:37:15 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Tue, 27 Dec 2016 16:37:11 +0100
Message-Id: <148285303159.12721.5833400768046299304.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 0/6] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This series proposes a generic (target-agnostic) instruction translation
framework.

It basically provides a generic main loop for instruction disassembly, wh=
ich
calls target-specific functions when necessary. This generalization makes
inserting new code in the main loop easier, and helps in keeping all targ=
ets in
synch as to the contents of it.

This series also paves the way towards adding events to trace guest code
execution (BBLs and instructions).

I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits =
in the
current organization, but will port the rest when this series gets merged.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---

Changes in v3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on 0737f32daf.


Changes in v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Port ARM and AARCH64 targets.
* Fold single-stepping checks into "max_insns" [Richard Henderson].
* Move instruction start marks to target code [Richard Henderson].
* Add target hook for TB start.
* Check for TCG temporary leaks.
* Move instruction disassembly into a target hook.
* Make breakpoint_hit() return an enum to accomodate target's needs (ARM).


Llu=C3=ADs Vilanova (6):
      Pass generic CPUState to gen_intermediate_code()
      queue: Add macro for incremental traversal
      target: [tcg] Add generic translation framework
      target: [tcg] Redefine DISAS_* onto the generic translation framewo=
rk (DJ_*)
      target: [tcg,i386] Port to generic translation framework
      target: [tcg,arm] Port to generic translation framework


 include/exec/exec-all.h               |   13 -
 include/exec/gen-icount.h             |    2=20
 include/exec/translate-all_template.h |   76 +++
 include/qemu/queue.h                  |    5=20
 include/qom/cpu.h                     |   21 +
 target-alpha/translate.c              |   11 -
 target-arm/translate-a64.c            |  348 ++++++++--------
 target-arm/translate.c                |  718 +++++++++++++++++----------=
------
 target-arm/translate.h                |   41 +-
 target-cris/translate.c               |   20 -
 target-i386/translate.c               |  304 ++++++--------
 target-lm32/translate.c               |   22 +
 target-m68k/translate.c               |   18 -
 target-microblaze/translate.c         |   22 +
 target-mips/translate.c               |   15 -
 target-moxie/translate.c              |   14 -
 target-openrisc/translate.c           |   22 +
 target-ppc/translate.c                |   15 -
 target-s390x/translate.c              |   16 -
 target-sh4/translate.c                |   15 -
 target-sparc/translate.c              |   11 -
 target-tilegx/translate.c             |    7=20
 target-tricore/translate.c            |    9=20
 target-unicore32/translate.c          |   20 -
 target-xtensa/translate.c             |   13 -
 translate-all.c                       |    2=20
 translate-all_template.h              |  202 +++++++++
 27 files changed, 1128 insertions(+), 854 deletions(-)
 create mode 100644 include/exec/translate-all_template.h
 create mode 100644 translate-all_template.h


To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
