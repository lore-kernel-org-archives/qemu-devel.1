Received: from eggs.gnu.org ([2001:4830:134:3::10]:47791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8II-0006y5-Hz
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8IG-0004fm-33
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:46 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:35588)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cK8IF-0004cf-Cb
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:40:43 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 22 Dec 2016 19:35:37 +0100
Message-Id: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/6] trace: [tcg] Optimize per-vCPU tracing
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
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Optimizes tracing of events with the 'tcg' and 'vcpu' properties (e.g., m=
emory
accesses), making it feasible to statically enable them by default on all=
 QEMU
builds.

Some quick'n'dirty numbers with 400.perlbench (SPECcpu2006) on the train =
input
(medium size - suns.pl) and the guest_mem_before event:

* vanilla, statically disabled
real	0m5,827s
user	0m5,800s
sys	0m0,024s

* vanilla, statically enabled (overhead: 2.35x)
real	0m13,696s
user	0m13,684s
sys	0m0,008s

* multi-tb, statically disabled (overhead: 1.09x)
real	0m6,383s
user	0m6,352s
sys	0m0,028s

* multi-tb, statically enabled (overhead: 1.11x)
real	0m6,493s
user	0m6,468s
sys	0m0,020s


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

To handle both issues, this series replicates the shared physical TB cach=
e,
creating a separate physical TB cache for every combination of event stat=
es
(those with the 'vcpu' and 'tcg' properties). Then, all vCPUs tracing the=
 same
events will use the same physical TB cache.

Sharing physical TBs makes this very space efficient (only the physical T=
B
caches, simple arrays of pointers, are replicated). Sharing physical TB c=
aches
maximizes TB reuse across vCPUs whenever possible, and makes dynamic even=
t state
changes more efficient (simply use a different physical TB cache).

The physical TB cache array is indexed with the vCPU's trace event state
bitmask. This is simpler and more efficient than emitting TCG code to che=
ck if
an event needs tracing, where we should still move the tracing call code =
to
either a cold path (making tracing performance worse), or leave it inline=
d
(making non-tracing performance worse).

This solution is also more efficient than eliding TCG code only when *zer=
o*
vCPUs are tracing an event, since enabling it on a single vCPU will impac=
t the
performance of all other vCPUs that are not tracing that event.

Note on overheads: I suspect the culprit of the 1.15x overhead lies in th=
e
  double dereference

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---

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


Llu=C3=ADs Vilanova (6):
      exec: [tcg] Refactor flush of per-CPU virtual TB cache
      trace: Make trace_get_vcpu_event_count() inlinable
      exec: [tcg] Use multiple physical TB caches
      exec: [tcg] Switch physical TB cache based on vCPU tracing state
      trace: [tcg] Do not generate TCG code to trace dinamically-disabled=
 events
      trace: [tcg,trivial] Re-align generated code


 cpu-exec.c                               |   11 +++-
 cputlb.c                                 |    2 -
 include/exec/exec-all.h                  |   12 ++++
 include/exec/tb-context.h                |    2 -
 include/qom/cpu.h                        |    3 +
 qom/cpu.c                                |    3 +
 scripts/tracetool/__init__.py            |    1=20
 scripts/tracetool/backend/dtrace.py      |    2 -
 scripts/tracetool/backend/ftrace.py      |   20 +++----
 scripts/tracetool/backend/log.py         |   16 +++--
 scripts/tracetool/backend/simple.py      |    2 -
 scripts/tracetool/backend/syslog.py      |    6 +-
 scripts/tracetool/backend/ust.py         |    2 -
 scripts/tracetool/format/h.py            |   24 ++++++--
 scripts/tracetool/format/tcg_h.py        |   19 +++++-
 scripts/tracetool/format/tcg_helper_c.py |    3 +
 trace/control-internal.h                 |    5 ++
 trace/control-target.c                   |    1=20
 trace/control.c                          |    9 +--
 trace/control.h                          |    5 +-
 translate-all.c                          |   92 ++++++++++++++++++++++++=
+-----
 translate-all.h                          |   43 ++++++++++++++
 translate-all.inc.h                      |   13 ++++
 23 files changed, 237 insertions(+), 59 deletions(-)
 create mode 100644 translate-all.inc.h


To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
