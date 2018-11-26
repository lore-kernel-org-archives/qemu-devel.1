Received: from eggs.gnu.org ([2001:4830:134:3::10]:60803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRI1Z-0002UK-NL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRI1T-0006iN-7L
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:38:09 -0500
References: <20181126141639.13208-1-kwolf@redhat.com>
	<20181126141639.13208-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ac3ebf6c-b15a-d729-5718-d602db225125@redhat.com>
Date: Mon, 26 Nov 2018 15:37:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181126141639.13208-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vvg0NmdoFuV4ZGUbaCGKZMgt7IOO8JG77"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v2 2/2] iotests: Test migration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vvg0NmdoFuV4ZGUbaCGKZMgt7IOO8JG77
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <ac3ebf6c-b15a-d729-5718-d602db225125@redhat.com>
Subject: Re: [PATCH for-3.1 v2 2/2] iotests: Test migration with -blockdev
References: <20181126141639.13208-1-kwolf@redhat.com>
 <20181126141639.13208-3-kwolf@redhat.com>
In-Reply-To: <20181126141639.13208-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.11.18 15:16, Kevin Wolf wrote:
> Check that block node activation and inactivation works with a block
> graph that is built with individually created nodes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/234     | 115 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/234.out |  27 +++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 143 insertions(+)
>  create mode 100755 tests/qemu-iotests/234
>  create mode 100644 tests/qemu-iotests/234.out
>=20
> diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
> new file mode 100755
> index 0000000000..58886b8dea
> --- /dev/null
> +++ b/tests/qemu-iotests/234
> @@ -0,0 +1,115 @@
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
> +# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
> +#
> +# Check that block node activation and inactivation works with a block=
 graph
> +# that is built with individually created nodes
> +
> +import iotests
> +import os
> +
> +iotests.verify_image_format(supported_fmts=3D['raw', 'qcow2'])
> +iotests.verify_platform(['linux'])
> +
> +with iotests.FilePath('img') as img_path, \
> +     iotests.FilePath('backing') as backing_path, \
> +     iotests.FilePath('mig_fifo_a') as fifo_a, \
> +     iotests.FilePath('mig_fifo_b') as fifo_b, \
> +     iotests.VM(path_suffix=3D'a') as vm_a, \
> +     iotests.VM(path_suffix=3D'b') as vm_b:
> +
> +    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, backing_path=
, '64M')
> +    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, img_path, '6=
4M')
> +
> +    os.mkfifo(fifo_a)
> +    os.mkfifo(fifo_b)
> +
> +    iotests.log('Launching source VM...')
> +    (vm_a.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % =
(img_path))
> +         .add_blockdev('%s,file=3Ddrive0-file,node-name=3Ddrive0' % (i=
otests.imgfmt))
> +         .add_blockdev('file,filename=3D%s,node-name=3Ddrive0-backing-=
file' % (backing_path))
> +         .add_blockdev('%s,file=3Ddrive0-backing-file,node-name=3Ddriv=
e0-backing' % (iotests.imgfmt))
> +         .launch())
> +
> +    iotests.log('Launching destination VM...')
> +    (vm_b.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % =
(img_path))
> +         .add_blockdev('%s,file=3Ddrive0-file,node-name=3Ddrive0' % (i=
otests.imgfmt))
> +         .add_blockdev('file,filename=3D%s,node-name=3Ddrive0-backing-=
file' % (backing_path))
> +         .add_blockdev('%s,file=3Ddrive0-backing-file,node-name=3Ddriv=
e0-backing' % (iotests.imgfmt))
> +         .add_incoming("exec: cat '%s'" % (fifo_a))
> +         .launch())
> +
> +    # Add a child node that was created after the parent node. The rev=
erse case
> +    # is covered by the -blockdev options above.
> +    vm_a.qmp('blockdev-snapshot', node=3D'drive0-backing', overlay=3D'=
drive0')

Sorry if I made it sound like my diff was ready for inclusion as-is. O:-)=


I think this should be vm_a.qmp_log() at least (and the reference output
needs to be adjusted accordingly).

Also, we probably have to execute the same command on vm_b...

> +    iotests.log('Enabling migration QMP events on A...')
> +    iotests.log(vm_a.qmp('migrate-set-capabilities', capabilities=3D[
> +        {
> +            'capability': 'events',
> +            'state': True
> +        }
> +    ]))
> +
> +    iotests.log('Starting migration to B...')
> +    iotests.log(vm_a.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_a)))
> +    with iotests.Timeout(3, 'Migration does not complete'):
> +        while True:
> +            event =3D vm_a.event_wait('MIGRATION')
> +            iotests.log(event, filters=3D[iotests.filter_qmp_event])
> +            if event['data']['status'] =3D=3D 'completed':
> +                break
> +
> +    iotests.log(vm_a.qmp('query-migrate')['return']['status'])
> +    iotests.log(vm_b.qmp('query-migrate')['return']['status'])
> +
> +    iotests.log(vm_a.qmp('query-status'))
> +    iotests.log(vm_b.qmp('query-status'))
> +
> +    iotests.log('Add a second parent to drive0-file...')
> +    iotests.log(vm_b.qmp('blockdev-add', driver=3D'raw', file=3D'drive=
0-file',
> +                         node_name=3D'drive0-raw'))
> +
> +    iotests.log('Restart A with -incoming and second parent...')
> +    vm_a.shutdown()
> +    (vm_a.add_blockdev('raw,file=3Ddrive0-file,node-name=3Ddrive0-raw'=
)
> +         .add_incoming("exec: cat '%s'" % (fifo_b))
> +         .launch())

