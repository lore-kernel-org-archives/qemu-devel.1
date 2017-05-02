Received: from eggs.gnu.org ([2001:4830:134:3::10]:39943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5fTq-0005e5-Al
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5fTn-00043s-31
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5fTm-00043P-QT
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:37:07 -0400
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-3-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1153646d-848e-91ca-87f6-7d83b4963174@redhat.com>
Date: Tue, 2 May 2017 16:37:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170502203115.22233-3-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GaOWvc3CR7dF75mET3WgHEh5o4C3aqPJ9"
Subject: Re: [Qemu-devel] [PATCH 2/4] string-input-visitor: Support
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GaOWvc3CR7dF75mET3WgHEh5o4C3aqPJ9
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <1153646d-848e-91ca-87f6-7d83b4963174@redhat.com>
Subject: Re: [PATCH 2/4] string-input-visitor: Support alternate types
References: <20170502203115.22233-1-ehabkost@redhat.com>
 <20170502203115.22233-3-ehabkost@redhat.com>
In-Reply-To: <20170502203115.22233-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 03:31 PM, Eduardo Habkost wrote:
> When parsing alternates from a string, there are some limitations in
> what we can do, but it is a valid use case in some situations. We can
> support booleans, integer types, and enums.
>=20
> This will be used to support 'feature=3Dforce' in -cpu options, while
> keeping 'feature=3Don|off|true|false' represented as boolean values.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

> =20
> +/* Support for alternates on string-input-visitor is limited, because
> + * the input string doesn't have any type information.
> + *
> + * Supported alternate member types:
> + * 1) enums
> + * 2) integer types
> + * 3) booleans (but only if the there's no enum variant
> + *    containing "on", "off", "true", or "false" as members)
> + *
> + * UNSUPPORTED alternate member types:
> + * 1) strings
> + * 2) complex types
> + */
> +static void start_alternate(Visitor *v, const char *name,
> +                            GenericAlternate **obj, size_t size,
> +                            unsigned long supported_qtypes, Error **er=
rp)
> +{
> +    StringInputVisitor *siv =3D to_siv(v);
> +    QType t =3D QTYPE_QSTRING;

Why do you document string as unsupported, and yet default to
QTYPE_QSTRING?  I don't see how a string is fundamentally different from
an enum (no alternate can have both at the same time, an alternate with
either type will have QTYPE_QSTRING set in supported_qtypes).

> +
> +    if (supported_qtypes & BIT(QTYPE_QBOOL)) {
> +        if (try_parse_bool(siv->string, NULL) =3D=3D 0) {
> +            t =3D QTYPE_QBOOL;
> +        }
> +    }
> +
> +    if (supported_qtypes & BIT(QTYPE_QINT)) {
> +        if (parse_str(siv, name, NULL) =3D=3D 0) {
> +            t =3D QTYPE_QINT;
> +        }
> +    }
> +
> +    *obj =3D g_malloc0(size);
> +    (*obj)->type =3D t;

Should you raise an error if you couldn't match the input with
supported_qtypes, rather than just blindly returning QTYPE_QSTRING?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GaOWvc3CR7dF75mET3WgHEh5o4C3aqPJ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCPv/AAoJEKeha0olJ0NqkEoIAI8hd3bgbnaGggMuocOfzN6o
aG0AHIRRf4iJqHmQhxjlzsyl+Lp/xGCqRibKhXJgtRU3My/sxt9cGkGk9CgYDEbJ
Of59x7YC691X5QSRQ1XIts2kmsBHkXLfWUZhs3kstMeT8bScbfdxRCQlzTAZPllB
1pKv+LnmxwvPyDB4kSQOWGvZXdlNbZs9WdieX9Mnitq55mal5xF+y2lN+4XBk08w
GOBoeeyMVyrDZitkk8KxSQT2+b9UP/Z8YgTrJpQB9r++7JGGtSyAxwxL+W+TJ14L
RC9uyuITcPPARunkdbaWrJ0DgqBRpUVERN24fpYb12a9P8s4z29AsovlMUBkazo=
=ZpSZ
-----END PGP SIGNATURE-----

--GaOWvc3CR7dF75mET3WgHEh5o4C3aqPJ9--
