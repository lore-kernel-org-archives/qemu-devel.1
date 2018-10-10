Received: from eggs.gnu.org ([2001:4830:134:3::10]:47311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gADiV-0002Tq-8G
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gADiR-0006nz-WB
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:35:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gADiR-0006n4-OR
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:35:51 -0400
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-5-crosa@redhat.com>
	<835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <95a8561c-0511-6a8a-a3eb-25d556029e7a@redhat.com>
Date: Wed, 10 Oct 2018 08:35:38 -0400
MIME-Version: 1.0
In-Reply-To: <835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] scripts/qemu.py: set predefined
 machine type based on arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 10/10/18 7:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/10/2018 01:26, Cleber Rosa wrote:
>> Some targets require a machine type to be set, as there's no default
>> (aarch64 is one example).  To give a consistent interface to users of
>> this API, this changes set_machine() so that a predefined default can
>> be used, if one is not given.  The approach used is exactly the same
>> with the console device type.
>>
>> Also, even when there's a default machine type, for some purposes,
>> testing included, it's better if outside code is explicit about the
>> machine type, instead of relying on whatever is set internally.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  scripts/qemu.py | 22 +++++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index d9e24a0c1a..fca9b76990 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -36,6 +36,15 @@ CONSOLE_DEV_TYPES =3D {
>>      r'^s390-ccw-virtio.*': 'sclpconsole',
>>      }
>> =20
>> +#: Maps archictures to the preferred machine type
>> +MACHINE_TYPES =3D {
>> +    r'^aarch64$': 'virt',
>> +    r'^ppc$': 'g3beige',
>> +    r'^ppc64$': 'pseries',
>> +    r'^s390x$': 's390-ccw-virtio',
>> +    r'^x86_64$': 'q35',
>=20
> Why choose Q35 rather than PC (the default)?
>=20
> I was wondering about how to generate variants/machines.json but this i=
s
> definitively something we want to do via a QMP query.
>=20
> Eduardo what do you think?
>=20

It was motivated by Eduardo's initiative to make q35 the default "across
the board".  He can confirm and give more details.

- Cleber.

>> +    }
>> +
>> =20
>>  class QEMUMachineError(Exception):
>>      """
>> @@ -413,13 +422,24 @@ class QEMUMachine(object):
>>          """
>>          self._arch =3D arch
>> =20
>> -    def set_machine(self, machine_type):
>> +    def set_machine(self, machine_type=3DNone):
>>          '''
>>          Sets the machine type
>> =20
>>          If set, the machine type will be added to the base arguments
>>          of the resulting QEMU command line.
>>          '''
>> +        if machine_type is None:
>> +            if self._arch is None:
>> +                raise QEMUMachineError("Can not set a default machine=
 type: "
>> +                                       "QEMU instance without a defin=
ed arch")
>> +            for regex, machine in MACHINE_TYPES.items():
>> +                if re.match(regex, self._arch):
>> +                    machine_type =3D machine
>> +                    break
>> +            if machine_type is None:
>> +                raise QEMUMachineError("Can not set a machine type: n=
o "
>> +                                       "matching machine type definit=
ion")
>>          self._machine =3D machine_type
>> =20
>>      def set_console(self, device_type=3DNone):
>>
