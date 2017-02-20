Received: from eggs.gnu.org ([2001:4830:134:3::10]:40742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cft45-0008HZ-UT
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cft45-0002uv-1i
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:52:01 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cft44-0002ug-RR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:52:00 -0500
Received: by mail-wr0-x22a.google.com with SMTP id 89so64928857wrr.3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 10:52:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b13702b2-44be-563b-5743-33c773a6e037@amsat.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-10-git-send-email-peter.maydell@linaro.org>
	<b13702b2-44be-563b-5743-33c773a6e037@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 18:51:39 +0000
Message-ID: <CAFEAcA_KnJPrKU2gWCkPJELkU3QtbTOu+_fMrHWwkPcwS+NE2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/11] armv7m: Split systick out
 from NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 20 February 2017 at 17:43, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 02/20/2017 12:36 PM, Peter Maydell wrote:
>> +/* Conversion factor from qemu timer to SysTick frequencies.  */
>> +static inline int64_t systick_scale(SysTickState *s)
>> +{
>> +    if (s->control & SYSTICK_CLKSOURCE) {
>> +        return system_clock_scale;
>> +    } else {
>> +        return 1000;
>
>
> this magic seems to be SYSTICK_SCALE
> (Paul Brook's commit 9ee6e8bb85)

This patch is just copying this function from one file to the other...
at some point we might want to try to improve the handling of
the clock scale factors but that leads into complication, because
the external-clocksource scale factor should really be board
level configurable. (Slightly confusingly the leg of this if/else
which is board-configurable is the one for the internal clock,
because we're modelling the ability of the stellaris board to
configure the PLLs so as to downclock the whole CPU, which
incidentally affects the timing of the internal systick clock.
Modelling this properly needs to wait on Fred Konrad's clocktree
patches getting in, I think.) For the moment I chose to just
leave the existing source alone, mostly.

>> +static void systick_instance_init(Object *obj)
>> +{
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>> +    SysTickState *s =3D SYSTICK(obj);
>> +
>> +    memory_region_init_io(&s->iomem, obj, &systick_ops, s, "systick",
>> 0xe0);
>
>
> It seems to me the correct size is 0x10. The manual describes the range
> 0x20-0xFF as _reserved_. This _reserved_ description is at the end of the
> 'SysTick' chapter which seems weird to me... I rather think this range
> belong to the 'Interrupt Controller'@'System Control Space'.

The table of the System Control Space (B3-3 in the v7M ARM ARM
rev E.b) defines the Systick space as 0xE000E010 - 0xE000E0FF,
which makes it 0xE0 bytes in size. The NVIC doesn't start
until 0xE000E100 in this table.

The table of the SysTick registers (B3-7) agrees, in that
it defines the registers as covering 0xE000E010 to 0xE000E0FF.
In the current architecture everything from 0x20..0xFF is
reserved, which just means there's nothing there, but if
there was ever a need for systick to get another register
for some reason then it would go into that space (and if
we then implemented the new register in QEMU we wouldn't need
to change the NVIC code, only the systick code).

I think the way this patch has modelled things matches the
architecture -- it's a guest error to access the gap between
0XE000E020 and 0xE000E0FF, but we should report it as an
attempt to access an invalid systick register rather than
an access to an invalid NVIC register.

thanks
-- PMM
