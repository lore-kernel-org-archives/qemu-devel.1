Received: from eggs.gnu.org ([2001:4830:134:3::10]:43165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCl-0007sn-WE
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCk-0002Lz-Ji
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dkuCk-0002LY-9Q
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:37:58 -0400
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-5-famz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <b62132d5-3cd6-cc9e-6efc-315405cbeb68@redhat.com>
Date: Thu, 24 Aug 2017 11:28:03 -0400
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-5-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gMIAqKD2UEKaigg3lu1I3bA62FbvaOili"
Subject: Re: [Qemu-devel] [PATCH v3 04/10] tests: Add ubuntu.i386 image
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
--gMIAqKD2UEKaigg3lu1I3bA62FbvaOili
From: Cleber Rosa <crosa@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <b62132d5-3cd6-cc9e-6efc-315405cbeb68@redhat.com>
Subject: Re: [PATCH v3 04/10] tests: Add ubuntu.i386 image
References: <20170822044155.2451-1-famz@redhat.com>
 <20170822044155.2451-5-famz@redhat.com>
In-Reply-To: <20170822044155.2451-5-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/22/2017 12:41 AM, Fam Zheng wrote:
> This adds a 32bit guest.
>=20
> The official LTS cloud image is downloaded and initialized with
> cloud-init.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/ubuntu.i386 | 88 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100755 tests/vm/ubuntu.i386
>=20
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> new file mode 100755
> index 0000000000..b478a8a03f
> --- /dev/null
> +++ b/tests/vm/ubuntu.i386
> @@ -0,0 +1,88 @@
> +#!/usr/bin/env python
> +#
> +# Ubuntu i386 image
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

tempfile is not used in this module.

> +import time
> +import basevm
> +
> +class UbuntuX86VM(basevm.BaseVM):
> +    name =3D "ubuntu.i386"
> +    BUILD_SCRIPT =3D """
> +        set -e;
> +        cd $(mktemp -d);
> +        sudo chmod a+r /dev/vdb;
> +        tar -xf /dev/vdb;
> +        ./configure {configure_opts};
> +        make -j{jobs};
> +        make check;
> +    """
> +
> +    def _gen_cloud_init_iso(self):
> +        cidir =3D self._tmpdir
> +        mdata =3D open(os.path.join(cidir, "meta-data"), "w")
> +        mdata.writelines(["instance-id: ubuntu-vm-0\n",
> +                         "local-hostname: ubuntu-guest\n"])
> +        mdata.close()
> +        udata =3D open(os.path.join(cidir, "user-data"), "w")
> +        udata.writelines(["#cloud-config\n",
> +                          "chpasswd:\n",
> +                          "  list: |\n",
> +                          "    root:%s\n" % self.ROOT_PASS,
> +                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST=
_PASS),
> +                          "  expire: False\n",
> +                          "users:\n",
> +                          "  - name: %s\n" % self.GUEST_USER,
> +                          "    sudo: ALL=3D(ALL) NOPASSWD:ALL\n",
> +                          "    ssh-authorized-keys:\n",
> +                          "    - %s\n" % basevm.SSH_PUB_KEY,
> +                          "  - name: root\n",
> +                          "    ssh-authorized-keys:\n",
> +                          "    - %s\n" % basevm.SSH_PUB_KEY])
> +        udata.close()
> +        subprocess.check_call(["genisoimage", "-output", "cloud-init.i=
so",
> +                               "-volid", "cidata", "-joliet", "-rock",=

> +                               "user-data", "meta-data"],
> +                               cwd=3Dcidir,
> +                               stdin=3Dself._devnull, stdout=3Dself._s=
tdout,
> +                               stderr=3Dself._stdout)
> +        return os.path.join(cidir, "cloud-init.iso")
> +
> +    def build_image(self, img):

Signature differs from the *BSD ones (rebuild=3DFalse).

- Cleber.

> +        cimg =3D self._download_with_cache("https://cloud-images.ubunt=
u.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-i386-disk1.img"=
)
> +        img_tmp =3D img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp])
> +        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> +        self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_i=
nit_iso()])
> +        self.wait_ssh()
> +        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
> +        self.ssh_root_check("apt-get update")
> +        self.ssh_root_check("apt-get install -y cloud-initramfs-growro=
ot")
> +        # Don't check the status in case the guest hang up too quickly=

> +        self.ssh_root("sync && reboot")
> +        time.sleep(5)
> +        self.wait_ssh()
> +        # The previous update sometimes doesn't survive a reboot, so d=
o it again
> +        self.ssh_root_check("apt-get update")
> +        self.ssh_root_check("apt-get build-dep -y qemu")
> +        self.ssh_root_check("apt-get install -y libfdt-dev")
> +        self.ssh_root("poweroff")
> +        self.wait()
> +        os.rename(img_tmp, img)
> +        return 0
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(basevm.main(UbuntuX86VM))
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--gMIAqKD2UEKaigg3lu1I3bA62FbvaOili
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlme8IQACgkQZX6NM6Xy
CfNxKQ/6AphiKDrKJw0FpQok0PRBLO0LkjcK7xX5ZJDyaLhZEUv5L3bqoicDrNDl
/FPAPtYW+fxM67ExvccCibOG/Mgv6K9Vs4xSJdd9+/RpNaigQDzyQoxXerrFZcCw
tesQF44bp+mSWi3rghPYnSfusIKrmr/Soj1pFNf7+k1LXlp+r6DVGwN5p3nb6TOU
iDZ5wjc1KPbMyAFuzLPzF5LjVcAlIDwut5gNYpavb3WVON5ZvEni15Xi33bs1Pkj
DS0hCfBRp3vnTKkJm/dZd9ZhNFvf/iF0lBpsQwgsTa788agmrJWT8GKJpLvurKut
psuEqomkNqziNsUvdUERkXRjjk5NrqwsJheEVOhHxFISTw6yQY+wDhuoNbVvFaqm
pReALCgnBV3a6oDYljDVS+oEPLbvKu4BsO6NNGRndYiD43PZtdBdRTOX9na1Rv0F
XxCje2IlSPI+KjL2QOCAaj1r3f4/2m9P+XTXGvTJLv7R6BpI9sCqXFCWjQf2p9Yp
S9XMUiBicaY0tJZmoV2wATPBFrIw3GBaqLRMTUJB8JMHTPHj5xZRHI6HtyLU1hgw
/8M9y3yW+x8HY5MCj4P7MiE+hTTl3fw3HKHP2ECjE40Hlg3ZloSsHw+RLlHv/scL
3heXlBCAQcRO38Mc7WdWVV+YvTIJ/oidBalaYCuS6vSYSO+9vGI=
=xrtJ
-----END PGP SIGNATURE-----

--gMIAqKD2UEKaigg3lu1I3bA62FbvaOili--
