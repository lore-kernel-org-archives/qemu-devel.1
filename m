Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqy9g-0007H0-M0
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqy8x-0000xZ-LP
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:07:40 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:32996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqy8x-0000wT-Dr
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:07:39 -0400
Received: by mail-oi0-x242.google.com with SMTP id 8-v6so18211288oip.0
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 03:07:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e65ebee0-33bf-3bb5-fc9a-2a60532af74e@amsat.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-17-peter.maydell@linaro.org>
	<e65ebee0-33bf-3bb5-fc9a-2a60532af74e@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Aug 2018 11:07:18 +0100
Message-ID: <CAFEAcA8==GqUH4mOc0ne9iCvUCpsqQmkRw8cYpu+GqM7Akd0Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 16/16] hw/arm/mps2-tz: Create
 PL081s and MSCs
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

On 18 August 2018 at 02:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 08/09/2018 10:01 AM, Peter Maydell wrote:
>> The AN505 FPGA image includes four PL081 DMA controllers, each
>> of which is gated by a Master Security Controller that allows
>> the guest to prevent a non-secure DMA controller from accessing
>> memory that is used by secure guest code. Create and wire
>> up these devices.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/arm/mps2-tz.c | 101 +++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 94 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
>> index 22180c56fb7..7d92bc5fe1c 100644
>> --- a/hw/arm/mps2-tz.c
>> +++ b/hw/arm/mps2-tz.c
>> @@ -45,7 +45,9 @@
>>  #include "hw/misc/mps2-scc.h"
>>  #include "hw/misc/mps2-fpgaio.h"
>>  #include "hw/misc/tz-mpc.h"
>> +#include "hw/misc/tz-msc.h"
>>  #include "hw/arm/iotkit.h"
>> +#include "hw/dma/pl080.h"
>>  #include "hw/devices.h"
>>  #include "net/net.h"
>>  #include "hw/core/split-irq.h"
>> @@ -75,8 +77,9 @@ typedef struct {
>>      UnimplementedDeviceState i2c[4];
>>      UnimplementedDeviceState i2s_audio;
>>      UnimplementedDeviceState gpio[4];
>> -    UnimplementedDeviceState dma[4];
>>      UnimplementedDeviceState gfx;
>> +    PL080State dma[4];
>> +    TZMSC msc[4];
>>      CMSDKAPBUART uart[5];
>>      SplitIRQ sec_resp_splitter;
>>      qemu_or_irq uart_irq_orgate;
>> @@ -273,6 +276,65 @@ static MemoryRegion *make_mpc(MPS2TZMachineState *m=
ms, void *opaque,
>>      return sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 0);
>>  }
>>
>> +static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
>> +                              const char *name, hwaddr size)
>> +{
>> +    PL080State *dma =3D opaque;
>> +    int i =3D dma - &mms->dma[0];
>
> This line is not trivial to read. I wondered "isn't this ptrdiff_t? why
> not divide by sizeof(dma)...

It's following the same approach as the other existing
make_*() functions in this file, though.


>> +    SysBusDevice *s;
>> +    char *mscname =3D g_strdup_printf("%s-msc", name);
>> +    TZMSC *msc =3D &mms->msc[i];
>> +    DeviceState *iotkitdev =3D DEVICE(&mms->iotkit);
>> +    MemoryRegion *msc_upstream;
>> +    MemoryRegion *msc_downstream;
>> +
>> +    /*
>> +     * Each DMA device is a PL081 whose transaction master interface
>> +     * is guarded by a Master Security Controller. The downstream end o=
f
>> +     * the MSC connects to the IoTKit AHB Slave Expansion port, so the
>> +     * DMA devices can see all devices and memory that the CPU does.
>> +     */
>> +    init_sysbus_child(OBJECT(mms), mscname, msc, sizeof(mms->msc[0]),
>
> sizeof(*msc) easier to read?

That would work and probably is better; again I was just following
the same thing I'd done in other make_*() functions earlier.

thanks
-- PMM
