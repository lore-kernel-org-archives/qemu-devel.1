Received: from eggs.gnu.org ([2001:4830:134:3::10]:54924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dachL-0001tP-HO
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dachG-0003tE-Hq
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:55:03 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:53635)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dachG-0003rR-5X
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:54:58 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 27 Jul 2017 09:54:48 +0300
Message-Id: <150113848793.25904.12006041120076726256.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/5] hypertrace: Lightweight guest-to-QEMU
 trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The hypertrace channel allows guest code to emit events in QEMU (the host=
) using
its tracing infrastructure (see "docs/trace.txt"). This works in both 'sy=
stem'
and 'user' modes, is architecture-agnostic and introduces minimal noise o=
n the
guest.

See first commit for a full description, use-cases and an example.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---

Changes in v6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Fix compilation errors.


Changes in v5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on 5a477a7806.
* Fix typo in "bsd-user/main.c" [Stephan Hajnoczi].
* Replace abort() with exit() in command-line errors [Stephan Hajnoczi].
* Fix alignment of data and control channels [Stephan Hajnoczi].
* Fix signal reflection in user-mode (SIGINT, SIGABRT, SIGSEGV) [Stephan =
Hajnoczi].
* Clarify semantics of hypertrace_guest_mmap_check() [Stephan Hajnoczi].
* Use uintptr_t instead of unsigned long in SEGV handler [Stephan Hajnocz=
i].
* Emit hypertrace's event with host-endian arguments [Stephan Hajnoczi].
* Enable true concurrency between user-mode guest threads by using a spea=
rate control channel page per client [Stephan Hajnoczi].
* Remove unused PAGE_SIZE define [Stephan Hajnoczi].
* Submit linux kernel API module separately to Linux upstream [Stephan Ha=
jnoczi].
* Assume guest code events are always enabled.


Changes in v4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Fix typo in stap script example.
* Fix compilation instructions in doc/hypertrace.txt.
* Rebase on 0737f32daf.


Changes in v3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on 4a58f35.
* Remove debugging printf's.
* Fix style issues identified by checkpatch.
* Fix control channel mapping in guest linux module.
* Add a short event description in "trace-events".
* Polish documentation in 1st patch.


Changes in v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Remove unnecessary casts for g2h() [Eric Blake].
* Use perror() [Eric Blake].
* Avoid expansions in application example [Eric Blake].
* Add copyright in document "hypertrace.txt" [Eric Blake].
* Make the user-mode hypertrace invocations thread-safe [Stefan Hajnoczi].
* Split dynamic hypertrace configuration into a separate "config" channel.

Llu=C3=ADs Vilanova (5):
      hypertrace: Add documentation
      hypertrace: Add tracing event "guest_hypertrace"
      hypertrace: [*-user] Add QEMU-side proxy to "guest_hypertrace" even=
t
      hypertrace: [softmmu] Add QEMU-side proxy to "guest_hypertrace" eve=
nt
      hypertrace: Add guest-side user-level library


 Makefile                           |   12 +
 Makefile.objs                      |    6 +
 bsd-user/main.c                    |   17 +
 bsd-user/mmap.c                    |   15 +
 bsd-user/syscall.c                 |   34 ++-
 configure                          |   36 +++
 docs/devel/tracing.txt             |    3=20
 docs/hypertrace.txt                |  225 ++++++++++++++++++++
 hypertrace/Makefile.objs           |   23 ++
 hypertrace/common.c                |   55 +++++
 hypertrace/common.h                |   25 ++
 hypertrace/guest/Makefile          |   30 +++
 hypertrace/guest/common.c          |  301 ++++++++++++++++++++++++++
 hypertrace/guest/qemu-hypertrace.h |   80 +++++++
 hypertrace/softmmu.c               |  237 +++++++++++++++++++++
 hypertrace/user.c                  |  414 ++++++++++++++++++++++++++++++=
++++++
 hypertrace/user.h                  |   71 ++++++
 include/hw/pci/pci.h               |    2=20
 include/qom/cpu.h                  |    4=20
 linux-user/main.c                  |   19 ++
 linux-user/mmap.c                  |   16 +
 linux-user/qemu.h                  |    3=20
 linux-user/signal.c                |   12 +
 linux-user/syscall.c               |   31 ++-
 rules.mak                          |    2=20
 trace-events                       |   11 +
 26 files changed, 1654 insertions(+), 30 deletions(-)
 create mode 100644 docs/hypertrace.txt
 create mode 100644 hypertrace/Makefile.objs
 create mode 100644 hypertrace/common.c
 create mode 100644 hypertrace/common.h
 create mode 100644 hypertrace/guest/Makefile
 create mode 100644 hypertrace/guest/common.c
 create mode 100644 hypertrace/guest/qemu-hypertrace.h
 create mode 100644 hypertrace/softmmu.c
 create mode 100644 hypertrace/user.c
 create mode 100644 hypertrace/user.h


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Daniel P Berrange <berrange@redhat.com>
