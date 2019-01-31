Received: from eggs.gnu.org ([209.51.188.92]:60623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp0Cm-0001hA-9q
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp0Cl-00015n-7c
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:27:44 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-13-crosa@redhat.com>
	<f53472e7-84a6-894f-6694-8729bdc1b284@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <a6a8c63f-a46c-fc33-1672-d214132d0054@redhat.com>
Date: Wed, 30 Jan 2019 19:27:33 -0500
MIME-Version: 1.0
In-Reply-To: <f53472e7-84a6-894f-6694-8729bdc1b284@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/18] Boot Linux Console Test: add a test
 for mips + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 1/22/19 5:16 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 1/17/19 7:56 PM, Cleber Rosa wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
>> board and verify the serial is working.  Also, it relies on the serial
>> device set by the machine itself.
>>
>> If mips is a target being built, "make check-acceptance" will
>> automatically include this test by the use of the "arch:mips" tags.
>>
>> Alternatively, this test can be run using:
>>
>>     $ avocado run -t arch:mips tests/acceptance
>>     $ avocado run -t machine:malta tests/acceptance
>>     $ avocado run -t endian:big tests/acceptance
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  .travis.yml                            |  2 +-
>>  scripts/qemu.py                        |  1 -
>>  tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
>>  3 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 844d514afa..49f9016e6a 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -187,7 +187,7 @@ matrix:
>> =20
>>      # Acceptance (Functional) tests
>>      - env:
>> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_6=
4-softmmu"
>> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_6=
4-softmmu,mips-softmmu"
>>          - TEST_CMD=3D"make check-acceptance"
>>        addons:
>>          apt:
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 88e1608b42..ef84b0f843 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -35,7 +35,6 @@ def kvm_available(target_arch=3DNone):
>>  #: Maps machine types to the preferred console device types
>>  CONSOLE_DEV_TYPES =3D {
>>      r'^clipper$': 'isa-serial',
>> -    r'^malta': 'isa-serial',
>>      r'^(pc.*|q35.*|isapc)$': 'isa-serial',
>>      r'^(40p|powernv|prep)$': 'isa-serial',
>>      r'^pseries.*': 'spapr-vty',
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py
>> index 278bb2be3d..0678ec91d2 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -60,3 +60,23 @@ class BootLinuxConsole(Test):
>>          self.vm.launch()
>>          console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
>>          self.wait_for_console_pattern(console_pattern)
>> +
>> +    def test_mips_malta(self):
>> +        """
>> +        :avocado: tags=3Darch:mips
>> +        :avocado: tags=3Dmachine:malta
>> +        :avocado: tags=3Dendian:big
>> +        """
>> +        kernel_url =3D ('http://people.debian.org/~aurel32/qemu/mips/=
'
>> +                      'vmlinux-3.2.0-4-4kc-malta')
>> +        kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
>> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
>=20
> Alex was concerned about using this "not-so-easily-reproducible" binary=
:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08441.html
>

I clearly missed that.

> So I sent another patch using a reproducible one, which you reviewed:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02747.html
>=20

And I clearly forgot about that :)

> Do you mind base this series on it?
>=20
> Thanks,
>=20
> Phil.

Of course!  Thanks for pointing that out.

- Cleber.
