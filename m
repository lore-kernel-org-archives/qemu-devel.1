Received: from eggs.gnu.org ([209.51.188.92]:42438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp182-00048Q-N6
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp181-0002MZ-L5
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:26:54 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-14-crosa@redhat.com>
	<e05b1d30-1a44-171a-02f7-d77e182ab90c@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <eb914790-ce08-df18-941b-bc93be89822d@redhat.com>
Date: Wed, 30 Jan 2019 20:26:43 -0500
MIME-Version: 1.0
In-Reply-To: <e05b1d30-1a44-171a-02f7-d77e182ab90c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/18] Boot Linux Console Test: add a test
 for mips64el + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 1/22/19 5:19 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 1/17/19 7:56 PM, Cleber Rosa wrote:
>> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
>> board and verify the serial is working.
>>
>> If mips64el is a target being built, "make check-acceptance" will
>> automatically include this test by the use of the "arch:mips" tags.
>>
>> Alternatively, this test can be run using:
>>
>>     $ avocado run -t arch:mips64el tests/acceptance
>>     $ avocado run -t machine:malta tests/acceptance
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  .travis.yml                            |  2 +-
>>  tests/acceptance/boot_linux_console.py | 39 +++++++++++++++++++++++++=
+
>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 49f9016e6a..28648f7a61 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -187,7 +187,7 @@ matrix:
>> =20
>>      # Acceptance (Functional) tests
>>      - env:
>> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_6=
4-softmmu,mips-softmmu"
>> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_6=
4-softmmu,mips-softmmu,mips64el-softmmu"
>>          - TEST_CMD=3D"make check-acceptance"
>>        addons:
>>          apt:
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py
>> index 0678ec91d2..20b845fce1 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -9,8 +9,11 @@
>>  # later.  See the COPYING file in the top-level directory.
>> =20
>>  import logging
>> +import os
>> =20
>>  from avocado_qemu import Test
>> +from avocado.utils import process
>> +from avocado.utils import archive
>> =20
>> =20
>>  class BootLinuxConsole(Test):
>> @@ -80,3 +83,39 @@ class BootLinuxConsole(Test):
>>          self.vm.launch()
>>          console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
>>          self.wait_for_console_pattern(console_pattern)
>> +
>> +    def test_mips64el_malta(self):
>> +        """
>> +        This test requires the ar tool to extract "data.tar.gz" from
>> +        the Debian package.
>> +
>> +        The kernel can be rebuilt using this Debian kernel source [1]=
 and
>> +        following the instructions on [2].
>> +
>> +        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-c=
ommon-tasks.html#s-common-official
>> +        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#l=
inux-source-2.6.32_2.6.32-48
>> +
>> +        :avocado: tags=3Darch:mips64el
>> +        :avocado: tags=3Dmachine:malta
>> +        """
>> +        deb_url =3D ('http://snapshot.debian.org/archive/debian/20130=
217T032700Z/'
>> +                   'pool/main/l/linux-2.6/'
>> +                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.d=
eb')
>> +        deb_hash =3D '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
>> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> +
>=20
> Can you refactor this code ...
>=20
>> +        cwd =3D os.getcwd()
>> +        os.chdir(self.workdir)
>> +        process.run("ar x %s data.tar.gz" % deb_path)
>> +        archive.extract("data.tar.gz", self.workdir)
>> +        os.chdir(cwd)
>> +        kernel_path =3D self.workdir + '/boot/vmlinux-2.6.32-5-5kc-ma=
lta'
>=20
> ... as an helper function?
>=20

Yes.  In fact, because of the kernel change in the previous patch, I've
added it there.

> Can be follow-up patch, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20

In the longer term, I expect to add deb (and RPM, etc) support to the
avocado.utils.archive module:

https://trello.com/c/bQBnvkjv/1437-avocadoutilsarchive-support-rpm-deb-et=
c


Thanks!
- Cleber.
