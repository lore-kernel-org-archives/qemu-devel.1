Received: from eggs.gnu.org ([209.51.188.92]:35458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hle@owl.eu.com>) id 1go3Gx-0001dQ-QK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hle@owl.eu.com>) id 1go3Gw-000827-Lb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:32:07 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hle@owl.eu.com>) id 1go3Gw-00080t-7d
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:32:06 -0500
Date: Mon, 28 Jan 2019 10:31:57 +0100
From: Hugo Lefeuvre <hle@debian.org>
Message-ID: <20190128093157.GA27483@hle-laptop>
References: <20181119110757.2692-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20181119110757.2692-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] bt: use size_t type for length
 parameters instead of int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Arash TC <tohidi.arash@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, debian-lts@lists.debian.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> The length parameter values are not negative, thus use an unsigned
> type 'size_t' for them. Many routines pass 'len' values to memcpy(3)
> calls. If it was negative, it could lead to memory corruption issues.
> Add check to avoid it.

I'm working on a Debian LTS security update for qemu and am currently
thinking about addressing this issue as well.

I see this patch has not been applied yet and the bluetooth subsystem
is pending deprecation. Are you still considering to apply it?

> @@ -113,6 +113,7 @@ static void vhci_host_send(void *opaque,
>      static uint8_t buf[4096];
> =20
>      buf[0] =3D type;
> +    assert(len < sizeof(buf));
>      memcpy(buf + 1, data, len);
> =20
>      while (write(s->fd, buf, len + 1) < 0)

Any reason why assert() calls are used here ?

These checks should always be executed, but they won't if user compiles
without asserts. Also, AFAIK any assert failure will stop the qemu host
process which is not what we want in this case.

regards,
 Hugo

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxOzA0ACgkQZYVUZx9w
0DQpBAf+Oeu+pXI8UKQ0M0HO5mSl2MT/8egWoy/nTCuR2YxcTlsxOwxKbOcZBXqi
p4HO1gItQMaEfMTGOhvVE2BJRvWar+/CS8j5ymD+6M6nm32TWdoqCAeoua/C/pI+
ycAkNAxhbpZfuzWFomc5Gqzm2+SWPR6wbFBOT8Z7fTRrZ61AFFuixJq0jdtCFEBZ
rx1gA+/r4+dll4hxxB4sZrIh2+Bde/0ZOEgHUJp9RqrXfwcJB9eSeBFNkClTRV+q
aB1iTFm0bTwIyuTO78jz/ofCD++Pxesdw6FYCZIoXx49Riyx6g7GzOQFGuevyqtI
2RxyGZOxf3pHM67ave5uXO1OK7FKxA==
=20/0
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
