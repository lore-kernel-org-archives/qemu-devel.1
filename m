Received: from eggs.gnu.org ([2001:4830:134:3::10]:56322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBMbf-0002st-GZ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBMbe-0002uu-JA
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:45:19 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBMbe-0002tW-Eq
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:45:18 -0400
Received: by mail-oi0-x241.google.com with SMTP id e80-v6so13832534oig.11
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:45:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <609a3ccf-88d7-bad3-c37a-eec6bcab0235@amsat.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-8-peter.maydell@linaro.org>
	<609a3ccf-88d7-bad3-c37a-eec6bcab0235@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Apr 2018 16:44:57 +0100
Message-ID: <CAFEAcA8M6s-PjFbnuOkPHRSSb+dW2LH9D26p4VfogsdPenPAEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/13] Change references to serial_hds[] to
 serial_hd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 25 April 2018 at 15:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Hi Peter,
>
> On 04/20/2018 11:52 AM, Peter Maydell wrote:
>> Change all the uses of serial_hds[] to go via the new
>> serial_hd() function. Code change produced with:
>>  find hw -name '*.[ch]' | xargs sed -i -e 's/serial_hds\[\([^]]*\)\]/ser=
ial_hd(\1)/g'
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>> --- a/hw/arm/mps2-tz.c
>> +++ b/hw/arm/mps2-tz.c
>> @@ -172,7 +172,7 @@ static MemoryRegion *make_uart(MPS2TZMachineState *m=
ms, void *opaque,
>>  {
>>      CMSDKAPBUART *uart =3D opaque;
>>      int i =3D uart - &mms->uart[0];
>> -    Chardev *uartchr =3D i < MAX_SERIAL_PORTS ? serial_hds[i] : NULL;
>> +    Chardev *uartchr =3D i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL;
>
> You can remove uartchr and directly use serial_hd(i).

These kinds of cleanup are in later patches in the series --
this one is kept strictly to the purely-mechanical sed change,
as otherwise it would be a bit awkward to review I thought.

>> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
>> index f68df56b97..75c44adf7d 100644
>> --- a/hw/arm/msf2-soc.c
>> +++ b/hw/arm/msf2-soc.c
>> @@ -138,10 +138,10 @@ static void m2sxxx_soc_realize(DeviceState *dev_so=
c, Error **errp)
>>      system_clock_scale =3D NANOSECONDS_PER_SECOND / s->m3clk;
>>
>>      for (i =3D 0; i < MSF2_NUM_UARTS; i++) {
>> -        if (serial_hds[i]) {
>> +        if (serial_hd(i)) {
>
> We can now remove this check, but maybe another series...
>
>>              serial_mm_init(get_system_memory(), uart_addr[i], 2,
>>                             qdev_get_gpio_in(armv7m, uart_irq[i]),
>> -                           115200, serial_hds[i], DEVICE_NATIVE_ENDIAN)=
;
>> +                           115200, serial_hd(i), DEVICE_NATIVE_ENDIAN);
>>          }

I agree that's probably a good change to make, but it's also
a behavioural change (we would go from only creating serial
devices where -serial args are given, to always creating
them). I wanted to generally avoid having any behavioural
changes in this series.

>> @@ -3963,21 +3963,21 @@ struct omap_mpu_state_s *omap310_mpu_init(Memory=
Region *system_memory,
>>                      omap_findclk(s, "uart1_ck"),
>>                      s->drq[OMAP_DMA_UART1_TX], s->drq[OMAP_DMA_UART1_RX=
],
>>                      "uart1",
>> -                    serial_hds[0]);
>> +                    serial_hd(0));
>>      s->uart[1] =3D omap_uart_init(0xfffb0800,
>>                                  qdev_get_gpio_in(s->ih[1], OMAP_INT_UAR=
T2),
>>                      omap_findclk(s, "uart2_ck"),
>>                      omap_findclk(s, "uart2_ck"),
>>                      s->drq[OMAP_DMA_UART2_TX], s->drq[OMAP_DMA_UART2_RX=
],
>>                      "uart2",
>> -                    serial_hds[0] ? serial_hds[1] : NULL);
>> +                    serial_hd(0) ? serial_hd(1) : NULL);
>
> This will need cleanup later...

It's a bit weird, but I don't think it's specifically wrong.

>> --- a/hw/mips/mips_mipssim.c
>> +++ b/hw/mips/mips_mipssim.c
>> @@ -213,8 +213,8 @@ mips_mipssim_init(MachineState *machine)
>>
>>      /* A single 16450 sits at offset 0x3f8. It is attached to
>>         MIPS CPU INT2, which is interrupt 4. */
>> -    if (serial_hds[0])
>> -        serial_init(0x3f8, env->irq[4], 115200, serial_hds[0],
>> +    if (serial_hd(0))
>
> We will drop this if () later... This now misses brackets :/

Hazard of pure-mechanical-change cleanup is that it
doesn't include coding-style fixes, but it's no
worse than it was before.

thanks
-- PMM
