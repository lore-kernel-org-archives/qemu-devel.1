Received: from eggs.gnu.org ([2001:4830:134:3::10]:33379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUqeX-0007ul-FV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUqeT-0008OW-9a
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:36:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUqeS-00089Y-UW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:36:13 -0400
Received: by mail-lf0-f67.google.com with SMTP id f28so13346482lfi.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 01:35:50 -0700 (PDT)
Date: Tue, 11 Jul 2017 09:34:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711083445.GA11181@stefanha-x1.localdomain>
References: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v10 0/7] trace: [tcg] Optimize per-vCPU
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
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 03:13:30PM +0300, Llu=EDs Vilanova wrote:
> Optimizes tracing of events with the 'tcg' and 'vcpu' properties (e.g., m=
emory
> accesses), making it feasible to statically enable them by default on all=
 QEMU
> builds. Last patch shows that overheads are completely eliminated in vari=
ous
> types of benchmarks for linux-user and softmmu (overheads where up to 2x
> before).
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
> hashing (as stored in the bitmap of #CPUState::trace_dstate).
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
> Signed-off-by: Llu=EDs Vilanova <address@hidden>
> ---
>=20
> Changes in v10
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Replace lingering trace_get_vcpu_event_count() with
>   CPU_TRACE_DSTATE_MAX_EVENTS [Emilio G. Cota].
> * Add performance results for dbt-bench [Emilio G. Cota].
>=20
>=20
> Changes in v9
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Rebase on 931892e8a6.
> * Undo renaming of tb->trace_vcpu_dstate to the shorter tb->trace_ds.
> * Add measurements to commit enabling all guest events.
>=20
>=20
> Changes in v8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [Emilio G. Cota]
>=20
> * Ported to current dev tree.
>=20
> * Allocate cpu->trace_dstate statically. This
>   * allows us to drop the event_count inline patch.
>   * simplifies and improves the performance of accessing cpu->trace_dstat=
e:
>     we just need to dereference, instead of going through bitmap_copy and
>     an intermediate unsigned long.
>=20
> * If we try to register more CPU events than the max we support (there's a
>   constant for it), drop the event and tell the user with error_report. B=
ut
>   really this is a bug, since we control what CPU events are traceable. S=
hould
>   we abort() as well?
>=20
> * Added rth's R-b tag
>=20
> * Addressed my own comments:
>   * rename tb->trace_vcpu_dstate to the shorter tb->trace_ds
>   * use uint32_t for tb->trace_ds instead of a typedef
>   * add BUILD_BUG_ON check to make sure tb->trace_ds is big enough
>   * fix xxhash
>=20
> * Do not add trace_dstate to tb_htable_lookup, since we can grab it from
>   cpu->trace_dstate.
>=20
> This patchset applies cleanly on top of rth's tcg-next (a01792e1e).
>=20
>=20
> Changes in v7
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Fix delayed dstate changes (now uses async_run_on_cpu() as suggested by=
 Paolo
>   Bonzini).
>=20
> * Note to Richard: patch 4 has been adapted to the new patch 3 async call=
back,
>   but is essentially the same.
>=20
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
> Llu=EDs Vilanova (7):
>       exec: [tcg] Refactor flush of per-CPU virtual TB cache
>       trace: Allocate cpu->trace_dstate in place
>       trace: [tcg] Delay changes to dynamic state when translating
>       exec: [tcg] Use different TBs according to the vCPU's dynamic traci=
ng state
>       trace: [tcg] Do not generate TCG code to trace dynamically-disabled=
 events
>       trace: [tcg,trivial] Re-align generated code
>       trace: [trivial] Statically enable all guest events
>=20
>=20
>  accel/tcg/cpu-exec.c                     |    8 ++++++--
>  accel/tcg/cputlb.c                       |    2 +-
>  accel/tcg/translate-all.c                |   26 +++++++++++++++++++-----=
--
>  include/exec/exec-all.h                  |   12 ++++++++++++
>  include/exec/tb-hash-xx.h                |    7 +++++--
>  include/exec/tb-hash.h                   |    5 +++--
>  include/qom/cpu.h                        |   12 ++++++------
>  qom/cpu.c                                |    8 --------
>  scripts/tracetool/__init__.py            |    3 ++-
>  scripts/tracetool/backend/dtrace.py      |    4 ++--
>  scripts/tracetool/backend/ftrace.py      |   20 ++++++++++----------
>  scripts/tracetool/backend/log.py         |   19 ++++++++++---------
>  scripts/tracetool/backend/simple.py      |    4 ++--
>  scripts/tracetool/backend/syslog.py      |    6 +++---
>  scripts/tracetool/backend/ust.py         |    4 ++--
>  scripts/tracetool/format/h.py            |   26 +++++++++++++++++++-----=
--
>  scripts/tracetool/format/tcg_h.py        |   21 +++++++++++++++++----
>  scripts/tracetool/format/tcg_helper_c.py |    5 +++--
>  tcg/tcg-runtime.c                        |    3 ++-
>  tests/qht-bench.c                        |    2 +-
>  trace-events                             |    6 +++---
>  trace/control-target.c                   |   21 ++++++++++++++++++---
>  trace/control.c                          |    9 ++++++++-
>  trace/control.h                          |    3 +++
>  24 files changed, 157 insertions(+), 79 deletions(-)
>=20
>=20
> To: qemu-devel@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Emilio G. Cota <cota@braap.org>
>=20

Besides Emilio's comments:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZI2lAAoJEJykq7OBq3PIwKYH/2ipLS51W7brlp2VW6P2sNlt
AIn4EkgKT+fjr+b8wAxPpp78WN7JcIW/tj5HbxfqAnAaOiwW5O474qCdkSBkGjkG
EFWbss1R9BTm3wNP8hkj2mWQAvRoO6yQTvrkYaBAnsKYIHDgt9lweiAZtbH/Xtz7
rLcZPRSkrVrCs2WwDMwYDlTkENGuQxX9Xmwhm44fAeM54j3h/52iNph73EqipkNm
8fA4cT3ryOSGMHbqPshsTZcQMZeyRh8ozRC6faFYBT2RkRyCFDeOdDJbMhbEVtf7
U1Qw5n5Jps8HW+Ef5O+bZgAULPjxKNWFkVMu/eiHGfEjxy47+8tY5llnVBHMrOI=
=e4Eo
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
