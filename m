Received: from eggs.gnu.org ([209.51.188.92]:54356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmiJ6-00054p-4k
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmiFY-0004Ut-Vw
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:53:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmiFY-0004Ti-N0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:53:08 -0500
Date: Thu, 24 Jan 2019 16:52:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190124165253.GT7953@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
	<ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
	<f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
	<4bf0c77e-ea8f-1813-a6a4-6ab6eb857cd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bf0c77e-ea8f-1813-a6a4-6ab6eb857cd0@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Kamil Rytarowski <n54@gmx.com>, Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com

On Thu, Jan 24, 2019 at 05:10:19PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 1/24/19 4:56 PM, Kamil Rytarowski wrote:
> > On 24.01.2019 16:52, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 8/16/17 9:21 AM, Fam Zheng wrote:
> >>> The image is prepared following instructions as in:
> >>>
> >>> https://wiki.qemu.org/Hosts/BSD
> >>>
> >>> Signed-off-by: Fam Zheng <famz@redhat.com>
> >>> ---
> >>>  tests/vm/openbsd | 45 ++++++++++++++++++++++++++++++++++++++++++++=
+
> >>>  1 file changed, 45 insertions(+)
> >>>  create mode 100755 tests/vm/openbsd
> >>>
> >>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> >>> new file mode 100755
> >>> index 0000000000..d37ff83a59
> >>> --- /dev/null
> >>> +++ b/tests/vm/openbsd
> >>> @@ -0,0 +1,45 @@
> >>> +#!/usr/bin/env python
> >>> +#
> >>> +# OpenBSD VM image
> >>> +#
> >>> +# Copyright (C) 2017 Red Hat Inc.
> >>> +#
> >>> +# Authors:
> >>> +#  Fam Zheng <famz@redhat.com>
> >>> +#
> >>> +# This work is licensed under the terms of the GNU GPL, version 2.=
  See
> >>> +# the COPYING file in the top-level directory.
> >>> +#
> >>> +
> >>> +import os
> >>> +import sys
> >>> +import logging
> >>> +import subprocess
> >>> +import tempfile
> >>> +import time
> >>> +import basevm
> >>> +
> >>> +class OpenBSDVM(basevm.BaseVM):
> >>> +    name =3D "openbsd"
> >>> +    BUILD_SCRIPT =3D """
> >>> +        set -e;
> >>> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> >>> +        tar -xf /dev/rsd1c;
> >>> +        ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --p=
ython=3Dpython2.7 {configure_opts};
> >>> +        gmake -j{jobs};
> >>> +        # XXX: "gmake check" seems to always hang or fail
> >>> +        #gmake check;
> >>
> >> OK, Now it makes more sense...
> >>
> >> After spending various hours trying to fix various issues on OpenBSD=
, I
> >> notice that we never ran tests on this OS.
> >> The only binary I can run is qemu-img, the rest seems useless.
> >> I'll summarize in a different thread.
> >>
> >=20
> > Is this W^X related?
>=20
> Part of it could be but I'm not sure.
>=20
> The 6.1 VM provided by Fam has /usr/local mounted with wxallowed, I
> tried building/running there and nothing changed, mmap() still returns
> ENOTSUP:

ENOTSUP from mmap is certainly what you'd expect from the W^X  scenario

  https://undeadly.org/cgi?action=3Darticle&sid=3D20160527203200

 "W^X violations are no longer permitted by default.  A kernel log messag=
e
  is generated, and mprotect/mmap return ENOTSUP.  If the sysctl(8) flag
  kern.wxabort is set then a SIGABRT occurs instead, for gdb use or cored=
ump
  creation."


> Since the current script build into /var/tmp (which is symlinked to
> /tmp) I also mounted /tmp wxallowed using the following patch:
>=20
> -- >8 --
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -39,6 +39,12 @@ class OpenBSDVM(basevm.BaseVM):
>          if os.path.exists(img):
>              os.rename(img_tmp, img)
> +        self.boot(img)
> +        self.wait_ssh()
> +        self.ssh_root_check("sed -E -i 's_(/tmp\ ffs)\ ([^\ ]*)_\\1
> \\2,wxallowed_' /etc/fstab")
> +        self.ssh_root_check("cat /etc/fstab")
> +        self.ssh_root("halt -p")
> +        self.wait()
> ---
>=20
> $ mount
> /dev/sd0a on / type ffs (local)
> /dev/sd0k on /home type ffs (local, nodev, nosuid)
> /dev/sd0d on /tmp type ffs (local, nodev, nosuid, wxallowed)
> /dev/sd0f on /usr type ffs (local, nodev)
> /dev/sd0g on /usr/X11R6 type ffs (local, nodev)
> /dev/sd0h on /usr/local type ffs (local, nodev, wxallowed)
> /dev/sd0j on /usr/obj type ffs (local, nodev, nosuid)
> /dev/sd0i on /usr/src type ffs (local, nodev, nosuid)
> /dev/sd0e on /var type ffs (local, nodev, nosuid)
>=20
> Still no progress.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
