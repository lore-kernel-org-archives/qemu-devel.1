Received: from eggs.gnu.org ([2001:4830:134:3::10]:45995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJYZ-0004wC-UT
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJYZ-0001l9-48
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:47:00 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-8-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b4d833b8-c6fd-567c-f500-354acf8c5cc7@redhat.com>
Date: Wed, 29 Mar 2017 21:46:51 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L3DqXi60WBFri9j9v244jCf9THemTcsuS"
Subject: Re: [Qemu-devel] [for-2.9 7/8] nbd: Tidy up blockdev-add interface
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
--L3DqXi60WBFri9j9v244jCf9THemTcsuS
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <b4d833b8-c6fd-567c-f500-354acf8c5cc7@redhat.com>
Subject: Re: [for-2.9 7/8] nbd: Tidy up blockdev-add interface
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 18:45, Markus Armbruster wrote:
> SocketAddress is a simple union, and simple unions are awkward: they
> have their variant members wrapped in a "data" object on the wire, and
> require additional indirections in C.  I intend to limit its use to
> existing external interfaces, and convert all internal interfaces to
> SocketAddressFlat.
>=20
> BlockdevOptionsNbd is an external interface using SocketAddress, but
> it's new in 2.9.  Replace it by SocketAddressFlat while we can.  This
> simplifies
>=20
>     { "execute": "blockdev-add",
>       "arguments": { "node-name": "foo", "driver": "nbd",
>                      "server": { "type": "inet",
> 		                 "data": { "host": "localhost",
> 				           "port": "12345" } } } }
>=20
> to
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
> Unfortunately, SocketAddress is also visible in -drive since 2.8.  Add
> still more gunk to nbd_process_legacy_socket_options().  You can now
> shorten
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.data.host=3D=
127.0.0.1,server.data.port=3D12345
>=20
> to
>=20
>     -drive if=3Dnone,driver=3Dnbd,server.type=3Dinet,server.host=3D127.=
0.0.1,server.port=3D12345
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/nbd.c          | 131 ++++++++++++++++++++++++++++++++++++++++---=
--------
>  qapi/block-core.json |   2 +-
>  2 files changed, 104 insertions(+), 29 deletions(-)

To be completely frank: If there is any drawback to using
SocketAddressFlat instead of SocketAdress, I would be against using it.
Less indirections in C is an argument, but less {} on the wire is not,
in my opinion. QMP is a machine interface and machines don't care about
that additional level.

Therefore, if you think this somehow affects compatibility, I would not
want to do this change.

I personally agree with Paolo that we can just break what we have, and
in addition I think that we *should* break what we have or we should not
do this change at all.

Max


--L3DqXi60WBFri9j9v244jCf9THemTcsuS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcDysSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlVUIALUrTlI91kAu6doddHD7dm80zsIDaSs4
qkbJouq6c1eCeQFCzWRcG3LW3jqkoLQfUFXzUKQBcwdZ7se+pD3VMeWMknackaCo
FCxMU5126/hNSrzHyGH/2dosbh1alBxPKVvq2wlg8ORj9pboCd07f8I8AbUMP6Cy
JB8ISyseJNZry90Zp9XC7qa2j9l0Ms7U5kMbiG8FW8WRjHlQJzVo75zNiKHwvLjx
hxxtsPWJjUkEsaxQysXT627IQkxLkvE0ZBsj7GhqVu3S9VF92+m7QfGPD/aeMzHb
gTdpVy6lY99U1sfBaVcvBbCJkxPL8/snvVSpwAXI6ZH7QpnkD8fkZBQ=
=QrIe
-----END PGP SIGNATURE-----

--L3DqXi60WBFri9j9v244jCf9THemTcsuS--
