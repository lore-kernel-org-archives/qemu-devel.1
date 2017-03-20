Received: from eggs.gnu.org ([2001:4830:134:3::10]:39154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzT3-00013u-0t
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzSy-0001Xb-QY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cpzSy-0001XF-HQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:43:28 -0400
Date: Mon, 20 Mar 2017 15:43:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170320154322.GD7320@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-9-stefanha@redhat.com>
	<CAMRbyyvW+MVg2EAMPrNDne5Ykp6RmXNO6Qew32sd67K__5nU7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <CAMRbyyvW+MVg2EAMPrNDne5Ykp6RmXNO6Qew32sd67K__5nU7g@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 8/8] iotests: add test 178 for qemu-img
 measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2017 at 09:04:59PM +0000, Nir Soffer wrote:
> On Wed, Mar 15, 2017 at 11:30 AM Stefan Hajnoczi <stefanha@redhat.com>
> wrote:
>=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/qemu-iotests/178           | 75
> > ++++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/178.out.qcow2 | 33 ++++++++++++++++++
> >  tests/qemu-iotests/178.out.raw   | 33 ++++++++++++++++++
> >  tests/qemu-iotests/group         |  1 +
> >  4 files changed, 142 insertions(+)
> >  create mode 100755 tests/qemu-iotests/178
> >  create mode 100644 tests/qemu-iotests/178.out.qcow2
> >  create mode 100644 tests/qemu-iotests/178.out.raw
> >
> > diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
> > new file mode 100755
> > index 0000000..8db1241
> > --- /dev/null
> > +++ b/tests/qemu-iotests/178
> > @@ -0,0 +1,75 @@
> > +#!/bin/bash
> > +#
> > +# qemu-img measure sub-command tests
> > +#
> > +# Copyright (C) 2017 Red Hat, Inc.
> > +#
> > +# This program is free software; you can redistribute it and/or modify
> > +# it under the terms of the GNU General Public License as published by
> > +# the Free Software Foundation; either version 2 of the License, or
> > +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > +#
> > +
> > +# creator
> > +owner=3Dstefanha@redhat.com
> > +
> > +seq=3D`basename $0`
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +status=3D1    # failure is the default!
> > +
> > +_cleanup()
> > +{
> > +    _cleanup_test_img
> > +}
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +# get standard environment, filters and checks
> > +. ./common.rc
> > +. ./common.filter
> > +. ./common.pattern
> > +
> > +_supported_fmt raw qcow2
> > +_supported_proto file
> > +_supported_os Linux
> > +
> > +echo "Input validation"
> >
>=20
> Maybe:
>=20
> echo "=3D=3D Input validation =3D=3D"
>=20
> for nicer output?

Will fix.  Other test cases also use "=3D=3D Title =3D=3D" so it should be
changed for consistency.

> > +echo
> > +
> > +_make_test_img 1G
> > +
> > +$QEMU_IMG measure # missing arguments
> > +$QEMU_IMG measure --size 2G "$TEST_IMG" # only one allowed
> > +$QEMU_IMG measure "$TEST_IMG" a # only one filename allowed
> > +$QEMU_IMG measure --object secret,id=3Dsec0,data=3DMTIzNDU2,format=3Db=
ase64 #
> > missing filename
> > +$QEMU_IMG measure --image-opts # missing filename
> > +$QEMU_IMG measure -f qcow2 # missing filename
> > +$QEMU_IMG measure -l snap1 # missing filename
> > +$QEMU_IMG measure -o , # invalid option list
> > +$QEMU_IMG measure -l snapshot.foo # invalid snapshot option
> > +$QEMU_IMG measure --output foo # invalid output format
> > +$QEMU_IMG measure --size -1 # invalid image size
> > +$QEMU_IMG measure -O foo "$TEST_IMG" # unknown image file format
> > +
> > +echo
> > +echo "Size calculation"
> > +echo
> > +
> > +for ofmt in human json; do
> > +    $QEMU_IMG measure --output=3D$ofmt -O "$IMGFMT" --size 2G
> >
>=20
> --size 0 may be interesting test

Will fix.

> > +    $QEMU_IMG measure --output=3D$ofmt -f "$IMGFMT" -O "$IMGFMT" "$TES=
T_IMG"
> >
>=20
> This measure converting raw to raw or qcow2 to qcow2, not sure it is very
> interesting, since in raw we don't need to measure, the size is always
> the virtual size, and for converting qcow2 to qcow2 can use use the
> source size.
>=20
> The most interesting case is converting raw to qcow2, and we want to test:
> - empty file
> - file with some clusters allocated
> - file with all clusters allocated

I'll extend the test to include both raw -> $IMGFMT and $IMGFMT ->
$IMGFMT.

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJYz/iaAAoJEJykq7OBq3PIR70H92RmWAi0F5wLnP+pJMFlPCt9
yTRu02/QmdHGg3bkEysBK+Nc8hoehVv0p4VKcn5nVXh5tG+Gnnm8MD/I1jYEnZPT
eRypCPAEBcBchJYXQhK5wCQJJWDZGpRuFudjZILNVzsCqoBIv3HNh2Mq+OJgmoBc
M4SZQpSXerfRhCr41E0qd4dpiVraSWY5kReYYIVVTK/xExEG5WIat9ewEWKX5gxw
Yo72L8wJ2MjghB2POihlj1/c9N8A8WdSWHshTQWiDHl+EFypDqfO9eRdVmb+dimz
NruoUD4iqrFJ9mXD5iha+Nb0c4WF8SAQbaW2Crnf6uaMzphpD6c7nVxokqINWQ==
=NuBv
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
