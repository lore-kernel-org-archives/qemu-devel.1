Received: from eggs.gnu.org ([2001:4830:134:3::10]:53388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgki-0005mJ-5a
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgkf-0007jC-1c
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:02:40 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:56192 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgke-0007ij-Ms
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:02:37 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:02:24 +0300
Message-Id: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
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
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

This series adds a basic interface to instrument tracing events and contr=
ol
their tracing state.

The instrumentation code is dynamically loaded into QEMU (either when it =
starts
or later using its remote control interfaces).

All events can be instrumented, but the instrumentable events must be exp=
licitly
specified at configure time.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---

Llu=C3=ADs Vilanova (13):
      instrument: Add documentation
      instrument: [none] Add null instrumentation mode
      instrument: [dynamic] Add dynamic instrumentation mode
      instrument: Allow adding the "instrument" property without modifyin=
g event files
      instrument: [dynamic] Add default public per-event functions
      instrument: Add event control interface
      instrument: Add generic command line library loader
      instrument: [linux-user] Add command line library loader
      instrument: [bsd-user] Add command line library loader
      instrument: [softmmu] Add command line library loader
      instrument: [qapi] Add library loader
      instrument: [hmp] Add library loader
      trace: Rename C++-specific names in event arguments


 .gitignore                                       |    7=20
 Makefile                                         |   65 ++++-
 Makefile.objs                                    |    8 +
 bsd-user/main.c                                  |   16 +
 bsd-user/syscall.c                               |    5=20
 configure                                        |   40 +++
 docs/devel/tracing.txt                           |    9 +
 docs/instrumentation.txt                         |  264 ++++++++++++++++=
++
 hmp-commands.hx                                  |   28 ++
 include/trace-tcg.h                              |    1=20
 instrument/Makefile.objs                         |   47 +++
 instrument/cmdline.c                             |  117 ++++++++
 instrument/cmdline.h                             |   58 ++++
 instrument/control.c                             |  316 ++++++++++++++++=
++++++
 instrument/control.h                             |   86 ++++++
 instrument/qemu-instr/control.h                  |  128 +++++++++
 instrument/qemu-instr/types.h                    |   81 ++++++
 instrument/qemu-instr/visibility-internal.h      |   58 ++++
 instrument/qmp.c                                 |   71 +++++
 linux-user/main.c                                |   20 +
 linux-user/syscall.c                             |    4=20
 monitor.c                                        |   55 ++++
 qapi-schema.json                                 |    3=20
 qapi/instrument.json                             |   92 ++++++
 qemu-options.hx                                  |   17 +
 rules.mak                                        |    3=20
 scripts/tracetool.py                             |   11 +
 scripts/tracetool/__init__.py                    |   43 +++
 scripts/tracetool/backend/instr_dynamic.py       |  161 +++++++++++
 scripts/tracetool/backend/instr_none.py          |   52 ++++
 scripts/tracetool/format/c.py                    |   37 ++-
 scripts/tracetool/format/h.py                    |    8 -
 scripts/tracetool/format/instr_api_h.py          |   76 +++++
 scripts/tracetool/format/instr_c.py              |   41 +++
 scripts/tracetool/format/instr_h.py              |   48 +++
 scripts/tracetool/format/instr_tcg_c.py          |   37 +++
 scripts/tracetool/format/instr_tcg_h.py          |   56 ++++
 scripts/tracetool/format/tcg_h.py                |    6=20
 scripts/tracetool/format/tcg_helper_c.py         |    4=20
 scripts/tracetool/format/tcg_helper_h.py         |    2=20
 scripts/tracetool/format/tcg_helper_wrapper_h.py |    2=20
 scripts/tracetool/transform.py                   |   13 +
 trace/event-internal.h                           |   10 +
 vl.c                                             |   11 +
 44 files changed, 2197 insertions(+), 20 deletions(-)
 create mode 100644 docs/instrumentation.txt
 create mode 100644 instrument/Makefile.objs
 create mode 100644 instrument/cmdline.c
 create mode 100644 instrument/cmdline.h
 create mode 100644 instrument/control.c
 create mode 100644 instrument/control.h
 create mode 100644 instrument/qemu-instr/control.h
 create mode 100644 instrument/qemu-instr/types.h
 create mode 100644 instrument/qemu-instr/visibility-internal.h
 create mode 100644 instrument/qmp.c
 create mode 100644 qapi/instrument.json
 create mode 100644 scripts/tracetool/backend/instr_dynamic.py
 create mode 100644 scripts/tracetool/backend/instr_none.py
 create mode 100644 scripts/tracetool/format/instr_api_h.py
 create mode 100644 scripts/tracetool/format/instr_c.py
 create mode 100644 scripts/tracetool/format/instr_h.py
 create mode 100644 scripts/tracetool/format/instr_tcg_c.py
 create mode 100644 scripts/tracetool/format/instr_tcg_h.py


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Emilio G. Cota <cota@braap.org>
