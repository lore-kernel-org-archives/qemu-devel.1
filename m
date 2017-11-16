Received: from eggs.gnu.org ([2001:4830:134:3::10]:39377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFKv7-0002DH-Dg
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eFKv2-0003DY-LE
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:13:33 -0500
Date: Thu, 16 Nov 2017 14:13:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171116141325.GD29106@stefanha-x1.localdomain>
References: <20171116112150.27607-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <20171116112150.27607-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.11] throttle-groups:
 forget timer and schedule next TGM on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 11:21:50AM +0000, Stefan Hajnoczi wrote:
> tg->any_timer_armed[] must be cleared when detaching pending timers from
> the AioContext.  Failure to do so leads to hung I/O because it looks
> like there are still timers pending when in fact they have been removed.
>=20
> Other ThrottleGroupMembers might have requests pending too so it's
> necessary to schedule the next TGM so it can set a timer.
>=20
> This patch fixes hung I/O when QEMU is launched with drives that are in
> the same throttling group:
>=20
>   (guest)$ dd if=3D/dev/zero of=3D/dev/vdb oflag=3Ddirect bs=3D512 &
>   (guest)$ dd if=3D/dev/zero of=3D/dev/vdc oflag=3Ddirect bs=3D512 &
>   (qemu) stop
>   (qemu) cont
>   ...I/O is stuck...
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/throttle-groups.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaDZ0EAAoJEJykq7OBq3PI3IUH/3ATc/XDOI3iC5/up+G9TrGL
99GNYUpanZtGT2SnMNiZ97Khgv3FV1tJRtyJnVIMDmA1Mpqkf9zsSMT6r9g8LfoG
YdZhh4Ho8CwGYgomfAsdsqqQew1R1GqUYpX0vxS3L0en3kjE4aqcacKUgaYHhhGH
hqz3lIuLTZ5F8Je0Ft8yD9WEu06EKl0H0QfWrxVBi3MgxP+uhVuv+Fz3Yzm8UYJe
e81DdvCa1CsCQxm36RpP9q3rOSKAW/dweob6UXU6UgBjFhS0oXxl7IPHfNqLsT6K
KeCFJxWAAf3vSbFRS87iJ3zchjiYeQ5ynX561v8gA8kkphWuXErSVpZAk5I09kw=
=mYpw
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
