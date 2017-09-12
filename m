Received: from eggs.gnu.org ([2001:4830:134:3::10]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1drYn3-0004hL-Gh
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1drYmy-00009z-EO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1drYmy-00009q-4k
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 20:10:52 -0400
Date: Tue, 12 Sep 2017 08:10:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170912001046.GF32341@lemon.lan>
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-5-famz@redhat.com>
	<87tw0dgqpv.fsf@linaro.org> <20170908232950.GD18677@lemon.lan>
	<874ls9bjlm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <874ls9bjlm.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/12] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com

On Mon, 09/11 11:44, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > On Fri, 09/08 16:22, Alex Benn=E9e wrote:
> >>
> >> Fam Zheng <famz@redhat.com> writes:
> >>
> >> > This is the common code to implement a "VM test" to
> >> >
> >> >   1) Download and initialize a pre-defined VM that has necessary
> >> >   dependencies to build QEMU and SSH access.
> >> >
> >> >   2) Archive $SRC_PATH to a .tar file.
> >> >
> >> >   3) Boot the VM, and pass the source tar file to the guest.
> >> >
> >> >   4) SSH into the VM, untar the source tarball, build from the sou=
rce.
> >> >
> >> > Signed-off-by: Fam Zheng <famz@redhat.com>
> >> > ---
> >> >  tests/vm/basevm.py | 276 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++++
> >> >  1 file changed, 276 insertions(+)
> >> >  create mode 100755 tests/vm/basevm.py
> >> >
> >> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> >> > new file mode 100755
> >> > index 0000000000..9db91d61fa
> >> > --- /dev/null
> >> > +++ b/tests/vm/basevm.py
> >> > @@ -0,0 +1,276 @@
> >> > +#!/usr/bin/env python
> >> > +#
> >> > +# VM testing base class
> >> > +#
> >> > +# Copyright (C) 2017 Red Hat Inc.
> >> > +#
> >> > +# Authors:
> >> > +#  Fam Zheng <famz@redhat.com>
> >> > +#
> >> > +# This work is licensed under the terms of the GNU GPL, version 2=
.  See
> >> > +# the COPYING file in the top-level directory.
> >> > +#
> >> > +
> >> > +import os
> >> > +import sys
> >> > +import logging
> >> > +import time
> >> > +import datetime
> >> > +sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..=
", "scripts"))
> >> > +from qemu import QEMUMachine
> >> > +import subprocess
> >> > +import hashlib
> >> > +import optparse
> >> > +import atexit
> >> > +import tempfile
> >> > +import shutil
> >> > +import multiprocessing
> >> > +import traceback
> >> > +
> >> > +SSH_KEY =3D """\
> >> > +-----BEGIN RSA PRIVATE KEY-----
> >> > +MIIEowIBAAKCAQEAopAuOlmLV6LVHdFBj8/eeOwI9CqguIJPp7eAQSZvOiB4Ag/R
> >> > +coEhl/RBbrV5Yc/SmSD4PTpJO/iM10RwliNjDb4a3I8q3sykRJu9c9PI/YsH8WN9
> >> > ++NH2NjKPtJIcKTu287IM5JYxyB6nDoOzILbTyJ1TDR/xH6qYEfBAyiblggdjcvhA
> >> > +RTf93QIn39F/xLypXvT1K2O9BJEsnJ8lEUvB2UXhKo/JTfSeZF8wPBeowaP9EONk
> >> > +7b+nuJOWHGg68Ji6wVi62tjwl2Szch6lxIhZBpnV7QNRKMfYHP6eIyF4pusazzZq
> >> > +Telsq6xI2ghecWLzb/MF5A+rklsGx2FNuJSAJwIDAQABAoIBAHHi4o/8VZNivz0x
> >> > +cWXn8erzKV6tUoWQvW85Lj/2RiwJvSlsnYZDkx5af1CpEE2HA/pFT8PNRqsd+MWC
> >> > +7AEy710cVsM4BYerBFYQaYxwzblaoojo88LSjVPw3h5Z0iLM8+IMVd36nwuc9dpE
> >> > +R8TecMZ1+U4Tl6BgqkK+9xToZRdPKdjS8L5MoFhGN+xY0vRbbJbGaV9Q0IHxLBkB
> >> > +rEBV7T1mUynneCHRUQlJQEwJmKpT8MH3IjsUXlG5YvnuuvcQJSNTaW2iDLxuOKp8
> >> > +cxW8+qL88zpb1D5dppoIu6rlrugN0azSq70ruFJQPc/A8GQrDKoGgRQiagxNY3u+
> >> > +vHZzXlECgYEA0dKO3gfkSxsDBb94sQwskMScqLhcKhztEa8kPxTx6Yqh+x8/scx3
> >> > +XhJyOt669P8U1v8a/2Al+s81oZzzfQSzO1Q7gEwSrgBcRMSIoRBUw9uYcy02ngb/
> >> > +j/ng3DGivfJztjjiSJwb46FHkJ2JR8mF2UisC6UMXk3NgFY/3vWQx78CgYEAxlcG
> >> > +T3hfSWSmTgKRczMJuHQOX9ULfTBIqwP5VqkkkiavzigGRirzb5lgnmuTSPTpF0LB
> >> > +XVPjR2M4q+7gzP0Dca3pocrvLEoxjwIKnCbYKnyyvnUoE9qHv4Kr+vDbgWpa2LXG
> >> > +JbLmE7tgTCIp20jOPPT4xuDvlbzQZBJ5qCQSoZkCgYEAgrotSSihlCnAOFSTXbu4
> >> > +CHp3IKe8xIBBNENq0eK61kcJpOxTQvOha3sSsJsU4JAM6+cFaxb8kseHIqonCj1j
> >> > +bhOM/uJmwQJ4el/4wGDsbxriYOBKpyq1D38gGhDS1IW6kk3erl6VAb36WJ/OaGum
> >> > +eTpN9vNeQWM4Jj2WjdNx4QECgYAwTdd6mU1TmZCrJRL5ZG+0nYc2rbMrnQvFoqUi
> >> > +BvWiJovggHzur90zy73tNzPaq9Ls2FQxf5G1vCN8NCRJqEEjeYCR59OSDMu/EXc2
> >> > +CnvQ9SevHOdS1oEDEjcCWZCMFzPi3XpRih1gptzQDe31uuiHjf3cqcGPzTlPdfRt
> >> > +D8P92QKBgC4UaBvIRwREVJsdZzpIzm224Bpe8LOmA7DeTnjlT0b3lkGiBJ36/Q0p
> >> > +VhYh/6cjX4/iuIs7gJbGon7B+YPB8scmOi3fj0+nkJAONue1mMfBNkba6qQTc6Y2
> >> > +5mEKw2/O7/JpND7ucU3OK9plcw/qnrWDgHxl0Iz95+OzUIIagxne
> >> > +-----END RSA PRIVATE KEY-----
> >> > +"""
> >> > +SSH_PUB_KEY =3D """\
> >> > +ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCikC46WYtXotUd0UGPz9547Aj0K=
qC4gk+nt4BBJm86IHgCD9FygSGX9EFutXlhz9KZIPg9Okk7+IzXRHCWI2MNvhrcjyrezKREm7=
1z08j9iwfxY3340fY2Mo+0khwpO7bzsgzkljHIHqcOg7MgttPInVMNH/EfqpgR8EDKJuWCB2N=
y+EBFN/3dAiff0X/EvKle9PUrY70EkSycnyURS8HZReEqj8lN9J5kXzA8F6jBo/0Q42Ttv6e4=
k5YcaDrwmLrBWLra2PCXZLNyHqXEiFkGmdXtA1Eox9gc/p4jIXim6xrPNmpN6WyrrEjaCF5xY=
vNv8wXkD6uSWwbHYU24lIAn qemu-vm-key
> >> > +"""
> >>
> >> I'm not sure we should be embedding the keys in the script. I unders=
tand
> >> we need a common key for downloaded images (although it would be bet=
ter
> >> to post-customise the image after download with the local developer
> >> keys). Perhaps ./tests/testing-keys/id_rsa[.pub]?
> >
> > We cannot generate keys or start from local keys because it's hard to=
 inject it
> > into the *BSD images without ssh access (chicken-and-egg problem). Ad=
ding the
> > local keys might be a good feature, indeed.
>=20
> Can't libguestfs be used to manipulate the image without booting BSD
> itself?

No, not working for BSD.

>=20
> Regardless I still think having the key embedded in the script rather
> than in files in the source tree is overly ugly.

OK, I can move it out.

> >>
> >> > +            "-device", "virtio-net-pci,netdev=3Dvnet",
> >> > +            "-vnc", ":0,to=3D20",
> >>
> >> Do we need a GUI?
> >
> > I'd like to keep it, it helps when you need to diagnose.
>=20
> As long it runs or fails cleanly when run on a on terminal.

I believe so.

> > In your case which qemu version are you using? If not master it proba=
bly is
> > failing because of the hostfwd syntax.
>=20
> Nope, built on master (fcea73709b966a7ded9efa7b106ea50c7fe9025c). As I
> say I need a cleaner error message to diagnose why it failed.

I mean the QEMU binary this script finds in $PATH: it invokes
"qemu-system-x86_64" command, not the built QEMU. This is overrideable by
setting QEMU=3D env.

Anyway I'll try to improve the error message.

Fam
