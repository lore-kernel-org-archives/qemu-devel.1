Received: from eggs.gnu.org ([2001:4830:134:3::10]:57424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lPc-0005Jd-KI
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lPb-00040w-Rb
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:53:04 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2af38699-b29a-99db-62e7-fb983799cd45@redhat.com>
Date: Thu, 12 Oct 2017 16:52:53 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qwqmRoi1Hr5xSgfQMjA35KobdwTAw0tAR"
Subject: Re: [Qemu-devel] [PATCH v3 04/13] nbd/server: structurize simple
 reply header sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qwqmRoi1Hr5xSgfQMjA35KobdwTAw0tAR
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <2af38699-b29a-99db-62e7-fb983799cd45@redhat.com>
Subject: Re: [PATCH v3 04/13] nbd/server: structurize simple reply header
 sending
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use packed structure instead of pointer arithmetics.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  6 ++++++
>  nbd/server.c        | 36 ++++++++++++++----------------------
>  2 files changed, 20 insertions(+), 22 deletions(-)
>=20

>      if (!len) {
> -        ret =3D nbd_send_reply(client->ioc, reply, errp);
> +        ret =3D nbd_write(client->ioc, &simple_reply, sizeof(simple_re=
ply), NULL);
>      } else {
>          qio_channel_set_cork(client->ioc, true);
> -        ret =3D nbd_send_reply(client->ioc, reply, errp);
> +        ret =3D nbd_write(client->ioc, &simple_reply, sizeof(simple_re=
ply), NULL);

One more thing: this should be errp, not NULL - we don't want to lose
the error, even if the next patch changes things yet again.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qwqmRoi1Hr5xSgfQMjA35KobdwTAw0tAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf5DUACgkQp6FrSiUn
Q2pMfwf9F2RH43ZgUER4D7Xt1cNHmINciHKQLXSx4/p7WyBEYT9vHIEjNvwyYZx7
aaNjAHXoh/xMZ45XiO4CLqN0AoRi95xil2su5Tm7V4GzwFGjLVAX5iWVJMAOXp4m
HfoJ0XoZd0kNTCkA7m5+f3Ba+YM1dbPVKCrbJs8br770MCgbsEEE+yGVho2p+QTY
c80ZG3EWN10oM300tPX0WNHypwm7qmiXHi2YHIvR8bBa1JZ0KnZbbkxgrPjT83an
wdqvkTcpmLawbrEqPWqnReOYFrU+wRZQ0HRNzH3ziA4wVx/HjyYHKjasOuRgHcY2
2XnDkYp9mVku+NvqHr51opb8HsrFzw==
=zz6G
-----END PGP SIGNATURE-----

--qwqmRoi1Hr5xSgfQMjA35KobdwTAw0tAR--
