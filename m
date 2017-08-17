Received: from eggs.gnu.org ([2001:4830:134:3::10]:47271)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1diIxf-0007Jy-Fd
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1diIxb-0002fD-Ga
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:27:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:58701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1diIxb-0002es-6N
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:27:35 -0400
References: <20170817024746.5961-1-famz@redhat.com>
	<20170817024746.5961-8-famz@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <a5ee7f11-0938-7b2a-44ba-01d7d9cd4e73@gmx.com>
Date: Thu, 17 Aug 2017 13:17:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170817024746.5961-8-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="59GdcUb6p8QmdlRrnNqA54tvUdTU3s9ev"
Subject: Re: [Qemu-devel] [PATCH RFC v2 07/10] tests: Add NetBSD image
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
--59GdcUb6p8QmdlRrnNqA54tvUdTU3s9ev
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 eblake@redhat.com
Message-ID: <a5ee7f11-0938-7b2a-44ba-01d7d9cd4e73@gmx.com>
Subject: Re: [PATCH RFC v2 07/10] tests: Add NetBSD image
References: <20170817024746.5961-1-famz@redhat.com>
 <20170817024746.5961-8-famz@redhat.com>
In-Reply-To: <20170817024746.5961-8-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.2017 04:47, Fam Zheng wrote:
> The image is prepared following instructions as in:
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Kamil Rytarowski <n54@gmx.com>

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



--59GdcUb6p8QmdlRrnNqA54tvUdTU3s9ev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZlXtRAAoJEEuzCOmwLnZs+IIP/jCyIq1WQGq+X4xbH00GWOxi
s/NzuNAyn1PbpUWiAZXeB97ER7FoUS3QqEwVBuKP834e/9IYWxBqg10WvLJtiwpd
I+VV4Z7PahmmvIEDT6/KUaUCV5vizI+CNLBKv0A9rAs98kVvNkKJZ8XW0bFFZ3Sl
jdHu0V7nDSc+Kcu+oQ4HkVz80VrgnXGcZ4aqYsTn7sxv4+dPurD2nW2xf2Ws5Be4
qNUOlgjZmoLLIj7Hd6zz9e/UlC0XlRhm2NeqD/8xnfhk4MXfufDLErT1yloF4qHd
DHcYUA5nNA5nVEyX/tDlJPCMZFhbf5uca2h0mhMzMKxMVCSe9Iv6OVoVyondE20M
/+S7Ba2Z+D75R473xFu0PKBFaalQDoB/M1jJvZ8q5RNSbPOGfJT1phaUCoSCrkSC
HEfAiRQUEQAcj9GZTS41he5oTrV5vOVTDNm2DmZEFr9Eh9jt5wwIO/50UJmzl1PD
cMt4MLyBT3qD8BDIeeqrBxrqA85RQplWDzxkywITsIT/dbu7nEZd9dl9ymzERgYP
oc/6xkwu8yvtHPs/+X7GDWQNTtJtX0MZ/cJ/ajnSy3ItSrBBY0lYZYTMGLnar9cp
r1CP9QqOp7+b9Ecb4zynZbV3aFeZMtcgpkgT4UUulmkW5rJHXYmEJabasxZXErzk
BBTZx2c9s6DkKlEk+Lyp
=pn1o
-----END PGP SIGNATURE-----

--59GdcUb6p8QmdlRrnNqA54tvUdTU3s9ev--
