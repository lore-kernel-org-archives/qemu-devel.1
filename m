Received: from eggs.gnu.org ([2001:4830:134:3::10]:34616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQYnD-0006ch-0P
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQYnC-0001su-6e
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:43:31 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQYnB-0001rf-VU
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:43:30 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so188935374wrb.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 05:43:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <44cd89c9-bd70-874d-f2bf-f51a9b4170c3@amsat.org>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-4-git-send-email-frederic.konrad@adacore.com>
	<44cd89c9-bd70-874d-f2bf-f51a9b4170c3@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 13:43:08 +0100
Message-ID: <CAFEAcA80LV1pX9D==ednuc3p5-sHv7MMhtnLYtKN7VNTC9Zr8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>, alistair@alistair23.me, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 29 June 2017 at 13:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> This is true it is better to abort here than risking a deadlock.
>
> However it seems to me they are 3 issues here:
> - the deadlock pattern is caused by using a global variable,
> - stellaris:ssys_calculate_system_clock() no checking RCC.SYSDIV and
> RCC2.SYSDIV2 values <=3D 2 are reserved (GUEST_ERROR)
> - stellaris:ssys_write(RCC2) not overrides correctly RCC

Stellaris works fine. It's other ARMv7M boards (which might forget
to set system_clock_scale) which don't work.

> I'd rather take this opportunity to fix the deadlock pattern using a
> getter/setter on system_clock_scale, doing the zero check in the setter a=
nd
> eventually aborting in the getter, what do you think?

We should be using a clock property on the CPU instead of system_clock_scal=
e.
Unfortunately Konrad's series attempting to add that infrastructure
is still in the "trying to sort out the right API in code review"
stage. I don't think it's worth trying to fiddle with the API
for it before we have the right eventual infrastructure in place.

(What system_clock_scale is actually doing is setting the
emulated frequency of the CPU, since that affects the
frequency of the timer.)

thanks
-- PMM
