Received: from eggs.gnu.org ([209.51.188.92]:52836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Ue0-0006Xd-Kj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3UTg-0002eK-T5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:37:05 -0400
Date: Mon, 11 Mar 2019 19:28:07 -0400
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190311232807.zzuhkkp2go7fw7o3@localhost.localdomain>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-6-crosa@redhat.com>
	<20190301112710.3563c30f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190301112710.3563c30f.cohuck@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/20] Acceptance tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Fri, Mar 01, 2019 at 11:27:10AM +0100, Cornelia Huck wrote:
> On Wed, 20 Feb 2019 19:57:38 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
>=20
> > It's useful to define the architecture that should be used in
> > situations such as:
> >  * the intended target of the QEMU binary to be used on tests
> >  * the architecture of code to be run within the QEMU binary, such
> >    as a kernel image or a full blown guest OS image
> >=20
> > This commit introduces both a test parameter and a test instance
> > attribute, that will contain such a value.
> >=20
> > Now, when the "arch" test parameter is given, it will influence the
> > selection of the default QEMU binary, if one is not given explicitly
> > by means of the "qemu_img" parameter.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >  docs/devel/testing.rst                    | 28 +++++++++++++++++++++=
++
> >  tests/acceptance/avocado_qemu/__init__.py | 14 +++++++++---
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> > index ceaaafc69f..6035db1b44 100644
> > --- a/docs/devel/testing.rst
> > +++ b/docs/devel/testing.rst
> > @@ -689,6 +689,21 @@ vm
> >  A QEMUMachine instance, initially configured according to the given
> >  ``qemu_bin`` parameter.
> > =20
> > +arch
> > +~~~~
> > +
> > +The architecture can be used on different levels of the stack, e.g. =
by
> > +the framework or by the test itself.  At the framework level, it wil=
l
> > +will currently influence the selection of a QEMU binary (when one is
>=20
> s/will will/will/

Thanks for spotting this!

>=20
> > +not explicitly given).
> > +
> > +Tests are also free to use this attribute value, for their own needs=
.
> > +A test may, for instance, use the same value when selecting the
> > +architecture of a kernel or disk image to boot a VM with.
> > +
> > +The ``arch`` attribute will be set to the test parameter of the same
> > +name, and if one is not given explicitly, it will be set to ``None``=
.
> > +
> >  qemu_bin
> >  ~~~~~~~~
> > =20
> > @@ -711,6 +726,19 @@ like the following:
> > =20
> >    PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-sy=
stem-x86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
> > =20
> > +arch
> > +~~~~
> > +
> > +The architecture that will influence the selection of a QEMU binary
> > +(when one is not explicitly given).
> > +
> > +Tests are also free to use this parameter value, for their own needs=
.
> > +A test may, for instance, use the same value when selecting the
> > +architecture of a kernel or disk image to boot a VM with.
> > +
> > +This parameter has a direct relation with the ``arch`` attribute.  I=
f
> > +not given, it will default to None.
> > +
> >  qemu_bin
> >  ~~~~~~~~
> > =20
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accept=
ance/avocado_qemu/__init__.py
> > index d8d5b48dac..f580582602 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
> >      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_O=
K)
> > =20
> > =20
> > -def pick_default_qemu_bin():
> > +def pick_default_qemu_bin(arch=3DNone):
> >      """
> >      Picks the path of a QEMU binary, starting either in the current =
working
> >      directory or in the source tree root directory.
> > =20
> > +    :param arch: the arch to use when looking for a QEMU binary (the=
 target
> > +                 will match the arch given).  If None (the default) =
arch
>=20
> s/None (the default)/None (the default),/ makes that sentence less
> confusing :)
>=20

Good point, thanks!

- Cleber.
