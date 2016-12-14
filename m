Received: from eggs.gnu.org ([2001:4830:134:3::10]:52129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHAvI-0005kp-QM
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHAvF-0005pd-Lf
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:52:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cHAvF-0005pJ-Cy
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:52:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25E428C55E
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 14:52:44 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b172e4df-b0f5-299e-85f2-c24bbd8deab7@redhat.com>
Date: Wed, 14 Dec 2016 08:52:41 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dJOLQpLvfWM60ikt3xVnf2VcD8CdNdES4"
Subject: Re: [Qemu-devel] [PATCH 03/54] char: use a static array for backends
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
--dJOLQpLvfWM60ikt3xVnf2VcD8CdNdES4
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <b172e4df-b0f5-299e-85f2-c24bbd8deab7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/54] char: use a static array for backends
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-4-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Number and kinds of backends is known at compile-time, use a fixed-size=
d
> static array to simplify iterations & lookups.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c           | 101 ++++++++++++++++++++++++++++--------------=
--------
>  include/sysemu/char.h |   1 +
>  2 files changed, 58 insertions(+), 44 deletions(-)
>=20

> @@ -4121,9 +4121,14 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts=
 *opts,
> =20
>      if (is_help_option(qemu_opt_get(opts, "backend"))) {
>          fprintf(stderr, "Available chardev backend types:\n");
> -        for (i =3D backends; i; i =3D i->next) {
> -            cd =3D i->data;
> -            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind=
]);
> +        for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> +            cd =3D backends[i];
> +            if (cd) {
> +                fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->=
kind]);
> +                if (cd->alias) {
> +                    fprintf(stderr, "%s\n", cd->alias);
> +                }
> +            }

Where did cd->alias come from?
/me reads rest of patch
Oh, you added it in the .h file. All the more reason to use patch
ordering to list .h changes first, but may also be worth a mention in
the commit message that you add an alias field to cover the cases where
we previously registered a driver twice under two names.

>=20
> -        cd =3D i->data;
> +    cd =3D NULL;
> +    for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
> +        const char *name =3D qemu_opt_get(opts, "backend");
> +        cd =3D backends[i];

Please hoist the computation of 'name' outside of the loop...

> -        if (strcmp(ChardevBackendKind_lookup[cd->kind],
> -                   qemu_opt_get(opts, "backend")) =3D=3D 0) {
> +        if (!cd) {
> +            continue;
> +        }
> +        if (g_str_equal(ChardevBackendKind_lookup[cd->kind], name) ||
> +            (cd->alias && g_str_equal(cd->alias, name))) {

Doesn't g_str_equal(NULL, "str") do the right thing without crashing?
Therefore, no need to check if cd->alias is non-NULL.

>              break;
>          }
>      }
> -    if (i =3D=3D NULL) {
> +    if (cd =3D=3D NULL) {
>          error_setg(errp, "chardev: backend \"%s\" not found",
>                     qemu_opt_get(opts, "backend"));

=2E..and then reuse 'name' here as well, rather than making multiple
repeated calls to qemu_opt_get().

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

The help text now lists aliases immediately after the canonical name,
while the QMP command now prepends aliases prior to the canonical name.
It doesn't affect correctness, but should you try to make the two lists
appear in the same order?  (Presumably by prepending the alias first,
not second.)


> @@ -4907,16 +4925,11 @@ static void register_types(void)
>          { .kind =3D CHARDEV_BACKEND_KIND_STDIO,
>            .parse =3D qemu_chr_parse_stdio, .create =3D qemu_chr_open_s=
tdio },
>  #if defined HAVE_CHARDEV_SERIAL
> -        { .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> -          .parse =3D qemu_chr_parse_serial, .create =3D qmp_chardev_op=
en_serial },
> -        { .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> +        { .kind =3D CHARDEV_BACKEND_KIND_SERIAL, .alias =3D "tty",
>            .parse =3D qemu_chr_parse_serial, .create =3D qmp_chardev_op=
en_serial },

Wait. How did patch 2/54 work? Or did you temporarily break the 'tty'
alias in that patch, and then fix it here?  All the more reason that my
review of 2/54 complaining about getting rid of the cd->name field
should be a separate patch; now I'm convinced of it.  But in that patch,
I suggested the order:

remove cd->name field as redundant with enum array lookup
convert to struct without cd->name

Whereas with this patch in the mix, the steps should probably be:

convert to struct that still has cd->name
add cd->alias to have multiple names
remove cd->name field as redundant with enum array lookup

>  #endif
>  #ifdef HAVE_CHARDEV_PARPORT
> -        { .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
> -          .parse =3D qemu_chr_parse_parallel,
> -          .create =3D qmp_chardev_open_parallel },
> -        { .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
> +        { .kind =3D CHARDEV_BACKEND_KIND_PARALLEL, .alias =3D "parport=
",
>            .parse =3D qemu_chr_parse_parallel,
>            .create =3D qmp_chardev_open_parallel },

Again, another breakage in 2/54.

>  #endif
> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 144514c962..c8750ede21 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -474,6 +474,7 @@ void qemu_chr_set_feature(CharDriverState *chr,
>  QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e);
> =20
>  typedef struct CharDriver {
> +    const char *alias;
>      ChardevBackendKind kind;
>      void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **err=
p);
>      CharDriverState *(*create)(const char *id,
>=20

Overall, I like the direction this is headed in.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dJOLQpLvfWM60ikt3xVnf2VcD8CdNdES4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYUVy5AAoJEKeha0olJ0NqbHQH/iBQww1FduKw1aclCsVk8ddP
pSq5/VBHBiTjRwdy6l3P4x2/RKqGBaU/MbC1W3PL8oIZ5Gv/BlBVxfk/BNRhQjNq
sy9j4wh8Jz1n6oHsiYB2OFiOg0ABiXonYIi0tDZoewxr7HaQMm5DU0Stff27xDdU
BmkbKvATec4J/FnPUTswD5/q9kiKfwdUXjiyggdIrMhA3s5PnMfmz1wg2x10qOfY
w2HST2f29vf8ww4/i5t++e0CswVvm4PkDyB6n/K08QpoYDQoQjqjs2XMSuCJbWF7
dLpAp8qV1kgDhLj2T6H8kxvuLoAuCCGflwLzXCpF1je8DX5mO8JjGsQyE0YwsSc=
=iH8Q
-----END PGP SIGNATURE-----

--dJOLQpLvfWM60ikt3xVnf2VcD8CdNdES4--
