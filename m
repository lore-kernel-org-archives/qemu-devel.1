Received: from eggs.gnu.org ([2001:4830:134:3::10]:47919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAGiZ-0003OJ-JX
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAGiW-00015E-EC
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gAGiW-00014b-3M
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:48:08 -0400
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-5-crosa@redhat.com>
	<835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
	<95a8561c-0511-6a8a-a3eb-25d556029e7a@redhat.com>
	<20181010134656.GE5738@habkost.net>
	<47f72e98-335f-b3c9-54c7-4c8a468d85d6@redhat.com>
	<26fe2055-77c2-45fa-4e88-62101d70b88b@redhat.com>
	<20181010142840.GH5738@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <118ed8f7-5947-12c6-f3f6-b10597f37aac@redhat.com>
Date: Wed, 10 Oct 2018 11:47:55 -0400
MIME-Version: 1.0
In-Reply-To: <20181010142840.GH5738@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 10/10/18 10:28 AM, Eduardo Habkost wrote:
> On Wed, Oct 10, 2018 at 10:15:15AM -0400, Cleber Rosa wrote:
>>
>>
>> On 10/10/18 9:59 AM, Cleber Rosa wrote:
>>>
>>>
>>> On 10/10/18 9:46 AM, Eduardo Habkost wrote:
>>>> On Wed, Oct 10, 2018 at 08:35:38AM -0400, Cleber Rosa wrote:
>>>>>
>>>>>
>>>>> On 10/10/18 7:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> On 10/10/2018 01:26, Cleber Rosa wrote:
>>>>>>> Some targets require a machine type to be set, as there's no defa=
ult
>>>>>>> (aarch64 is one example).  To give a consistent interface to user=
s of
>>>>>>> this API, this changes set_machine() so that a predefined default=
 can
>>>>>>> be used, if one is not given.  The approach used is exactly the s=
ame
>>>>>>> with the console device type.
>>>>>>>
>>>>>>> Also, even when there's a default machine type, for some purposes=
,
>>>>>>> testing included, it's better if outside code is explicit about t=
he
>>>>>>> machine type, instead of relying on whatever is set internally.
>>>>>>>
>>>>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>>>>> ---
>>>>>>>  scripts/qemu.py | 22 +++++++++++++++++++++-
>>>>>>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>>>>> index d9e24a0c1a..fca9b76990 100644
>>>>>>> --- a/scripts/qemu.py
>>>>>>> +++ b/scripts/qemu.py
>>>>>>> @@ -36,6 +36,15 @@ CONSOLE_DEV_TYPES =3D {
>>>>>>>      r'^s390-ccw-virtio.*': 'sclpconsole',
>>>>>>>      }
>>>>>>> =20
>>>>>>> +#: Maps archictures to the preferred machine type
>>>>>>> +MACHINE_TYPES =3D {
>>>>>>> +    r'^aarch64$': 'virt',
>>>>>>> +    r'^ppc$': 'g3beige',
>>>>>>> +    r'^ppc64$': 'pseries',
>>>>>>> +    r'^s390x$': 's390-ccw-virtio',
>>>>>>> +    r'^x86_64$': 'q35',
>>>>>>
>>>>>> Why choose Q35 rather than PC (the default)?
>>>>>>
>>>>>> I was wondering about how to generate variants/machines.json but t=
his is
>>>>>> definitively something we want to do via a QMP query.
>>>>>>
>>>>>> Eduardo what do you think?
>>>>>>
>>>>>
>>>>> It was motivated by Eduardo's initiative to make q35 the default "a=
cross
>>>>> the board".  He can confirm and give more details.
>>>>
>>>> Making Q35 the default on applications using QEMU and libvirt is
>>>> something I'd like to happen.  But I think the simplest way to do
>>>> that is to change the QEMU default.  This way you won't need this
>>>> table on qemu.py: you can just use the default provided by QEMU.
>>>>
>>>
>>> The idea is to bring consistency on how we're calling
>>> "qemu-system-$(ARCH)", and at the same time apply the "explicit is
>>> better than implicit" rule.
>>>
>>> The most important fact is that some targets do not (currently) have
>>> "the default provided by QEMU", aarch64 is one of them.
>>>
>>> - Cleber.
>>>
>>
>> So I ended up not relaying the question properly: should we default
>> (even if explicitly adding "-machine") to "pc"?
>=20
> I think using the default machine-type (when QEMU has a default)
> would be less surprising for users of the qemu.py API.
>=20

OK, agreed.

> Implicitly adding -machine when there's no default is also
> surprising, but then it's a nice surprise: instead of crashing
> you get a running VM.
>=20
> Now, there are two other questions related to this:
>=20
> If using 'pc' as default, should we always add -machine, or just
> omit the machine-type name?  I think we should omit it unless the
> caller asked for a specific machine-type name (because it would
> be less surprising for users of the API).
>=20

OK.

> About our default testing configuration for acceptance tests:
> should acceptance tests run against PC by default?  Should it
> test Q35?  Should we test both PC and Q35?  I'm not sure what's
> the answer, but I think these decisions shouldn't affect the
> qemu.py API at all.
>=20

OK.

To make sure we're on the same page, we're still going to have default
machine types, based on the arch, for those targets that don't provide
one (aarch64 is one example).  Right?

- Cleber.
