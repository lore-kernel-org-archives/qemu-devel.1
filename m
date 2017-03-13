Received: from eggs.gnu.org ([2001:4830:134:3::10]:34008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnX4f-0002Rr-1a
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnX4b-0000Xu-5J
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnX4a-0000XE-Tr
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:00:09 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89b4538d-216a-07da-1552-e1bd617a4f84@redhat.com>
Date: Mon, 13 Mar 2017 16:00:05 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IIUknw57lx9RlIQ1O1SWo0jdvhCv6m5gF"
Subject: Re: [Qemu-devel] [PATCH for-2.9 02/47] qapi: Make doc comments
 optional where we don't need them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IIUknw57lx9RlIQ1O1SWo0jdvhCv6m5gF
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <89b4538d-216a-07da-1552-e1bd617a4f84@redhat.com>
Subject: Re: [PATCH for-2.9 02/47] qapi: Make doc comments optional where we
 don't need them
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Since we added the documentation generator in commit 3313b61, doc
> comments are mandatory.  That's a very good idea for a schema that
> needs to be documented, but has proven to be annoying for testing.

As I've found out while rebasing my JSON output visitor as well as
patches to allow anonymous bases to flat unions.  Thanks, this will help =
me!

>=20
> Make doc comments optional again, but add a new directive
>=20
>     { 'pragma': { 'doc-required': true } }
>=20
> to let a QAPI schema require them.

I like it.  It's extensible to other pragmas, as well; and reading
ahead, it looks like you did a good job of flagging unknown pragmas.

>=20
> Require documentation in the schemas we actually want documented:
> qapi-schema.json and qga/qapi-schema.json.
>=20
> We could probably make qapi2texi.py cope with incomplete
> documentation, but for now, simply make it refuse to run unless the
> schema has 'doc-required': true.

I'd rather fail early on our non-documented stuff then risk broken
corner cases; so I think you made the right decision.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/qapi-code-gen.txt             | 40 +++++++++++++++++++++++++-----=
--------

> @@ -277,6 +280,11 @@ class QAPISchemaParser(object):
>                                         "Value of 'include' must be a s=
tring")
>                  self._include(include, info, os.path.dirname(abs_fname=
),
>                                previously_included)
> +            elif "pragma" in expr:
> +                if len(expr) !=3D 1:
> +                    raise QAPISemError(info, "Invalid 'pragma' directi=
ve")

You may also want to check that you have an actual dictionary; otherwise.=
=2E.

> +                for name, value in expr['pragma'].iteritems():

calling .iteritems() can lead to some funky python messages. For
example, tweaking qapi-schema.json to use

{ 'pragma': [ { 'doc-required': true } ] }

=3D>

$ make
  GEN     qmp-commands.h
Traceback (most recent call last):
  File "/home/eblake/qemu/scripts/qapi-commands.py", line 317, in <module=
>
    schema =3D QAPISchema(input_file)
  File "/home/eblake/qemu/scripts/qapi.py", line 1496, in __init__
    parser =3D QAPISchemaParser(open(fname, "r"))
  File "/home/eblake/qemu/scripts/qapi.py", line 286, in __init__
    for name, value in expr['pragma'].iteritems():
AttributeError: 'list' object has no attribute 'iteritems'
Makefile:431: recipe for target 'qmp-commands.h' failed

Not the end of the world, but we've done a nice job elsewhere of
avoiding cryptic python traces.

> +        global doc_required
> +        if name =3D=3D 'doc-required':
> +            if not isinstance(value, bool):
> +                raise QAPISemError(info,
> +                                   "Pragma 'doc-required' must be bool=
ean")
> +            doc_required =3D value

No testsuite coverage of this message?

If you decide to not bother, or to defer error message(s) cleanup to
followups (especially since we are running short on time for fixing the
actual doc regression from going into 2.9), then using this patch as-is
can have:

Reviewed-by: Eric Blake <eblake@redhat.com>

Of course, if you spin a v2 that actually addresses my concerns, it
probably will be more involved than something that can trivially keep my
R-b (in part because you'll probably also want a testsuite addition to
cover any new error message...).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IIUknw57lx9RlIQ1O1SWo0jdvhCv6m5gF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxwhVAAoJEKeha0olJ0NqdKoH/jTxI7DCwoTN3vlsH2TZeIxM
WFpMX6sXGC+zrXOQ5lCR4az8AbirODkxzQpzBqmsJhw6uKQHeAyxppczuR4VH0r/
oGcCI/Z610sQS/cwWuWpFAOtNeoSWbmUE/V1dIQM6VP8RZE8VwDFVhmrDcCEYrO4
2/tAneeH+sT+1dt+WUsb5OoFN3e4gSxyNk7oM/UFgELQRQDfDshx1b5uh3vxVczb
FYxI6LhO2MeH912wlpPlCF4d0aEgwr+ifUr3NAgsBeAnhv9L010eH9BPxqq3uuNG
VwnnZ8hBGSxYxaCQ6z4u91hEIYVrG7wQIPh7HY7psO5Tn19GWD1bD8pVKV0gV1g=
=WHkC
-----END PGP SIGNATURE-----

--IIUknw57lx9RlIQ1O1SWo0jdvhCv6m5gF--
