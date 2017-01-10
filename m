Received: from eggs.gnu.org ([2001:4830:134:3::10]:54049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cR0lc-0003BP-Pu
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cR0lZ-00077w-Mt
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:03:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cR0lZ-00077P-EP
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:03:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DDE180F75
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:03:25 +0000 (UTC)
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
	<20170110174810.17748-7-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6231aa8-1463-0d7b-0b46-9c9011f50920@redhat.com>
Date: Tue, 10 Jan 2017 12:03:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170110174810.17748-7-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rUSgDvO7SnHnT4XvHSKM97NFiQQFuLxvL"
Subject: Re: [Qemu-devel] [PATCH v2 06/20] char: use a static array for
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rUSgDvO7SnHnT4XvHSKM97NFiQQFuLxvL
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <a6231aa8-1463-0d7b-0b46-9c9011f50920@redhat.com>
Subject: Re: [PATCH v2 06/20] char: use a static array for backends
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
 <20170110174810.17748-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 11:47 AM, Marc-Andr=C3=A9 Lureau wrote:
> Number and kinds of backends is known at compile-time, use a fixed-size=
d
> static array to simplify iterations & lookups.

This part is okay;

> Add an alias field to the
> CharDriver structure to cover the cases where we previously registered =
a
> driver twice under two names.

but this part belongs in the 5/20 commit message.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c | 68 ++++++++++++++++++++++++++++++-----------------------=
--------
>  1 file changed, 34 insertions(+), 34 deletions(-)

> @@ -4143,15 +4144,17 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpt=
s *opts,
>          goto err;
>      }
> =20
> -    for (i =3D backends; i; i =3D i->next) {
> -        cd =3D i->data;
> -
> +    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> +        cd =3D backends[i];

> @@ -4368,11 +4371,15 @@ qmp_prepend_backend(ChardevBackendInfoList *lis=
t, const char *name)
>  ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
>  {
>      ChardevBackendInfoList *backend_list =3D NULL;
> -    CharDriver *c;
> -    GSList *i;
> +    const CharDriver *c;
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> +        c =3D backends[i];
> +        if (!c) {

Worth using the name 'cd' everywhere for consistency?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rUSgDvO7SnHnT4XvHSKM97NFiQQFuLxvL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdSHmAAoJEKeha0olJ0NqAKcIAKO8UGklbF42YXdAcqxEEUHo
gbNsVQnIS1rZryG6nQsUnaLdJ3l5WYUl83Z2eK/ZWVxNQkzaT5bwhZz/DCQamJua
qRAlEXIDIMx6y4knEeEVr2NM6Cu+V4AXjFDeJkMN0OCQUzBnSwv1gJ5iahl3RwhE
vM7ze6sMMhMVFsxtYG+AmA2K3SmpDa045rMMvVWfuBht8Az2rX/4+UxB1BTU4hwz
bT6ybOGHvv2z39jf1QyoHe4U+6+prQdbADj6wG9hME5+tkD/cqyLRjQE77YF0DqD
u5Ww+qP86lPPIiDCyeQOHgZ9NFywQ0W1IgGu5depFaedWoMC229zUoJ7fF1JCTc=
=AVX8
-----END PGP SIGNATURE-----

--rUSgDvO7SnHnT4XvHSKM97NFiQQFuLxvL--
