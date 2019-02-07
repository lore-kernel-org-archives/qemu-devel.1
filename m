Received: from eggs.gnu.org ([209.51.188.92]:59233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gro0a-00066x-R1
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gro0Z-0005Is-2d
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:02:44 -0500
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-6-crosa@redhat.com>
	<20190206164004.79be247a.cohuck@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <fa162265-629f-73e1-c483-3cad10f1b101@redhat.com>
Date: Thu, 7 Feb 2019 13:02:30 -0500
MIME-Version: 1.0
In-Reply-To: <20190206164004.79be247a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/20] Acceptance tests: introduce arch
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
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>



On 2/6/19 10:40 AM, Cornelia Huck wrote:
> On Fri,  1 Feb 2019 19:55:55 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
>=20
>> It's useful to define the architecture that should be used in
>> situations such as:
>>  * the intended target of the QEMU binary to be used on tests
>>  * the architecture of code to be run within the QEMU binary, such
>>    as a kernel image or a full blown guest OS image
>=20
> Thinking a bit more about this: These two are often, but not
> necessarily, the same. For example, starting a machine with the 64 bit
> variant of an architecture to run a guest with the 32 bit variant of
> that architecture might be a valid case.
>=20

I agree with everything you said, and that's why I imagine "arch" being
used as a safe default type of parameter.

See, the QEMU binary can be influenced by the "arch" parameter, but can
still be *defined* by the "qemu_bin" parameter.  That's the same
approach I believe can be applied to the architecture of the guest code.
 When time comes, we may add a "guest_arch" parameter of sorts.  We
don't have that use case now, but I believe we'll be covered when it come=
s.

>>
>> This commit introduces both a test parameter and a test instance
>> attribute, that will contain such a value.
>>
>> Now, when the "arch" test parameter is given, it will influence the
>> selection of the default QEMU binary, if one is not given explicitly
>> by means of the "qemu_img" parameter.
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  docs/devel/testing.rst                    | 17 +++++++++++++++++
>>  tests/acceptance/avocado_qemu/__init__.py | 14 +++++++++++---
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 44c9b3ae74..d37c4b0e77 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -689,6 +689,16 @@ vm
>>  A QEMUMachine instance, initially configured according to the given
>>  ``qemu_bin`` parameter.
>> =20
>> +arch
>> +~~~~
>> +
>> +The architecture that will be used on a number of different
>> +scenarios.  For instance, when a QEMU binary is not explicitly given,
>> +the one selected will depend on this attribute.
>=20
> This is probably a bit too vague. (What are "different scenarios"?)
>=20

I believe it's kind of vague because I was thinking of both the
"framework level" code, and the possible uses in the tests.

At the "framework" level, it's only used for the case listed there
("when a QEMU binary is not explicitly given...").

> Does it select anything else than the architecture of the vm that will
> be started?
>=20

No, it doesn't.  The idea here was that tests may choose to use the same
attribute value in their own specific ("different") scenarios.

I can certainly make this clearer.

>> +
>> +The ``arch`` attribute will be set to the test parameter of the same
>> +name, and if one is not given explicitly, it will be set to ``None``.
>> +
>>  qemu_bin
>>  ~~~~~~~~
>> =20
>> @@ -711,6 +721,13 @@ like the following:
>> =20
>>    PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-sys=
tem-x86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
>> =20
>> +arch
>> +~~~~
>> +
>> +The architecture that will be used on a number of different scenarios=
.
>=20
> Same comment here.
>=20

ACK.

>> +This parameter has a direct relation with the ``arch`` attribute.  If
>> +not given, it will default to None.
>> +
>>  qemu_bin
>>  ~~~~~~~~
>> =20
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accepta=
nce/avocado_qemu/__init__.py
>> index d8d5b48dac..f580582602 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
>>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK=
)
>> =20
>> =20
>> -def pick_default_qemu_bin():
>> +def pick_default_qemu_bin(arch=3DNone):
>>      """
>>      Picks the path of a QEMU binary, starting either in the current w=
orking
>>      directory or in the source tree root directory.
>> =20
>> +    :param arch: the arch to use when looking for a QEMU binary (the =
target
>> +                 will match the arch given).  If None (the default) a=
rch
>> +                 will be the current host system arch (as given by
>> +                 :func:`os.uname`).
>=20
> This is more specific :)
>=20

Yep, I'll make the other doc snippets clearer.

Thanks!
- Cleber.

>> +    :type arch: str
>>      :returns: the path to the default QEMU binary or None if one coul=
d not
>>                be found
>>      :rtype: str or None
>>      """
>> -    arch =3D os.uname()[4]
>> +    if arch is None:
>> +        arch =3D os.uname()[4]
>>      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>>                                            "qemu-system-%s" % arch)
>>      if is_readable_executable_file(qemu_bin_relative_path):
>> @@ -47,8 +53,10 @@ def pick_default_qemu_bin():
>>  class Test(avocado.Test):
>>      def setUp(self):
>>          self.vm =3D None
>> +        self.arch =3D self.params.get('arch')
>> +        default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>>          self.qemu_bin =3D self.params.get('qemu_bin',
>> -                                        default=3Dpick_default_qemu_b=
in())
>> +                                        default=3Ddefault_qemu_bin)
>>          if self.qemu_bin is None:
>>              self.cancel("No QEMU binary defined or found in the sourc=
e tree")
>>          self.vm =3D QEMUMachine(self.qemu_bin)
>=20
