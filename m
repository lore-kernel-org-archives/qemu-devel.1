Received: from eggs.gnu.org ([209.51.188.92]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpcXd-0005W6-Qw
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpcXa-0005c1-0J
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:23:47 -0500
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2edaa66c-52d9-ad56-d155-304ec7fb6903@redhat.com>
Date: Fri, 1 Feb 2019 11:23:15 -0600
MIME-Version: 1.0
In-Reply-To: <1548942405-760115-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GKlKjDRbR3MFidHviaT2emZ0eNOQnPMMS"
Subject: Re: [Qemu-devel] [PATCH v11 3/3] qemu-img info: bitmaps extension
 new test 239
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GKlKjDRbR3MFidHviaT2emZ0eNOQnPMMS
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <2edaa66c-52d9-ad56-d155-304ec7fb6903@redhat.com>
Subject: Re: [PATCH v11 3/3] qemu-img info: bitmaps extension new test 239
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548942405-760115-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548942405-760115-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/31/19 7:46 AM, Andrey Shinkevich wrote:
> A new test file 239 added to the qemu-iotests set. It checks
> the output format of 'qemu-img info' for bitmaps extension of
> qcow2 specific information.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/239     |  74 ++++++++++++++++++++++++++
>  tests/qemu-iotests/239.out | 130 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 205 insertions(+)
>  create mode 100755 tests/qemu-iotests/239
>  create mode 100644 tests/qemu-iotests/239.out

Kevin just sent a pull request with 239 consumed for something else (a
test for dmg; also consumed 240); I don't mind renumbering the test as
242 or later as part of staging if we are happy with this version of the
test.  But I also see that Vladimir had some suggestions, so I wouldn't
be surprised if you want to send a v12.

>=20
> diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
> new file mode 100755
> index 0000000..bee7943
> --- /dev/null
> +++ b/tests/qemu-iotests/239
> @@ -0,0 +1,74 @@
> +#!/usr/bin/env python
> +#
> +# Test for qcow2 bitmap printed information
> +#
> +# Copyright (c) 2018 Virtuozzo International GmbH

Want to claim 2019?


> +def add_bitmap(bitmap_number, persistent, disabled):
> +    granularity =3D 2**(13 + bitmap_number)
> +    bitmap_name =3D 'bitmap-' + str(bitmap_number-1)
> +    vm =3D iotests.VM().add_drive(disk)
> +    vm.launch()
> +    vm.qmp_log('block-dirty-bitmap-add', node=3D'drive0', name=3Dbitma=
p_name,
> +               granularity=3Dgranularity, persistent=3Dpersistent,
> +               disabled=3Ddisabled)
> +    vm.shutdown()
> +
> +def write_to_disk(offset, size):
> +    write =3D 'write {} {}K'.format(offset, size)
> +    qemu_io('-f', iotests.imgfmt, '-c', write, disk)
> +    log('Write ' + str(size) + 'K to disk at offset ' + str(hex(offset=
)))
> +
> +
> +qemu_img_create('-f', iotests.imgfmt, disk, '1M')
> +
> +for num in range(1, 4):
> +    disabled =3D False
> +    if num =3D=3D 2:
> +        disabled =3D True
> +    add_bitmap(num, bool(num-1), disabled)

I don't know the pythonic way of coercing a bool value out of a check
for whether another value is a particular integer; but I see that you
did it in two different styles.  I don't know if this works, but it
would at least look more consistent:

add_bitmap(num, bool(num =3D=3D 1), bool(num =3D=3D 2))

> +    write_to_disk((num-1)*chunk, chunk)

Does PEP8 want spaces around those operators?

> +    print_bitmap()
> +    log('')
> +
> +vm =3D iotests.VM().add_drive(disk)
> +vm.launch()
> +log('Checking \"in-use\" flag...')
> +print_bitmap()
> +vm.shutdown()

The test output looks like reasonable coverage.
Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--GKlKjDRbR3MFidHviaT2emZ0eNOQnPMMS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUgIMACgkQp6FrSiUn
Q2oXTgf/bYuyjbFEgfI+gOhZC5RoA0j193y2g8YF6zZBnp7jk6trS4FUuLY3bT4h
BipvAzu2hIdqkzhkQOrjqHaKaB9nyCOJYs4fcHgdYra413lNKrkcWGxXUei7mO5A
0B4CujTxoqwjyssZ/5rn12CGAvXqI2SquQ8b+WZAcbuUiPCKm4YDF6GEwBh9sm33
aSiW5zfCsmfH8WVUIy09ana2JM+deBgKB0fcSUQu0eHAM4bl639zxEG9bt3oLTPq
8UTLdPkAMbf7elZcwEbbQwtrH1bqz7zzYki0SK2HB8cWkb6wzlgJYLOMLt0BFvKw
YH75lOSmW+kvvRDLwZMSeuYbxp1Zjw==
=Ks2W
-----END PGP SIGNATURE-----

--GKlKjDRbR3MFidHviaT2emZ0eNOQnPMMS--
