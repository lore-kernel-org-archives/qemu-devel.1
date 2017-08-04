Received: from eggs.gnu.org ([2001:4830:134:3::10]:49780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ddhOs-0001Ef-0t
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ddhOo-0003Ko-0z
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:32:42 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:37604)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ddhOn-0003HQ-Gv
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 14:32:37 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
	<20170804153453.GG14565@stefanha-x1.localdomain>
Date: Fri, 04 Aug 2017 21:32:25 +0300
In-Reply-To: <20170804153453.GG14565@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Fri, 4 Aug 2017 16:34:53 +0100")
Message-ID: <87mv7fkwue.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 0/5] hypertrace: Lightweight
 guest-to-QEMU trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>

Stefan Hajnoczi writes:

> On Sun, Jul 30, 2017 at 05:08:18PM +0300, Llu=C3=ADs Vilanova wrote:
>> The hypertrace channel allows guest code to emit events in QEMU (the hos=
t) using
>> its tracing infrastructure (see "docs/trace.txt"). This works in both 's=
ystem'
>> and 'user' modes, is architecture-agnostic and introduces minimal noise =
on the
>> guest.
>>=20
>> See first commit for a full description, use-cases and an example.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>>=20
>> Changes in v8
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Do not use 'seq' when there's no extra hypertrace arguments (BSD behav=
es
>> differently for "seq 0").
>> * Fix compilation for bsd-user.

> Hi Llu=C3=ADs,
> Any changes regarding the fundamental approach since September 2016?

> Back then I had the following concerns about hypertrace for full-system
> virtualization:

> Going to QEMU for every guest trace event has high overhead under
> virtualization.  The alternative approach is recording separate traces
> and merging them for analysis.  This is possible with trace-cmd [1] and
> LTTng [2].

> Merging traces eliminates the performance bottleneck and does not
> require new paravirt interfaces or guest tracing libraries.  I think it
> it would be a distraction to support hypertrace for the virtualization
> use case because it fundamentally has a high overhead.

> I see promise in using hypertrace for TCG because it is low-overhead
> when running inside the QEMU process.  I'll review the patches again
> with this in mind and not focus on virtualization.

> [1] https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg00887.html
> [2] http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracec=
ompass.doc.user/Virtual-Machine-Analysis.html
>     and also generic trace synchronization
>     http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracec=
ompass.doc.user/Trace-synchronization.html#Trace_synchronization

There's been no fundamental changes since then (just the few bits listed in=
 the
v5-v8 changelog).

But I'm kind of split on this one.

If you want high-performance trace correlation, this will work much better =
for
TCG than virtualization (where [1] will probably be more efficient).

If you want a hook to trigger other operations (like in the docs example), I
think this is the right approach. In fact, my initial interest in hypertrac=
e was
for instrumentation, so maybe this should be subsumed into the proposal of a
stable instrumentation API.

What do you think?

Cheers,
  Lluis


> Stefan

>> Changes in v7
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Use 'expr' instead of assuming 'bash' when generating the "emit.c" fil=
e.
>> * Restore generation of trace-events-all.
>>=20
>>=20
>> Changes in v6
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Fix compilation errors.
>>=20
>>=20
>> Changes in v5
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Rebase on 5a477a7806.
>> * Fix typo in "bsd-user/main.c" [Stephan Hajnoczi].
>> * Replace abort() with exit() in command-line errors [Stephan Hajnoczi].
>> * Fix alignment of data and control channels [Stephan Hajnoczi].
>> * Fix signal reflection in user-mode (SIGINT, SIGABRT, SIGSEGV) [Stephan=
 Hajnoczi].
