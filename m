Received: from eggs.gnu.org ([2001:4830:134:3::10]:53805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fRlnA-0003Oj-4Y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 17:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fRln9-0003Po-0U
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 17:53:00 -0400
References: <20180608151536.7378-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5dc8086d-3d8c-9ccf-93e1-4ac802c1b56f@redhat.com>
Date: Sat, 9 Jun 2018 23:52:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180608151536.7378-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="42fcI3JbEPg9d35t0j6JLWopnGiEg4q2O"
Subject: Re: [Qemu-devel] [PATCH] throttle: Fix crash on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--42fcI3JbEPg9d35t0j6JLWopnGiEg4q2O
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <5dc8086d-3d8c-9ccf-93e1-4ac802c1b56f@redhat.com>
Subject: Re: [PATCH] throttle: Fix crash on reopen
References: <20180608151536.7378-1-berto@igalia.com>
In-Reply-To: <20180608151536.7378-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-08 17:15, Alberto Garcia wrote:
> The throttle block filter can be reopened, and with this it is
> possible to change the throttle group that the filter belongs to.
>=20
> The way the code does that is the following:
>=20
>   - On throttle_reopen_prepare(): create a new ThrottleGroupMember
>     and attach it to the new throttle group.
>=20
>   - On throttle_reopen_commit(): detach the old ThrottleGroupMember,
>     delete it and replace it with the new one.
>=20
> The problem with this is that by replacing the ThrottleGroupMember the
> previous value of io_limits_disabled is lost, causing an assertion
> failure in throttle_co_drain_end().
>=20
> This problem can be reproduced by reopening a throttle node:
>=20
>    $QEMU -monitor stdio
>    -object throttle-group,id=3Dtg0,x-iops-total=3D1000 \
>    -blockdev node-name=3Dhd0,driver=3Dqcow2,file.driver=3Dfile,file.fil=
ename=3Dhd.qcow2 \
>    -blockdev node-name=3Droot,driver=3Dthrottle,throttle-group=3Dtg0,fi=
le=3Dhd0,read-only=3Don
>=20
>    (qemu) block_stream root
>    block/throttle.c:214: throttle_co_drain_end: Assertion `tgm->io_limi=
ts_disabled' failed.
>=20
> Since we only want to change the throttle group on reopen there's no
> need to create a ThrottleGroupMember and discard the old one. It's
> easier if we simply detach it from its current group and attach it to
> the new one.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/throttle.c | 54 +++++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 33 insertions(+), 21 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--42fcI3JbEPg9d35t0j6JLWopnGiEg4q2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlscTDIACgkQ9AfbAGHV
z0C7rwf/aHSg9ReZxEyb6xvAh30RkXrGudOUweX0i2aORCdu7YaZZPgQhXlG7LU4
VPAAZRJyy2ItqRsQ+jMf3R7E2mgsaD2hzikK9Y2BObKmaa6liBFOdL0k3nKeIRmX
kj8TqaVlGepXVcM0GaVumuyourWRWoKoH2QqCBDbvwb7Tx5S/j2vKD3CJw8msWzk
PTVt0sfaNNbsyEpTESX5PWToNPV9AASGzP+Zj6AfaAH4JTu8vokdldGEy9oPWrSH
J/qEKgI+bRXSRzoXLNYMgb4U0yBtgzHakIhlWC8Jba04LzwOjD9EWZPPUd005lGk
608AGSOO9UC2x3wCHwamjrS4uhGAuw==
=vH0L
-----END PGP SIGNATURE-----

--42fcI3JbEPg9d35t0j6JLWopnGiEg4q2O--
