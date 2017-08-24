Received: from eggs.gnu.org ([2001:4830:134:3::10]:43406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuD3-00087M-P1
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCx-0002Uo-OJ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dkuCx-0002U9-F4
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:11 -0400
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-7-famz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <7f5841bd-fcc9-636b-6a82-00f1ad2852aa@redhat.com>
Date: Thu, 24 Aug 2017 11:37:04 -0400
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-7-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HFPApoSWiFjiSgJMB5Sn2AlFOpnRgt7jg"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HFPApoSWiFjiSgJMB5Sn2AlFOpnRgt7jg
From: Cleber Rosa <crosa@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com,
 pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <7f5841bd-fcc9-636b-6a82-00f1ad2852aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/10] tests: Add NetBSD image
References: <20170822044155.2451-1-famz@redhat.com>
 <20170822044155.2451-7-famz@redhat.com>
In-Reply-To: <20170822044155.2451-7-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/22/2017 12:41 AM, Fam Zheng wrote:
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

logging is not used in this module.

> +import subprocess
> +import tempfile
> +import time

tempfile and time imports can also be removed.

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

Same comment as in the FreeBSDVM class: I don't see how "rebuild" will
ever get set by using "basevm.main()".

- Cleber.

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

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--HFPApoSWiFjiSgJMB5Sn2AlFOpnRgt7jg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlme8qAACgkQZX6NM6Xy
CfOwHA/+N7ZUDZeoydo5dGo8vaOFmIDh79/fA4tZVs+/qrmz/Q4T9ItU8xr0xWpC
2CAvimR2ougwObnjRpoizuLC0SPC/1YNwyYZSpdGATr9NN8dh5PejhcVYGNi5FTi
z6N0JSiRl+F7WepZwWI9iQkWjPG4JmkX2MYc2h5ouHtzkqMb4QuUHHKuzLTpSYht
mrj2X/8BDMnW4Ku9riVsL2TgGVnPXIQCDpqQWTGzaILN8q/aUBYsi8AYAMTiWUh6
5wrsaMYYZzK1F0TIKBIth69vISZrA4GZlFQ7upuwOxno72WsYW8v0ZpNtOjt36cj
67NiDB2MQX1gcUICpopb8dAwu39pA5ak0kn5b7Crfn1qSQmfeNFBMRmGvk7uuPmE
RYtw7rTER/lINp7UBY7bCkhSvDTx9ujCb4OUvJUsMa1OmRWDci3AePOyecffuLUI
wCMkvTobI2g/4LioUkti1EuENCB1tRBMqM5t+VYSwj2IOzf71tfrdrvXbA/lnl5m
zCtMvKquHlFcy4Lvtaf3LHmpVPZX35i0hwcDS9cb8qz8xNsoeuTlUgF0WfVoNEVn
U6DPC695x0iQYk26mUnszI0AUmoG99NM2mwCIOVxC6BLR0TPSPBY0diuErSnHToO
a9Lgsf5CS5+yHXDhhS2pfFAwxDy2uoyHhmFYzSidMV47jkUsNRc=
=7Hkk
-----END PGP SIGNATURE-----

--HFPApoSWiFjiSgJMB5Sn2AlFOpnRgt7jg--
