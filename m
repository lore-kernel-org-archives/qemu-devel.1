Received: from eggs.gnu.org ([2001:4830:134:3::10]:35436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQYs8-000114-Vv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQYs7-0005bs-Ji
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:48:37 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:56558
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dQYs7-0005aN-Da
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:48:35 -0400
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-4-git-send-email-frederic.konrad@adacore.com>
	<44cd89c9-bd70-874d-f2bf-f51a9b4170c3@amsat.org>
	<CAFEAcA80LV1pX9D==ednuc3p5-sHv7MMhtnLYtKN7VNTC9Zr8Q@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <b8647425-0ac5-4aa2-e70e-5421e59f3b7f@adacore.com>
Date: Thu, 29 Jun 2017 14:48:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80LV1pX9D==ednuc3p5-sHv7MMhtnLYtKN7VNTC9Zr8Q@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, alistair@alistair23.me, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>



On 06/29/2017 02:43 PM, Peter Maydell wrote:
> On 29 June 2017 at 13:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>> This is true it is better to abort here than risking a deadlock.
>>
>> However it seems to me they are 3 issues here:
>> - the deadlock pattern is caused by using a global variable,
>> - stellaris:ssys_calculate_system_clock() no checking RCC.SYSDIV and
>> RCC2.SYSDIV2 values <=3D 2 are reserved (GUEST_ERROR)
>> - stellaris:ssys_write(RCC2) not overrides correctly RCC
>=20
> Stellaris works fine. It's other ARMv7M boards (which might forget
> to set system_clock_scale) which don't work.

Yes actually the issue is with new boards when you forgot to set
system_clock_scale (as it happened to me :)).

Peter you suggest we fix that later when the clock is in place?

Fred

>=20
>> I'd rather take this opportunity to fix the deadlock pattern using a
>> getter/setter on system_clock_scale, doing the zero check in the sette=
r and
>> eventually aborting in the getter, what do you think?
>=20
> We should be using a clock property on the CPU instead of system_clock_=
scale.
> Unfortunately Konrad's series attempting to add that infrastructure
> is still in the "trying to sort out the right API in code review"
> stage. I don't think it's worth trying to fiddle with the API
> for it before we have the right eventual infrastructure in place.
>=20
> (What system_clock_scale is actually doing is setting the
> emulated frequency of the CPU, since that affects the
> frequency of the timer.)
>=20
> thanks
> -- PMM
>=20
