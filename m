Received: from eggs.gnu.org ([2001:4830:134:3::10]:35456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6kEU-0001SH-Or
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6kER-00020n-LU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:53:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6kER-0001zZ-CT
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:53:43 -0400
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-4-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a30986e0-6a07-509d-a2c0-969847bc4906@redhat.com>
Date: Fri, 5 May 2017 15:53:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170505201128.12099-4-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NlVQEXrsf0D0ae7fgp0GnB6VP2eMUNB1K"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] string-input-visitor: Support
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NlVQEXrsf0D0ae7fgp0GnB6VP2eMUNB1K
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <a30986e0-6a07-509d-a2c0-969847bc4906@redhat.com>
Subject: Re: [PATCH v2 3/3] string-input-visitor: Support alternate types
References: <20170505201128.12099-1-ehabkost@redhat.com>
 <20170505201128.12099-4-ehabkost@redhat.com>
In-Reply-To: <20170505201128.12099-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 03:11 PM, Eduardo Habkost wrote:
> When parsing alternates from a string, there are some limitations in
> what we can do, but it is a valid use case in some situations. We can
> support booleans, integer types, and enums.

Stale comment, given...

>=20
> This will be used to support 'feature=3Dforce' in -cpu options, while
> keeping 'feature=3Don|off|true|false' represented as boolean values.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Updated string_input_visitor_new() documentation
>   to mention alternate support (Markus Armbruster)
> * Detect ambiguous alternates at runtime. Test case included.
> * Removed support for integers. We don't need it yet, and

=2E..this.

>   it would require sorting out the parse_str() mess.
> * Change supported_qtypes to uint32_t (Eric Blake)
> * Update tests/qapi-schema/qapi-schema-test.out to match
>   qapi-schema-test.json updates
>   (Eric Blake)
> * Code indentation fix (Markus Armbruster)
> * Use &error_abort on test cases instead of g_assert(!err)
>   (Markus Armbruster)
> ---

> =20
> +/*
> + * Check if alternate type string representation is ambiguous and
> + * can't be parsed by StringInputVisitor
> + */
> +static bool ambiguous_alternate(uint32_t qtypes, const char *const enu=
m_table[])
> +{
> +    uint32_t non_str_qtypes =3D qtypes & ~(1U << QTYPE_QSTRING);
> +
> +    if ((qtypes & (1U << QTYPE_QSTRING)) && !enum_table && non_str_qty=
pes) {
> +        return true;
> +    }
> +
> +    if (qtypes & (1U << QTYPE_QBOOL)) {
> +        const char *const *e;
> +        /*
> +         * If the string representation of enum members can be parsed =
as
> +         * booleans, the alternate string representation is ambiguous.=

> +         */
> +        for (e =3D enum_table; e && *e; e++) {
> +            if (try_parse_bool(*e, NULL) =3D=3D 0) {
> +                return true;
> +            }
> +        }
> +    }
> +
> +    return false;
> +}

Seems okay for detecting ambiguity, but it is a runtime cost (one that
you will run every single time you parse, even though the answer will be
the same every single time you run it); I still think doing it at QAPI
compile time will be more efficient in the long run.  And as this is the
only use of enum_table added in 2/3, I'm still not sold on needing that
patch.

> +
> +static void start_alternate(Visitor *v, const char *name,
> +                            GenericAlternate **obj, size_t size,
> +                            uint32_t qtypes, const char *const enum_ta=
ble[],
> +                            Error **errp)
> +{
> +    /*
> +     * Enum types are represented as QTYPE_QSTRING, so this is
> +     * the default. Actual parsing of the string as an enum is
> +     * done by visit_type_<EnumType>(), which is called just
> +     * after visit_start_alternate().
> +     */
> +    QType qtype =3D QTYPE_QSTRING;
> +    uint32_t unsupported_qtypes =3D qtypes & ~((1U << QTYPE_QSTRING) |=

> +                                             (1U << QTYPE_QBOOL));
> +    StringInputVisitor *siv =3D to_siv(v);
> +
> +    if (ambiguous_alternate(qtypes, enum_table)) {
> +        error_setg(errp, "Can't parse ambiguous alternate type");
> +        return;
> +    }
> +
> +    if (unsupported_qtypes) {
> +        error_setg(errp, "Can't parse %s' alternate member",
> +                   QType_lookup[ctz32(unsupported_qtypes)]);
> +        return;
> +    }
> +
> +    if ((qtypes & (1U << QTYPE_QBOOL)) &&
> +        try_parse_bool(siv->string, NULL) =3D=3D 0) {
> +        qtype =3D QTYPE_QBOOL;
> +    }
> +
> +    *obj =3D g_malloc0(size);
> +    (*obj)->type =3D qtype;

Slightly simpler for ignoring int for now, while still something we
could add in later.  I've been wanting to have an alternate for
'int'/'str' for InetAddress port, since we want to support named ports
but most often use just integers.  On the command line, port=3D1 is fine,=

but in QMP, we currently have to spell it port=3D"1".  That's a case wher=
e
we'd allow a pairing of any string with an integer, rather than just an
enum.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NlVQEXrsf0D0ae7fgp0GnB6VP2eMUNB1K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDOZUAAoJEKeha0olJ0NqfpAH/1lmRBdCIqDLY/K7LFJk0aJO
SMYN1vkxcsWTl0iB30EXeie3bzg9WCQtweDt31clESwGXxbfTYBjeAX28dTeQcbV
J90bAc4UsxO4INZDWz0n7wWYyrRZSYntR6rCj1rnMWdlMmDi6qtK8MGo3VgXeJaq
HK4Wl6+BsUAibH+3r94K7porVWNyAOvFIW1Jj7BixOT/jP9vmYOkhlCfGhwC3k3p
D65UnO9LDPk04xn0QodB/ZDrvZ8sBxAL27qRgpvs1gxUN26IaXEaDlqYeULxzkkv
oeGxjeWPECubrgMkqUJRy5NbeQyqlbD1IiXCrLh/IkkzeM/ihPkOxlnRDFIoJnk=
=JwVP
-----END PGP SIGNATURE-----

--NlVQEXrsf0D0ae7fgp0GnB6VP2eMUNB1K--
