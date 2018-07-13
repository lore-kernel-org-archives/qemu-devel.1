Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdsLu-0008FC-UU
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdsLZ-0006HO-UA
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:18:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fdsLZ-0006Dx-3w
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:18:33 -0400
Date: Fri, 13 Jul 2018 15:18:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180713071829.GB3916@lemon.usersys.redhat.com>
References: <20180712012829.20231-1-famz@redhat.com>
	<20180712012829.20231-5-famz@redhat.com>
	<c32cc2c7-3483-7b73-183d-485bec8987f2@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c32cc2c7-3483-7b73-183d-485bec8987f2@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] tests: Add centos VM testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, 07/12 12:02, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> On 07/11/2018 10:28 PM, Fam Zheng wrote:
> > This one does docker testing in the VM. It is intended to replace the
> > native docker testing on patchew testers.
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/vm/Makefile.include |  3 +-
> >  tests/vm/centos           | 84 +++++++++++++++++++++++++++++++++++++=
++
> >  2 files changed, 86 insertions(+), 1 deletion(-)
> >  create mode 100755 tests/vm/centos
> >=20
> > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > index 5daa2a3b73..af19b7a4e6 100644
> > --- a/tests/vm/Makefile.include
> > +++ b/tests/vm/Makefile.include
> > @@ -2,7 +2,7 @@
> > =20
> >  .PHONY: vm-build-all
> > =20
> > -IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd
> > +IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd centos
> >  IMAGE_FILES :=3D $(patsubst %, tests/vm/%.img, $(IMAGES))
> > =20
> >  .PRECIOUS: $(IMAGE_FILES)
> > @@ -14,6 +14,7 @@ vm-test:
> >  	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM=
"
> >  	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
> >  	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM=
"
> > +	@echo "  vm-build-centos                 - Build QEMU in CentOS VM,=
 with Docker"
> > =20
> >  vm-build-all: $(addprefix vm-build-, $(IMAGES))
> > =20
> > diff --git a/tests/vm/centos b/tests/vm/centos
> > new file mode 100755
> > index 0000000000..afd560c564
> > --- /dev/null
> > +++ b/tests/vm/centos
> > @@ -0,0 +1,84 @@
> > +#!/usr/bin/env python
> > +#
> > +# CentOS image
> > +#
> > +# Copyright 2018 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Fam Zheng <famz@redhat.com>
> > +#
> > +# This code is licensed under the GPL version 2 or later.  See
> > +# the COPYING file in the top-level directory.
> > +#
> > +
> > +import os
> > +import sys
> > +import subprocess
> > +import basevm
> > +import time
> > +
> > +class CentosVM(basevm.BaseVM):
> > +    name =3D "centos"
> > +    BUILD_SCRIPT =3D """
> > +        set -e;
> > +        cd $(mktemp -d);
> > +        export SRC_ARCHIVE=3D/dev/vdb;
> > +        sudo chmod a+r $SRC_ARCHIVE;
> > +        tar -xf $SRC_ARCHIVE;
> > +        make docker-test-block@centos7 V=3D{verbose} J=3D{jobs};
> > +        make docker-test-quick@centos7 V=3D{verbose} J=3D{jobs};
> > +        make docker-test-mingw@fedora V=3D{verbose} J=3D{jobs};
> > +    """
> > +
> > +    def _gen_cloud_init_iso(self):
> > +        cidir =3D self._tmpdir
> > +        mdata =3D open(os.path.join(cidir, "meta-data"), "w")
> > +        mdata.writelines(["instance-id: centos-vm-0\n",
> > +                          "local-hostname: centos-guest\n"])
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
> > +                          "    - %s\n" % basevm.SSH_PUB_KEY,
> > +                          "locale: en_US.UTF-8\n"])
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
> > +        cimg =3D self._download_with_cache("https://cloud.centos.org=
/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
> > +        img_tmp =3D img + ".tmp"
> > +        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
> > +        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
> > +        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"]=
)
> > +        self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud=
_init_iso()])
> > +        self.wait_ssh()
> > +        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>=20
> Here I had to add:
>=20
>   for k, v in os.environ.iteritems():
>       if k.lower() =3D=3D "http_proxy":
>           self.ssh_root_check("echo 'proxy=3D" + v + "' >> /etc/yum.con=
f")
>=20
> I understood we will fix this corporate firewall issue later in basevm,
> still I couldn't test your series without.

Could you test this patch?

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 25361c6b7d..4bc1a657d3 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -106,7 +106,10 @@ class BaseVM(object):
         if interactive:
             ssh_cmd +=3D ['-t']
         assert not isinstance(cmd, str)
-        ssh_cmd +=3D ["%s@127.0.0.1" % user] + list(cmd)
+        env_names =3D ['ftp_proxy', 'http_proxy', 'https_proxy']
+        envs =3D ["%s=3D%s" % (k, v) for k, v in os.environ.items() \
+                if k.lower() in env_names]
+        ssh_cmd +=3D ["%s@127.0.0.1" % user] + envs + list(cmd)
         logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
         r =3D subprocess.call(ssh_cmd)
         if check and r !=3D 0:
