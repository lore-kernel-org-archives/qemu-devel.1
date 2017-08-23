Received: from eggs.gnu.org ([2001:4830:134:3::10]:54549)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dkXLA-0003ka-SD
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dkXL6-0005MO-Su
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:13:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:64303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dkXL6-0005M0-Ht
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:13:04 -0400
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-7-famz@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <fa516204-de03-abe0-6618-d8437a6d559c@gmx.com>
Date: Wed, 23 Aug 2017 17:15:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-7-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AkCMKH95VGiuU9aQujtpxvjkhsjK5jvV8"
Subject: Re: [Qemu-devel] [PATCH v3 06/10] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AkCMKH95VGiuU9aQujtpxvjkhsjK5jvV8
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 eblake@redhat.com
Message-ID: <fa516204-de03-abe0-6618-d8437a6d559c@gmx.com>
Subject: Re: [PATCH v3 06/10] tests: Add NetBSD image
References: <20170822044155.2451-1-famz@redhat.com>
 <20170822044155.2451-7-famz@redhat.com>
In-Reply-To: <20170822044155.2451-7-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.08.2017 06:41, Fam Zheng wrote:
> The image is prepared following instructions as in:
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  tests/vm/netbsd | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100755 tests/vm/netbsd
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> new file mode 100755
> index 0000000000..7d7dfe6586
> --- /dev/null
> +++ b/tests/vm/netbsd
> @@ -0,0 +1,45 @@
> +#!/usr/bin/env python
> +#
> +# NetBSD VM image
> +#
> +# Copyright (C) 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  Se=
e
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +import sys
> +import logging
> +import subprocess
> +import tempfile
> +import time
> +import basevm
> +
> +class NetBSDVM(basevm.BaseVM):
> +    name =3D "netbsd"
> +    BUILD_SCRIPT =3D """
> +        set -e;
> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        tar -xf /dev/ld1a;

I've rechecked a similar setup, and I think that there might be needed
/dev/rld1a (initial r stands for raw device).

> +        ./configure --python=3Dpython2.7 {configure_opts};
> +        gmake -j{jobs};
> +        gmake check;
> +    """
> +
> +    def build_image(self, img, rebuild=3DFalse):
> +        if os.path.exists(img) and not rebuild:
> +            return
> +        cimg =3D self._download_with_cache("http://download.patchew.or=
g/netbsd.img.xz",
> +                                         sha256sum=3D'b633d565b0eac3d0=
2015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
> +        img_tmp_xz =3D img + ".tmp.xz"
> +        img_tmp =3D img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        os.rename(img_tmp, img)
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(basevm.main(NetBSDVM))
>=20



--AkCMKH95VGiuU9aQujtpxvjkhsjK5jvV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZnZwAAAoJEEuzCOmwLnZsEswP/j3dCcALg7bwMOU8bZ2qJGj7
uXKPrx68zbeXyMUGNL3kjAnAhLQH3H1+qA+r7MP4PIA1/92b73MoFad2Cw1oS7rY
p3fJ9SOgynOdtjzKF9G/qTURqEdP6KNt1Ce6AvUEguPafghLq+XHIJD0SfA1tbVj
4iFRwhxxGOb44rPx9lSfOMdtKbu2QNE+C6LYOrN+wDf86HXt1e9h/xjwIVFl+/hV
akJUgPeLVNhMpSErEKf5e8oX4h8dPP2OewDxeUWZ7Xsiv05h9DVfBVN9dPoLGe54
jn1StY6SAktAJiO3KW02GnWbzoTg7Ek30+QmU9tMkQn6sNsGlFDWF+0I6KXJsjdo
af4ODi6tI0QPbHRz9nXBd7+02NIOE5cXOCt1XUssWVlldq3Tw9nlLw46JpWYUxh7
fZZaxK6cYvnycr6OtrSBD0GUkgoA2qvdyyKJNGwVVwuD0HBAMg5TsbZMqXP6toU+
mvVC+XyVsDy36aBNdRWrheU6mD5wA4cgoHZmkDnvJRhseY+FjTWOLVJ35rBFUMr2
K32Y1DdxtBmbbMD4axE3v2KFkK1sOzNxnMUGj87bgzImkv363+tIZ5SA0YxB1YBz
cDj3tD78RsbulRhhC8WCfytBkQge1LDRlHrszBYyW3I92k16a6pf2SyNqTSwKjLD
eY1oeNcyX7umkqP/dlL9
=SLGN
-----END PGP SIGNATURE-----

--AkCMKH95VGiuU9aQujtpxvjkhsjK5jvV8--