=2E..and here on vm_a again?

Max

> +    iotests.log('Enabling migration QMP events on B...')
> +    iotests.log(vm_b.qmp('migrate-set-capabilities', capabilities=3D[
> +        {
> +            'capability': 'events',
> +            'state': True
> +        }
> +    ]))
> +
> +    iotests.log('Starting migration back to A...')
> +    iotests.log(vm_b.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_b)))
> +    with iotests.Timeout(3, 'Migration does not complete'):
> +        while True:
> +            event =3D vm_b.event_wait('MIGRATION')
> +            iotests.log(event, filters=3D[iotests.filter_qmp_event])
> +            if event['data']['status'] =3D=3D 'completed':
> +                break
> +
> +    iotests.log(vm_a.qmp('query-migrate')['return']['status'])
> +    iotests.log(vm_b.qmp('query-migrate')['return']['status'])
> +
> +    iotests.log(vm_a.qmp('query-status'))
> +    iotests.log(vm_b.qmp('query-status'))
> diff --git a/tests/qemu-iotests/234.out b/tests/qemu-iotests/234.out
> new file mode 100644
> index 0000000000..115537cd5c
> --- /dev/null
> +++ b/tests/qemu-iotests/234.out
> @@ -0,0 +1,27 @@
> +Launching source VM...
> +Launching destination VM...
> +Enabling migration QMP events on A...
> +{"return": {}}
> +Starting migration to B...
> +{"return": {}}
> +{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"mic=
roseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {=
"microseconds": "USECS", "seconds": "SECS"}}
> +completed
> +completed
> +{"return": {"running": false, "singlestep": false, "status": "postmigr=
ate"}}
> +{"return": {"running": true, "singlestep": false, "status": "running"}=
}
> +Add a second parent to drive0-file...
> +{"return": {}}
> +Restart A with -incoming and second parent...
> +Enabling migration QMP events on B...
> +{"return": {}}
> +Starting migration back to A...
> +{"return": {}}
> +{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"mic=
roseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {=
"microseconds": "USECS", "seconds": "SECS"}}
> +completed
> +completed
> +{"return": {"running": true, "singlestep": false, "status": "running"}=
}
> +{"return": {"running": false, "singlestep": false, "status": "postmigr=
ate"}}
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index ddf1a5b549..8c56a0ad11 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -231,3 +231,4 @@
>  231 auto quick
>  232 auto quick
>  233 auto quick
> +234 auto quick migration
>=20



--vvg0NmdoFuV4ZGUbaCGKZMgt7IOO8JG77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlv8BTcACgkQ9AfbAGHV
z0DO3wgAp49ONIsyhXcAP1jAyJ81uqycihvBYFgNY3dp1YhLJn+sMdMt46FKut9N
QGlQ22uphgJ4kN+zAwqrLd4rSztNkLqOep0K+/qF3eAziWpUBVVFIc80gcDg6Gi3
GAaVC7uCydZ98CPt11qfEBS38zxF0+Ev6+nfZxR66a/5jierg5HuoCoxFVS1yLmK
/rFLOKH5+TSmp1xCGzKTsNickkj+fmmO0Ly5djmExORqXSarxxSvNjPK+reHSXp4
VSm0wXWzhsXt8wSqrLItRPsT8UhJYuLyZ0TNMu+GO06mp5UxKTH5FHpmID0tvVma
yIAw9GacF9uIKJIce49E/zyOwrUgjw==
=YF/6
-----END PGP SIGNATURE-----

--vvg0NmdoFuV4ZGUbaCGKZMgt7IOO8JG77--
