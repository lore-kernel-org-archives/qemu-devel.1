Received: from eggs.gnu.org ([2001:4830:134:3::10]:33134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA17p-0000NO-Bv
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA17k-0005EU-RI
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gA17k-0005E0-IF
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:09:08 -0400
References: <20181004151429.7232-1-crosa@redhat.com>
	<20181004151429.7232-6-crosa@redhat.com>
	<acc4179c-13f3-0a55-7731-86b90b20ec0c@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <8673bb6c-a689-d69a-40cc-4189b0a78acb@redhat.com>
Date: Tue, 9 Oct 2018 19:08:56 -0400
MIME-Version: 1.0
In-Reply-To: <acc4179c-13f3-0a55-7731-86b90b20ec0c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] Acceptance Tests: set machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 10/5/18 11:42 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 04/10/2018 17:14, Cleber Rosa wrote:
>> By setting the machine type, even if it's the one that will be picked
>> based on the arch, it's possible to run the same tests with targets
>> that require a machine type (in addition to those that don't).
>>
>> Given that only boot_linux_console.py contains code specific to x86_64
>> (an explicit reference to the kernel image that will be used) the
>> other tests can be used to test different targets:
>>
>>   $ avocado run -p arch=3Daarch64 --filter-by-tags=3D'-x86_64' -- test=
s/acceptance/
>>
>> Eventually, to reduce boiler plate code, the idea is to concentrate
>> the basic configuration (arch, machine, console) in either another
>> utility method, or make that happen by default.  This is of course the
>> subject of a future discussion.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/acceptance/boot_linux_console.py | 3 ++-
>>  tests/acceptance/version.py            | 2 ++
>>  tests/acceptance/vnc.py                | 5 +++++
>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py
>> index 98324f7591..58032f971c 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -30,7 +30,8 @@ class BootLinuxConsole(Test):
>>          kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
>>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
>> =20
>> -        self.vm.set_machine('pc')
>> +        self.vm.set_arch(self.arch)
>> +        self.vm.set_machine()
>>          self.vm.set_console()
>>          kernel_command_line =3D 'console=3DttyS0'
>>          self.vm.add_args('-kernel', kernel_path,
>> diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
>> index 13b0a7440d..7a3a20945f 100644
>> --- a/tests/acceptance/version.py
>> +++ b/tests/acceptance/version.py
>> @@ -18,6 +18,8 @@ class Version(Test):
>>      :avocado: tags=3Dquick
>>      """
>>      def test_qmp_human_info_version(self):
>> +        self.vm.set_arch(self.arch)
>> +        self.vm.set_machine()
>>          self.vm.launch()
>>          res =3D self.vm.command('human-monitor-command',
>>                                command_line=3D'info version')
>> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
>> index b1ef9d71b1..4a8a83025f 100644
>> --- a/tests/acceptance/vnc.py
>> +++ b/tests/acceptance/vnc.py
>> @@ -16,6 +16,11 @@ class Vnc(Test):
>>      :avocado: enable
>>      :avocado: tags=3Dvnc,quick
>>      """
>> +    def setUp(self):
>> +        super(Vnc, self).setUp()
>> +        self.vm.set_arch(self.arch)
>> +        self.vm.set_machine()
>> +
>>      def test_no_vnc(self):
>>          self.vm.add_args('-nodefaults', '-S')
>>          self.vm.launch()
>>
>=20
> $ uname -m
> aarch64
> $ avocado --show=3Dapp run
> --json-variants-load=3Dtests/acceptance/variants/arch.json
> tests/acceptance/vnc.py
> JOB ID     : 06f38999b7386afbd66023e7c1daee84d7991060
> JOB LOG    :
> /home/phil/avocado/job-results/job-2018-10-05T15.40-06f3899/job.log
>  (01/20) tests/acceptance/vnc.py:Vnc.test_no_vnc;aarch64: PASS (0.34 s)
>  (02/20) tests/acceptance/vnc.py:Vnc.test_no_vnc;ppc: PASS (0.31 s)
>  (03/20) tests/acceptance/vnc.py:Vnc.test_no_vnc;ppc64: PASS (0.35 s)
>  (04/20) tests/acceptance/vnc.py:Vnc.test_no_vnc;s390x: PASS (0.24 s)
>  (05/20) tests/acceptance/vnc.py:Vnc.test_no_vnc;x86_64: PASS (0.34 s)
>  (06/20)
> tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password;aarch64: PASS
> (0.34 s)
>  (07/20) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password;ppc:
> PASS (0.27 s)
>  (08/20) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password;ppc64:
> PASS (0.34 s)
>  (09/20) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password;s390x:
> PASS (0.24 s)
>  (10/20) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password;x86_64=
:
> PASS (0.35 s)
>  (11/20)
> tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_passwor=
d;aarch64:
> PASS (0.33 s)
>  (12/20)
> tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_passwor=
d;ppc:
> PASS (0.28 s)
>  (13/20)
> tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_passwor=
d;ppc64:
> PASS (0.38 s)
>  (14/20)
> tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_passwor=
d;s390x:
> PASS (0.26 s)
>  (15/20)
> tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_passwor=
d;x86_64:
> PASS (0.35 s)
>  (16/20) tests/acceptance/vnc.py:Vnc.test_vnc_change_password;aarch64:
> PASS (0.35 s)
>  (17/20) tests/acceptance/vnc.py:Vnc.test_vnc_change_password;ppc: PASS
> (0.28 s)
>  (18/20) tests/acceptance/vnc.py:Vnc.test_vnc_change_password;ppc64:
> PASS (0.36 s)
>  (19/20) tests/acceptance/vnc.py:Vnc.test_vnc_change_password;s390x:
> PASS (0.26 s)
>  (20/20) tests/acceptance/vnc.py:Vnc.test_vnc_change_password;x86_64:
> PASS (0.34 s)
> RESULTS    : PASS 20 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0
> | CANCEL 0
> JOB TIME   : 8.30 s
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20

I think this is a "tested by" for the next commit (the one that adds the
JSON file), right?

Thanks for testing it!
- Cleber.
