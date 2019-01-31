Received: from eggs.gnu.org ([209.51.188.92]:59224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp03G-0008CJ-Ss
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp03G-0006o1-2i
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:17:54 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-11-crosa@redhat.com>
	<4b7decb3-c198-cff6-0ec1-5fc58df64a74@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <54687368-29bb-2d42-d972-e1f84eed7255@redhat.com>
Date: Wed, 30 Jan 2019 19:17:40 -0500
MIME-Version: 1.0
In-Reply-To: <4b7decb3-c198-cff6-0ec1-5fc58df64a74@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/18] Boot Linux Console Test: refactor
 the console watcher into utility method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>



On 1/22/19 5:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 1/17/19 7:56 PM, Cleber Rosa wrote:
>> This introduces a utility method that monitors the console device and
>> looks for either a message that signals the test success or failure.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/acceptance/boot_linux_console.py | 30 ++++++++++++++++++-------=
-
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py
>> index 35b31162d4..278bb2be3d 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -23,6 +23,25 @@ class BootLinuxConsole(Test):
>> =20
>>      timeout =3D 60
>> =20
>> +    def wait_for_console_pattern(self, success_message,
>> +                                 failure_message=3D'Kernel panic - no=
t syncing'):
>> +        """
>> +        Waits for messages to appear on the console, while logging th=
e content
>> +
>> +        :param success_message: if this message appears, test succeed=
s
>> +        :param failure_message: if this message appears, test fails
>> +        """
>> +        console =3D self.vm.console_socket.makefile()
>> +        console_logger =3D logging.getLogger('console')
>> +        while True:
>> +            msg =3D console.readline()
>> +            console_logger.debug(msg.strip())
>> +            if success_message in msg:
>> +                break
>> +            if failure_message in msg:
>> +                fail =3D 'Failure message found in console: %s' % fai=
lure_message
>> +                self.fail(fail)
>> +
>=20
> This helper is more generic than the BootLinuxConsole class, can you
> move it out? I'd like to use it in test_uefi_ovmf_x86_64_pc and
> test_uefi_armvirtqemu_aarch64_virt.
>=20
> Anyway this can be a follow-up patch, so regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20

Sure thing, I'll work on something on top of this.  Tracking it here in
the mean time:

https://trello.com/c/oJtL1nRJ/78-create-utility-out-of-waitforconsolepatt=
ern

- Cleber.
