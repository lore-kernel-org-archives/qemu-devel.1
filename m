Received: from eggs.gnu.org ([208.118.235.92]:60052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gekqE-0003XN-An
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 13:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gekqA-0005wK-RK
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 13:02:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gekqA-0005vQ-Gj
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 13:02:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36658C7C1C
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 18:02:00 +0000 (UTC)
Date: Wed, 2 Jan 2019 19:01:58 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190102180158.GA6015@natto.ory.fergeau.eu>
References: <20190102140535.11512-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20190102140535.11512-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adding Markus to cc: list, I forgot to do it when sending the patch.

Christophe

On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
> commit 8bca4613 added support for %% in json strings when interpolating,
> but in doing so, this broke handling of % when not interpolating as the
> '%' is skipped in both cases.
> This commit ensures we only try to handle %% when interpolating.
>=20
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> ---
>  qobject/json-parser.c | 10 ++++++----
>  tests/check-qjson.c   |  5 +++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 7a7ae9e8d1..d8eb210c0c 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -208,11 +208,13 @@ static QString *parse_string(JSONParserContext *ctx=
t, JSONToken *token)
>              }
>              break;
>          case '%':
> -            if (ctxt->ap && ptr[1] !=3D '%') {
> -                parse_error(ctxt, token, "can't interpolate into string"=
);
> -                goto out;
> +            if (ctxt->ap) {
> +                if (ptr[1] !=3D '%') {
> +                    parse_error(ctxt, token, "can't interpolate into str=
ing");
> +                    goto out;
> +                }
> +                ptr++;
>              }
> -            ptr++;
>              /* fall through */
>          default:
>              cp =3D mod_utf8_codepoint(ptr, 6, &end);
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index d876a7a96e..fa2afccb0a 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -175,6 +175,11 @@ static void utf8_string(void)
>              "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
>              "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
>              "\\u03BA\\u1F79\\u03C3\\u03BC\\u03B5",
> +        },
> +            /* '%' character when not interpolating */
> +        {
> +            "100%",
> +            "100%",
>          },
>          /* 2  Boundary condition test cases */
>          /* 2.1  First possible sequence of a certain length */
> --=20
> 2.20.1
>=20
>=20

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlws/JYACgkQqdjCFCms
bILCJBAAgJ0m4pXRG3fvhNNBv5OQmouXOD/fJCAZ7AxVQp6JlK4ZXXunIw4A9Q3U
31Rnpo3iFpT8DmZESeF7a+VAg3s4WmXDAdHlbNcCjylJ6Uix7XRYvp3YhGLDFJX1
CgUyazbpTZFVgWARpJ4XLgji48fUF3DmuA1izHWxJcCKjbP+2rM8hLxy0XSqVeNc
d3gNY4i4GkAb6qRL34G5qOTrKbh+tEylYznKASCrSBQKt3O57MPMgQPFLF0zLpPJ
A5hBGp1JHJzBTssYD2myC5LvcgbwqOk4e7/0VcaPu//weOzvmggT3aJLBRjKC4YA
WRwUyjikL6GBo0hWlpnzZk6RwUrdez1ABojzVPkTwP+H7mp/WrPyMMleh4nA2Ut+
8DiOk5hul+DLQ5qPU0rcQeYYB0QLx6j+5CnHQ0TtUuYMprsqMCWi1h7LCLtoGVqG
+ry2IDxKLdbhjDfw9zNm0wVJkx60CYTQhngh6Alfok5AACTcu8SNTB17c2995Fyg
9B6X8sOAUby0PWsHKBUWCSHFKWWNc/2cudlr2Kq1hgNNFZr8hBMkkhe+li+PDksJ
7/VuWZmKBlVV9si7eZ2qiI7Hs1pe5pJwZzJvnQYxA3h8FggFjI0IfMnG4tLDkaK5
CxKsBHDYXpwD58iziBxoixiAJzC4FL+xI1kVCt8Jk83TosHlxHg=
=hfDt
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
