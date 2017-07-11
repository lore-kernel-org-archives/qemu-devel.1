Received: from eggs.gnu.org ([2001:4830:134:3::10]:42511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUuw0-00070k-EY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUuvv-00010v-Ol
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:10:36 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUuvv-00010N-He
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:10:31 -0400
Received: by mail-wr0-f181.google.com with SMTP id r103so183028316wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 06:10:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b3cd94f2-8a32-9b09-54b1-0cfa6eff0c36@amsat.org>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-7-git-send-email-peter.maydell@linaro.org>
	<b3cd94f2-8a32-9b09-54b1-0cfa6eff0c36@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 14:09:09 +0100
Message-ID: <CAFEAcA8cxuj04T5qDE7xPjTEXOcGZdhnZvaGOdmb08KjyjsE3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 6/7] hw/misc/mps2_scc: Implement
 MPS2 Serial Communication Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 11 July 2017 at 13:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> I Peter,
>
> On 07/11/2017 08:17 AM, Peter Maydell wrote:
>>
>> Implement a model of the Serial Communication Controller (SCC) found
>> in MPS2 FPGA images.
>>
>> The primary purpose of this device is to communicate with the
>> Motherboard Configuration Controller (MCC) which is located on
>> the MPS board itself, outside the FPGA image. This is used
>> for programming the MPS clock generators. The SCC also has
>> some basic ID registers and an output for the board LEDs.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/misc/Makefile.objs           |   1 +
>>   include/hw/misc/mps2-scc.h      |  43 ++++++
>>   hw/misc/mps2-scc.c              | 310
>> ++++++++++++++++++++++++++++++++++++++++
>
>
> Hmm I understand hw/ssi is for Synchronous Serial Interface, this interfa=
ce
> doesn't belong there?

No, it's not an SSI bus -- that's a standardized clocked
point-to-point serial interface. This is just a fairly
ad-hoc communication channel.

>> +++ b/include/hw/misc/mps2-scc.h
>> @@ -0,0 +1,43 @@
>> +/*
>> + * ARM CMSDK APB timer emulation
>
>
> ARM MPS2 SCC emulation

Oops; fixed.

>> +static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned siz=
e)
>> +{
>> +    MPS2SCC *s =3D MPS2_SCC(opaque);
>> +    uint64_t r;
>> +
>> +    switch (offset) {
>> +    case A_CFG0:
>> +        r =3D s->cfg0;
>> +        break;
>> +    case A_CFG1:
>> +        r =3D s->cfg1;
>> +        break;
>> +    case A_CFG3:
>> +        /* These are user-settable DIP switches on the board. We don't
>> +         * model that, so just return zeroes.
>> +         */
>
>
> Shouldn't be hard to have a property (thinking about having multiple boar=
ds
> and using those switches to have some board unique ID, not switches one
> might toggle at runtime).

No, on the board these are wired up to user-toggled switches.
Board ID information is in the ID/AID/CFG4 registers, which we have
properties for.


>> +    case A_CFG1:
>> +        /* CFG1 bits [7:0] control the board LEDs. We don't currently
>> have
>> +         * a mechanism for displaying this graphically, so use a trace
>> event.
>> +         */
>
>
> Well MIPS Jazz uses hw/display/jazz_led.c which is kinda nice :)
>
> Now than there is interest in simulating IoT boards and so, we might thin=
k
> about a generic LED display.

Yeah, if we do this at all we should have generic support (and
ideally you might want to see both the LED output and the
LCD screen output at the same time). This tracepoint is a
low-effort placeholder because I don't want to get into trying
to define and implement a generic LED-and-switches kind of UI.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

thanks
-- PMM
