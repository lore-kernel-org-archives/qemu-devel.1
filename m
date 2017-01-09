Received: from eggs.gnu.org ([2001:4830:134:3::10]:55885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQxe1-0001FA-0X
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQxdz-00064e-RB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:43:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQxdz-00064H-Hv
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:43:23 -0500
Date: Mon, 9 Jan 2017 17:04:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109170434.GM30228@stefanha-x1.localdomain>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SEFvVLxbW/dEDtN8"
Content-Disposition: inline
In-Reply-To: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
Subject: Re: [Qemu-devel] [PATCH v6 0/7] trace: [tcg] Optimize per-vCPU
 tracing states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--SEFvVLxbW/dEDtN8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2016 at 07:40:54PM +0100, Llu=EDs Vilanova wrote:
> Optimizes tracing of events with the 'tcg' and 'vcpu' properties (e.g., m=
emory
> accesses), making it feasible to statically enable them by default on all=
 QEMU
> builds.
>=20
> Some quick'n'dirty numbers with 400.perlbench (SPECcpu2006) on the train =
input
> (medium size - suns.pl) and the guest_mem_before event:
>=20
> * vanilla, statically disabled
> real	0m2,259s
> user	0m2,252s
> sys	0m0,004s
>=20
> * vanilla, statically enabled (overhead: 2.18x)
> real	0m4,921s
> user	0m4,912s
> sys	0m0,008s
>=20
> * multi-tb, statically disabled (overhead: 0.99x) [within noise range]
> real	0m2,228s
> user	0m2,216s
> sys	0m0,008s
>=20
> * multi-tb, statically enabled (overhead: 0.99x) [within noise range]
> real	0m2,229s
> user	0m2,224s
> sys	0m0,004s
>=20
>=20
> Right now, events with the 'tcg' property always generate TCG code to tra=
ce that
> event at guest code execution time, where the event's dynamic state is ch=
ecked.
>=20
> This series adds a performance optimization where TCG code for events wit=
h the
> 'tcg' and 'vcpu' properties is not generated if the event is dynamically
> disabled. This optimization raises two issues:
>=20
> * An event can be dynamically disabled/enabled after the corresponding TC=
G code
>   has been generated (i.e., a new TB with the corresponding code should be
>   used).
>=20
> * Each vCPU can have a different dynamic state for the same event (i.e., =
tracing
>   the memory accesses of only one process pinned to a vCPU).
>=20
> To handle both issues, this series integrates the dynamic tracing event s=
tate
> into the TB hashing function, so that vCPUs tracing different events will=
 use
> separate TBs. Note that only events with the 'vcpu' property are used for
> hashing (as stored in the bitmap of CPUState->trace_dstate).
>=20
> This makes dynamic event state changes on vCPUs very efficient, since the=
y can
> use TBs produced by other vCPUs while on the same event state combination=
 (or
> produced by the same vCPU, earlier).
>=20
> Discarded alternatives:
>=20
> * Emitting TCG code to check if an event needs tracing, where we should s=
till
>   move the tracing call code to either a cold path (making tracing perfor=
mance
>   worse), or leave it inlined (making non-tracing performance worse).
>=20
> * Eliding TCG code only when *zero* vCPUs are tracing an event, since ena=
bling
>   it on a single vCPU will impact the performance of all other vCPUs that=
 are
>   not tracing that event.
>=20
> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> ---
>=20
> Changes in v6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Check hashing size error with QEMU_BUILD_BUG_ON [Richard Henderson].
>=20
>=20
> Changes in v5
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Move define into "qemu-common.h" to allow compilation of tests.
>=20
>=20
> Changes in v4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Incorporate trace_dstate into the TB hashing function instead of using
>   multiple physical TB caches [suggested by Richard Henderson].
>=20
>=20
> Changes in v3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Rebase on 0737f32daf.
> * Do not use reserved symbol prefixes ("__") [Stefan Hajnoczi].
> * Refactor trace_get_vcpu_event_count() to be inlinable.
> * Optimize cpu_tb_cache_set_requested() (hottest path).
>=20
>=20
> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Fix bitmap copy in cpu_tb_cache_set_apply().
> * Split generated code re-alignment into a separate patch [Daniel P. Berr=
ange].
>=20
>=20
> Llu=EDs Vilanova (7):
>       exec: [tcg] Refactor flush of per-CPU virtual TB cache
>       trace: Make trace_get_vcpu_event_count() inlinable
>       trace: [tcg] Delay changes to dynamic state when translating
>       exec: [tcg] Use different TBs according to the vCPU's dynamic traci=
ng state
>       trace: [tcg] Do not generate TCG code to trace dinamically-disabled=
 events
>       trace: [tcg,trivial] Re-align generated code
>       trace: [trivial] Statically enable all guest events
>=20
>=20
>  cpu-exec.c                               |   52 ++++++++++++++++++++++++=
+++---
>  cputlb.c                                 |    2 +
>  include/exec/exec-all.h                  |   11 ++++++
>  include/exec/tb-hash-xx.h                |    8 ++++-
>  include/exec/tb-hash.h                   |    5 ++-
>  include/qemu-common.h                    |    3 ++
>  include/qom/cpu.h                        |    7 ++++
>  qom/cpu.c                                |    4 ++
>  scripts/tracetool/__init__.py            |    1 +
>  scripts/tracetool/backend/dtrace.py      |    2 +
>  scripts/tracetool/backend/ftrace.py      |   20 ++++++------
>  scripts/tracetool/backend/log.py         |   17 +++++-----
>  scripts/tracetool/backend/simple.py      |    2 +
>  scripts/tracetool/backend/syslog.py      |    6 ++-
>  scripts/tracetool/backend/ust.py         |    2 +
>  scripts/tracetool/format/h.py            |   24 ++++++++++----
>  scripts/tracetool/format/tcg_h.py        |   19 +++++++++--
>  scripts/tracetool/format/tcg_helper_c.py |    3 +-
>  tests/qht-bench.c                        |    2 +
>  trace-events                             |    6 ++-
>  trace/control-internal.h                 |    5 +++
>  trace/control-target.c                   |   14 +++++++-
>  trace/control.c                          |    9 +----
>  trace/control.h                          |    5 ++-
>  translate-all.c                          |   30 +++++++++++++----
>  25 files changed, 195 insertions(+), 64 deletions(-)
>=20
>=20
> To: qemu-devel@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>

The tracing aspects seem fine.  I have left a comment regarding
thread-safety.

I'll merge it once Richard Henderson has had time to review it from a
TCG perspective.

--SEFvVLxbW/dEDtN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc8KiAAoJEJykq7OBq3PI2ngH/2bA5JY4a42ziHAguxtEaDiq
LvG/G4bXCN8RIIg2oKBvLkGcFDbyd4CNLFOBJw5uCJH5v6Q6TXLa7yQWGaW6NlBB
hoAEFq8PnUOZPmSV4jj70l/pGykOBNBHvhHhkn/8MdwGLMdyk5mcSkuAd649cMNk
I58TPHGIQQk6kL3ueliQXKMSYWkkrc9HFB8nytfIycu8lRphCXqODZyg9H3R9TXU
FuZi/8gwAy1KzDK94w0gXdjviNzn5Y/dadJ/pCSfOzKu9NrxO8JlNmaeMPhXD5Zm
jg5rmtnrOlvZJLvI3vaDAczGssrHliZ0oamA68pArLc/6GZcxIengZbDzzxqn8Y=
=n8LI
-----END PGP SIGNATURE-----

--SEFvVLxbW/dEDtN8--
