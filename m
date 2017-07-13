Received: from eggs.gnu.org ([2001:4830:134:3::10]:34120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfTg-0001gc-CE
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfTf-0001U4-Du
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:52:28 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-6-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2567ecf-5325-2048-3c86-23c82b20f2fc@redhat.com>
Date: Thu, 13 Jul 2017 09:52:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170707203049.534-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SrvpJ602Ba2At6dvOCO3aeISf0rRXGCVp"
Subject: Re: [Qemu-devel] [PATCH v5 5/9] nbd: Refactor reply to
 NBD_OPT_EXPORT_NAME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SrvpJ602Ba2At6dvOCO3aeISf0rRXGCVp
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, marcandre.lureau@redhat.com
Message-ID: <e2567ecf-5325-2048-3c86-23c82b20f2fc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/9] nbd: Refactor reply to
 NBD_OPT_EXPORT_NAME
References: <20170707203049.534-1-eblake@redhat.com>
 <20170707203049.534-6-eblake@redhat.com>
In-Reply-To: <20170707203049.534-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 03:30 PM, Eric Blake wrote:
> Reply directly in nbd_negotiate_handle_export_name(), rather than
> waiting until nbd_negotiate_options() completes.  This will make it
> easier to implement NBD_OPT_GO.  Pass additional parameters around,
> rather than stashing things inside NBDClient.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v5: new patch
> ---

>  static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_=
t length,
> +                                            uint16_t myflags, bool no_=
zeroes,
>                                              Error **errp)
>  {
>      char name[NBD_MAX_NAME_SIZE + 1];
> +    char buf[8 + 4 + 124] =3D "";

Ouch, this is sized 2 bytes too large (it was copying from old-style
negotiation, which sends 4 bytes instead of 2 for the flags after the nam=
e).

> +    trace_nbd_negotiate_new_style_size_flags(client->exp->size,
> +                                             client->exp->nbdflags | m=
yflags);
> +    stq_be_p(buf, client->exp->size);
> +    stw_be_p(buf + 8, client->exp->nbdflags | myflags);
> +    len =3D no_zeroes ? 10 : sizeof(buf);
> +    ret =3D nbd_write(client->ioc, buf, len, errp);

which means we are breaking things by sending too much.

I'll submit the followup patch shortly, assuming Paolo's v1 pull request
doesn't get held up for any other reason.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SrvpJ602Ba2At6dvOCO3aeISf0rRXGCVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ4kfAAoJEKeha0olJ0NqURkH/iYwLszWAD1TZpvG2/hevuld
JliCSFsIqu8aRVuABfe0YOWn9IvI+h5anrb2ugwJMtVt2oGpp4x+Wo4eXr5ZRm7N
wRV2rhW0UZLbHf72qiPJ6hoILOo8jCx+gfUiEAeEhKB5cIrUXO1k/T/3Ev4OC78H
yDDWJxT3tCH9EvOoQSal6m5SNvqvWe7AEHMAAXAOApysWZuNXJ2QR3fL5E+LHFBA
asjXz72gn8bhsJAmNcg/bxoVI7bITpTMbeRdzpOMTBVkMp+YBWHVEZUUDGLLTMZQ
DghX5Ft0zwnNnCXtuyTtxQBsXibNAEEYhGdLl7F3CGyr/zfz95Hcic1Syg69T8c=
=WoM4
-----END PGP SIGNATURE-----

--SrvpJ602Ba2At6dvOCO3aeISf0rRXGCVp--
