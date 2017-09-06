Received: from eggs.gnu.org ([2001:4830:134:3::10]:35889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpe2X-0007MS-1A
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpe2Q-0000cx-VS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:23:01 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:55258)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpe2Q-0000bS-Ex
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:22:54 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 20:22:41 +0300
Message-Id: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/20] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

This series adds an API to add instrumentation events.

It also provides additional APIs for:
* Controlling tracing events
* Peek/poke guest memory

There's still missing APIs for (can be added in later series?):
* Provide something like tracing's per-vCPU trace states (i.e., so that e=
ach
  vCPU can have different instrumentation code). It's still not clear to =
me if
  we should extend the per-vCPU bitmap with instrumentation events, or ot=
herwise
  somehow reuse the bits in tracing events (since they're currently limit=
ed).
* Peek/poke guest registers

The instrumentation code is dynamically loaded as a library into QEMU eit=
her
when it starts or later using its remote control interfaces.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---

Changes in v4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Add missing stub function.


Changes in v3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Use a separate event set for instrumentation (i.e., do not instrument t=
racing
  events) [Stefan Hajnoczi].
* Add API for peek/poke guest memory.


Changes in v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Update QEMU version in QAPI [Eric Blake].
* Clarify 'msg' result in QAPI is for humans only.
* Make 'msg' and 'handle' results optional in QAPI.
* Use a list of 'str' in 'instr-load' QAPI command.
* Update MAINTAINERS.
* Add macros for error-reporting in API.


Llu=C3=ADs Vilanova (20):
      instrument: Add documentation
      instrument: Add configure-time flag
      instrument: Add generic library loader
      instrument: [linux-user] Add command line library loader
      instrument: [bsd-user] Add command line library loader
      instrument: [softmmu] Add command line library loader
      instrument: [qapi] Add library loader
      instrument: [hmp] Add library loader
      instrument: Add basic control interface
      instrument: Add support for tracing events
      instrument: Track vCPUs
      instrument: Add event 'guest_cpu_enter'
      instrument: Add event 'guest_cpu_exit'
      instrument: Add event 'guest_cpu_reset'
      trace: Introduce a proper structure to describe memory accesses
      instrument: Add event 'guest_mem_before_trans'
      instrument: Add event 'guest_mem_before_exec'
      instrument: Add event 'guest_user_syscall'
      instrument: Add event 'guest_user_syscall_ret'
      instrument: Add API to manipulate guest memory


 .gitignore                                |    1=20
 MAINTAINERS                               |    7 +
 Makefile                                  |    8 +
 Makefile.objs                             |    4 +
 Makefile.target                           |    1=20
 bsd-user/main.c                           |   15 ++
 bsd-user/syscall.c                        |   11 ++
 configure                                 |   12 ++
 cpus-common.c                             |    9 +
 docs/instrument.txt                       |  174 +++++++++++++++++++++++=
+++
 hmp-commands.hx                           |   28 ++++
 include/exec/cpu_ldst_template.h          |   19 +--
 include/exec/cpu_ldst_useronly_template.h |   19 +--
 include/exec/helper-gen.h                 |    1=20
 include/exec/helper-proto.h               |    1=20
 include/exec/helper-tcg.h                 |    1=20
 instrument/Makefile.objs                  |    9 +
 instrument/cmdline.c                      |  124 ++++++++++++++++++
 instrument/cmdline.h                      |   49 +++++++
 instrument/control.c                      |  148 ++++++++++++++++++++++
 instrument/control.h                      |  123 ++++++++++++++++++
 instrument/control.inc.h                  |   56 ++++++++
 instrument/error.h                        |   34 +++++
 instrument/events.h                       |   86 +++++++++++++
 instrument/events.inc.h                   |  108 ++++++++++++++++
 instrument/helpers.h                      |    1=20
 instrument/load.c                         |  196 +++++++++++++++++++++++=
++++++
 instrument/load.h                         |   87 +++++++++++++
 instrument/qemu-instr/control.h           |  169 +++++++++++++++++++++++=
++
 instrument/qemu-instr/state.h             |  104 +++++++++++++++
 instrument/qemu-instr/types.h             |  115 +++++++++++++++++
 instrument/qemu-instr/types.inc.h         |   15 ++
 instrument/qemu-instr/visibility.h        |   58 +++++++++
 instrument/qmp.c                          |   88 +++++++++++++
 instrument/state.c                        |   72 +++++++++++
 instrument/trace.c                        |  125 ++++++++++++++++++
 linux-user/main.c                         |   19 +++
 linux-user/syscall.c                      |    6 +
 monitor.c                                 |   60 +++++++++
 qapi-schema.json                          |    3=20
 qapi/instrument.json                      |   96 ++++++++++++++
 qemu-options.hx                           |   19 +++
 qom/cpu.c                                 |    2=20
 stubs/Makefile.objs                       |    1=20
 stubs/instrument.c                        |   25 ++++
 tcg/tcg-op.c                              |   27 +++-
 trace/control-target.c                    |    2=20
 trace/control.c                           |    4 -
 trace/control.h                           |   24 ++++
 trace/mem-internal.h                      |   22 ++-
 trace/mem.h                               |    8 +
 vl.c                                      |   15 ++
 52 files changed, 2371 insertions(+), 40 deletions(-)
 create mode 100644 docs/instrument.txt
 create mode 100644 instrument/Makefile.objs
 create mode 100644 instrument/cmdline.c
 create mode 100644 instrument/cmdline.h
 create mode 100644 instrument/control.c
 create mode 100644 instrument/control.h
 create mode 100644 instrument/control.inc.h
 create mode 100644 instrument/error.h
 create mode 100644 instrument/events.h
 create mode 100644 instrument/events.inc.h
 create mode 100644 instrument/helpers.h
 create mode 100644 instrument/load.c
 create mode 100644 instrument/load.h
 create mode 100644 instrument/qemu-instr/control.h
 create mode 100644 instrument/qemu-instr/state.h
 create mode 100644 instrument/qemu-instr/types.h
 create mode 100644 instrument/qemu-instr/types.inc.h
 create mode 100644 instrument/qemu-instr/visibility.h
 create mode 100644 instrument/qmp.c
 create mode 100644 instrument/state.c
 create mode 100644 instrument/trace.c
 create mode 100644 qapi/instrument.json
 create mode 100644 stubs/instrument.c


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Emilio G. Cota <cota@braap.org>
Cc: Eric Blake <eblake@redhat.com>
