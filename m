Received: from eggs.gnu.org ([2001:4830:134:3::10]:38977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZ67-0005V5-Aq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZ62-0000bm-Kn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:03:03 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:34569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZ62-0000bU-Gb
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:02:58 -0400
Received: by mail-qt0-x236.google.com with SMTP id 32so73514231qtv.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:02:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-4-git-send-email-frederic.konrad@adacore.com>
	<44cd89c9-bd70-874d-f2bf-f51a9b4170c3@amsat.org>
	<CAFEAcA80LV1pX9D==ednuc3p5-sHv7MMhtnLYtKN7VNTC9Zr8Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <95e817f5-904e-83fd-eadb-2ab00ebddd9a@amsat.org>
Date: Thu, 29 Jun 2017 10:02:52 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80LV1pX9D==ednuc3p5-sHv7MMhtnLYtKN7VNTC9Zr8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, alistair@alistair23.me, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 06/29/2017 09:43 AM, Peter Maydell wrote:
> On 29 June 2017 at 13:35, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> This is true it is better to abort here than risking a deadlock.
>>
>> However it seems to me they are 3 issues here:
>> - the deadlock pattern is caused by using a global variable,
>> - stellaris:ssys_calculate_system_clock() no checking RCC.SYSDIV and
>> RCC2.SYSDIV2 values <= 2 are reserved (GUEST_ERROR)
>> - stellaris:ssys_write(RCC2) not overrides correctly RCC
> 
> Stellaris works fine. It's other ARMv7M boards (which might forget
> to set system_clock_scale) which don't work.

Oh I misread ssys_calculate_system_clock(), indeed system_clock_scale 
can not get below 5 so no deadlock on Stellaris.

>> I'd rather take this opportunity to fix the deadlock pattern using a
>> getter/setter on system_clock_scale, doing the zero check in the setter and
>> eventually aborting in the getter, what do you think?
> 
> We should be using a clock property on the CPU instead of system_clock_scale.
> Unfortunately Konrad's series attempting to add that infrastructure
> is still in the "trying to sort out the right API in code review"
> stage. I don't think it's worth trying to fiddle with the API
> for it before we have the right eventual infrastructure in place.

I see. I'd rather move the comment and assert() in systick_scale().

> (What system_clock_scale is actually doing is setting the
> emulated frequency of the CPU, since that affects the
> frequency of the timer.)
