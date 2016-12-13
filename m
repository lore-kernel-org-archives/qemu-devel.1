Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cGwEw-0007ns-No
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 18:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cGwEs-00048V-Kd
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 18:12:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cGwEs-00048K-CX
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 18:12:02 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7899A7F7AF
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 23:12:01 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1051274c-0d34-fc33-4eb8-3777c586f527@redhat.com>
Date: Tue, 13 Dec 2016 17:11:59 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lo5vGXQb4WdNwCc8D15n8Vj8XnewnL9I0"
Subject: Re: [Qemu-devel] [PATCH 02/54] char: use a const CharDriver
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
--Lo5vGXQb4WdNwCc8D15n8Vj8XnewnL9I0
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <1051274c-0d34-fc33-4eb8-3777c586f527@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/54] char: use a const CharDriver
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-3-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> No need to allocate & copy fileds, let's use static const struct

s/fileds/fields/

> instead.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/baum.c       |   8 +++-
>  backends/msmouse.c    |   7 +++-
>  backends/testdev.c    |   7 +++-
>  qemu-char.c           | 100 ++++++++++++++++++++++++------------------=
--------
>  spice-qemu-char.c     |  14 +++++--
>  ui/console.c          |   9 +++--
>  include/sysemu/char.h |  19 +++++-----
>  7 files changed, 90 insertions(+), 74 deletions(-)
>=20

> +++ b/backends/baum.c
> @@ -686,8 +686,12 @@ fail_handle:
> =20
>  static void register_types(void)
>  {
> -    register_char_driver("braille", CHARDEV_BACKEND_KIND_BRAILLE, NULL=
,
> -                         chr_baum_init);
> +    static const CharDriver driver =3D {
> +        .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
> +        .parse =3D NULL, .create =3D chr_baum_init

Why did the "braille" string disappear?  Oh, I see... [1]

No need to specify .parse, since C99 initialization guarantees
zero-assignment to any field omitted.

I kind of prefer one struct member per line when doing C99
initialization, rather than bunching two in one line.

I also prefer a trailing comma, as then adding a new (non-zero) member
initialization in a later patch is a one-line addition, rather than
modifying an existing line to add a trailing comma.


> +++ b/backends/msmouse.c
> @@ -179,8 +179,11 @@ static CharDriverState *qemu_chr_open_msmouse(cons=
t char *id,
> =20
>  static void register_types(void)
>  {
> -    register_char_driver("msmouse", CHARDEV_BACKEND_KIND_MSMOUSE, NULL=
,
> -                         qemu_chr_open_msmouse);
> +    static const CharDriver driver =3D {
> +        .kind =3D CHARDEV_BACKEND_KIND_MSMOUSE,
> +        .parse =3D NULL, .create =3D qemu_chr_open_msmouse

Looks like my comments are repeated throughout the patch.


> -void register_char_driver(const char *name, ChardevBackendKind kind,
> -                          CharDriverParse *parse, CharDriverCreate *cr=
eate)
> +void register_char_driver(const CharDriver *driver)
>  {
> -    CharDriver *s;
> -
> -    s =3D g_malloc0(sizeof(*s));
> -    s->name =3D g_strdup(name);
> -    s->kind =3D kind;
> -    s->parse =3D parse;
> -    s->create =3D create;
> -
> -    backends =3D g_slist_append(backends, s);
> +    backends =3D g_slist_append(backends, (void *)driver);

Might be worth a comment that this is casting away const (as my first
reaction is "oh, you forgot that C allows automatic conversion of any
pointer to void*")

>  }
> =20
>  CharDriverState *qemu_chr_new_from_opts(QemuOpts *opts,
> @@ -4139,7 +4123,7 @@ CharDriverState *qemu_chr_new_from_opts(QemuOpts =
*opts,
>          fprintf(stderr, "Available chardev backend types:\n");
>          for (i =3D backends; i; i =3D i->next) {
>              cd =3D i->data;
> -            fprintf(stderr, "%s\n", cd->name);
> +            fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind=
]);

=2E..[1] Your series is already long, so don't feel like you have to do
this, but: if I were working on it, I might have done the elimination of
cd->name, the name parameter, and the use of ChardevBackendKind_lookup[]
in one patch (getting rid of JUST the "braille" parameter and friends at
the call sites), and then the const'ification of the remaining
parameters in the second patch.

> +++ b/include/sysemu/char.h

Laszlo's suggestion of the git order file would have promoted this part
of the patch first :)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Lo5vGXQb4WdNwCc8D15n8Vj8XnewnL9I0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYUIA/AAoJEKeha0olJ0NqH4IH/ApykFHTaJDr6giYbePNZuu4
tHsjG43cjsaNE+eGlgjzZNfgnm7Mdztd3VgVc6fmTa1GMYfi4LMlv7shlXYhYMzv
mbrdcp6jF2OTQ/HWzwXP4OkbFzdaS+eGLgZ5wxdM78HnVTvtZQBHhmF3OU436X/h
2WQT8olskb0jdk90vEqXdE7DwUwRPP9tKD9pYY47h+FWc8tHctLX5C5LIpdGFHCR
3AYsRBh48y1OKhEe/uuTys4SbA74HjgHHXIYixtLiNhDMO5YreYwBR9fK5bIEeoT
4zG/U/yF2hBiWIcQXlA0jeYJcBv1mZgnMagc/wTpbsb7yPnE7wgPCCJeMELWS1M=
=0PC5
-----END PGP SIGNATURE-----

--Lo5vGXQb4WdNwCc8D15n8Vj8XnewnL9I0--
