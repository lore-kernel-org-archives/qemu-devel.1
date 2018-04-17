Received: from eggs.gnu.org ([2001:4830:134:3::10]:37175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8W8f-0004LS-GW
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8W8c-0000iG-RD
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:19:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8W8c-0000hi-Li
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:19:34 -0400
References: <AM3PR07MB273186AEFA49A506BFC2D28B3B30@AM3PR07MB273.eurprd07.prod.outlook.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c22286f-9fae-06fb-0bc3-e307385f39f8@redhat.com>
Date: Tue, 17 Apr 2018 14:19:25 -0500
MIME-Version: 1.0
In-Reply-To: <AM3PR07MB273186AEFA49A506BFC2D28B3B30@AM3PR07MB273.eurprd07.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RGYmgs5nqqZjQIT7MDrXcQ1kNazSZYzgp"
Subject: Re: [Qemu-devel] [PATCH] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)" <ricardo.perez_blanco@nokia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RGYmgs5nqqZjQIT7MDrXcQ1kNazSZYzgp
From: Eric Blake <eblake@redhat.com>
To: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
 <ricardo.perez_blanco@nokia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Message-ID: <2c22286f-9fae-06fb-0bc3-e307385f39f8@redhat.com>
Subject: Re: [PATCH] Show values and description when using "qom-list"
References: <AM3PR07MB273186AEFA49A506BFC2D28B3B30@AM3PR07MB273.eurprd07.prod.outlook.com>
In-Reply-To: <AM3PR07MB273186AEFA49A506BFC2D28B3B30@AM3PR07MB273.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2018 03:05 AM, Perez Blanco, Ricardo (Nokia - BE/Antwerp) wrote:=

> Dear all,
>=20
> Here you can find my first contribution to qemu. Please, do not hesitat=
e to do any kind of remark.

Welcome to the community.  Looking forward to your v2 patch submission
(see my reply to your followup, for more things to fix before you send v2=
).


> Subject: [PATCH] Show values and description when using "qom-list"
>=20
> For debugging purposes it is very useful to:
>  - See the description of the field. This information is already filled=

>    in but not shown in "qom-list" command.
>  - Display value of the field. So far, only well known types are
>    implemented (string, str, int, uint, bool).
>=20
> Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> ---
>  hmp.c          | 13 +++++++++++--
>  qapi/misc.json |  4 +++-
>  qmp.c          | 26 ++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 3 deletions(-)
>=20
> diff --git a/hmp.c b/hmp.c
> index a25c7bd..967e0b2 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2490,8 +2490,17 @@ void hmp_qom_list(Monitor *mon, const QDict *qdi=
ct)
>          while (list !=3D NULL) {
>              ObjectPropertyInfo *value =3D list->value;
>=20
> -            monitor_printf(mon, "%s (%s)\n",
> -                           value->name, value->type);
> +            monitor_printf(mon, "%s", value->name);
> +            if (value->value) {
> +                monitor_printf(mon, "=3D%s", value->value);
> +            }

Technically, you should be checking 'if (value->has_value)'.  It happens
that our current code sets value->value to NULL if value->has_value is
false, but that's less reliable.  Someday, we may improve our QAPI code
generator to quit generating has_FOO members when FOO is an optional
pointer and NULL is an obvious indication that FOO was not provided (at
which point, your code as written is correct), but we're not there yet.


> +++ b/qapi/misc.json
> @@ -1328,10 +1328,12 @@
>  #
>  # @description: if specified, the description of the property.
>  #
> +# @value: if specified, the value of the property.

Missing a mention that this field is '(since 2.13)'.

> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'ObjectPropertyInfo',
> -  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
> +  'data': { 'name': 'str', 'type': 'str', '*description':'str', '*valu=
e':'str' } }
>=20
>  ##
>  # @qom-list:
> diff --git a/qmp.c b/qmp.c
> index f722616..750b5d0 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -237,6 +237,32 @@ ObjectPropertyInfoList *qmp_qom_list(const char *p=
ath, Error **errp)
>=20
>          entry->value->name =3D g_strdup(prop->name);
>          entry->value->type =3D g_strdup(prop->type);
> +        if (prop->description) {
> +            entry->value->description =3D g_strdup(prop->description);=

> +        }
> +        if ((g_ascii_strncasecmp(entry->value->type, "string", 6) =3D=3D=
 0) ||
> +            (g_ascii_strncasecmp(entry->value->type, "str", 3) =3D=3D =
0)) {

This will accept a type named "strange"; is that intentional?

> +            Error **errp =3D NULL;
> +            entry->value->value =3D g_strdup_printf("\"%s\"",
> +                object_property_get_str(obj, entry->value->name, errp)=
);
> +        }
> +        if (g_ascii_strncasecmp(entry->value->type, "int", 3) =3D=3D 0=
) {

Likewise, this will accept a type named "internal".  I'm not sure if
your manual checking for types by names is the best approach; and the
fact that we are stringizing the result instead of using the natural
JSON type (a string for "str", a number for "int") is a bit worrisome.

> +            Error **errp =3D NULL;
> +            entry->value->value =3D g_strdup_printf("%ld",
> +                object_property_get_int(obj, entry->value->name, errp)=
);
> +        }
> +        if (g_ascii_strncasecmp(entry->value->type, "uint", 4) =3D=3D =
0) {
> +            Error **errp =3D NULL;
> +            entry->value->value =3D g_strdup_printf("%lu",
> +                object_property_get_uint(obj, entry->value->name, errp=
));
> +        }
> +        if (g_ascii_strncasecmp(entry->value->type, "bool", 4) =3D=3D =
0) {
> +            Error **errp =3D NULL;
> +            entry->value->value =3D g_strdup_printf("%s",
> +               (object_property_get_bool(obj, entry->value->name, errp=
) =3D=3D true)
> +                ? "true" : "false");
> +        }

Since the ->value field is optional, you have to set
entry->value->has_value =3D true anywhere that you are setting
entry->value->value to a string.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RGYmgs5nqqZjQIT7MDrXcQ1kNazSZYzgp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWSL0ACgkQp6FrSiUn
Q2o0egf/SlT2FUwFqsl3oxSjqjzcRD6Gp3WZbnZHEouBSQMbs+cRHPfNntlTGGD7
jqDPWC1NBp9gxeKuWKQ4eVo4+/+GzJ/CZcN4b1Xtrn1buQmG7WrUQyUwwvWoTOGq
qGt3gfOgqPCGyiYoZJAplMpaqJP37/As8cHrbUAXBHKp4gxhy9CxN/h45GHWhvbj
/PW4XixJtnbcL2kb5nDe+vYGUuPlfnmKwI1DehEVwYm8ATVATbdY0iM6cCRkaV8Y
71G0CfN1dpK7M3KcEYrVbaC4qp8ttgI4Ej1iRykOg8BATCuQx3sYWzyDPuJq0s+j
yUh68RWKxwwe/jhAZ6dZPf0KChAP3g==
=+O6J
-----END PGP SIGNATURE-----

--RGYmgs5nqqZjQIT7MDrXcQ1kNazSZYzgp--
