Received: from eggs.gnu.org ([2001:4830:134:3::10]:55594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqiz1-0004wI-Am
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eqiz0-0005g9-GR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:24:07 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eqiz0-0005fv-87
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:24:06 -0500
Received: by mail-lf0-x242.google.com with SMTP id g72so9249921lfg.3
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:24:06 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA_U98jy+v0qKDKvYqh4LidHE-hdzNz=FdGBRKSdeexPoA@mail.gmail.com>
References: <cover.1519406423.git.alistair.francis@xilinx.com>
	<0f4e15f8aafe82a7b36318c0689f49c974b3402a.1519406423.git.alistair.francis@xilinx.com>
	<CAFEAcA_U98jy+v0qKDKvYqh4LidHE-hdzNz=FdGBRKSdeexPoA@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Feb 2018 09:23:34 -0800
Message-ID: <CAKmqyKMn+87rvTms0CkP4yqcx_aC7-QAgc=TmxLtcXNNQRh9zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Tue, Feb 27, 2018 at 8:36 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 February 2018 at 17:21, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> Allow the guest to determine the time set from the QEMU command line.
>>
>> This includes adding a trace event to debug the new time.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>
> Thanks for reworking this -- I think it looks simpler this way.
>
>> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
>> index 87649836cc..2867563bdd 100644
>> --- a/include/hw/timer/xlnx-zynqmp-rtc.h
>> +++ b/include/hw/timer/xlnx-zynqmp-rtc.h
>> @@ -79,6 +79,9 @@ typedef struct XlnxZynqMPRTC {
>>      qemu_irq irq_rtc_int;
>>      qemu_irq irq_addr_error_int;
>>
>> +    struct tm current_tm;
>> +    uint32_t tick_offset;
>> +
>
> Do we need current_tm to be a struct field now?
>
>> @@ -143,6 +164,10 @@ static void rtc_reset(DeviceState *dev)
>>          register_reset(&s->regs_info[i]);
>>      }
>>
>> +    trace_xlnx_zynqmp_rtc_gettime(s->current_tm.tm_year, s->current_tm.tm_mon,
>> +                                  s->current_tm.tm_mday, s->current_tm.tm_hour,
>> +                                  s->current_tm.tm_min, s->current_tm.tm_sec);
>> +
>
> ...this trace is in reset, and is the only place we read
> current_tm, except for...
>
>>      rtc_int_update_irq(s);
>>      addr_error_int_update_irq(s);
>>  }
>> @@ -178,14 +203,46 @@ static void rtc_init(Object *obj)
>>      sysbus_init_mmio(sbd, &s->iomem);
>>      sysbus_init_irq(sbd, &s->irq_rtc_int);
>>      sysbus_init_irq(sbd, &s->irq_addr_error_int);
>> +
>> +    qemu_get_timedate(&s->current_tm, 0);
>> +    s->tick_offset = mktimegm(&s->current_tm) -
>> +        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
>
> ...this code in init, which could just use a local variable
> instead, since the trace in reset isn't really reporting
> interesting information any more (the value never changes, so
> you could trace it in init instead).

Yeah you are right. I have moved it all to the init() function.

Alistair

>
>> +}
>>
>
> thanks
> -- PMM
