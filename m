Received: from eggs.gnu.org ([2001:4830:134:3::10]:36645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e6tgM-00041c-4x
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e6tgL-0004sk-3Z
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:31:26 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-12-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59e54507-ba07-6e06-e849-660b595a96d7@redhat.com>
Date: Tue, 24 Oct 2017 02:31:14 -0500
MIME-Version: 1.0
In-Reply-To: <20171019222637.17890-12-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qfmLMwop6DQCIg0kNQJwMD1dafoLvfkoU"
Subject: Re: [Qemu-devel] [PATCH v5 11/11] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qfmLMwop6DQCIg0kNQJwMD1dafoLvfkoU
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <59e54507-ba07-6e06-e849-660b595a96d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/11] nbd: Minimal structured read for
 client
References: <20171019222637.17890-1-eblake@redhat.com>
 <20171019222637.17890-12-eblake@redhat.com>
In-Reply-To: <20171019222637.17890-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 05:26 PM, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Minimal implementation: for structured error only error_report error
> message.
>=20

> +
> +    /* In-out fields, set by client before nbd_receive_negotiate() and=

> +     * updated by server results during nbd_receive_negotiate() */
> +    bool structured_reply;
> +

> +++ b/nbd/client.c
> @@ -685,6 +685,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const c=
har *name,
>          if (fixedNewStyle) {
>              int result;
>=20
> +            if (info->structured_reply) {
> +                result =3D nbd_request_simple_option(ioc,
> +                                                   NBD_OPT_STRUCTURED_=
REPLY,
> +                                                   errp);
> +                if (result < 0) {
> +                    goto fail;
> +                }
> +                info->structured_reply =3D result =3D=3D 1;
> +            }
> +

Another bug fix: if we are not fixedNewStyle, then the client cannot
request structured_reply from the server, so we must clear
info->structure_reply before returning to the client.  Fixing that
cleans up a lot of the iotests failures (since iotests tends to run
old-style servers that cannot negotiate options - maybe we should
improve that, since newstyle is better, but that's a task for another day=
).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qfmLMwop6DQCIg0kNQJwMD1dafoLvfkoU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnu7EIACgkQp6FrSiUn
Q2pY8AgArwr7ocB2Nq8nP2xgZjlJRruSEYqfM79HSIoYfABN/66gVdi4Rw0rRjTq
WkBk9mcDisudWyaZywPq5CqaBxajTtBjqnYXFP+Z5U/XUjUfsIhfsb5AXt9Zxeb0
i/r1Bik8H7Z+r7X8tsEkVyGYOOM4PsHuQxaOrKyl3aU42Ep5st36zEtj7cZIt1on
X3wpMLvNIsV9reQvnvx60KE0XWjDqODvgwPsjtJ/8T1uXNs0mn63v3lrHgiPGhnx
WIg1UvomkfmEoxohOB9EpcAD45CT6b9k2urW0ALanS44IVyHcMX6npytortwMGnQ
XcG9j17iFv3kEm+wDb3ePqgEHBKPUA==
=tkqx
-----END PGP SIGNATURE-----

--qfmLMwop6DQCIg0kNQJwMD1dafoLvfkoU--
