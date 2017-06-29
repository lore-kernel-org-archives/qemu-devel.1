Received: from eggs.gnu.org ([2001:4830:134:3::10]:45158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQZKO-0005G3-I7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQZKK-00054Q-IZ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:17:47 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:41390
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dQZKK-000542-Cd
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:17:44 -0400
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-4-git-send-email-frederic.konrad@adacore.com>
	<44cd89c9-bd70-874d-f2bf-f51a9b4170c3@amsat.org>
	<CAFEAcA80LV1pX9D==ednuc3p5-sHv7MMhtnLYtKN7VNTC9Zr8Q@mail.gmail.com>
	<95e817f5-904e-83fd-eadb-2ab00ebddd9a@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <d4df2047-0058-d0ae-6d4c-48bf8c408f2c@adacore.com>
Date: Thu, 29 Jun 2017 15:17:37 +0200
MIME-Version: 1.0
In-Reply-To: <95e817f5-904e-83fd-eadb-2ab00ebddd9a@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/3] armv7m_systick: abort instead of
 locking on a bad rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, alistair@alistair23.me, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>



On 06/29/2017 03:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/29/2017 09:43 AM, Peter Maydell wrote:
>> On 29 June 2017 at 13:35, Philippe Mathieu-Daud=C3=A9=20
>> <f4bug@amsat.org> wrote:
>>> This is true it is better to abort here than risking a deadlock.
>>>
>>> However it seems to me they are 3 issues here:
>>> - the deadlock pattern is caused by using a global variable,
>>> - stellaris:ssys_calculate_system_clock() no checking=20
>>> RCC.SYSDIV and
>>> RCC2.SYSDIV2 values <=3D 2 are reserved (GUEST_ERROR)
>>> - stellaris:ssys_write(RCC2) not overrides correctly RCC
>>
>> Stellaris works fine. It's other ARMv7M boards (which might forget
>> to set system_clock_scale) which don't work.
>=20
> Oh I misread ssys_calculate_system_clock(), indeed=20
> system_clock_scale can not get below 5 so no deadlock on Stellaris.
>=20
>>> I'd rather take this opportunity to fix the deadlock pattern=20
>>> using a
>>> getter/setter on system_clock_scale, doing the zero check in=20
>>> the setter and
>>> eventually aborting in the getter, what do you think?
>>
>> We should be using a clock property on the CPU instead of=20
>> system_clock_scale.
>> Unfortunately Konrad's series attempting to add that=20
>> infrastructure
>> is still in the "trying to sort out the right API in code review"
>> stage. I don't think it's worth trying to fiddle with the API
>> for it before we have the right eventual infrastructure in place.
>=20
> I see. I'd rather move the comment and assert() in systick_scale().

Makes sense, I missed the potential divide-by-zero exception
which might happen in SysTick Current Value:

val =3D ((s->tick - (t + 1)) / systick_scale(s)) + 1;

I'll do the change and re-post a V2 when there will be some input
on the two first patches.

Thanks,
Fred

>=20
>> (What system_clock_scale is actually doing is setting the
>> emulated frequency of the CPU, since that affects the
>> frequency of the timer.)
>=20
