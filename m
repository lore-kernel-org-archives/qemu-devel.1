Received: from eggs.gnu.org ([2001:4830:134:3::10]:46687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYHyH-0001Tp-8g
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYHyC-0006Gh-CV
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:50:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYHyC-0006GV-36
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:50:32 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90AD36197C
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 19:50:31 +0000 (UTC)
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-18-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03c6fb68-3051-dd02-cbea-19b3b2ed70b3@redhat.com>
Date: Mon, 30 Jan 2017 13:50:28 -0600
MIME-Version: 1.0
In-Reply-To: <20170130133954.31353-18-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BEJtx38tQADX5KTdO3vqmHGwkPFgopfxL"
Subject: Re: [Qemu-devel] [PATCH v2 17/41] char: get rid of CharDriver
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
--BEJtx38tQADX5KTdO3vqmHGwkPFgopfxL
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <03c6fb68-3051-dd02-cbea-19b3b2ed70b3@redhat.com>
Subject: Re: [PATCH v2 17/41] char: get rid of CharDriver
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
 <20170130133954.31353-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 07:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> qemu_chr_new_from_opts() is modified to not need CharDriver backend[]
> array, but uses instead objectified qmp_query_chardev_backends() and
> char_get_class(). The alias field is moved outside in a ChardevAlias[],=

> similar to QDevAlias for devices.
>=20
> "kind" and "parse" are moved to ChardevClass ("kind" is to be removed
> next)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h |  12 +-
>  backends/baum.c       |   6 +-
>  backends/msmouse.c    |   6 +-
>  backends/testdev.c    |   6 +-
>  qemu-char.c           | 315 +++++++++++++++++++++++-------------------=
--------
>  spice-qemu-char.c     |  15 +--
>  ui/console.c          |  10 +-
>  ui/gtk.c              |  10 +-
>  8 files changed, 159 insertions(+), 221 deletions(-)
>=20

> +static void
> +chardev_name_foreach(void (*fn)(const char *name, void *opaque), void =
*opaque)
> +{
> +    ChadevClassFE fe =3D { .fn =3D fn, .opaque =3D opaque };
> +    int i;
> +
> +    object_class_foreach(chardev_class_foreach, TYPE_CHARDEV, false, &=
fe);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
> +        fn(chardev_alias_table[i].alias, opaque);
> +    }

This now visits all aliases last,...

> @@ -4182,15 +4237,8 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
> =20
>      if (is_help_option(name)) {
>          GString *str =3D g_string_new("");
> -        for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> -            cd =3D backends[i];
> -            if (cd) {
> -                g_string_append_printf(str, "\n%s", ChardevBackendKind=
_lookup[cd->kind]);
> -                if (cd->alias) {
> -                    g_string_append_printf(str, "\n%s", cd->alias);
> -                }
> -            }
> -        }

=2E..while the old code visited them inline.  But that's cosmetic; I don'=
t
think it hurts.

> +
> +        chardev_name_foreach(help_string_append, str);

> =20
>  ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
>  {
>      ChardevBackendInfoList *backend_list =3D NULL;
> -    const CharDriver *c;
> -    int i;
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> -        c =3D backends[i];
> -        if (!c) {
> -            continue;
> -        }
> -
> -        backend_list =3D qmp_prepend_backend(backend_list,
> -                                           ChardevBackendKind_lookup[c=
->kind]);
> -        if (c->alias) {
> -            backend_list =3D qmp_prepend_backend(backend_list, c->alia=
s);
> -        }
> -    }
> +    chardev_name_foreach(qmp_prepend_backend, &backend_list);

And the refactoring into visitor/callback made for some nice reuse.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BEJtx38tQADX5KTdO3vqmHGwkPFgopfxL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj5kEAAoJEKeha0olJ0Nqxa4IAJVP6NNJIPw3XakqxH9zpheF
smWWcbCvNYknjtiuGiZ7rQiwv4oiIKDfFPO7HTd7HoC93P6beKafH83z8gu/vCCG
IMbL7GxhkwkT6aolhSfw7yn+Pjs7C9BrxsoSAXgvCY3gr9uNxXqxy7ODhUrkBi8l
vGukJLaOTiFR0oW4A+q2TBodjoqO9bD4D/E4uxWbFnygTT1ZHXjgDJscTl2x3xHn
uaH38I0EswU2J6NZh7NwCAAITVhFMVyHS+iHG+WOQtl4h6hJ0SrsGmP6Y0c+YG6i
wqO9vlsRciDScIKV28WlJfZ3+nczmMY24Rdx/8byYa5TyTk7sj+PH6PJmtZskV8=
=ye4B
-----END PGP SIGNATURE-----

--BEJtx38tQADX5KTdO3vqmHGwkPFgopfxL--
