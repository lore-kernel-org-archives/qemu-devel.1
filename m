Received: from eggs.gnu.org ([2001:4830:134:3::10]:41857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbyr-00022m-J1
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbyk-0002kk-9S
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:34:45 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:50864 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbyj-0002iF-UM
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:34:42 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 26 Dec 2016 21:34:38 +0100
Message-Id: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/6] hypertrace: Lightweight guest-to-QEMU
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

Llu=C3=ADs Vilanova (6):
      hypertrace: Add documentation
      hypertrace: Add tracing event "guest_hypertrace"
      hypertrace: [*-user] Add QEMU-side proxy to "guest_hypertrace" even=
t
      hypertrace: [softmmu] Add QEMU-side proxy to "guest_hypertrace" eve=
nt
      hypertrace: Add guest-side user-level library
      hypertrace: Add guest-side Linux module


 Makefile                                           |    8=20
 Makefile.objs                                      |    6=20
 bsd-user/main.c                                    |   17 +
 bsd-user/mmap.c                                    |   15 +
 bsd-user/syscall.c                                 |   34 +-
 configure                                          |   40 ++
 docs/hypertrace.txt                                |  237 ++++++++++++++
 docs/tracing.txt                                   |    3=20
 hypertrace/Makefile.objs                           |   21 +
 hypertrace/common.c                                |   26 ++
 hypertrace/common.h                                |   23 +
 hypertrace/guest/linux-module/Kbuild.in            |    7=20
 hypertrace/guest/linux-module/Makefile             |   23 +
 .../include/linux/qemu-hypertrace-internal.h       |   46 +++
 .../linux-module/include/linux/qemu-hypertrace.h   |   73 ++++
 hypertrace/guest/linux-module/qemu-hypertrace.c    |  149 +++++++++
 hypertrace/guest/user/Makefile                     |   30 ++
 hypertrace/guest/user/common.c                     |  296 ++++++++++++++=
++++
 hypertrace/guest/user/qemu-hypertrace.h            |   80 +++++
 hypertrace/softmmu.c                               |  235 ++++++++++++++
 hypertrace/user.c                                  |  332 ++++++++++++++=
++++++
 hypertrace/user.h                                  |   63 ++++
 include/hw/pci/pci.h                               |    2=20
 include/qom/cpu.h                                  |    4=20
 linux-user/main.c                                  |   19 +
 linux-user/mmap.c                                  |   17 +
 linux-user/qemu.h                                  |    3=20
 linux-user/syscall.c                               |   31 +-
 trace-events                                       |   11 +
 trace/Makefile.objs                                |    2=20
 30 files changed, 1826 insertions(+), 27 deletions(-)
 create mode 100644 docs/hypertrace.txt
 create mode 100644 hypertrace/Makefile.objs
 create mode 100644 hypertrace/common.c
 create mode 100644 hypertrace/common.h
 create mode 100644 hypertrace/guest/linux-module/Kbuild.in
 create mode 100644 hypertrace/guest/linux-module/Makefile
 create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace-internal.h
 create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace.h
 create mode 100644 hypertrace/guest/linux-module/qemu-hypertrace.c
 create mode 100644 hypertrace/guest/user/Makefile
 create mode 100644 hypertrace/guest/user/common.c
 create mode 100644 hypertrace/guest/user/qemu-hypertrace.h
 create mode 100644 hypertrace/softmmu.c
 create mode 100644 hypertrace/user.c
 create mode 100644 hypertrace/user.h


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Daniel P Berrange <berrange@redhat.com>
