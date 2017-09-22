Received: from eggs.gnu.org ([2001:4830:134:3::10]:42611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvGYW-000528-0l
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 01:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvGYS-0006wd-R6
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 01:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvGYS-0006wJ-LQ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 01:31:12 -0400
Date: Fri, 22 Sep 2017 13:31:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922053107.GF1397@lemon.lan>
References: <20170921150755.19914-1-famz@redhat.com>
	<20170921150755.19914-8-famz@redhat.com>
	<2ea507f1-3ff3-54e9-2fbf-d69c727de5c6@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2ea507f1-3ff3-54e9-2fbf-d69c727de5c6@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 07/13] tests: Add FreeBSD image
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

On Fri, 09/22 00:17, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> On 09/21/2017 12:07 PM, Fam Zheng wrote:
> > The image is prepared following instructions as in:
> >=20
> > https://wiki.qemu.org/Hosts/BSD
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   tests/vm/freebsd | 42 ++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> >   create mode 100755 tests/vm/freebsd
> >=20
> > diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> > new file mode 100755
> > index 0000000000..039dad8f69
> > --- /dev/null
> > +++ b/tests/vm/freebsd
> > @@ -0,0 +1,42 @@
> > +#!/usr/bin/env python
> > +#
> > +# FreeBSD VM image
> > +#
> > +# Copyright 2017 Red Hat Inc.
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
> > +
> > +class FreeBSDVM(basevm.BaseVM):
> > +    name =3D "freebsd"
> > +    BUILD_SCRIPT =3D """
> > +        set -e;
> > +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> > +        tar -xf /dev/vtbd1;
> > +        ./configure {configure_opts};
> > +        gmake -j{jobs};
> > +        gmake check;
> > +    """
> > +
> > +    def build_image(self, img):
> > +        cimg =3D self._download_with_cache("http://download.patchew.=
org/freebsd-11.1-amd64.img.xz",
> > +                sha256sum=3D'adcb771549b37bc63826c501f05121a206ed3d9=
f55f49145908f7e1432d65891')
> > +        img_tmp_xz =3D img + ".tmp.xz"
> > +        img_tmp =3D img + ".tmp"
> > +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
>=20
> I'd rather see this part common to 3 images refactored as @static
> BaseVM.download_and_extract_image() and some logging:
>=20
>         logging.debug("Extracting %s...", fname)
>=20
> > +        subprocess.check_call(["xz", "-df", img_tmp_xz])
>=20
> else one wonder what's happening here.
>=20
> (for another patch on top on this series)

Yep, that sounds good.

Fam
