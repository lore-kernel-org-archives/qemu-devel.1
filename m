Received: from eggs.gnu.org ([2001:4830:134:3::10]:51398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drsJp-0000id-3g
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drsJl-0006fe-Lj
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:02:05 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:45493)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drsJl-0006ZB-6U
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:02:01 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 00:01:42 +0300
Message-Id: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/22] instrument: Add basic event
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
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

This series adds an API to add instrumentation events.

It also provides additional APIs for:
* Controlling tracing events.
* Peek/poke guest memory.

TODO:
* Replace qi_event_gen_* with generating calls to arbitrary functions (e.=
g.,
  qi_event_gen_call(num_args, va_list)).
* Flush all TBs when an execution-time event is unset (to ensure it won't=
 be
  called in the future).
* Flush all TBs when a translation-time event is set (to ensure no future=
 events
  will be lost).

Undecided:
* Alternatively to the two last points above, provide an API to request a=
 TB
  flush (much more flexible and can be more efficient, but requires instr=
umentor
  to clearly know differences between translation and execution).
* Pass a user-provided pointer to events (i.e., to avoid using global
  variables).
* Provide something like tracing's per-vCPU trace states (i.e., so that e=
ach
  vCPU can have different instrumentation code). Useful mainly for sampli=
ng
  (enable/disable instrumentation multiple times without re-translating g=
uest
  code) and more complex use cases like tracing a guest process in softmm=
u mode.
  It's still not clear to me if we should extend the per-vCPU bitmap with
  instrumentation events, or otherwise somehow reuse the bits in tracing =
events
  (since they're currently limited).
* Allow multiple callbacks per event (both to support multiple callbacks
  installed by a library, and multiple libraries at the same time).
* Allow instr libraries to iterate on the list of guest CPUs (info is alr=
eady
  available through guest_cpu_enter/guest_cpu_exit, but forces libs to be
  prepared for hot-plugging guest CPUs).

Future APIs (for later series):
* Peek/poke guest registers.
* Add breakpoints to trigger instrumentation functions.
* Trigger instrumentation functions from guest code (former hypertrace).
* Add events for guest code translation/execution (once the respective tr=
acing
  events are accepted upstream).
* Add events for exceptions/syscalls.
* Add events for TB invalidation (necessary for libraries to deallocate a=
ny data
  they might have allocated for the TBs they instrumented).

The instrumentation code is dynamically loaded as a library into QEMU eit=
her
when it starts or later using its remote control interfaces. The loaded c=
ode
only has access to function explicitly exported through the QI_VPUBLIC ma=
cro.

This series is branch 'devel-instrument' in
https://code.gso.ac.upc.edu/git/qemu-dbi.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---

Changes in v5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on fcea73709b.
* Minor changes to pass checkpatch.
* Fix symbol availability to external libraries by adding missing default=
 symbol
  visibility flag.
* Use a string to identify instrumentation handles [Markus Armbruster].
* Use stubs for command line initialization.
* Use stubs to signal unsupported QAPI commands [Markus Armbruster].
* Use error messages instead of codes in QAPI commands [Markus Armbruster=
].
* Move symbol visibility macros to internal "qemu/compiler.h" header.
* Trigger event 'guest_cpu_enter' when library is loaded.
* Trigger event 'guest_cpu_exit' and flush TBs when library is unloaded.
* Rename instr_cpu_get/instr_cpu_set into clearer
  instr_cpu_to_qicpu/instr_cpu_from_qicpu.
* Rename handle_get/handle_put to clearer handle_new/handle_destroy.
* Ensure qi_event_set_* are called only on the proper mode and targets.


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


Llu=C3=ADs Vilanova (22):
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
      instrument: Support synchronous modification of vCPU state
      exec: Add function to synchronously flush TB on a stopped vCPU
      instrument: Add event 'guest_cpu_exit'
      instrument: Add event 'guest_cpu_reset'
      trace: Introduce a proper structure to describe memory accesses
      instrument: Add event 'guest_mem_before_trans'
      instrument: Add event 'guest_mem_before_exec'
      instrument: Add event 'guest_user_syscall'
      instrument: Add event 'guest_user_syscall_ret'
      instrument: Add API to manipulate guest memory


 .gitignore                                |    1=20
 MAINTAINERS                               |    8 +
 Makefile                                  |    8 +
 Makefile.objs                             |    4 +
 Makefile.target                           |    1=20
 accel/stubs/tcg-stub.c                    |    3=20
 accel/tcg/translate-all.c                 |    7 +
 bsd-user/main.c                           |   17 ++
 bsd-user/syscall.c                        |   14 ++
 configure                                 |   13 ++
 cpus-common.c                             |    9 +
 docs/instrument.txt                       |  173 ++++++++++++++++++++++
 hmp-commands.hx                           |   32 ++++
 include/exec/cpu_ldst_template.h          |   19 +-
 include/exec/cpu_ldst_useronly_template.h |   19 +-
 include/exec/exec-all.h                   |    1=20
 include/exec/helper-gen.h                 |    1=20
 include/exec/helper-proto.h               |    1=20
 include/exec/helper-tcg.h                 |    1=20
 include/qemu/compiler.h                   |   19 ++
 instrument/Makefile.objs                  |    8 +
 instrument/cmdline.c                      |  128 ++++++++++++++++
 instrument/cmdline.h                      |   51 +++++++
 instrument/control.c                      |  227 +++++++++++++++++++++++=
++++++
 instrument/control.h                      |  153 ++++++++++++++++++++
 instrument/control.inc.h                  |   67 +++++++++
 instrument/error.h                        |   34 ++++
 instrument/events.h                       |   86 +++++++++++
 instrument/events.inc.h                   |  109 ++++++++++++++
 instrument/helpers.h                      |    2=20
 instrument/load.c                         |  210 +++++++++++++++++++++++=
++++
 instrument/load.h                         |   88 +++++++++++
 instrument/qemu-instr/control.h           |  177 +++++++++++++++++++++++
 instrument/qemu-instr/state.h             |  104 +++++++++++++
 instrument/qemu-instr/types.h             |  115 +++++++++++++++
 instrument/qemu-instr/types.inc.h         |   15 ++
 instrument/qmp.c                          |   82 ++++++++++
 instrument/state.c                        |   73 +++++++++
 instrument/trace.c                        |  125 ++++++++++++++++
 linux-user/main.c                         |   21 +++
 linux-user/syscall.c                      |    7 +
 monitor.c                                 |   43 +++++
 qapi-schema.json                          |    3=20
 qapi/instrument.json                      |   49 ++++++
 qemu-options.hx                           |   19 ++
 qom/cpu.c                                 |    2=20
 stubs/Makefile.objs                       |    1=20
 stubs/instrument.c                        |   75 ++++++++++
 tcg/tcg-op.c                              |   27 ++-
 trace/control-target.c                    |    2=20
 trace/control.c                           |    4 -
 trace/control.h                           |   24 +++
 trace/mem-internal.h                      |   22 ++-
 trace/mem.h                               |    8 +
 vl.c                                      |   15 ++
 55 files changed, 2487 insertions(+), 40 deletions(-)
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
 create mode 100644 instrument/qmp.c
 create mode 100644 instrument/state.c
 create mode 100644 instrument/trace.c
 create mode 100644 qapi/instrument.json
 create mode 100644 stubs/instrument.c


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Emilio G. Cota <cota@braap.org>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
