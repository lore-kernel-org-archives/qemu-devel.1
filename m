Received: from eggs.gnu.org ([2001:4830:134:3::10]:36621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc789-0004M5-Cj
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc785-0002qu-BK
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:36:53 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dc785-0002pS-4A
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:36:49 -0400
Received: by mail-wm0-x243.google.com with SMTP id q189so23731923wmd.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 02:36:48 -0700 (PDT)
Date: Mon, 31 Jul 2017 10:36:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170731093645.GE11830@stefanha-x1.localdomain>
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Content-Disposition: inline
In-Reply-To: <20170729131159.24949-5-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] trace-events: fix code style: print
 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org, berrange@redhat.com


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 29, 2017 at 04:11:59PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> The only exception are groups of numers separated by symbols
> '.', ' ', ':', '/', like 'ab.09.7d'.
>=20
> This patch is made by the following:
>=20
> > find . -name trace-events | xargs python script.py
>=20
> where script.py is the following python script:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>  #!/usr/bin/env python
>=20
> import sys
> import re
> import fileinput
>=20
> rhex =3D '%[-+ *.0-9]*(?:[hljztL]|ll|hh)?(?:x|X|"\s*PRI[xX][^"]*"?)'
> rgroup =3D re.compile('((?:' + rhex + '[.:/ ])+' + rhex + ')')
> rbad =3D re.compile('(?<!0x)' + rhex)
>=20
> files =3D sys.argv[1:]
>=20
> for fname in files:
>     for line in fileinput.input(fname, inplace=3DTrue):
>         arr =3D re.split(rgroup, line)
>         for i in range(0, len(arr), 2):
>             arr[i] =3D re.sub(rbad, '0x\g<0>', arr[i])
>=20
>         sys.stdout.write(''.join(arr))
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  accel/tcg/trace-events    |   2 +-
>  block/trace-events        |  22 +++----
>  hw/audio/trace-events     |   4 +-
>  hw/char/trace-events      |  12 ++--
>  hw/display/trace-events   |  12 ++--
>  hw/dma/trace-events       |  20 +++---
>  hw/i386/xen/trace-events  |   4 +-
>  hw/input/trace-events     |   4 +-
>  hw/intc/trace-events      | 156 +++++++++++++++++++++++-----------------=
------
>  hw/isa/trace-events       |   4 +-
>  hw/misc/trace-events      |  78 +++++++++++------------
>  hw/net/trace-events       |  34 +++++-----
>  hw/nvram/trace-events     |   2 +-
>  hw/ppc/trace-events       |  64 +++++++++----------
>  hw/s390x/trace-events     |  20 +++---
>  hw/scsi/trace-events      | 112 ++++++++++++++++-----------------
>  hw/sd/trace-events        |   4 +-
>  hw/timer/trace-events     |  20 +++---
>  hw/usb/trace-events       |  56 ++++++++---------
>  hw/vfio/trace-events      |  44 ++++++-------
>  hw/virtio/trace-events    |   6 +-
>  linux-user/trace-events   |  10 +--
>  migration/trace-events    |  36 +++++------
>  nbd/trace-events          |  18 +++---
>  net/trace-events          |   4 +-
>  target/arm/trace-events   |  10 +--
>  target/s390x/trace-events |   2 +-
>  target/sparc/trace-events |  30 ++++-----
>  28 files changed, 395 insertions(+), 395 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZfvotAAoJEJykq7OBq3PIlvQH/Ryx5nurxXyLFT1w6oY4FNrf
q8m63J7+iMJNUGQrlJ2AnlfD1gxtXSQbqmp7HHTEmNZ6CPS41Bazr6v4rEauYO40
O8ZCNnCF6r3UeTbMCFwJTidJ2VBmzpsXmQ8sq9xMSIWH5mOWbYvL5vqFu2sdshsr
e+Omn9QQ6DbfjSJX3iR/UtcGoYiRj0Iq9o5BTz53shIEqzqRUahLCBmuzrrxsV1Y
qxWstoqK4y2h5XcRoiEAxH6xE2dZxz71igMrkUKnCHYJvjQ485dWErsBXQcMJhhG
FCk3OkGgY5V7OJxcqj/nb5nmjlY0TPczyxSVmlLegCkUnhXe0xgg0ylcNdBdzLY=
=1kpp
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
