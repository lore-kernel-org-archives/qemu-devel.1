Received: from eggs.gnu.org ([2001:4830:134:3::10]:42343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gC3IR-0003AH-1a
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gC3IM-00015j-Gg
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gC3IB-0000yR-TZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:52:22 -0400
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-8-crosa@redhat.com>
	<f64fd819-8977-bcc0-97db-84ef4c83a046@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <affc1f0d-9ae9-193d-002b-773024561734@redhat.com>
Date: Mon, 15 Oct 2018 09:52:03 -0400
MIME-Version: 1.0
In-Reply-To: <f64fd819-8977-bcc0-97db-84ef4c83a046@amsat.org>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 10/13/18 7:08 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 10/10/18 1:26 AM, Cleber Rosa wrote:
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
>=20
> Can we keep a such tag (in format 'arch:x86_64') ...
>=20

Yes, sure.  That's how the best "standards" are born ;)

>>      """
>> =20
>>      timeout =3D 60
>> =20
>>      def test(self):
>> +        if self.arch !=3D 'x86_64':
>> +            self.cancel('Currently specific to the x86_64 target arch=
')
>=20
> ... and have this check generic? (Eventually via a QemuTest(Test) paren=
t
> class).
>=20

Yes, there's a lot of upcoming setup that can be made generic to the
base class.  Some of that is coming soon.

Thanks!
- Cleber.

>>          kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/2=
8/'
>>                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
>>          kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
>>
