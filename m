Received: from eggs.gnu.org ([2001:4830:134:3::10]:46050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cykpG-0002FK-Ow
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cykpF-00008d-UE
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:54:42 -0400
References: <20170412164445.23039-1-berrange@redhat.com>
	<20170412164445.23039-5-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d4c4b19e-8e27-b1f1-4bbc-684655827b31@redhat.com>
Date: Thu, 13 Apr 2017 21:54:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170412164445.23039-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jVqm4iSCAiK7cJjr4qx3LMWgVrfFFfeX3"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jVqm4iSCAiK7cJjr4qx3LMWgVrfFFfeX3
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <d4c4b19e-8e27-b1f1-4bbc-684655827b31@redhat.com>
Subject: Re: [PATCH v4 4/4] qemu-img: copy *key-secret opts when opening newly
 created files
References: <20170412164445.23039-1-berrange@redhat.com>
 <20170412164445.23039-5-berrange@redhat.com>
In-Reply-To: <20170412164445.23039-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.04.2017 18:44, Daniel P. Berrange wrote:
> The qemu-img dd/convert commands will create a image file and
> then try to open it. Historically it has been possible to open
> new files without passing any options. With encrypted files
> though, the *key-secret options are mandatory, so we need to
> provide those options when opening the newly created file.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)

Thanks!

> diff --git a/qemu-img.c b/qemu-img.c
> index 31c4923..3d9e7b3 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -332,6 +334,33 @@ static BlockBackend *img_open_file(const char *fil=
ename,
>  }
> =20
> =20
> +static int img_add_key_secrets(void *opaque,
> +                               const char *name, const char *value,
> +                               Error **errp)
> +{
> +    QDict *options =3D opaque;
> +
> +    if (g_str_has_suffix(name, "key-secret")) {
> +        qdict_put(options, name, qstring_from_str(value));
> +    }
> +
> +    return 0;
> +}
> +
> +static BlockBackend *img_open_new_file(const char *filename,
> +                                       QemuOpts *create_opts,
> +                                       const char *fmt, int flags,
> +                                       bool writethrough, bool quiet)
> +{
> +    QDict *options =3D NULL;
> +
> +    options =3D qdict_new();
> +    qemu_opt_foreach(create_opts, img_add_key_secrets, options, NULL);=


I'd prefer &error_abort instead of NULL there. Not a hard requirement,
but I don't see a reason not to use it.

Max

> +
> +    return img_open_file(filename, options, fmt, flags, writethrough, =
quiet);
> +}
> +
> +
>  static BlockBackend *img_open(bool image_opts,
>                                const char *filename,
>                                const char *fmt, int flags, bool writeth=
rough,
> @@ -351,7 +380,7 @@ static BlockBackend *img_open(bool image_opts,
[...]


--jVqm4iSCAiK7cJjr4qx3LMWgVrfFFfeX3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljv13USHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AH3cIAI9aydhcFve6d7AZfODR5zHTKgs1rlGO
5wFduKO+H21QUFOP4xRehhqhRP09UzsNE6oHar8YtML25s7S+H9u3e9fWmcvxHmZ
cbFXAkC+hLoqWB0xUmczrI8lK1QiMMaz4O1T8dOR9edoiSGBTfa28xKM5uWL/yvA
kavJQgTwakO7XbcA4TgbEKbhxWanV7FoAmrplyBn67gMteTjAO0/AAqTrK2K4gLw
pbAQy6Fvl3aKb0GW3M0CpUzHQDpQm3jyP6JtE04dkUEGGwhBko94IpJbGxialV6D
ZQ2RvWWiyszEvqcJWun0ZfVP5YIIWsEA07wJ91hLco8TzrpcvdWWeOw=
=rso1
-----END PGP SIGNATURE-----

--jVqm4iSCAiK7cJjr4qx3LMWgVrfFFfeX3--
