Received: from eggs.gnu.org ([2001:4830:134:3::10]:44621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5WIE-0007OL-8S
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5WIB-0002ts-4w
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:48:34 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:59266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d5WIA-0002t3-VJ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:48:31 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 74C78EB120
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 13:48:28 +0200 (CEST)
Date: Tue, 2 May 2017 13:48:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170502134815.3f0e94ff@bahia>
In-Reply-To: <20170427072843.8089-2-david@gibson.dropbear.id.au>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/6UCSVslVP/E0MFPwSPTE=fE";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 1/4] qapi: add explicit null
 to string input and output visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com, qemu-ppc@nongnu.org, abologna@redhat.com

--Sig_/6UCSVslVP/E0MFPwSPTE=fE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Apr 2017 17:28:40 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Greg Kurz <groug@kaod.org>
>=20
> This may be used for deprecated object properties that are kept for
> backwards compatibility.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  qapi/string-input-visitor.c  | 11 +++++++++++
>  qapi/string-output-visitor.c | 14 ++++++++++++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index c089491..63ae115 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -326,6 +326,16 @@ static void parse_type_number(Visitor *v, const char=
 *name, double *obj,
>      *obj =3D val;
>  }
> =20
> +static void parse_type_null(Visitor *v, const char *name, Error **errp)
> +{
> +    StringInputVisitor *siv =3D to_siv(v);
> +
> +    if (!siv->string || siv->string[0]) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "nul=
l",
> +                   "null");

I had boldly copied the error_setg() line from qobject_input_type_null(), b=
ut
I guess the 3rd argument ("null") isn't really appropriate to describe the
expected input in this case.

What about something like below ?

+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
+                   "empty string");

> +    }
> +}
> +
>  static void string_input_free(Visitor *v)
>  {
>      StringInputVisitor *siv =3D to_siv(v);
> @@ -349,6 +359,7 @@ Visitor *string_input_visitor_new(const char *str)
>      v->visitor.type_bool =3D parse_type_bool;
>      v->visitor.type_str =3D parse_type_str;
>      v->visitor.type_number =3D parse_type_number;
> +    v->visitor.type_null =3D parse_type_null;
>      v->visitor.start_list =3D start_list;
>      v->visitor.next_list =3D next_list;
>      v->visitor.check_list =3D check_list;
> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index 94ac821..5ec5352 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -266,6 +266,19 @@ static void print_type_number(Visitor *v, const char=
 *name, double *obj,
>      string_output_set(sov, g_strdup_printf("%f", *obj));
>  }
> =20
> +static void print_type_null(Visitor *v, const char *name, Error **errp)
> +{
> +    StringOutputVisitor *sov =3D to_sov(v);
> +    char *out;
> +
> +    if (sov->human) {
> +        out =3D g_strdup("<null>");
> +    } else {
> +        out =3D g_strdup("");
> +    }
> +    string_output_set(sov, out);
> +}
> +
>  static void
>  start_list(Visitor *v, const char *name, GenericList **list, size_t size,
>             Error **errp)
> @@ -351,6 +364,7 @@ Visitor *string_output_visitor_new(bool human, char *=
*result)
>      v->visitor.type_bool =3D print_type_bool;
>      v->visitor.type_str =3D print_type_str;
>      v->visitor.type_number =3D print_type_number;
> +    v->visitor.type_null =3D print_type_null;
>      v->visitor.start_list =3D start_list;
>      v->visitor.next_list =3D next_list;
>      v->visitor.end_list =3D end_list;


--Sig_/6UCSVslVP/E0MFPwSPTE=fE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkIcf8ACgkQAvw66wEB28JK2wCeJcqmbPPwwi2srNOTwLs6X9ZT
1JEAnA9INWQPQXQ6zAyOWo/Q9O3DSaC5
=z9lr
-----END PGP SIGNATURE-----

--Sig_/6UCSVslVP/E0MFPwSPTE=fE--
