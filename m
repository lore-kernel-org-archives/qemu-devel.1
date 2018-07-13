Received: from eggs.gnu.org ([2001:4830:134:3::10]:45090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdzlr-00023b-UT
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdzlq-0006Te-T3
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:14:11 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdzlq-0006TP-M0
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:14:10 -0400
Received: by mail-oi0-x242.google.com with SMTP id v8-v6so62843015oie.5
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 08:14:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-q-cCJMVjPwu8UC667EyngNAoxQK6mb6Yjj5RL54b6uw@mail.gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<66872d46-25b1-aa14-407d-359bae14815b@amsat.org>
	<CAFEAcA-q-cCJMVjPwu8UC667EyngNAoxQK6mb6Yjj5RL54b6uw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jul 2018 16:13:49 +0100
Message-ID: <CAFEAcA9_BPxnnqFQ=inNNUefaBsF1pfA2VtY4PQ=TATRx_NBsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] accel/tcg: Support
 execution from MMIO and small MMU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>

On 12 July 2018 at 17:37, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 11 July 2018 at 05:21, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
>> I applied and quickly tested your series on a MIPS SoC I'm working on
>> which has a tiny SRAM:
>>
>> (qemu) info mtree
>> address-space: memory
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>     0000000000000000-00000000000007ff (prio 0, ram): sram
>>     0000000010000000-00000000107fffff (prio 0, i/o): pflash
>>     0000000014000000-0000000014ffffff (prio 0, ram): dram
>>     000000001fc00000-000000001fc0ffff (prio 0, rom): srom
>>
>> The firmware copies the ISR in this SRAM area, sadly it didn't work as
>> expected:
>>
>> qemu-system-mips: Bad ram pointer 0x4a4

> Are you sure this is executing from the SRAM at this point?
> The PC value in the backtrace is 2415932580 =3D=3D 900034A4. I don't
> know how the MMU is configured at this point, but my guess is that
> that's actually in the pflash area, and you're running into a
> different bug:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg00674.html
> where when we attempt to execute from a romd device that's in romd
> mode we incorrectly think it's RAM in get_page_addr_code() and crash.

I just sent a follow-on patch which should fix the 'bad ram pointer'
assert. If your guest really is trying to execute from the pflash
here then it will just misbehave in a different way, though,
since pflash status response bytes are probably not valid MIPS
instructions...

thanks
-- PMM
