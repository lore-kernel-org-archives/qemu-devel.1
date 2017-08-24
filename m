Received: from eggs.gnu.org ([2001:4830:134:3::10]:43236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCs-0007yL-EH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCq-0002PL-8S
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dkuCp-0002OX-UT
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:04 -0400
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-6-famz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <f3f12cf2-193d-7207-45a8-88055060baef@redhat.com>
Date: Thu, 24 Aug 2017 11:33:07 -0400
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-6-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TqBr6KSTBBQ7Jl4xQPdbv88dE1lx7Sjh7"
Subject: Re: [Qemu-devel] [PATCH v3 05/10] tests: Add FreeBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TqBr6KSTBBQ7Jl4xQPdbv88dE1lx7Sjh7
From: Cleber Rosa <crosa@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <f3f12cf2-193d-7207-45a8-88055060baef@redhat.com>
Subject: Re: [PATCH v3 05/10] tests: Add FreeBSD image
References: <20170822044155.2451-1-famz@redhat.com>
 <20170822044155.2451-6-famz@redhat.com>
In-Reply-To: <20170822044155.2451-6-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/22/2017 12:41 AM, Fam Zheng wrote:
> The image is prepared following instructions as in:
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/freebsd | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100755 tests/vm/freebsd
>=20
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> new file mode 100755
> index 0000000000..0e4eb037d7
> --- /dev/null
> +++ b/tests/vm/freebsd
> @@ -0,0 +1,45 @@
> +#!/usr/bin/env python
> +#
> +# FreeBSD VM image
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

logging is not used in this module.

> +import subprocess
> +import tempfile
> +import time

tempfile and time are also not used in this module.

> +import basevm
> +
> +class FreeBSDVM(basevm.BaseVM):
> +    name =3D "freebsd"
> +    BUILD_SCRIPT =3D """
> +        set -e;
> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        tar -xf /dev/vtbd1;
> +        ./configure {configure_opts};
> +        gmake -j{jobs};
> +        gmake check;
> +    """
> +
> +    def build_image(self, img, rebuild=3DFalse):

I don't see how "rebuild" will ever get set by using "basevm.main()".
Also it doesn't exist in UbuntuX86VM, so it's not a uniform interface.

- Cleber.

> +        if os.path.exists(img) and not rebuild:
> +            return
> +        cimg =3D self._download_with_cache("http://download.patchew.or=
g/freebsd.img.xz",
> +                sha256sum=3D'adcb771549b37bc63826c501f05121a206ed3d9f5=
5f49145908f7e1432d65891')
> +        img_tmp_xz =3D img + ".tmp.xz"
> +        img_tmp =3D img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        os.rename(img_tmp, img)
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(basevm.main(FreeBSDVM))
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--TqBr6KSTBBQ7Jl4xQPdbv88dE1lx7Sjh7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlme8bQACgkQZX6NM6Xy
CfPWtg//QuOLGB472VvlVtnO3za/7SAUivACUinxNHnwus5KWnkTjUNNbNOjflQ4
wpKHtiARSzeSxbcjhgK46e/zZFqtWPQ+6Su224ozrYcRt2haqgDOQS9J2FfRDbrK
ycKJ7cpc1zUX02Zna0whsGY7c1IhW06X/1f8m1H0gNuVvKl3VcDENRUPWYkkXNbZ
QAGkOqq1j7N4HUHbQqGqP9D//VAGh18v1mmaL4yrUPuyC7iqCnfUNSuw0YcbZYxV
Lw/ItPMPVbPOd/PnUQw35EcmgsYzVf49Wg6aw0n8PaeU2zn5AypgUHHnQUJ866/T
Asb1CE7KNlupBNlBBmPzeoKbkCt7eSV9svXBITGZkulDytnis7TW0+igFJw8WWuE
6v0r8uF1ABCNm7PO10Tkyk2rNbtdKqq1QPe48j3NmXd7yyDCWIUYHCqF+iS/o2MH
rQig3HddOqwAYR+92uF3v2u9xiuW40XkjJKiERMfj4Czbcghp12rHzMW3kGbHZhL
+f9w147U7zGawHBlaiTetmQc0VGEXmMt5JzO1xq1E3v/2zOmwsPxLfM+14bpCfgA
3aWZCEUBRoRiBoNAc5eCrY5QpBCXf1olMhk+Fv7JcisQjWFb1QwDqnT4FUuZ6TRV
haQHg04OtzC65gEX3TUDIrtQi+9NIBWALRmBvaEU+7GtB3km+Gg=
=uA5D
-----END PGP SIGNATURE-----

--TqBr6KSTBBQ7Jl4xQPdbv88dE1lx7Sjh7--
