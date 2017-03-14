Received: from eggs.gnu.org ([2001:4830:134:3::10]:57111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cns85-0005m7-MM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cns82-0001d3-Hv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cns82-0001cO-8i
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:29:06 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-27-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c75316de-3aa7-c6d5-a626-fd407a31789c@redhat.com>
Date: Tue, 14 Mar 2017 14:29:01 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-27-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7oTWORJvu9itWOkct0eAtBIECavmodwcL"
Subject: Re: [Qemu-devel] [PATCH for-2.9 26/47] qapi2texi: Generate
 reference to base type members
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
--7oTWORJvu9itWOkct0eAtBIECavmodwcL
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <c75316de-3aa7-c6d5-a626-fd407a31789c@redhat.com>
Subject: Re: [PATCH for-2.9 26/47] qapi2texi: Generate reference to base type
 members
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-27-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-27-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> The generated documentation doesn't mention object type members
> inherited from a base type.  Fix that.
>=20
> Example change (qemu-qmp-ref.txt):
>=20
>   -- Struct: VncServerInfo
>=20
>       The network connection information for server
>=20
>       Members:
>       'auth' (optional)
> 	   authentication method used for the plain (non-websocket) VNC
> 	   server
> +     The members of 'VncBasicInfo'
>=20

Again, will be more useful later in the series when you add hyperlinking.=


>       Since: 2.1
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 993b652..7083d0c 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -143,7 +143,7 @@ def texi_member(member):
>          ' (optional)' if member.optional else '')
> =20
> =20
> -def texi_members(doc, what, member_func):
> +def texi_members(doc, what, base, member_func):
>      """Format the table of members"""
>      items =3D ''
>      for section in doc.args.itervalues():
> @@ -152,6 +152,8 @@ def texi_members(doc, what, member_func):
>          else:
>              desc =3D 'Not documented'
>          items +=3D member_func(section.member) + texi_format(desc) + '=
\n'
> +    if base:
> +        items +=3D '@item The members of @code{%s}\n' % base.doc_type(=
)

Will this still work for implicit bases?

> =20
> @@ -205,11 +207,13 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisi=
tor):
>              typ =3D 'Flat Union'
>          else:
>              typ =3D 'Simple Union'
> +        if base and base.is_implicit():
> +            base =3D None

Hmm - you just ignore those, such as the anonymous base in CpuInfo.  On
the other hand, CpuInfo documents its base fields explicitly.  Are we at
risk of double-documenting a base member, both explicitly and via its
named base type?

At any rate, this patch is an incremental improvement, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7oTWORJvu9itWOkct0eAtBIECavmodwcL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyER9AAoJEKeha0olJ0Nq5NoIAJLzofBDjDjG/letK3Ni++RB
MFpREkDZxKme4oT6ciWKyebfgG5PEh5ZVwzyn3h3q/ox+14sFKAORVg9WH95GGAe
n0qxY+gWbd45a9+eZf4HDsfwjRKFsgjWBAyu9tglzR6D9iac2JfkKYs/1f9IuOGL
Sv3NT571CDD3O0ibb4FBOsZ90k0oicjpa0TlLEJb4V88KcqwljT+rweJt88iLmg2
mFCJDFzMtOUmHjjI4hUFr2SiSncO6nB/+n7AuWXPOlJazznDhEKqbsMsZof4erk3
dFeeVaL0wNHCNRasUdUayVF48vPBc6dk29UiCAEmYd6jvi6bmYh/Y6JkEjNNXn4=
=JchW
-----END PGP SIGNATURE-----

--7oTWORJvu9itWOkct0eAtBIECavmodwcL--
