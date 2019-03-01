Received: from eggs.gnu.org ([209.51.188.92]:49348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzfO2-0007fR-Fn
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzfO1-0006gT-FD
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:27:26 -0500
Date: Fri, 1 Mar 2019 11:27:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190301112710.3563c30f.cohuck@redhat.com>
In-Reply-To: <20190221005753.27955-6-crosa@redhat.com>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-6-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Wed, 20 Feb 2019 19:57:38 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> It's useful to define the architecture that should be used in
> situations such as:
>  * the intended target of the QEMU binary to be used on tests
>  * the architecture of code to be run within the QEMU binary, such
>    as a kernel image or a full blown guest OS image
>=20
> This commit introduces both a test parameter and a test instance
> attribute, that will contain such a value.
>=20
> Now, when the "arch" test parameter is given, it will influence the
> selection of the default QEMU binary, if one is not given explicitly
> by means of the "qemu_img" parameter.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  docs/devel/testing.rst                    | 28 +++++++++++++++++++++++
>  tests/acceptance/avocado_qemu/__init__.py | 14 +++++++++---
>  2 files changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index ceaaafc69f..6035db1b44 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -689,6 +689,21 @@ vm
>  A QEMUMachine instance, initially configured according to the given
>  ``qemu_bin`` parameter.
> =20
> +arch
> +~~~~
> +
> +The architecture can be used on different levels of the stack, e.g. by
> +the framework or by the test itself.  At the framework level, it will
> +will currently influence the selection of a QEMU binary (when one is

s/will will/will/

> +not explicitly given).
> +
> +Tests are also free to use this attribute value, for their own needs.
> +A test may, for instance, use the same value when selecting the
> +architecture of a kernel or disk image to boot a VM with.
> +
> +The ``arch`` attribute will be set to the test parameter of the same
> +name, and if one is not given explicitly, it will be set to ``None``.
> +
>  qemu_bin
>  ~~~~~~~~
> =20
> @@ -711,6 +726,19 @@ like the following:
> =20
>    PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-system=
-x86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
> =20
> +arch
> +~~~~
> +
> +The architecture that will influence the selection of a QEMU binary
> +(when one is not explicitly given).
> +
> +Tests are also free to use this parameter value, for their own needs.
> +A test may, for instance, use the same value when selecting the
> +architecture of a kernel or disk image to boot a VM with.
> +
> +This parameter has a direct relation with the ``arch`` attribute.  If
> +not given, it will default to None.
> +
>  qemu_bin
>  ~~~~~~~~
> =20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index d8d5b48dac..f580582602 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
> =20
> =20
> -def pick_default_qemu_bin():
> +def pick_default_qemu_bin(arch=3DNone):
>      """
>      Picks the path of a QEMU binary, starting either in the current work=
ing
>      directory or in the source tree root directory.
> =20
> +    :param arch: the arch to use when looking for a QEMU binary (the tar=
get
> +                 will match the arch given).  If None (the default) arch

s/None (the default)/None (the default),/ makes that sentence less
confusing :)

> +                 will be the current host system arch (as given by
> +                 :func:`os.uname`).
> +    :type arch: str
>      :returns: the path to the default QEMU binary or None if one could n=
ot
>                be found
>      :rtype: str or None
>      """
> -    arch =3D os.uname()[4]
> +    if arch is None:
> +        arch =3D os.uname()[4]
>      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>                                            "qemu-system-%s" % arch)
>      if is_readable_executable_file(qemu_bin_relative_path):
> @@ -47,8 +53,10 @@ def pick_default_qemu_bin():
>  class Test(avocado.Test):
>      def setUp(self):
>          self.vm =3D None
> +        self.arch =3D self.params.get('arch')
> +        default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>          self.qemu_bin =3D self.params.get('qemu_bin',
> -                                        default=3Dpick_default_qemu_bin(=
))
> +                                        default=3Ddefault_qemu_bin)
>          if self.qemu_bin is None:
>              self.cancel("No QEMU binary defined or found in the source t=
ree")
>          self.vm =3D QEMUMachine(self.qemu_bin)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
