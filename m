Received: from eggs.gnu.org ([2001:4830:134:3::10]:46020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddecv-0004IB-1I
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddecs-0002U6-Ue
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ddecs-0002St-M1
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:34:58 -0400
Date: Fri, 4 Aug 2017 16:34:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170804153453.GG14565@stefanha-x1.localdomain>
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
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
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2017 at 05:08:18PM +0300, Llu=EDs Vilanova wrote:
> The hypertrace channel allows guest code to emit events in QEMU (the host=
) using
> its tracing infrastructure (see "docs/trace.txt"). This works in both 'sy=
stem'
> and 'user' modes, is architecture-agnostic and introduces minimal noise o=
n the
> guest.
>=20
> See first commit for a full description, use-cases and an example.
>=20
> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> ---
>=20
> Changes in v8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Do not use 'seq' when there's no extra hypertrace arguments (BSD behaves
>   differently for "seq 0").
> * Fix compilation for bsd-user.

Hi Llu=EDs,
Any changes regarding the fundamental approach since September 2016?

Back then I had the following concerns about hypertrace for full-system
virtualization:

Going to QEMU for every guest trace event has high overhead under
virtualization.  The alternative approach is recording separate traces
and merging them for analysis.  This is possible with trace-cmd [1] and
LTTng [2].

Merging traces eliminates the performance bottleneck and does not
require new paravirt interfaces or guest tracing libraries.  I think it
it would be a distraction to support hypertrace for the virtualization
use case because it fundamentally has a high overhead.

I see promise in using hypertrace for TCG because it is low-overhead
when running inside the QEMU process.  I'll review the patches again
with this in mind and not focus on virtualization.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg00887.html
[2] http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecom=
pass.doc.user/Virtual-Machine-Analysis.html
    and also generic trace synchronization
    http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecom=
pass.doc.user/Trace-synchronization.html#Trace_synchronization

Stefan

> Changes in v7
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Use 'expr' instead of assuming 'bash' when generating the "emit.c" file.
> * Restore generation of trace-events-all.
>=20
>=20
> Changes in v6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Fix compilation errors.
>=20
>=20
> Changes in v5
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Rebase on 5a477a7806.
> * Fix typo in "bsd-user/main.c" [Stephan Hajnoczi].
> * Replace abort() with exit() in command-line errors [Stephan Hajnoczi].
> * Fix alignment of data and control channels [Stephan Hajnoczi].
> * Fix signal reflection in user-mode (SIGINT, SIGABRT, SIGSEGV) [Stephan =
Hajnoczi].
> * Clarify semantics of hypertrace_guest_mmap_check() [Stephan Hajnoczi].
> * Use uintptr_t instead of unsigned long in SEGV handler [Stephan Hajnocz=
i].
> * Emit hypertrace's event with host-endian arguments [Stephan Hajnoczi].
> * Enable true concurrency between user-mode guest threads by using a spea=
rate control channel page per client [Stephan Hajnoczi].
> * Remove unused PAGE_SIZE define [Stephan Hajnoczi].
> * Submit linux kernel API module separately to Linux upstream [Stephan Ha=
jnoczi].
> * Assume guest code events are always enabled.
>=20
>=20
> Changes in v4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Fix typo in stap script example.
> * Fix compilation instructions in doc/hypertrace.txt.
> * Rebase on 0737f32daf.
>=20
>=20
> Changes in v3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Rebase on 4a58f35.
> * Remove debugging printf's.
> * Fix style issues identified by checkpatch.
> * Fix control channel mapping in guest linux module.
> * Add a short event description in "trace-events".
> * Polish documentation in 1st patch.
>=20
>=20
> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Remove unnecessary casts for g2h() [Eric Blake].
> * Use perror() [Eric Blake].
> * Avoid expansions in application example [Eric Blake].
> * Add copyright in document "hypertrace.txt" [Eric Blake].
> * Make the user-mode hypertrace invocations thread-safe [Stefan Hajnoczi].
> * Split dynamic hypertrace configuration into a separate "config" channel.
>=20
> Llu=EDs Vilanova (5):
>       hypertrace: Add documentation
>       hypertrace: Add tracing event "guest_hypertrace"
>       hypertrace: [*-user] Add QEMU-side proxy to "guest_hypertrace" event
>       hypertrace: [softmmu] Add QEMU-side proxy to "guest_hypertrace" eve=
nt
>       hypertrace: Add guest-side user-level library
>=20
>=20
>  Makefile                           |   11 +
>  Makefile.objs                      |    6 +
>  bsd-user/main.c                    |   17 +
>  bsd-user/mmap.c                    |   15 +
>  bsd-user/qemu.h                    |    3=20
>  bsd-user/syscall.c                 |   34 ++-
>  configure                          |   36 +++
>  docs/devel/tracing.txt             |    3=20
>  docs/hypertrace.txt                |  225 ++++++++++++++++++++
>  hypertrace/Makefile.objs           |   25 ++
>  hypertrace/common.c                |   55 +++++
>  hypertrace/common.h                |   25 ++
>  hypertrace/guest/Makefile          |   30 +++
>  hypertrace/guest/common.c          |  301 ++++++++++++++++++++++++++
>  hypertrace/guest/qemu-hypertrace.h |   80 +++++++
>  hypertrace/softmmu.c               |  237 +++++++++++++++++++++
>  hypertrace/user.c                  |  415 ++++++++++++++++++++++++++++++=
++++++
>  hypertrace/user.h                  |   71 ++++++
>  include/hw/pci/pci.h               |    2=20
>  include/qom/cpu.h                  |    4=20
>  linux-user/main.c                  |   19 ++
>  linux-user/mmap.c                  |   16 +
>  linux-user/qemu.h                  |    3=20
>  linux-user/signal.c                |   12 +
>  linux-user/syscall.c               |   31 ++-
>  rules.mak                          |    2=20
>  trace-events                       |   11 +
>  27 files changed, 1660 insertions(+), 29 deletions(-)
>  create mode 100644 docs/hypertrace.txt
>  create mode 100644 hypertrace/Makefile.objs
>  create mode 100644 hypertrace/common.c
>  create mode 100644 hypertrace/common.h
>  create mode 100644 hypertrace/guest/Makefile
>  create mode 100644 hypertrace/guest/common.c
>  create mode 100644 hypertrace/guest/qemu-hypertrace.h
>  create mode 100644 hypertrace/softmmu.c
>  create mode 100644 hypertrace/user.c
>  create mode 100644 hypertrace/user.h
>=20
>=20
> To: qemu-devel@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Luiz Capitulino <lcapitulino@redhat.com>
> Cc: Daniel P Berrange <berrange@redhat.com>

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZhJQdAAoJEJykq7OBq3PIYP0IAIglU30oWM0S8HDiBOegeWm4
ADG0H+so4ZzQ59UjtyAYenJdAZCd3LplN00oP25IeOiRB9z4Df7/r7zWJbMwggcU
T0RqbgumsYUfZR9r5YbFiqeh6IWOE4HE78S8mIXeFKpuIbo958Z6QAayLB+rcOqf
LnYTvBKJt5d0IZ87+praTQ5v6ave1UYD24WK/4JUaUAlk4of5lfQJQA59Th+OiAH
zdOOq0sMxoNt+wThQ20DhXVykOLOIU6znvuL89RQxCBulLvOQDcFZxOoYgGnGmk7
76xYWvSe+IYvMQflrATR8EoojVi90JrhHvuTpfvAZDLyuW1cI5HFnMqkGpnmYxM=
=JX1o
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
