Received: from eggs.gnu.org ([2001:4830:134:3::10]:58224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnx6D-00008N-R2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnx69-0006bw-8c
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnx69-0006b3-0U
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:47:29 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-43-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72221cb5-f918-b791-0c88-f51dc123a682@redhat.com>
Date: Tue, 14 Mar 2017 19:47:26 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-43-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j4E00tusgfk2hXBllEIOgKbMI1ObNcupp"
Subject: Re: [Qemu-devel] [PATCH for-2.9 42/47] qapi: enum_types is a list
 used like a dict, make it one
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
--j4E00tusgfk2hXBllEIOgKbMI1ObNcupp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <72221cb5-f918-b791-0c88-f51dc123a682@redhat.com>
Subject: Re: [PATCH for-2.9 42/47] qapi: enum_types is a list used like a
 dict, make it one
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-43-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-43-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

No idea if python actually behaves more efficiently, but this is a nice
algorithmic change:

> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index f06e3c4..5a3a606 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -46,7 +46,7 @@ returns_whitelist =3D []
>  # Whitelist of entities allowed to violate case conventions
>  name_case_whitelist =3D []
> =20
> -enum_types =3D []
> +enum_types =3D {}
>  struct_types =3D []
>  union_types =3D []
>  all_names =3D {}
> @@ -562,7 +562,7 @@ def find_alternate_member_qtype(qapi_type):
>          return builtin_types[qapi_type]
>      elif find_struct(qapi_type):
>          return 'QTYPE_QDICT'
> -    elif find_enum(qapi_type):
> +    elif qapi_type in enum_types:

A good dictionary uses a tree structure for O(log n), or even hash
lookup for amortized O(1) behavior here,

> -def find_enum(name):
> -    global enum_types
> -    for enum in enum_types:
> -        if enum['enum'] =3D=3D name:
> -            return enum
> -    return None
> -

while our lookup was O(n) on paper.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--j4E00tusgfk2hXBllEIOgKbMI1ObNcupp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyI8eAAoJEKeha0olJ0NqUEoH/idL2crTq/B2NOPDiBH9xtGo
uVHQ3YoT+vOwxRcwByferbtsRI1sfjWVWYFScpcHn4s0DpasQaLXE0f53M/UeMfu
q/CWZcZvZnnU9XBFx4mSd7c/WhNcHwPmKtYNyhT3MiQpM9hs4itjVEeqpZUUEMzf
La42bjQZvFTo/v5xrOmAT846CCot8drI7zBUzaCg/fRZTFtjVPIcRRTiPiBZFYuX
0TqLWqOCPlOa40BCHuLdKd8gRz/ktuWbxd67h5LQNXEgwWa87NJv+ar35SG0wJqp
ZIo6NDqKY2xLse8s4FdGInNxX1YlxBVbhbzMfbmpf1kXcX7Ebpx6ViLyaUqZojs=
=LIOK
-----END PGP SIGNATURE-----

--j4E00tusgfk2hXBllEIOgKbMI1ObNcupp--
