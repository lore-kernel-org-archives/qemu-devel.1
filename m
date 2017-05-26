Received: from eggs.gnu.org ([2001:4830:134:3::10]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMDH-0002fr-Tf
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMDE-0007xz-Ma
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:52:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dEMDE-0007xM-Cb
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B26C8046A
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 20:51:55 +0000 (UTC)
References: <20170526202316.22736-1-ehabkost@redhat.com>
	<20170526202316.22736-3-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1bf0456a-f9d1-1e9a-dcd4-ca9b3569b567@redhat.com>
Date: Fri, 26 May 2017 15:51:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170526202316.22736-3-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sn7JqKmH2ivGkUlscqiPcWkph8C8hUon8"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qmp: Include 'abstract' field on
 'qom-list-types' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sn7JqKmH2ivGkUlscqiPcWkph8C8hUon8
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <1bf0456a-f9d1-1e9a-dcd4-ca9b3569b567@redhat.com>
Subject: Re: [PATCH v2 2/3] qmp: Include 'abstract' field on 'qom-list-types'
 output
References: <20170526202316.22736-1-ehabkost@redhat.com>
 <20170526202316.22736-3-ehabkost@redhat.com>
In-Reply-To: <20170526202316.22736-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:23 PM, Eduardo Habkost wrote:
> A client may be interested in getting the list of both abstract and
> non-abstract types.  Instead of requiring them to make multiple queries=

> with different filter arguments, just return an 'abstract' field in
> 'qom-list-types'.
>=20
> In addition to the new test code for validating this field, update the
> abstract-interfaces test case to query for all 'interface' subtypes
> (including abstract ones), and to look at the 'abstract' field directly=
=2E
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

> +++ b/qapi-schema.json
> @@ -3056,12 +3056,15 @@
>  #
>  # @name: the type name found in the search
>  #
> +# @abstract: the type is abstract and can't be directly instantiated.
> +#            Omitted if false. (since 2.10)
> +#

A little bit awkward in that libvirt will have to see if ANY entry in
the large returned result has "abstract":true before it can assume
"abstract":false on the remaining entries (that is, older qemu don't
output abstract ever, but still mentions abstract types, so blindly
writing code to assume absence of "abstract" means false breaks on those
older versions).  Or a query of introspection to see if the field name
is even supported would do.  Not insurmountable, though.

>  # Since: 1.1
>  #
>  # Notes: This command is experimental and may change syntax in future =
releases.

Is this note still helpful, or should we delete it now?

>  ##
>  { 'struct': 'ObjectTypeInfo',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', '*abstract': 'bool' } }

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sn7JqKmH2ivGkUlscqiPcWkph8C8hUon8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJVpAAoJEKeha0olJ0NqSKIH/2jhN3WN6KUjShRKdoVa6Us0
Uk+BLTG6y7cjaUNhsE2lk/jQtZ80yOcUB6rMIFyhzMPYn4UycZAZdwTJFU2Va0nS
oBrttTRJYnFA4oHnJGgaBlvjG9b28nq2a8TfWC44DGIR+myurtKeDT+fD27uTh6s
JsHgzWyNHFtfFAU3RohapHrx0A9Z1nOF9usQwzKUcdXECX0Z2PCS7KBFKK9EMrG8
wgIVu81rN9TugWPcREzkCVxOiW2IMxJoL18nFTXQuPKQvCcINhO5Iq3Y5JCs3hgi
qhfln9aEbL8OEceit10FafTMGPSqG+m9bncuYwp6ixZXsa+vFkaLx7GNPuwgCIM=
=qx/2
-----END PGP SIGNATURE-----

--sn7JqKmH2ivGkUlscqiPcWkph8C8hUon8--
