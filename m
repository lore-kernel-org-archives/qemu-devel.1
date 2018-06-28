Received: from eggs.gnu.org ([2001:4830:134:3::10]:34947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYerf-0002Jp-Fp
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYerc-00010e-E3
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:54:07 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYerb-0000w9-Te
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:54:04 -0400
Received: by mail-wm0-x242.google.com with SMTP id l15-v6so427064wmc.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:54:03 -0700 (PDT)
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-2-f4bug@amsat.org>
	<87k1qivqm5.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87k1qivqm5.fsf@linaro.org>
Date: Thu, 28 Jun 2018 22:54:01 +0100
Message-ID: <87a7revapy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/6] avocado: Add a Test.arch
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
>> Tests can change this property to run tests in other
>> architectures than the host one.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  tests/acceptance/avocado_qemu/__init__.py | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptanc=
e/avocado_qemu/__init__.py
>> index 1e54fd5932..6e9601f5e9 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -13,6 +13,7 @@ import sys
>>
>>  import avocado
>>
>> +HOST_ARCH =3D os.uname()[4]
>
> The python docs seem to point to platform as a more stable way of
> querying this stuff:
>
>   platform.machine() =3D> 'x86_64' or 'aarch64'
>
>>  SRC_ROOT_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(__file=
__)))
>>  SRC_ROOT_DIR =3D os.path.abspath(os.path.dirname(SRC_ROOT_DIR))
>>  sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
>> @@ -23,12 +24,11 @@ def is_readable_executable_file(path):
>>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>>
>>
>> -def pick_default_qemu_bin():
>> +def pick_default_qemu_bin(arch):
>>      """
>>      Picks the path of a QEMU binary, starting either in the current wor=
king
>>      directory or in the source tree root directory.
>>      """
>> -    arch =3D os.uname()[4]
>>      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>>                                            "qemu-system-%s" % arch)
>>      if is_readable_executable_file(qemu_bin_relative_path):
>> @@ -41,10 +41,19 @@ def pick_default_qemu_bin():
>>
>>
>>  class Test(avocado.Test):
>> +    _arch =3D HOST_ARCH

But actually this is wrong - because the host arch may not boot machines
defined in the tests. I suspect each superclass needs to explicitly set
it's arch and we should assert it has done so here.

>> +
>> +    @property
>> +    def arch(self):
>> +        """
>> +        Returns the architecture required to run the current test
>> +        """
>> +        return self._arch
>> +
>>      def setUp(self):
>>          self.vm =3D None
>> -        self.qemu_bin =3D self.params.get('qemu_bin',
>> -                                        default=3Dpick_default_qemu_bin=
())
>> +        qemu_bin =3D pick_default_qemu_bin(self.arch)
>> +        self.qemu_bin =3D self.params.get('qemu_bin', default=3Dqemu_bi=
n)
>>          if self.qemu_bin is None:
>>              self.cancel("No QEMU binary defined or found in the source =
tree")
>>          self.vm =3D QEMUMachine(self.qemu_bin)


--
Alex Benn=C3=A9e
