Received: from eggs.gnu.org ([2001:4830:134:3::10]:56953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3A8-0008BQ-Bb
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3A3-0001Pp-I8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp3A3-0001PO-8d
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:00:19 -0400
Date: Tue, 5 Sep 2017 10:00:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905020013.GA22515@lemon.lan>
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-6-famz@redhat.com>
	<2f969c4b-7568-5692-2763-21d1259981e9@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2f969c4b-7568-5692-2763-21d1259981e9@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/12] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Fri, 09/01 16:50, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> On 08/31/2017 03:42 AM, Fam Zheng wrote:
> > This adds a 32bit guest.
> >=20
> > The official LTS cloud image is downloaded and initialized with
> > cloud-init.
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   tests/vm/ubuntu.i386 | 88 +++++++++++++++++++++++++++++++++++++++++=
+++++++++++
> >   1 file changed, 88 insertions(+)
> >   create mode 100755 tests/vm/ubuntu.i386
> >=20
> > diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> > new file mode 100755
> > index 0000000000..1a55856d9c
> > --- /dev/null
> > +++ b/tests/vm/ubuntu.i386
> > @@ -0,0 +1,88 @@
> > +#!/usr/bin/env python
> > +#
> > +# Ubuntu i386 image
> > +#
> > +# Copyright (C) 2017 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Fam Zheng <famz@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.  =
See
> > +# the COPYING file in the top-level directory.
> > +#
> > +
> > +import os
> > +import sys
> > +import subprocess
> > +import basevm
> > +import time
> > +
> > +class UbuntuX86VM(basevm.BaseVM):
> > +    name =3D "ubuntu.i386"
> > +    BUILD_SCRIPT =3D """
> > +        set -e;
> > +        cd $(mktemp -d);
> > +        sudo chmod a+r /dev/vdb;
> > +        tar -xf /dev/vdb;
> > +        ./configure {configure_opts};
> > +        make -j{jobs};
> > +        make check;
> > +    """
> > +
> > +    def _gen_cloud_init_iso(self):
> > +        cidir =3D self._tmpdir
> > +        mdata =3D open(os.path.join(cidir, "meta-data"), "w")
> > +        mdata.writelines(["instance-id: ubuntu-vm-0\n",
> > +                         "local-hostname: ubuntu-guest\n"])
> > +        mdata.close()
> > +        udata =3D open(os.path.join(cidir, "user-data"), "w")
> > +        udata.writelines(["#cloud-config\n",
> > +                          "chpasswd:\n",
> > +                          "  list: |\n",
> > +                          "    root:%s\n" % self.ROOT_PASS,
> > +                          "    %s:%s\n" % (self.GUEST_USER, self.GUE=
ST_PASS),
> > +                          "  expire: False\n",
> > +                          "users:\n",
> > +                          "  - name: %s\n" % self.GUEST_USER,
> > +                          "    sudo: ALL=3D(ALL) NOPASSWD:ALL\n",
> > +                          "    ssh-authorized-keys:\n",
> > +                          "    - %s\n" % basevm.SSH_PUB_KEY,
> > +                          "  - name: root\n",
> > +                          "    ssh-authorized-keys:\n",
> > +                          "    - %s\n" % basevm.SSH_PUB_KEY])
> > +        udata.close()
> > +        subprocess.check_call(["genisoimage", "-output", "cloud-init=
.iso",
> > +                               "-volid", "cidata", "-joliet", "-rock=
",
> > +                               "user-data", "meta-data"],
> > +                               cwd=3Dcidir,
> > +                               stdin=3Dself._devnull, stdout=3Dself.=
_stdout,
> > +                               stderr=3Dself._stdout)
> > +        return os.path.join(cidir, "cloud-init.iso")
> > +
> > +    def build_image(self, img):
> > +        cimg =3D self._download_with_cache("https://cloud-images.ubu=
ntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-i386-disk1.im=
g")
> > +        img_tmp =3D img + ".tmp"
> > +        subprocess.check_call(["cp", "-f", cimg, img_tmp])
> > +        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"]=
)
> > +        self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud=
_init_iso()])
>=20
> I'd rather test a 32bit cpu, not 64bit cpu in 32bit mode.
>=20
> I first tested with "-cpu pentium2" which worked, I then find it easier=
 this
> way:
>=20
> if /dev/kvm: "kvm32"
> else: "qemu32"
>=20
> What do you think?

No, I don't think so, I'm not testing the cpu emulation here. Let's focus=
 on the
test subject which is what happens in the guest, not how it is emulated, =
as long
as it works.

Fam
