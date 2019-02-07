Received: from eggs.gnu.org ([209.51.188.92]:35942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1groKG-0005Hn-LL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1groKF-0003IP-BC
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:23:04 -0500
From: Cleber Rosa <crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-6-crosa@redhat.com>
	<20190206164004.79be247a.cohuck@redhat.com>
	<fa162265-629f-73e1-c483-3cad10f1b101@redhat.com>
Message-ID: <99b31455-41be-af68-ad03-1119340905c3@redhat.com>
Date: Thu, 7 Feb 2019 13:22:10 -0500
MIME-Version: 1.0
In-Reply-To: <fa162265-629f-73e1-c483-3cad10f1b101@redhat.com>
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



On 2/7/19 1:02 PM, Cleber Rosa wrote:
>=20
>=20
> On 2/6/19 10:40 AM, Cornelia Huck wrote:
>> On Fri,  1 Feb 2019 19:55:55 -0500
>> Cleber Rosa <crosa@redhat.com> wrote:
>>
>>> It's useful to define the architecture that should be used in
>>> situations such as:
>>>  * the intended target of the QEMU binary to be used on tests
>>>  * the architecture of code to be run within the QEMU binary, such
>>>    as a kernel image or a full blown guest OS image
>>
>> Thinking a bit more about this: These two are often, but not
>> necessarily, the same. For example, starting a machine with the 64 bit
>> variant of an architecture to run a guest with the 32 bit variant of
>> that architecture might be a valid case.
>>
>=20
> I agree with everything you said, and that's why I imagine "arch" being
> used as a safe default type of parameter.
>=20
> See, the QEMU binary can be influenced by the "arch" parameter, but can
> still be *defined* by the "qemu_bin" parameter.  That's the same
> approach I believe can be applied to the architecture of the guest code=
.
>  When time comes, we may add a "guest_arch" parameter of sorts.  We
> don't have that use case now, but I believe we'll be covered when it co=
mes.
>=20
>>>
>>> This commit introduces both a test parameter and a test instance
>>> attribute, that will contain such a value.
>>>
>>> Now, when the "arch" test parameter is given, it will influence the
>>> selection of the default QEMU binary, if one is not given explicitly
>>> by means of the "qemu_img" parameter.
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  docs/devel/testing.rst                    | 17 +++++++++++++++++
>>>  tests/acceptance/avocado_qemu/__init__.py | 14 +++++++++++---
>>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>>> index 44c9b3ae74..d37c4b0e77 100644
>>> --- a/docs/devel/testing.rst
>>> +++ b/docs/devel/testing.rst
>>> @@ -689,6 +689,16 @@ vm
>>>  A QEMUMachine instance, initially configured according to the given
>>>  ``qemu_bin`` parameter.
>>> =20
>>> +arch
>>> +~~~~
>>> +
>>> +The architecture that will be used on a number of different
>>> +scenarios.  For instance, when a QEMU binary is not explicitly given=
,
>>> +the one selected will depend on this attribute.
>>
>> This is probably a bit too vague. (What are "different scenarios"?)
>>
>=20
> I believe it's kind of vague because I was thinking of both the
> "framework level" code, and the possible uses in the tests.
>=20
> At the "framework" level, it's only used for the case listed there
> ("when a QEMU binary is not explicitly given...").
>=20
>> Does it select anything else than the architecture of the vm that will
>> be started?
>>
>=20
> No, it doesn't.  The idea here was that tests may choose to use the sam=
e
> attribute value in their own specific ("different") scenarios.
>=20
> I can certainly make this clearer.
>=20

Hi Cornelia,

How does this sound?

---

The architecture that will influence the selection of a QEMU binary
(when one is not explicitly given).

Tests are also free to use this attribute value, for their own needs.
A test may, for instance, use the same value when selecting the
architecture of a kernel or disk image to boot a VM with.

The ``arch`` attribute will be set to the test parameter of the same
name, and if one is not given explicitly, it will be set to ``None``.

---

It uses your previous point about the 64/32 bit host/guest as an
example.  Again, a test could use another parameter (not a Test class
attribute) if it wants to use code for a different arch than the host.

Thanks,
- Cleber.

>>> +
>>> +The ``arch`` attribute will be set to the test parameter of the same
>>> +name, and if one is not given explicitly, it will be set to ``None``=
.
>>> +
>>>  qemu_bin
>>>  ~~~~~~~~
>>> =20
>>> @@ -711,6 +721,13 @@ like the following:
>>> =20
>>>    PARAMS (key=3Dqemu_bin, path=3D*, default=3Dx86_64-softmmu/qemu-sy=
stem-x86_64) =3D> 'x86_64-softmmu/qemu-system-x86_64
>>> =20
>>> +arch
>>> +~~~~
>>> +
>>> +The architecture that will be used on a number of different scenario=
s.
>>
>> Same comment here.
>>
>=20
> ACK.
>=20
>>> +This parameter has a direct relation with the ``arch`` attribute.  I=
f
>>> +not given, it will default to None.
>>> +
>>>  qemu_bin
>>>  ~~~~~~~~
>>> =20
>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accept=
ance/avocado_qemu/__init__.py
>>> index d8d5b48dac..f580582602 100644
>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>> @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
>>>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_O=
K)
>>> =20
>>> =20
>>> -def pick_default_qemu_bin():
>>> +def pick_default_qemu_bin(arch=3DNone):
>>>      """
>>>      Picks the path of a QEMU binary, starting either in the current =
working
>>>      directory or in the source tree root directory.
>>> =20
>>> +    :param arch: the arch to use when looking for a QEMU binary (the=
 target
>>> +                 will match the arch given).  If None (the default) =
arch
>>> +                 will be the current host system arch (as given by
>>> +                 :func:`os.uname`).
>>
>> This is more specific :)
>>
>=20
> Yep, I'll make the other doc snippets clearer.
>=20
> Thanks!
> - Cleber.
>=20
>>> +    :type arch: str
>>>      :returns: the path to the default QEMU binary or None if one cou=
ld not
>>>                be found
>>>      :rtype: str or None
>>>      """
>>> -    arch =3D os.uname()[4]
>>> +    if arch is None:
>>> +        arch =3D os.uname()[4]
>>>      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>>>                                            "qemu-system-%s" % arch)
>>>      if is_readable_executable_file(qemu_bin_relative_path):
>>> @@ -47,8 +53,10 @@ def pick_default_qemu_bin():
>>>  class Test(avocado.Test):
>>>      def setUp(self):
>>>          self.vm =3D None
>>> +        self.arch =3D self.params.get('arch')
>>> +        default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>>>          self.qemu_bin =3D self.params.get('qemu_bin',
>>> -                                        default=3Dpick_default_qemu_=
bin())
>>> +                                        default=3Ddefault_qemu_bin)
>>>          if self.qemu_bin is None:
>>>              self.cancel("No QEMU binary defined or found in the sour=
ce tree")
>>>          self.vm =3D QEMUMachine(self.qemu_bin)
>>

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
