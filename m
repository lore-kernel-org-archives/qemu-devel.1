Received: from eggs.gnu.org ([2001:4830:134:3::10]:56718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAOfb-0004gh-Lz
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAOfY-0008Hs-Ve
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:17:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gAOfY-0008Gr-Lj
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:17:36 -0400
From: Cleber Rosa <crosa@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-5-crosa@redhat.com>
	<835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
	<95a8561c-0511-6a8a-a3eb-25d556029e7a@redhat.com>
	<20181010134656.GE5738@habkost.net>
	<47f72e98-335f-b3c9-54c7-4c8a468d85d6@redhat.com>
	<26fe2055-77c2-45fa-4e88-62101d70b88b@redhat.com>
	<20181010142840.GH5738@habkost.net>
	<118ed8f7-5947-12c6-f3f6-b10597f37aac@redhat.com>
Message-ID: <963e4f75-76a1-d3f3-3a03-b8de13429175@redhat.com>
Date: Wed, 10 Oct 2018 20:17:26 -0400
MIME-Version: 1.0
In-Reply-To: <118ed8f7-5947-12c6-f3f6-b10597f37aac@redhat.com>
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



On 10/10/18 11:47 AM, Cleber Rosa wrote:
>=20
>=20
> On 10/10/18 10:28 AM, Eduardo Habkost wrote:
>> On Wed, Oct 10, 2018 at 10:15:15AM -0400, Cleber Rosa wrote:
>>>
>>>
>>> On 10/10/18 9:59 AM, Cleber Rosa wrote:
>>>>
>>>>
>>>> On 10/10/18 9:46 AM, Eduardo Habkost wrote:
>>>>> On Wed, Oct 10, 2018 at 08:35:38AM -0400, Cleber Rosa wrote:
>>>>>>
>>>>>>
>>>>>> On 10/10/18 7:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>> On 10/10/2018 01:26, Cleber Rosa wrote:
>>>>>>>> Some targets require a machine type to be set, as there's no def=
ault
>>>>>>>> (aarch64 is one example).  To give a consistent interface to use=
rs of
>>>>>>>> this API, this changes set_machine() so that a predefined defaul=
t can
>>>>>>>> be used, if one is not given.  The approach used is exactly the =
same
>>>>>>>> with the console device type.
>>>>>>>>
>>>>>>>> Also, even when there's a default machine type, for some purpose=
s,
>>>>>>>> testing included, it's better if outside code is explicit about =
the
>>>>>>>> machine type, instead of relying on whatever is set internally.
>>>>>>>>
>>>>>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>>>>>> ---
>>>>>>>>  scripts/qemu.py | 22 +++++++++++++++++++++-
>>>>>>>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>>>>>> index d9e24a0c1a..fca9b76990 100644
>>>>>>>> --- a/scripts/qemu.py
>>>>>>>> +++ b/scripts/qemu.py
>>>>>>>> @@ -36,6 +36,15 @@ CONSOLE_DEV_TYPES =3D {
>>>>>>>>      r'^s390-ccw-virtio.*': 'sclpconsole',
>>>>>>>>      }
>>>>>>>> =20
>>>>>>>> +#: Maps archictures to the preferred machine type
>>>>>>>> +MACHINE_TYPES =3D {
>>>>>>>> +    r'^aarch64$': 'virt',
>>>>>>>> +    r'^ppc$': 'g3beige',
>>>>>>>> +    r'^ppc64$': 'pseries',
>>>>>>>> +    r'^s390x$': 's390-ccw-virtio',
>>>>>>>> +    r'^x86_64$': 'q35',
>>>>>>>
>>>>>>> Why choose Q35 rather than PC (the default)?
>>>>>>>
>>>>>>> I was wondering about how to generate variants/machines.json but =
this is
>>>>>>> definitively something we want to do via a QMP query.
>>>>>>>
>>>>>>> Eduardo what do you think?
>>>>>>>
>>>>>>
>>>>>> It was motivated by Eduardo's initiative to make q35 the default "=
across
>>>>>> the board".  He can confirm and give more details.
>>>>>
>>>>> Making Q35 the default on applications using QEMU and libvirt is
>>>>> something I'd like to happen.  But I think the simplest way to do
>>>>> that is to change the QEMU default.  This way you won't need this
>>>>> table on qemu.py: you can just use the default provided by QEMU.
>>>>>
>>>>
>>>> The idea is to bring consistency on how we're calling
>>>> "qemu-system-$(ARCH)", and at the same time apply the "explicit is
>>>> better than implicit" rule.
>>>>
>>>> The most important fact is that some targets do not (currently) have
>>>> "the default provided by QEMU", aarch64 is one of them.
>>>>
>>>> - Cleber.
>>>>
>>>
>>> So I ended up not relaying the question properly: should we default
>>> (even if explicitly adding "-machine") to "pc"?
>>
>> I think using the default machine-type (when QEMU has a default)
>> would be less surprising for users of the qemu.py API.
>>
>=20
> OK, agreed.
>=20
>> Implicitly adding -machine when there's no default is also
>> surprising, but then it's a nice surprise: instead of crashing
>> you get a running VM.
>>
>> Now, there are two other questions related to this:
>>
>> If using 'pc' as default, should we always add -machine, or just
>> omit the machine-type name?  I think we should omit it unless the
>> caller asked for a specific machine-type name (because it would
>> be less surprising for users of the API).
>>
>=20

Getting down to business, trying to apply those changes, I was faced
with a situation.  Actually, the same situation I faced a few months
ago.  Handling it was defered until it was *really* a blocker.
Basically the issue is: the set_console() method, which gives tests a
ready to use console, depends on knowing the machine type (see
CONSOLE_DEV_TYPES).

As a case study, let's look at "boot_console_linux.py":
 1) it sets the machine type explicitly
 2) it has nothing to do with the specific machine type
 3) the setting of a machine type is boiler plate code to set a console
 4) the console is used on the test's real purpose: verifying the Linux
