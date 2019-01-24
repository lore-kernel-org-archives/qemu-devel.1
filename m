Received: from eggs.gnu.org ([209.51.188.92]:39942)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmhMP-00045Y-8A
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmhMO-0004hs-9L
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:56:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:52443)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmhMN-0004gB-VD
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:56:08 -0500
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
	<ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
Date: Thu, 24 Jan 2019 16:56:42 +0100
MIME-Version: 1.0
In-Reply-To: <ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iZDu4I677rPExy7EtKvLAsuS56vXkolnI"
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iZDu4I677rPExy7EtKvLAsuS56vXkolnI
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>,
 stefanha@redhat.com
Message-ID: <f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
References: <20170816072104.24420-1-famz@redhat.com>
 <20170816072104.24420-9-famz@redhat.com>
 <ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
In-Reply-To: <ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.01.2019 16:52, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/16/17 9:21 AM, Fam Zheng wrote:
>> The image is prepared following instructions as in:
>>
>> https://wiki.qemu.org/Hosts/BSD
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  tests/vm/openbsd | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100755 tests/vm/openbsd
>>
>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>> new file mode 100755
>> index 0000000000..d37ff83a59
>> --- /dev/null
>> +++ b/tests/vm/openbsd
>> @@ -0,0 +1,45 @@
>> +#!/usr/bin/env python
>> +#
>> +# OpenBSD VM image
>> +#
>> +# Copyright (C) 2017 Red Hat Inc.
>> +#
>> +# Authors:
>> +#  Fam Zheng <famz@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
>> +# the COPYING file in the top-level directory.
>> +#
>> +
>> +import os
>> +import sys
>> +import logging
>> +import subprocess
>> +import tempfile
>> +import time
>> +import basevm
>> +
>> +class OpenBSDVM(basevm.BaseVM):
>> +    name =3D "openbsd"
>> +    BUILD_SCRIPT =3D """
>> +        set -e;
>> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>> +        tar -xf /dev/rsd1c;
>> +        ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --pyth=
on=3Dpython2.7 {configure_opts};
>> +        gmake -j{jobs};
>> +        # XXX: "gmake check" seems to always hang or fail
>> +        #gmake check;
>=20
> OK, Now it makes more sense...
>=20
> After spending various hours trying to fix various issues on OpenBSD, I=

> notice that we never ran tests on this OS.
> The only binary I can run is qemu-img, the rest seems useless.
> I'll summarize in a different thread.
>=20

Is this W^X related?

>> +    """
>> +
>> +    def build_image(self, img, rebuild=3DFalse):
>> +        if os.path.exists(img) and not rebuild:
>> +            return
>> +        cimg =3D self._download_with_cache("http://download.patchew.o=
rg/openbsd.img.xz")
>> +        img_tmp_xz =3D img + ".tmp.xz"
>> +        img_tmp =3D img + ".tmp"
>> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
>> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
>> +        subprocess.check_call(["mv", img_tmp, img])
>> +
>> +if __name__ =3D=3D "__main__":
>> +    sys.exit(basevm.main(OpenBSDVM))
>>
>=20



--iZDu4I677rPExy7EtKvLAsuS56vXkolnI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxJ4DoMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs/+EP/2yftWtdcASEw14fK0gKD+f8Iw8s0uo1UY/q/L8i
0AdikCBxeZXY1pGbQkXPsjsBuFHHv+IihSDPSGCegEGvPbl8L3Q6dUOh38491iWo
USv7FTjvDWH3Oahobx0zXLIll1dC0D+vy69x5aoqrLnl3chxO3eVTDeWPO5c40pf
NNrpsi9kHpNWe0MFWYwow2PI5qPmLACNp0uuYKKCG1ywtZhgboAPh+jB5Mb9lIgT
KBfW7wHU6K8f1sA7eZjfyDbjFtbp6plVEnJ3S2n/6UwXIht81ZxN7pb/VbFdfY7i
+ofoHVYxBDp4aKkDheoYQi73IKw4Hqo6ohOI+4Pe5T+nsnhAyU7Vx+soVUInZNH9
43tPmkaigD9H91TXjcJV8o28gsWRdRBqRxE5b4parc+BqfbtIXyPC/jejjLs1J2a
fckFhmka0BY/s7M84W1abp0MFxrXlSmET+x+4k01sdCGDopfzJgDiVLX57hP/ot+
UO3HTYDadQJVtWgeQwCSKWfzTYCBGdcF9q7cBDZIhUnVJEmBDBkoTYRAca7ApulC
BXT56+PCded4jDM6YDW8RbEblLEdx7iapbdhxmjmK+t7CIlRCaQR9AEFbWBJ+UXZ
ptvp1jMvjVBKqvWn5e8aRO7VZ5iEnDoP00mFmcUdWTL1a3O1LxpGRDeVDzYbFFpJ
Uo5A
=grnn
-----END PGP SIGNATURE-----

--iZDu4I677rPExy7EtKvLAsuS56vXkolnI--