>> * Clarify semantics of hypertrace_guest_mmap_check() [Stephan Hajnoczi].
>> * Use uintptr_t instead of unsigned long in SEGV handler [Stephan Hajnoc=
zi].
>> * Emit hypertrace's event with host-endian arguments [Stephan Hajnoczi].
>> * Enable true concurrency between user-mode guest threads by using a spe=
arate control channel page per client [Stephan Hajnoczi].
>> * Remove unused PAGE_SIZE define [Stephan Hajnoczi].
>> * Submit linux kernel API module separately to Linux upstream [Stephan H=
ajnoczi].
>> * Assume guest code events are always enabled.
>>=20
>>=20
>> Changes in v4
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Fix typo in stap script example.
>> * Fix compilation instructions in doc/hypertrace.txt.
>> * Rebase on 0737f32daf.
>>=20
>>=20
>> Changes in v3
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Rebase on 4a58f35.
>> * Remove debugging printf's.
>> * Fix style issues identified by checkpatch.
>> * Fix control channel mapping in guest linux module.
>> * Add a short event description in "trace-events".
>> * Polish documentation in 1st patch.
>>=20
>>=20
>> Changes in v2
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> * Remove unnecessary casts for g2h() [Eric Blake].
>> * Use perror() [Eric Blake].
>> * Avoid expansions in application example [Eric Blake].
>> * Add copyright in document "hypertrace.txt" [Eric Blake].
>> * Make the user-mode hypertrace invocations thread-safe [Stefan Hajnoczi=
].
>> * Split dynamic hypertrace configuration into a separate "config" channe=
l.
>>=20
>> Llu=C3=ADs Vilanova (5):
>> hypertrace: Add documentation
>> hypertrace: Add tracing event "guest_hypertrace"
>> hypertrace: [*-user] Add QEMU-side proxy to "guest_hypertrace" event
>> hypertrace: [softmmu] Add QEMU-side proxy to "guest_hypertrace" event
>> hypertrace: Add guest-side user-level library
>>=20
>>=20
>> Makefile                           |   11 +
>> Makefile.objs                      |    6 +
>> bsd-user/main.c                    |   17 +
>> bsd-user/mmap.c                    |   15 +
>> bsd-user/qemu.h                    |    3=20
>> bsd-user/syscall.c                 |   34 ++-
>> configure                          |   36 +++
>> docs/devel/tracing.txt             |    3=20
>> docs/hypertrace.txt                |  225 ++++++++++++++++++++
>> hypertrace/Makefile.objs           |   25 ++
>> hypertrace/common.c                |   55 +++++
>> hypertrace/common.h                |   25 ++
>> hypertrace/guest/Makefile          |   30 +++
>> hypertrace/guest/common.c          |  301 ++++++++++++++++++++++++++
>> hypertrace/guest/qemu-hypertrace.h |   80 +++++++
>> hypertrace/softmmu.c               |  237 +++++++++++++++++++++
>> hypertrace/user.c                  |  415 ++++++++++++++++++++++++++++++=
++++++
>> hypertrace/user.h                  |   71 ++++++
>> include/hw/pci/pci.h               |    2=20
>> include/qom/cpu.h                  |    4=20
>> linux-user/main.c                  |   19 ++
>> linux-user/mmap.c                  |   16 +
>> linux-user/qemu.h                  |    3=20
>> linux-user/signal.c                |   12 +
>> linux-user/syscall.c               |   31 ++-
>> rules.mak                          |    2=20
>> trace-events                       |   11 +
>> 27 files changed, 1660 insertions(+), 29 deletions(-)
>> create mode 100644 docs/hypertrace.txt
>> create mode 100644 hypertrace/Makefile.objs
>> create mode 100644 hypertrace/common.c
>> create mode 100644 hypertrace/common.h
>> create mode 100644 hypertrace/guest/Makefile
>> create mode 100644 hypertrace/guest/common.c
>> create mode 100644 hypertrace/guest/qemu-hypertrace.h
>> create mode 100644 hypertrace/softmmu.c
>> create mode 100644 hypertrace/user.c
>> create mode 100644 hypertrace/user.h
>>=20
>>=20
>> To: qemu-devel@nongnu.org
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Luiz Capitulino <lcapitulino@redhat.com>
>> Cc: Daniel P Berrange <berrange@redhat.com>
