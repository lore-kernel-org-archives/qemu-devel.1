Received: from eggs.gnu.org ([2001:4830:134:3::10]:57683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPUBg-0002M1-B6
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPUBc-0000ZC-9m
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:36:20 -0400
Date: Mon, 26 Jun 2017 14:36:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626133611.GB29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 2/8] block: Add
 aio_context field in ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 03:46:54PM +0300, Manos Pitsidianakis wrote:
> timer_cb() needs to know about the current Aio context of the throttle
> request that is woken up. In order to make ThrottleGroupMember backend
> agnostic, this information is stored in an aio_context field instead of
> accessing it from BlockBackend.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/block-backend.c   |  1 +
>  block/throttle-groups.c | 19 +++++----------
>  include/qemu/throttle.h |  1 +
>  tests/test-throttle.c   | 65 +++++++++++++++++++++++++++----------------=
------
>  util/throttle.c         |  4 +++
>  5 files changed, 48 insertions(+), 42 deletions(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 90a7abaa53..1d501ec973 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1928,6 +1928,7 @@ void blk_io_limits_disable(BlockBackend *blk)
>  /* should be called before blk_set_io_limits if a limit is set */
>  void blk_io_limits_enable(BlockBackend *blk, const char *group)
>  {
> +    blk->public.throttle_group_member.aio_context =3D blk_get_aio_contex=
t(blk);
>      assert(!blk->public.throttle_group_member.throttle_state);
>      throttle_group_register_tgm(&blk->public.throttle_group_member, grou=
p);

Or throttle_group_register_tgm() could take an AioContext* argument, I
think that's a little cleaner than modifying throttle_group_member
fields in multiple source files.

> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 5e9d8fb4d6..7883cbb511 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -71,6 +71,7 @@ static QemuMutex throttle_groups_lock;
>  static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =3D
>      QTAILQ_HEAD_INITIALIZER(throttle_groups);
> =20
> +
>  /* Increments the reference count of a ThrottleGroup given its name.
>   *
>   * If no ThrottleGroup is found with the given name a new one is

Spurious whitespace change.  Please do not change whitespace in random
places.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUQ3LAAoJEJykq7OBq3PICZoH/i218PjZy3qORICN5qSyXMLZ
7kpLYR44F1r01ebLsnl7O1qLx6vC5g4S+TTVHBxpNkwPxupX89ik+Tcf6gFlteQf
SKTWrVFMmCwnT5lqtAIlrWAYodmybgWfNx50bQu+OajWkDa2tdWxsVyg7fQgXGaa
8kMTMuQlDPI1v9LDp332MEtFAVT2gwVwOY+diiJfWzRQdjByVdzSkU7Mks4lUv2O
AZ6NbMp4WZKsNv895x5UUvD+9lj76h9C631vjz9a9cHRh+6G5FC0xlxhYmlk7Svu
581PKM+UJopKmbkEKxN3kogG7wE7Y0I3sg4GG13Y1iplDN0TrJlFcaQmCgiseio=
=gMvP
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
