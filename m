Received: from eggs.gnu.org ([2001:4830:134:3::10]:38052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQIh-0001AS-Sw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQIg-0005DX-ND
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:27:51 -0400
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-3-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e8c46fbd-318f-20a1-b04f-4b323331409f@redhat.com>
Date: Mon, 12 Mar 2018 17:27:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180306204819.11266-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qry4SfYNPpAp7kXc1yitvwQELSO8fLmBa"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: add 208 nbd-server +
 blockdev-snapshot-sync test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qry4SfYNPpAp7kXc1yitvwQELSO8fLmBa
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <e8c46fbd-318f-20a1-b04f-4b323331409f@redhat.com>
Subject: Re: [PATCH 2/2] iotests: add 208 nbd-server + blockdev-snapshot-sync
 test case
References: <20180306204819.11266-1-stefanha@redhat.com>
 <20180306204819.11266-3-stefanha@redhat.com>
In-Reply-To: <20180306204819.11266-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-06 21:48, Stefan Hajnoczi wrote:
> This test case adds an NBD server export and then invokes
> blockdev-snapshot-sync, which changes the BlockDriverState node that th=
e
> NBD server's BlockBackend points to.  This is an interesting scenario t=
o
> test and exercises the code path fixed by the previous commit.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/208     | 55 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/208.out |  9 ++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 65 insertions(+)
>  create mode 100755 tests/qemu-iotests/208
>  create mode 100644 tests/qemu-iotests/208.out
>=20
> diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
> new file mode 100755
> index 0000000000..4e82b96c82
> --- /dev/null
> +++ b/tests/qemu-iotests/208
> @@ -0,0 +1,55 @@
> +#!/usr/bin/env python
> +#
> +# Copyright (C) 2018 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +# Creator/Owner: Stefan Hajnoczi <stefanha@redhat.com>
> +#
> +# Check that the runtime NBD server does not crash when stopped after
> +# blockdev-snapshot-sync.
> +
> +import iotests
> +
> +with iotests.FilePath('disk.img') as disk_img_path, \
> +     iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, =
\
> +     iotests.FilePath('nbd.sock') as nbd_sock_path, \
> +     iotests.VM() as vm:
> +
> +    img_size =3D '10M'
> +    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, disk_img_pat=
h, img_size)
> +
> +    iotests.log('Launching VM...')
> +    (vm.add_drive(disk_img_path, 'node-name=3Ddrive0-node', interface=3D=
'none')
> +       .launch())
> +
> +    iotests.log('Starting NBD server...')
> +    iotests.log(vm.qmp('nbd-server-start', addr=3D{
> +            "type": "unix",
> +            "data": {
> +                "path": nbd_sock_path,
> +            }
> +        }))
> +
> +    iotests.log('Adding NBD export...')
> +    iotests.log(vm.qmp('nbd-server-add', device=3D'drive0-node', writa=
ble=3DTrue))
> +
> +    iotests.log('Creating external snapshot...')
> +    iotests.log(vm.qmp('blockdev-snapshot-sync',
> +        node_name=3D'drive0-node',
> +        snapshot_node_name=3D'drive0-snapshot-node',
> +        snapshot_file=3Ddisk_snapshot_img_path))
> +
> +    iotests.log('Stopping NBD server...')
> +    iotests.log(vm.qmp('nbd-server-stop'))

Hm.  Tests what it's supposed to test.

However, I'm not sure whether that's what we want...  If I give a node
name to nbd-server-add, I'd probably expect the NBD server to stay at
that node.  We have BdrvChild.stay_at_node for that, so we could
implement it.  The question is whether we want to.

However, both wanting the snapshot to be below and above the NBD server
makes sense...  Perhaps it's best to leave it as-is, even if it is
surprising to some, because this way we at least don't have to switch to
RO mode (which we probably would if the NBD server is suddenly below the
snapshot).

I'm sure adding atomic graph change operations to QMP will fix all of
that.  I'm sure.

Anyway, since your test doesn't even check whether the NBD server is
above or below the snapshot (clever! :-))...

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qry4SfYNPpAp7kXc1yitvwQELSO8fLmBa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmqn0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALtUH/jibCSw1+vicJmnlJXoNp3AjEgHdermv
PcuTOAAS8manXIWvp/7upNNUxzK2OMoeTm3PJpeEQhwVYdJf64qPsjRSHv7TfIum
UyuClaZCSGowbhfJ5962l2RDvdZAk8nqbfrbqubxtDHgQFnPORb9DS+jpQzLszdx
fR03kgLsoGzHfajVmmOLHAJn9V0jGRw7TlGXNxsLoEZvYttHnNN2KDxF6ROX0smC
UtGGhuvVBn/tGP8rBn8JyUWiVN0yIKmpHXpgy7OXq9dshBcqs2vc+SBqHBEfHnxU
w8bEClVfpY5vYp+WtLRxGRZmP575SZcNXWyGVvY5aEZfeZBqtN+oWLw=
=d+E/
-----END PGP SIGNATURE-----

--qry4SfYNPpAp7kXc1yitvwQELSO8fLmBa--
