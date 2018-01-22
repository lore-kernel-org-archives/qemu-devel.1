Received: from eggs.gnu.org ([2001:4830:134:3::10]:35797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edj1g-0003VW-Ti
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edj1g-0007gD-1J
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:49:08 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-4-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45080fc9-c869-a8c8-0f20-ca9d950fb2cc@redhat.com>
Date: Mon, 22 Jan 2018 14:48:55 -0600
MIME-Version: 1.0
In-Reply-To: <1516366207-109842-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="og1h25ZcIN7pP9mrECi2eSzeG1lRddYqQ"
Subject: Re: [Qemu-devel] [PATCH v2 3/8] ide: account UNMAP (TRIM) operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--og1h25ZcIN7pP9mrECi2eSzeG1lRddYqQ
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com
Message-ID: <45080fc9-c869-a8c8-0f20-ca9d950fb2cc@redhat.com>
Subject: Re: [PATCH v2 3/8] ide: account UNMAP (TRIM) operations
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516366207-109842-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516366207-109842-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 06:50 AM, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  hw/ide/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20

> @@ -460,10 +468,15 @@ static void ide_issue_trim_cb(void *opaque, int r=
et)
>                  }
> =20
>                  if (!ide_sect_range_ok(s, sector, count)) {
> +                    block_acct_invalid(blk_get_stats(s->blk),
> +                                       BLOCK_ACCT_UNMAP);
>                      iocb->is_invalid =3D true;
>                      goto done;
>                  }
> =20
> +                block_acct_start(blk_get_stats(s->blk), &s->acct,
> +                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT=
_UNMAP);

We're still mixing bytes- and block-based reporting; how easy or hard
would it be to flip block_acct_start() and friends to be byte-based?
But not the subject of this series, per se.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--og1h25ZcIN7pP9mrECi2eSzeG1lRddYqQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmTjcACgkQp6FrSiUn
Q2qBOwgAkrvySqBmAB8q+0rz0JDXPPS+wvCZvh4geb2w2k/3jYxuBhHclc+/zjrw
fM8N900d+QLQ+Iq+TTalDIGHfcEVuv0WeG7kCi1YP7mqr1csqjJzFRadMqdDPZ9A
QeGJXfH4YKfwncz5M6Ox2/TKnlvIFOu16u3hVSE4QsoIen7S+0+12WYrta/Ul/93
8Czgeobc76+Hy+QOaIBPYQKkcticU0q2c0bXHvmOIb7Izlii2k0yXlzAeyRS5TaZ
C5GOOragG7rUEF9SBmesFUZvMwhEx2g1JquDHufKRs9HS/Vhn/YdFtmmDpkk2r6n
mrGzX6uXwjpwmgoqbnduW2WBVC0MbA==
=mU57
-----END PGP SIGNATURE-----

--og1h25ZcIN7pP9mrECi2eSzeG1lRddYqQ--
