Received: from eggs.gnu.org ([2001:4830:134:3::10]:48223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEFTV-0005n1-Df
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEFTR-0008VR-Ek
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:12:33 -0500
Date: Mon, 13 Nov 2017 14:12:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171113141217.GC27765@stefanha-x1.localdomain>
References: <20171110151934.16883-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20171110151934.16883-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] throttle-groups: drain before detaching
 ThrottleState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>, Alberto Garcia <berto@igalia.com>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 03:19:34PM +0000, Stefan Hajnoczi wrote:
> I/O requests hang after stop/cont commands at least since QEMU 2.10.0
> with -drive iops=3D100:
>=20
>   (guest)$ dd if=3D/dev/zero of=3D/dev/vdb oflag=3Ddirect count=3D1000
>   (qemu) stop
>   (qemu) cont
>   ...I/O is stuck...
>=20
> This happens because blk_set_aio_context() detaches the ThrottleState
> while requests may still be in flight:
>=20
>   if (tgm->throttle_state) {
>       throttle_group_detach_aio_context(tgm);
>       throttle_group_attach_aio_context(tgm, new_context);
>   }
>=20
> This patch encloses the detach/attach calls in a drained region so no
> I/O request is left hanging.  Also add assertions so we don't make the
> same mistake again in the future.
>=20
> Reported-by: Yongxue Hong <yhong@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v4:
>  * Simplified patch in response to Berto's review
> ---
>  block/block-backend.c   | 2 ++
>  block/throttle-groups.c | 6 ++++++
>  2 files changed, 8 insertions(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaCahBAAoJEJykq7OBq3PIso4H/RsfxWhX9wm4HvRwU71HD0NO
zsOooLq3HK2D1mgU2uAn4QGDC/+78j4/8C7RDcBppBiMF0hni3bZd2GGju9udUOA
1O7fJnr4mG1w3luMecQRkcp6FOLspAKe6uV88kbNZ3kCO2MhXm50MzVuBf8a6IDK
rPtH0bL36hZFMKOCZZABAyYidPVygK6Cbx04/cOr2UB7SVWmY8kN9ssP9cPd+dX/
boVNGuZTQo9f/sBM6udPRhQYN33oBipL0OkdlshO0mKvjlJicpDVoeMOG1Pu52sw
3S3EEeHKQAGgDjPpfmHnHY+oSrTmIkCCiwsl/96GJOQ5moHzd35X5Tqp0zqB5tY=
=R3+g
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
