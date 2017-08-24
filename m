Received: from eggs.gnu.org ([2001:4830:134:3::10]:43272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCt-0007zK-MO
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCs-0002QZ-6S
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dkuCr-0002Pt-Sk
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:06 -0400
From: Cleber Rosa <crosa@redhat.com>
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-8-famz@redhat.com>
Message-ID: <81b75d30-897e-fefe-70f5-6678d6ed663b@redhat.com>
Date: Thu, 24 Aug 2017 11:34:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-8-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IEgsNFeVaPfIrR0En6soo7mvHl79bfAKn"
Subject: Re: [Qemu-devel] [PATCH v3 07/10] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IEgsNFeVaPfIrR0En6soo7mvHl79bfAKn
From: Cleber Rosa <crosa@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com,
 pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <81b75d30-897e-fefe-70f5-6678d6ed663b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/10] tests: Add OpenBSD image
References: <20170822044155.2451-1-famz@redhat.com>
 <20170822044155.2451-8-famz@redhat.com>
In-Reply-To: <20170822044155.2451-8-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/22/2017 12:41 AM, Fam Zheng wrote:
> The image is prepared following instructions as in:
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/openbsd | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100755 tests/vm/openbsd
>=20
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> new file mode 100755
> index 0000000000..b308aa252b
> --- /dev/null
> +++ b/tests/vm/openbsd
> @@ -0,0 +1,46 @@
> +#!/usr/bin/env python
> +#
> +# OpenBSD VM image
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

logging, and tempfile are not used here.

> +import basevm
> +
> +class OpenBSDVM(basevm.BaseVM):
> +    name =3D "openbsd"
> +    BUILD_SCRIPT =3D """
> +        set -e;
> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> +        tar -xf /dev/rsd1c;
> +        ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --pytho=
n=3Dpython2.7 {configure_opts};
> +        gmake -j{jobs};
> +        # XXX: "gmake check" seems to always hang or fail
> +        #gmake check;
> +    """
> +
> +    def build_image(self, img, rebuild=3DFalse):

Same comment as in the FreeBSDVM class: I don't see how "rebuild" will
ever get set by using "basevm.main()".

- Cleber.

> +        if os.path.exists(img) and not rebuild:
> +            return
> +        cimg =3D self._download_with_cache("http://download.patchew.or=
g/openbsd.img.xz",
> +                sha256sum=3D'8c6cedc483e602cfee5e04f0406c64eb99138495e=
8ca580bc0293bcf0640c1bf')
> +        img_tmp_xz =3D img + ".tmp.xz"
> +        img_tmp =3D img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
> +        os.rename(img_tmp, img)
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(basevm.main(OpenBSDVM))
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]




--IEgsNFeVaPfIrR0En6soo7mvHl79bfAKn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlme8hEACgkQZX6NM6Xy
CfNOrBAArlV25mOMnb3mbT3HVltdc3z5echUuEOev/vU9dZ/SFSJ0w6kjdg49u6Z
gPnJYOp0wDuDoV647CK4nldNjPrHdjfBUkbRkthCWeOxpYtIlvpVNu//bGkO3Hx9
JpXQEvw+eU4sB/JG05HgTsM8LRwh4b7iZvXFifsJ8TFkB3HdqA8AQF7ERXajssJK
jxUMjBIhRPIGMCZ/LClTvlLyrrT/0OXzTpnZX5w/8785/7LjZ4bjIQ3KOl3O/pay
bM4TF3bV+W24Q/jA/3cGtAvbfZjbElbmaNwdfKkyteE+MGxwIPdpEYHWQZEiDFtR
WlQl3y9yWpWaxYZKBnnciEkqyMpVpqg/VPGfJdUnsAbFZWczPYmFb+jbvcOCNZGX
TrGu3hDMJHYBqjU7HrHw9vWqI+IRRtaOr1tnIyM1+OxFbD8xMa7odRmeXQN25Gxy
Ox5mI5WXbVrAywdekFWtthoqaOxQJ7wRCDfTJltPk36xliT1+/KF+AZ+WHvUlMLn
QML3bcCxdHnrqFM8AoMoKHoEhw3QYnc31lr/pjyaEXqCYCWB6kxQPolSSIzpHPMh
sjDmBLRq0Xrknk7ZYoNBah7hKlkGO4z3yC7kYuGXH6zi8I22OXBV5p/lqphoPOM5
9ZLsg1aiZtJ8rOv3Rv5ivixE0YTg/7pTw+cYwqPT2CgxkZqUfgU=
=cONh
-----END PGP SIGNATURE-----

--IEgsNFeVaPfIrR0En6soo7mvHl79bfAKn--
