Received: from eggs.gnu.org ([209.51.188.92]:56308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hle@owl.eu.com>) id 1goTCa-0000Yu-HA
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hle@owl.eu.com>) id 1goTCZ-0000oj-BS
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:13:20 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:52013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hle@owl.eu.com>) id 1goTCZ-0000nP-4w
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:13:19 -0500
Date: Tue, 29 Jan 2019 14:13:11 +0100
From: Hugo Lefeuvre <hle@debian.org>
Message-ID: <20190129131311.GA1478@hle-laptop>
References: <20181119110757.2692-1-ppandit@redhat.com>
	<20190128093157.GA27483@hle-laptop>
	<83722857-5a7f-c722-4b56-6b04d78a9e2e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <83722857-5a7f-c722-4b56-6b04d78a9e2e@redhat.com>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: P J P <ppandit@redhat.com>, Eric Blake <eblake@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Arash TC <tohidi.arash@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, debian-lts@lists.debian.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> I have been assigned to fix this issue, but rather fixing locally this
> BT device, fix the pattern on all devices.
> I'll post the series during the week and Cc you (and eventually the
> Debian LTS list when it gets merged). The series obsoletes this patch,
> so the plan is to not apply it.

Thanks ! I will wait for your patch then.

> > Any reason why assert() calls are used here ?
> >=20
> > These checks should always be executed, but they won't if user compiles
> > without asserts. Also, AFAIK any assert failure will stop the qemu host
> > process which is not what we want in this case.
>=20
> There was a discussion about this, and the outcome is QEMU does not
> support building without assertions. See this commit:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblobdiff;f=3Dinclude/qemu/osdep.h;=
h=3D9966638;hp=3D6855b94;hb=3D262a69f42;hpb=3D825bfa005

Makes sense. But I'm still sceptical about assert() being used here.

For example:

    @@ -113,6 +113,7 @@ static void vhci_host_send(void *opaque,
         static uint8_t buf[4096];
    =20
         buf[0] =3D type;
    +    assert(len < sizeof(buf));
         memcpy(buf + 1, data, len);
    =20
         while (write(s->fd, buf, len + 1) < 0)

=46rom my understanding assert() calls are supposed to be a way to verify
code assumptions at runtime. assert failures are always bugs, so they
terminate the process.

If len is passed by guest systems, an excessive value should not be
considered a bug but invalid user passed input, that is normal behaviour,
right? In this case I expect qemu to simply reject the input instead of
triggering an assert failure and terminating.

regards,
 Hugo

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxQUWcACgkQZYVUZx9w
0DRAxQgAiKUi2t78fu8XPh5mdmyx2QS4YtbUDq0wHaKUkFiWhoSi4NHkMY6XmZs8
vK9BUJJQldM4O3hhNczTlwUxnL8XNm7X4eA4lyXZr3gF0gCFdCFAQYvyuB5DgsG5
pool0rJ1UCTQNT0zI8Q1lHjSfXHIfJo6ZfyHcKo+B2Dyol5cqVPxCypluatEqtKN
ytxMSm/b/e2gSG822UP/f64pV9GHKOloarGy3l7jnpio2XSQW/IGO7TrKI0w5Nmr
49z0WeEaGZkylDD4y4svYn/5u2oGhsYKmfpFwYeaoXwYYGmSjCrsuX0MBP0+fG38
qQe9pCWGMnz9ii2MdIbBykuZviGt9A==
=nn+l
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
