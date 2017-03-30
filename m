Received: from eggs.gnu.org ([2001:4830:134:3::10]:43485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cthja-0003wi-Oi
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cthjZ-0007bU-Us
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:35:58 -0400
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
	<1490895797-29094-9-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e6382858-ec9e-233e-74b4-4b3197a35039@redhat.com>
Date: Thu, 30 Mar 2017 23:35:48 +0200
MIME-Version: 1.0
In-Reply-To: <1490895797-29094-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7vaOxeCWl7EmEBtfqHPApEe2c6WDqxgIG"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9 8/9] nbd: Tidy up blockdev-add
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7vaOxeCWl7EmEBtfqHPApEe2c6WDqxgIG
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <e6382858-ec9e-233e-74b4-4b3197a35039@redhat.com>
Subject: Re: [PATCH v3 for-2.9 8/9] nbd: Tidy up blockdev-add interface
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
 <1490895797-29094-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490895797-29094-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 19:43, Markus Armbruster wrote:
> SocketAddress is a simple union, and simple unions are awkward: they
> have their variant members wrapped in a "data" object on the wire, and
> require additional indirections in C.  I intend to limit its use to
> existing external interfaces, and convert all internal interfaces to
> SocketAddressFlat.
>=20
> BlockdevOptionsNbd is an external interface using SocketAddress.  We
> already use SocketAddressFlat elsewhere in blockdev=3Dadd.  Replace it

Still s/=3D/-/, but nothing I can't fix. ;-)

Max

> by SocketAddressFlat while we can (it's new in 2.9) for simplicity and
> consistency.  For example,
>=20
>     { "execute": "blockdev-add",
>       "arguments": { "node-name": "foo", "driver": "nbd",
>                      "server": { "type": "inet",
> 		                 "data": { "host": "localhost",
> 				           "port": "12345" } } } }
>=20
> becomes
>=20
>     { "execute": "blockdev-add",
>       "arguments": { "node-name": "foo", "driver": "nbd",
>                      "server": { "type": "inet",
> 		                 "host": "localhost", "port": "12345" } } }
>=20
> Since the internal interfaces still take SocketAddress, this requires
> conversion function socket_address_crumple().  It'll go away when I
> update the interfaces.
>=20
> Unfortunately, SocketAddress is also visible in -drive since 2.8:
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.data.host=3D=
127.0.0.1,server.data.port=3D12345
>=20
> Nobody should be using it, as it's fairly new and has never been
> documented, so adding still more compatibility gunk to keep it working
> isn't worth the trouble.  You now have to use
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.host=3D127.=
0.0.1,server.port=3D12345
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/nbd.c          | 53 +++++++++++++++++++++++++++-----------------=
--------
>  qapi/block-core.json |  2 +-
>  2 files changed, 29 insertions(+), 26 deletions(-)



--7vaOxeCWl7EmEBtfqHPApEe2c6WDqxgIG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdejQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AsXwIAKmuBLZEgAIEFBN59QLoRSG522JqRXim
e6SVbPXhJjGmMaoxxPNp1mXe50PdAJy0sezmWqohR4OCX8xrga8U3+5eRaCY0ns1
Cgj45d4sATdb1Ald+sm5myVCPEtizi72fR2/MupoZCBYd+7nkgZnAlDAiRgoGoHM
vqC/C1q+l4QeFiaiFEu7G3xaT8921m8RM//JB9FuuO3zFVXzckC+U7v48CRL8y0v
zOWrMkZdCWmeycZ72qZOdCBpbSZPxWp/iDNumlXvsIMoMEUDSZRFAZTxMFkbtNDR
FmDnaFGnaMXYAgYsHaTcanFgcT65QlRG/tQIw3Ekck0Sxry+1qZeZig=
=dKC/
-----END PGP SIGNATURE-----

--7vaOxeCWl7EmEBtfqHPApEe2c6WDqxgIG--