kernel booted

Now, to be able to run the same test -- booting a Linux kernel -- on
*other target archs*, we need the same machinery.  Even more important:
to have similar tests we'll need to either abstract those features or
duplicate them.  This can be seen, at least in part, on the firmware
tests that Philippe sent to the list: they would also benefit from
having a console device ready to be used on the configured machine type[1=
]:

Assuming that we want to provide this type of machinery for free (or as
close as that) to the acceptance/functional tests, we need some source
of "known good" configuration for the targets we aim to support.

Let's restrict the discussion to the issue at hand, machine types, while
keeping in mind that the same pattern happened with devices types to use
as console before, and my experience running into default network device
types in further work (tests that interact with the guest by ssh'ing
into it).

The solutions I can think of are:

 1) run the target binary previous to the "real" run, and query
information -- this is what Avocado-VT does[2], and something I tried on
earlier versions of the acceptance tests infrastructure code

 2) attempt to get this information from the build system[3]

 3) hard code the "known" good configuration

I've previously worked on solutions along the lines of #1 and #2, but
the general feedback wasn't that positive, for valid reasons.  Eduardo
probably remembers this.

So, I'm tempted to try solution #3.  As much as duplicating target
defaults in qemu.py doesn't sound perfect, it seems to be the more
predictable and attainable solution at this point.

Thoughts?

Thanks!
- Cleber.

[1] - https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00591.html
[2] -
https://github.com/avocado-framework/avocado-vt/blob/65.0/virttest/utils_=
misc.py#L2105
[3] - http://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06757.html

> OK.
>=20
>> About our default testing configuration for acceptance tests:
>> should acceptance tests run against PC by default?  Should it
>> test Q35?  Should we test both PC and Q35?  I'm not sure what's
>> the answer, but I think these decisions shouldn't affect the
>> qemu.py API at all.
>>
>=20
> OK.
>=20
> To make sure we're on the same page, we're still going to have default
> machine types, based on the arch, for those targets that don't provide
> one (aarch64 is one example).  Right?
>=20
> - Cleber.
>=20
