Received: from eggs.gnu.org ([209.51.188.92]:60146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gpCoK-0003G4-Np
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gpCoJ-0006vQ-1R
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:55:20 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-6-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <17c4d1e9-b837-1931-1ddf-fafaf075a902@redhat.com>
Date: Thu, 31 Jan 2019 11:55:04 -0200
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-6-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/18] Acceptance tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Cleber,

On 01/17/2019 04:56 PM, Cleber Rosa wrote:
> It's useful to define the architecture that should be used in
> situations such as:
>   * the intended target of the QEMU binary to be used on tests
>   * the architecture of code to be run within the QEMU binary, such
>     as a kernel image or a full blown guest OS image
>
> This commit introduces both a test parameter and a test instance
> attribute, that will contain such a value.
>
> Now, when the "arch" test parameter is given, it will influence the
> selection of the default QEMU binary, if one is not given explicitly
> by means of the "qemu_img" parameter.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   docs/devel/testing.rst                    | 18 ++++++++++++++++++
>   tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>   2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 44c9b3ae74..60a16c5834 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -689,6 +689,17 @@ vm
>   A QEMUMachine instance, initially configured according to the given
>   ``qemu_bin`` parameter.
>  =20
> +arch
> +~~~~
> +
> +The architecture that will be used on a number of different
> +scenarios.  For instance, when a QEMU binary is not explicitly given,
> +the one selected will depend on this attribute.
> +
> +The ``arch`` attribute will be set to the test parameter of the same
> +name, and if one is not given explicitly, it will default to the
> +system architecture (as given by ``uname``).

Unless I'm missing something, the arch attribute will be None if I don't=20
pass the arch parameter nor set the arch tag.

------
[root@xxx qemu]# cat tests/acceptance/arch.py
from avocado_qemu import Test

class Arch(Test):
 =C2=A0=C2=A0=C2=A0 """
 =C2=A0=C2=A0=C2=A0 :avocado: enable
 =C2=A0=C2=A0=C2=A0 """
 =C2=A0=C2=A0=C2=A0 def test(self):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(self.arch, "=
x86_64")
[root@xxx qemu]# ./tests/venv/bin/avocado run tests/acceptance/arch.py
JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : 032aabb8ec2364944d0e29df3b61931b42f4587c
JOB LOG=C2=A0=C2=A0=C2=A0 : /root/avocado/job-results/job-2019-01-31T08.4=
2-032aabb/job.log
 =C2=A0(1/1) tests/acceptance/arch.py:Arch.test: FAIL: None !=3D 'x86_64'=
 (0.03 s)
RESULTS=C2=A0=C2=A0=C2=A0 : PASS 0 | ERROR 0 | FAIL 1 | SKIP 0 | WARN 0 |=
 INTERRUPT 0 |=20
CANCEL 0
JOB TIME=C2=A0=C2=A0 : 0.20 s
[root@xxx qemu]# ./tests/venv/bin/avocado run -p arch=3Dx86_64=20
tests/acceptance/arch.py
JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : 1913a73510cab4b6b118bd7e94e2746011368628
JOB LOG=C2=A0=C2=A0=C2=A0 : /root/avocado/job-results/job-2019-01-31T08.4=
2-1913a73/job.log
 =C2=A0(1/1) tests/acceptance/arch.py:Arch.test: PASS (0.01 s)
RESULTS=C2=A0=C2=A0=C2=A0 : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 |=
 INTERRUPT 0 |=20
CANCEL 0
JOB TIME=C2=A0=C2=A0 : 0.19 s
[root@xxx qemu]# cat tests/acceptance/arch_tag.py
from avocado_qemu import Test

class Arch(Test):
 =C2=A0=C2=A0=C2=A0 """
 =C2=A0=C2=A0=C2=A0 :avocado: enable
 =C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:x86_64
 =C2=A0=C2=A0=C2=A0 """
 =C2=A0=C2=A0=C2=A0 def test(self):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(self.arch, "=
x86_64")
[root@xxx qemu]# ./tests/venv/bin/avocado run tests/acceptance/arch_tag.p=
y
JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : bc85be065586b8e9cf371489e1801489910e41b0
JOB LOG=C2=A0=C2=A0=C2=A0 : /root/avocado/job-results/job-2019-01-31T08.4=
3-bc85be0/job.log
 =C2=A0(1/1) tests/acceptance/arch_tag.py:Arch.test: PASS (0.01 s)
RESULTS=C2=A0=C2=A0=C2=A0 : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 |=
 INTERRUPT 0 |=20
CANCEL 0
JOB TIME=C2=A0=C2=A0 : 0.19 s
------

- Wainer

> +
>   qemu_bin
>   ~~~~~~~~
>  =20
> @@ -711,6 +722,13 @@ like the following:
>  =20
>     PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-sys=
tem-x86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
>  =20
> +arch
> +~~~~
> +
> +The architecture that will be used on a number of different scenarios.
> +This parameter has a direct relation with the ``arch`` attribute.  If
> +not given, it will default to None.
> +
>   qemu_bin
>   ~~~~~~~~
>  =20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> index d8d5b48dac..7a38851753 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
>       return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK=
)
>  =20
>  =20
> -def pick_default_qemu_bin():
> +def pick_default_qemu_bin(arch=3DNone):
>       """
>       Picks the path of a QEMU binary, starting either in the current w=
orking
>       directory or in the source tree root directory.
>  =20
> +    :param arch: the arch to use when looking for a QEMU binary (the t=
arget
> +                 will match the arch given).  If None (the default) ar=
ch
> +                 will be the current host system arch (as given by
> +                 :func:`os.uname`).
> +    :type arch: str
>       :returns: the path to the default QEMU binary or None if one coul=
d not
>                 be found
>       :rtype: str or None
>       """
> -    arch =3D os.uname()[4]
> +    if arch is None:
> +        arch =3D os.uname()[4]
>       qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>                                             "qemu-system-%s" % arch)
>       if is_readable_executable_file(qemu_bin_relative_path):
> @@ -47,8 +53,9 @@ def pick_default_qemu_bin():
>   class Test(avocado.Test):
>       def setUp(self):
>           self.vm =3D None
> +        self.arch =3D self.params.get('arch')
>           self.qemu_bin =3D self.params.get('qemu_bin',
> -                                        default=3Dpick_default_qemu_bi=
n())
> +                                        default=3Dpick_default_qemu_bi=
n(self.arch))
>           if self.qemu_bin is None:
>               self.cancel("No QEMU binary defined or found in the sourc=
e tree")
>           self.vm =3D QEMUMachine(self.qemu_bin)
