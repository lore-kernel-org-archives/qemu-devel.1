Received: from eggs.gnu.org ([2001:4830:134:3::10]:41268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dspFX-00042s-Af
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dspFU-0006bg-8m
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:57:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dspFT-0006bM-VI
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:57:32 -0400
Date: Fri, 15 Sep 2017 19:57:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170915115726.GJ17199@lemon>
References: <20170913030119.3957-1-famz@redhat.com>
	<20170913030119.3957-6-famz@redhat.com> <87wp508a5w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87wp508a5w.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 05/13] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Fri, 09/15 12:37, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > This is the common code to implement a "VM test" to
> >
> >   1) Download and initialize a pre-defined VM that has necessary
> >   dependencies to build QEMU and SSH access.
> >
> >   2) Archive $SRC_PATH to a .tar file.
> >
> >   3) Boot the VM, and pass the source tar file to the guest.
> >
> >   4) SSH into the VM, untar the source tarball, build from the source=
.
> >
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/vm/basevm.py | 256 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >  1 file changed, 256 insertions(+)
> >  create mode 100755 tests/vm/basevm.py
> >
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > new file mode 100755
> > index 0000000000..e4603f3fba
> > --- /dev/null
> > +++ b/tests/vm/basevm.py
> > @@ -0,0 +1,256 @@
> > +#!/usr/bin/env python
> > +#
> > +# VM testing base class
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
> > +import logging
> > +import time
> > +import datetime
> > +sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", =
"scripts"))
> > +from qemu import QEMUMachine
> > +import subprocess
> > +import hashlib
> > +import optparse
> > +import atexit
> > +import tempfile
> > +import shutil
> > +import multiprocessing
> > +import traceback
> > +
> > +SSH_KEY =3D open(os.path.join(od.path.dirname(__file__),
> > +               "..", "keys", "id_rsa")).read()
> > +SSH_PUB_KEY =3D open(os.path.join(od.path.dirname(__file__),
> > +                   "..", "keys", "id_rsa.pub")).read()
>=20
> Hmm I don't think this was tested:
>=20
> 12:35:56 [alex@zen:~/l/q/qemu.git] review/fam-vm-build-test-v7(+2/-2) =B1=
 make vm-build-netbsd
>         CHK version_gen.h
>     VM-IMAGE netbsd
> Traceback (most recent call last):
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/netbsd", line 17, in <mo=
dule>
>     import basevm
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 30, in =
<module>
>     SSH_KEY =3D open(os.path.join(od.path.dirname(__file__),
> NameError: name 'od' is not defined
> /home/alex/lsrc/qemu/qemu.git/tests/vm/Makefile.include:23: recipe for =
target 'tests/vm/netbsd.img' failed

Right, I tested the fixed version (s/od/os).

Fam
