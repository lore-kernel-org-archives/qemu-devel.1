Received: from eggs.gnu.org ([2001:4830:134:3::10]:40562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctcyx-0001QA-OK
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctcyw-0003nH-Vt
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:31:31 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-9-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dfc2b733-ae8e-6786-7f41-cd6857486801@redhat.com>
Date: Thu, 30 Mar 2017 18:31:18 +0200
MIME-Version: 1.0
In-Reply-To: <1490879707-6060-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eedWgEkQLMi8ggUdps7fIuiiihTNLn6rP"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 08/10] nbd: Tidy up blockdev-add
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
--eedWgEkQLMi8ggUdps7fIuiiihTNLn6rP
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <dfc2b733-ae8e-6786-7f41-cd6857486801@redhat.com>
Subject: Re: [RFC v2 for-2.9 08/10] nbd: Tidy up blockdev-add interface
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 15:15, Markus Armbruster wrote:
> SocketAddress is a simple union, and simple unions are awkward: they
> have their variant members wrapped in a "data" object on the wire, and
> require additional indirections in C.  I intend to limit its use to
> existing external interfaces, and convert all internal interfaces to
> SocketAddressFlat.
>=20
> BlockdevOptionsNbd is an external interface using SocketAddress.  We
> already use SocketAddressFlat elsewhere in blockdev=3Dadd.  Replace it

s/=3D/-/

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
>  block/nbd.c          | 94 +++++++++++++++++++++++++++++++++++++-------=
--------
>  qapi/block-core.json |  2 +-
>  2 files changed, 69 insertions(+), 27 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

(Hoping the next patch gets squashed in)


--eedWgEkQLMi8ggUdps7fIuiiihTNLn6rP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdMtYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADPkH/RAw9HcP1kaZjBxrwTZS6x6JxQsT92aB
GyIIk/gladrSon/eLZdADyK7Ry1Fo3KyBP5mZZ0jWUplWpJz5jZe31w2zQD9tu7q
fbo7RS4C1nJAym3lTmDh09yqiSSKAJQg3SbLMNEhVvgzdfRRd7Gd/ZKeuSc9ILc2
rOAzbTKg+41iDma1wP73c6flWAxMuqCTp6rNWoTamx5ixrjy/IOUststARONvBXb
TqNzYboFdeF4eiPnuc5N5Ybs07MxLIriv/qUgxvjKO4W7fI3RY08DiTM/ETkWAa1
D1ISZApdR4MOFCUpYxuTzI8hnLOQxC/QRziVWppSKl5PS0+7RPgebN8=
=lY8c
-----END PGP SIGNATURE-----

--eedWgEkQLMi8ggUdps7fIuiiihTNLn6rP--
