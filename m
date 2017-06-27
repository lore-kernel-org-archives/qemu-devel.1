Received: from eggs.gnu.org ([2001:4830:134:3::10]:33328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPnAP-0006Jl-N7
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPnAM-000055-JW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:52:17 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:57473)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPnAM-0008US-2Y
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:52:14 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Tue, 27 Jun 2017 12:52:00 +0300
Message-Id: <149855711979.4578.11884555663631849051.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 0/7] trace: [tcg] Optimize per-vCPU tracing
 states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Optimizes tracing of events with the 'tcg' and 'vcpu' properties (e.g., m=
emory
accesses), making it feasible to statically enable them by default on all=
 QEMU
builds.

Some quick'n'dirty numbers with 400.perlbench (SPECcpu2006) on the train =
input
(medium size - suns.pl) and the guest_mem_before event:

* vanilla, statically disabled
real    0m2,259s
user    0m2,252s
sys     0m0,004s

* vanilla, statically enabled (overhead: 2.18x)
real    0m4,921s
user    0m4,912s
sys     0m0,008s

* multi-tb, statically disabled (overhead: 0.99x) [within noise range]
real    0m2,228s
user    0m2,216s
sys     0m0,008s

* multi-tb, statically enabled (overhead: 0.99x) [within noise range]
real    0m2,229s
user    0m2,224s
sys     0m0,004s


Right now, events with the 'tcg' property always generate TCG code to tra=
ce that
event at guest code execution time, where the event's dynamic state is ch=
ecked.

This series adds a performance optimization where TCG code for events wit=
h the
'tcg' and 'vcpu' properties is not generated if the event is dynamically
disabled. This optimization raises two issues:

* An event can be dynamically disabled/enabled after the corresponding TC=
G code
  has been generated (i.e., a new TB with the corresponding code should b=
e
  used).

* Each vCPU can have a different dynamic state for the same event (i.e., =
tracing
  the memory accesses of only one process pinned to a vCPU).

To handle both issues, this series integrates the dynamic tracing event s=
tate
into the TB hashing function, so that vCPUs tracing different events will=
 use
separate TBs. Note that only events with the 'vcpu' property are used for
hashing (as stored in the bitmap of CPUState->trace_dstate).

This makes dynamic event state changes on vCPUs very efficient, since the=
y can
use TBs produced by other vCPUs while on the same event state combination=
 (or
produced by the same vCPU, earlier).

Discarded alternatives:

* Emitting TCG code to check if an event needs tracing, where we should s=
till
  move the tracing call code to either a cold path (making tracing perfor=
mance
  worse), or leave it inlined (making non-tracing performance worse).

* Eliding TCG code only when *zero* vCPUs are tracing an event, since ena=
bling
  it on a single vCPU will impact the performance of all other vCPUs that=
 are
  not tracing that event.

Signed-off-by: Llu=C3=ADs Vilanova <address@hidden>
---

Changes in v9
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on 931892e8a6.
* Undo renaming of tb->trace_vcpu_dstate to the shorter tb->trace_ds.
* Add measurements to commit enabling all guest events.


Changes in v8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Emilio G. Cota]

* Ported to current dev tree.

* Allocate cpu->trace_dstate statically. This
  * allows us to drop the event_count inline patch.
  * simplifies and improves the performance of accessing cpu->trace_dstat=
e:
    we just need to dereference, instead of going through bitmap_copy and
    an intermediate unsigned long.

* If we try to register more CPU events than the max we support (there's =
a
  constant for it), drop the event and tell the user with error_report. B=
ut
  really this is a bug, since we control what CPU events are traceable. S=
hould
  we abort() as well?

* Added rth's R-b tag

* Addressed my own comments:
  * rename tb->trace_vcpu_dstate to the shorter tb->trace_ds
  * use uint32_t for tb->trace_ds instead of a typedef
  * add BUILD_BUG_ON check to make sure tb->trace_ds is big enough
  * fix xxhash

* Do not add trace_dstate to tb_htable_lookup, since we can grab it from
  cpu->trace_dstate.

This patchset applies cleanly on top of rth's tcg-next (a01792e1e).


Changes in v7
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Fix delayed dstate changes (now uses async_run_on_cpu() as suggested by=
 Paolo
  Bonzini).

* Note to Richard: patch 4 has been adapted to the new patch 3 async call=
back,
  but is essentially the same.


Changes in v6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Check hashing size error with QEMU_BUILD_BUG_ON [Richard Henderson].


Changes in v5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Move define into "qemu-common.h" to allow compilation of tests.


Changes in v4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Incorporate trace_dstate into the TB hashing function instead of using
  multiple physical TB caches [suggested by Richard Henderson].


Changes in v3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on 0737f32daf.
* Do not use reserved symbol prefixes ("__") [Stefan Hajnoczi].
* Refactor trace_get_vcpu_event_count() to be inlinable.
* Optimize cpu_tb_cache_set_requested() (hottest path).


Changes in v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Fix bitmap copy in cpu_tb_cache_set_apply().
* Split generated code re-alignment into a separate patch [Daniel P. Berr=
ange].

Llu=C3=ADs Vilanova (7):
      exec: [tcg] Refactor flush of per-CPU virtual TB cache
      trace: Allocate cpu->trace_dstate in place
      trace: [tcg] Delay changes to dynamic state when translating
      exec: [tcg] Use different TBs according to the vCPU's dynamic traci=
ng state
      trace: [tcg] Do not generate TCG code to trace dinamically-disabled=
 events
      trace: [tcg,trivial] Re-align generated code
      trace: [trivial] Statically enable all guest events


 accel/tcg/cpu-exec.c                     |    8 ++++++--
 accel/tcg/cputlb.c                       |    2 +-
 accel/tcg/translate-all.c                |   26 +++++++++++++++++++-----=
--
 include/exec/exec-all.h                  |   12 ++++++++++++
 include/exec/tb-hash-xx.h                |    7 +++++--
 include/exec/tb-hash.h                   |    5 +++--
 include/qom/cpu.h                        |   12 ++++++------
 qom/cpu.c                                |    8 --------
 scripts/tracetool/__init__.py            |    3 ++-
 scripts/tracetool/backend/dtrace.py      |    4 ++--
 scripts/tracetool/backend/ftrace.py      |   20 ++++++++++----------
 scripts/tracetool/backend/log.py         |   19 ++++++++++---------
 scripts/tracetool/backend/simple.py      |    4 ++--
 scripts/tracetool/backend/syslog.py      |    6 +++---
 scripts/tracetool/backend/ust.py         |    4 ++--
 scripts/tracetool/format/h.py            |   26 +++++++++++++++++++-----=
--
 scripts/tracetool/format/tcg_h.py        |   21 +++++++++++++++++----
 scripts/tracetool/format/tcg_helper_c.py |    5 +++--
 tcg/tcg-runtime.c                        |    3 ++-
 tests/qht-bench.c                        |    2 +-
 trace-events                             |    6 +++---
 trace/control-target.c                   |   21 ++++++++++++++++++---
 trace/control.c                          |    9 ++++++++-
 trace/control.h                          |    3 +++
 24 files changed, 157 insertions(+), 79 deletions(-)


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Emilio G. Cota <cota@braap.org>
