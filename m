Received: from eggs.gnu.org ([2001:4830:134:3::10]:39176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPa7b-00047L-3I
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPa7X-00057R-3l
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:24:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPa7W-00056v-R9
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:24:11 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E92CB11744
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 19:24:10 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-7-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7367a62e-09b4-3c48-1812-5c2586e0f4ac@redhat.com>
Date: Fri, 6 Jan 2017 13:24:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-7-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5WRTRTqgbecmhxJdeK4RHo8doUvIXh9ul"
Subject: Re: [Qemu-devel] [PATCH 06/20] char: use a static array for backends
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
--5WRTRTqgbecmhxJdeK4RHo8doUvIXh9ul
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <7367a62e-09b4-3c48-1812-5c2586e0f4ac@redhat.com>
Subject: Re: [PATCH 06/20] char: use a static array for backends
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> Number and kinds of backends is known at compile-time, use a fixed-size=
d
> static array to simplify iterations & lookups. Add an alias field to th=
e
> CharDriver structure to cover the cases where we previously registered =
a
> driver twice under two names.

Except that 5/20 didn't register twice under two names, so my option 2
on that patch was floating that portion of this patch earlier.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h |  1 +
>  qemu-char.c           | 98 ++++++++++++++++++++++++++++++-------------=
--------
>  2 files changed, 59 insertions(+), 40 deletions(-)
>=20
> @@ -4134,17 +4139,20 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpt=
s *opts,
>          goto err;
>      }
> =20
> -    for (i =3D backends; i; i =3D i->next) {
> -        cd =3D i->data;
> +    cd =3D NULL;

Dead assignment, since backends is a non-empty array so it will always
be overwritten by the first iteration of the following loop.

> +    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> +        cd =3D backends[i];
> =20
> -        if (strcmp(ChardevBackendKind_lookup[cd->kind],
> -                   qemu_opt_get(opts, "backend")) =3D=3D 0) {
> +        if (!cd) {
> +            continue;
> +        }
> +        if (g_str_equal(ChardevBackendKind_lookup[cd->kind], name) ||
> +            (g_strcmp0(cd->alias, name) =3D=3D 0)) {
>              break;
>          }
>      }
> -    if (i =3D=3D NULL) {
> -        error_setg(errp, "chardev: backend \"%s\" not found",
> -                   qemu_opt_get(opts, "backend"));
> +    if (cd =3D=3D NULL || i >=3D ARRAY_SIZE(backends)) {

Simplify: 'if (i =3D=3D ARRAY_SIZE(backends))' (whether cd is NULL at the=

end of the loop is irrelevant, you know it is non-NULL if you broke
early on a match, but it is ALSO non-null if the last element of the
array was non-NULL; and right now, our last element of the array is the
'memory' alias which is unconditionally present and thus non-NULL; also,
i cannot grow greater than ARRAY_SIZE(), so =3D=3D suffices rather than >=
=3D).

>  ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
>  {
>      ChardevBackendInfoList *backend_list =3D NULL;
> -    CharDriver *c =3D NULL;
> -    GSList *i =3D NULL;
> +    const CharDriver *c;
> +    int i;
> =20
> -    for (i =3D backends; i; i =3D i->next) {
> -        ChardevBackendInfoList *info =3D g_malloc0(sizeof(*info));
> -        c =3D i->data;
> -        info->value =3D g_malloc0(sizeof(*info->value));
> -        info->value->name =3D g_strdup(ChardevBackendKind_lookup[c->ki=
nd]);
> +    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> +        c =3D backends[i];
> +        if (!c) {
> +            continue;
> +        }
> =20
> -        info->next =3D backend_list;
> -        backend_list =3D info;
> +        backend_list =3D qmp_prepend_backend(backend_list, c,
> +                                           ChardevBackendKind_lookup[c=
->kind]);
> +        if (c->alias) {
> +            backend_list =3D qmp_prepend_backend(backend_list, c, c->a=
lias);
> +        }

Hmm, I didn't account for this in the changes I suggested for option 2
of 5/20 (which means unless you further tweak it, I temporarily
regressed the command to omit the aliases - but then again, taking your
5/20 as-is without either of my options omits the aliases and lists the
canonical name twice).

> @@ -4827,22 +4849,16 @@ ChardevReturn *qmp_chardev_add(const char *id, =
ChardevBackend *backend,
>          goto out_error;
>      }
> =20
> -    for (i =3D backends; i; i =3D i->next) {
> -        cd =3D i->data;
> -
> -        if (cd->kind =3D=3D backend->type) {
> -            chr =3D cd->create(id, backend, ret, &be_opened, &local_er=
r);
> -            if (local_err) {
> -                error_propagate(errp, local_err);
> -                goto out_error;
> -            }
> -            break;
> -        }
> +    cd =3D (int)backend->type >=3D 0 && backend->type < ARRAY_SIZE(bac=
kends) ?
> +        backends[backend->type] : NULL;
> +    if (cd =3D=3D NULL) {
> +        error_setg(errp, "chardev backend not available");

Worth including %s and the user-provided name that failed lookup?

> @@ -4927,6 +4943,7 @@ static void register_types(void)
>  #if defined HAVE_CHARDEV_SERIAL
>          {
>              .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> +            .alias =3D "tty",
>              .parse =3D qemu_chr_parse_serial,
>              .create =3D qmp_chardev_open_serial,
>          },

Unless you get rid of the duplicates (both my option 1 and option 2 of
5/20 did so), then you are registering 'serial/tty' once, and
'serial/NULL' a second time, where the second registration overwrites
the first, and so the alias doesn't work.

> @@ -4939,6 +4956,7 @@ static void register_types(void)
>  #ifdef HAVE_CHARDEV_PARPORT
>          {
>              .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
> +            .alias =3D "parport",
>              .parse =3D qemu_chr_parse_parallel,
>              .create =3D qmp_chardev_open_parallel,
>          },

And again.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5WRTRTqgbecmhxJdeK4RHo8doUvIXh9ul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb+7YAAoJEKeha0olJ0Nqv/kH/2TAhs8krrQJXa2pToVwUwOr
83W6oXOXW7v5mpnmFZF7HCA4bkVkdhe4eZQO6jVU7846wz92OWJb3FCKinu/HtiN
qr39PhH6W+XbADltTjXx/Kn9WyF/1BD5r8VTnXDG2nBBJFMF/jDCvS08s868j+0K
RxA2XbK6h2uHulaLo13o4cgQD2bkysTjaB/3PHOfinTnQxVTBi4KS3yzWAfSo9SN
gmxT9tElxqM1A+JGCDo5ACXVpXuw3YdCi0GvBW8QqGVWLDWilaIdAngqSFOcH2/6
J3KrIrGMmZxoyxhehuQEY5fA8gTKIQPC07AcQxuf94MjUH2897cil5qMfBkqN8E=
=FkQO
-----END PGP SIGNATURE-----

--5WRTRTqgbecmhxJdeK4RHo8doUvIXh9ul--
