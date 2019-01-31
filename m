Received: from eggs.gnu.org ([209.51.188.92]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpHas-0001qc-7Q
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpHaq-0000Nb-Qk
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:01:46 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-6-crosa@redhat.com>
	<17c4d1e9-b837-1931-1ddf-fafaf075a902@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <418df945-3e0e-a160-c68e-bd1c24168717@redhat.com>
Date: Thu, 31 Jan 2019 14:01:32 -0500
MIME-Version: 1.0
In-Reply-To: <17c4d1e9-b837-1931-1ddf-fafaf075a902@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>



On 1/31/19 8:55 AM, Wainer dos Santos Moschetta wrote:
> Hi Cleber,
>=20
> On 01/17/2019 04:56 PM, Cleber Rosa wrote:
>> It's useful to define the architecture that should be used in
>> situations such as:
>> =C2=A0 * the intended target of the QEMU binary to be used on tests
>> =C2=A0 * the architecture of code to be run within the QEMU binary, su=
ch
>> =C2=A0=C2=A0=C2=A0 as a kernel image or a full blown guest OS image
>>
>> This commit introduces both a test parameter and a test instance
>> attribute, that will contain such a value.
>>
>> Now, when the "arch" test parameter is given, it will influence the
>> selection of the default QEMU binary, if one is not given explicitly
>> by means of the "qemu_img" parameter.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 docs/devel/testing.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 18 ++++++++++++++++++
>> =C2=A0 tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>> =C2=A0 2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 44c9b3ae74..60a16c5834 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -689,6 +689,17 @@ vm
>> =C2=A0 A QEMUMachine instance, initially configured according to the g=
iven
>> =C2=A0 ``qemu_bin`` parameter.
>> =C2=A0 +arch
>> +~~~~
>> +
>> +The architecture that will be used on a number of different
>> +scenarios.=C2=A0 For instance, when a QEMU binary is not explicitly g=
iven,
>> +the one selected will depend on this attribute.
>> +
>> +The ``arch`` attribute will be set to the test parameter of the same
>> +name, and if one is not given explicitly, it will default to the
>> +system architecture (as given by ``uname``).
>=20
> Unless I'm missing something, the arch attribute will be None if I don'=
t
> pass the arch parameter nor set the arch tag.
>=20

I think you're not missing anything, but I was.  Thanks for catching that=
.

- Cleber.

> ------
> [root@xxx qemu]# cat tests/acceptance/arch.py
> from avocado_qemu import Test
>=20
> class Arch(Test):
> =C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0 :avocado: enable
> =C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0 def test(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(self.arch, =
"x86_64")
> [root@xxx qemu]# ./tests/venv/bin/avocado run tests/acceptance/arch.py
> JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : 032aabb8ec2364944d0e29df3b61931b42f458=
7c
> JOB LOG=C2=A0=C2=A0=C2=A0 : /root/avocado/job-results/job-2019-01-31T08=
.42-032aabb/job.log
> =C2=A0(1/1) tests/acceptance/arch.py:Arch.test: FAIL: None !=3D 'x86_64=
' (0.03 s)
> RESULTS=C2=A0=C2=A0=C2=A0 : PASS 0 | ERROR 0 | FAIL 1 | SKIP 0 | WARN 0=
 | INTERRUPT 0 |
> CANCEL 0
> JOB TIME=C2=A0=C2=A0 : 0.20 s
> [root@xxx qemu]# ./tests/venv/bin/avocado run -p arch=3Dx86_64
> tests/acceptance/arch.py
> JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : 1913a73510cab4b6b118bd7e94e27460113686=
28
> JOB LOG=C2=A0=C2=A0=C2=A0 : /root/avocado/job-results/job-2019-01-31T08=
.42-1913a73/job.log
> =C2=A0(1/1) tests/acceptance/arch.py:Arch.test: PASS (0.01 s)
> RESULTS=C2=A0=C2=A0=C2=A0 : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0=
 | INTERRUPT 0 |
> CANCEL 0
> JOB TIME=C2=A0=C2=A0 : 0.19 s
> [root@xxx qemu]# cat tests/acceptance/arch_tag.py
> from avocado_qemu import Test
>=20
> class Arch(Test):
> =C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0 :avocado: enable
> =C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:x86_64
> =C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0 def test(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(self.arch, =
"x86_64")
> [root@xxx qemu]# ./tests/venv/bin/avocado run tests/acceptance/arch_tag=
.py
> JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : bc85be065586b8e9cf371489e1801489910e41=
b0
> JOB LOG=C2=A0=C2=A0=C2=A0 : /root/avocado/job-results/job-2019-01-31T08=
.43-bc85be0/job.log
> =C2=A0(1/1) tests/acceptance/arch_tag.py:Arch.test: PASS (0.01 s)
> RESULTS=C2=A0=C2=A0=C2=A0 : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0=
 | INTERRUPT 0 |
> CANCEL 0
> JOB TIME=C2=A0=C2=A0 : 0.19 s
> ------
>=20
> - Wainer
>=20
>> +
>> =C2=A0 qemu_bin
>> =C2=A0 ~~~~~~~~
>> =C2=A0 @@ -711,6 +722,13 @@ like the following:
>> =C2=A0 =C2=A0=C2=A0=C2=A0 PARAMS (key=3Dqemu_bin, path=3D*,
>> default=3Dx86_64-softmmu/qemu-system-x86_64) =3D>
>> 'x86_64-softmmu/qemu-system-x86_64
>> =C2=A0 +arch
>> +~~~~
>> +
>> +The architecture that will be used on a number of different scenarios=
.
>> +This parameter has a direct relation with the ``arch`` attribute.=C2=A0=
 If
>> +not given, it will default to None.
>> +
>> =C2=A0 qemu_bin
>> =C2=A0 ~~~~~~~~
>> =C2=A0 diff --git a/tests/acceptance/avocado_qemu/__init__.py
>> b/tests/acceptance/avocado_qemu/__init__.py
>> index d8d5b48dac..7a38851753 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return os.path.isfile(path) and os.acce=
ss(path, os.R_OK | os.X_OK)
>> =C2=A0 =C2=A0 -def pick_default_qemu_bin():
>> +def pick_default_qemu_bin(arch=3DNone):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Picks the path of a QEMU binary, starti=
ng either in the current
>> working
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 directory or in the source tree root di=
rectory.
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 :param arch: the arch to use when looking f=
or a QEMU binary
>> (the target
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 will match the arch given).=C2=A0 If None (th=
e default) arch
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 will be the current host system arch (as give=
n by
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 :func:`os.uname`).
>> +=C2=A0=C2=A0=C2=A0 :type arch: str
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :returns: the path to the default QEMU =
binary or None if one
>> could not
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 be found
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :rtype: str or None
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0 arch =3D os.uname()[4]
>> +=C2=A0=C2=A0=C2=A0 if arch is None:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch =3D os.uname()[4]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_bin_relative_path =3D os.path.join=
("%s-softmmu" % arch,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "qemu-system-%s" % arch)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if is_readable_executable_file(qemu_bin=
_relative_path):
>> @@ -47,8 +53,9 @@ def pick_default_qemu_bin():
>> =C2=A0 class Test(avocado.Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def setUp(self):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm =3D Non=
e
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.arch =3D self.params.=
get('arch')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.qemu_bin =3D=
 self.params.get('qemu_bin',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 default=3Dpick_default_qemu_bin())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
>> default=3Dpick_default_qemu_bin(self.arch))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.qemu_bi=
n is None:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 self.cancel("No QEMU binary defined or found in the
>> source tree")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm =3D QEM=
UMachine(self.qemu_bin)
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
