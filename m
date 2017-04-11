Received: from eggs.gnu.org ([2001:4830:134:3::10]:44473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxtPw-0005TD-3e
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxtPt-0005ld-2N
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:53:00 -0400
Date: Tue, 11 Apr 2017 11:52:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170411105239.GD17943@stefanha-x1.localdomain>
References: <20170410150542.30376-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 00/10] block: Fixes regarding
 dataplane and management operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 11:05:32PM +0800, Fam Zheng wrote:
> v3: Respin the unmerged changes from v2 and include one new fix:
>=20
>     (Yes, it is a big series for the last -rc, and I personally prefer th=
e v2
>     approach for the 4-9 part of the problem, which is much more mechanic=
al.)
>=20
>     - 1, 2 are redoing previous patch 4, using bdrv_parent_drained_begin/=
end.
>       [Kevin]
>       Also fix the ordering against aio_context_release. [Stefan]
>     - 3 is unchanged from patch 6 in v2.
>     - 4-9 are reworking of patch 5 following Paolo's suggestion, which al=
lowed
>       better patch split.
>     - 10 is finding of a latent bug, which is revealed by patch 9.
>=20
> v2: - Drop patch 4 in v1. A second thought made me feel neither it nor Ke=
vin's
>       suggestion to move the BH process to bdrv_drain_recurse/BDRV_POLL_W=
HILE
>       is a complete fix. So leave it for a separate patch.
>     - Add rev-by to patches 1, 3, 4.
>     - Split from patch 1 in v1 and add patch 2, for the new assertions. [=
Kevin]
>     - Rewrite patch 5. Fix block job's co when a BDS is moved to a differ=
ent
>       aio context. [Kevin]
>     - Add patch 6.
>=20
> Crashes are reported on dataplane devices when doing snapshot and commit =
under
> guest I/O.
>=20
> With this series, Ed's test case '176' now passes:
>=20
>     https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9
>=20
> Fam Zheng (10):
>   block: Make bdrv_parent_drained_begin/end public
>   block: Quiesce old aio context during bdrv_set_aio_context
>   tests/block-job-txn: Don't start block job before adding to txn
>   coroutine: Extract qemu_aio_coroutine_enter
>   async: Introduce aio_co_enter and aio_co_enter_if_inactive
>   block: Introduce bdrv_coroutine_enter and *_if_inactive
>   blockjob: Use bdrv_coroutine_enter to start coroutine
>   qemu-io-cmds: Use bdrv_coroutine_enter
>   block: Use bdrv_coroutine_enter to start I/O coroutines
>   block: Fix bdrv_co_flush early return
>=20
>  block.c                    | 17 +++++++++++++++--
>  block/block-backend.c      |  4 ++--
>  block/io.c                 | 34 ++++++++++++++++++----------------
>  blockjob.c                 |  4 ++--
>  include/block/aio.h        | 18 ++++++++++++++++++
>  include/block/block.h      | 27 +++++++++++++++++++++++++++
>  include/qemu/coroutine.h   |  5 +++++
>  qemu-io-cmds.c             |  2 +-
>  tests/qemu-iotests/109.out | 10 +++++-----
>  tests/test-blockjob-txn.c  |  6 +++++-
>  util/async.c               | 14 +++++++++++++-
>  util/qemu-coroutine.c      | 11 ++++++++---
>  util/trace-events          |  2 +-
>  13 files changed, 120 insertions(+), 34 deletions(-)

We need a fix for 2.9.  Interactions between AioContexts, coroutines,
and blockjobs are complex and brittle.  That is a pre-existing problem
though and hopefully we can simplify abstractions in 2.10.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7LV3AAoJEJykq7OBq3PI8fEIAIyiwEm4Ls5fSo6HmRtMvv0z
szaQdjIaH74WlIyQalhH4V2n75BquvkGdc5JAq0/T95rPK9O1aWqnxzk/b+R4vzL
XXijcvRhH3po6gjB0N+elCpy/ooDSrd7AslAveFs2GHm0zCMtwBQAce+lDtu+PtQ
fKtO9yGQUXvzebwGoBRsYAfzzDdTfmpBHgBKKtJ7fdTsndTuRP4bJsgzC1droV5T
/JvRSTKB+LOyAjYoaBLkYuiTyVJpGZO4zIjwCUo6j6UEn0yQKaWR6hFh7PfzkeiI
F471s8aU1i3OYJh0y/bReHnLe7jHvDWrgI3TI6XLQFV9cLntPpFTyEm77rbS/Ek=
=cZBJ
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
