Received: from eggs.gnu.org ([2001:4830:134:3::10]:56588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAEFR-0004x6-H3
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAEFO-0005CS-7U
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:09:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gAEFN-0005C7-Ua
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:09:54 -0400
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-8-crosa@redhat.com>
	<a633eba5-3b96-2e36-db9d-25b8718c6bbb@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <8b21b355-5fc9-36c8-5c23-bee0b75b68ca@redhat.com>
Date: Wed, 10 Oct 2018 09:09:44 -0400
MIME-Version: 1.0
In-Reply-To: <a633eba5-3b96-2e36-db9d-25b8718c6bbb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/7] Acceptance Tests: change the
 handling of tests for specific archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 10/10/18 6:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/10/2018 01:26, Cleber Rosa wrote:
>> With the introduction of a variants file that can run the same
>> tests on various architectures, it makes sense to make most tests
>> to be reusable on those environments.  The exception should be
>> when a test is really testing a specific architecture feature.
>>
>> With the change proposed here, on a command line such as:
>>
>>   $ avocado run \
>>      --json-variants-load=3Dtests/acceptance/variants/arch.json \
>>      -- tests/acceptance/
>>
>> The boot_linux_console.py tests will appear as "CANCELED: Currently
>> specific to the x86_64 arch", which is as a good thing when compared
>> to being ignored by tags because:
>>
>>  * The architecture specific parts can be addressed
>>  * It will be run on the matching architecture (as opposed to always
>>    being filtered out by the tags mechanism)
>>  * CANCELED tests do no influence negatively the overall job results,
>>    they're not considered an error or failure
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/acceptance/boot_linux_console.py | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py
>> index 58032f971c..ba3ac036da 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -19,12 +19,13 @@ class BootLinuxConsole(Test):
>>      and the kernel command line is properly passed from QEMU to the k=
ernel
>> =20
>>      :avocado: enable
>> -    :avocado: tags=3Dx86_64
>>      """
>> =20
>>      timeout =3D 60
>> =20
>>      def test(self):
>> +        if self.arch !=3D 'x86_64':
>> +            self.cancel('Currently specific to the x86_64 target arch=
')
>>          kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/2=
8/'
>>                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
>>          kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
>>
>=20
> For some reason this test run quicker on a aarch64 host than my x86 lap=
top:
>=20
> ThunderX 88XX (aarch64 Little Endian):
>=20
>  (05/30)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test;x86_64:
> PASS (12.88 s)
>=20
> Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz:
>=20
>  (05/30)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test;x86_64:
> PASS (31.13 s)
>=20

The only reason I can think of is faster networking on the aarch64
machine.  Are those numbers more or less the same on subsequent runs?

Thanks for testing it!
- Cleber.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
