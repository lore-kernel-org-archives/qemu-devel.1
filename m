Received: from eggs.gnu.org ([2001:4830:134:3::10]:56497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eesWP-0000v5-1p
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 20:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eesWN-0000jq-Sz
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 20:09:37 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:37412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eesWN-0000hw-KC
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 20:09:35 -0500
Received: by mail-lf0-x243.google.com with SMTP id 63so5898778lfv.4
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 17:09:35 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA-eOMvYYv--wjs+i1wGG3AN1VueqZjtnE5vpBH=UavkfQ@mail.gmail.com>
References: <cover.1516746211.git.alistair.francis@xilinx.com>
	<29c39a6f9ce3734bf693581348ed78f4bff3e0ef.1516746211.git.alistair.francis@xilinx.com>
	<CAFEAcA-eOMvYYv--wjs+i1wGG3AN1VueqZjtnE5vpBH=UavkfQ@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 25 Jan 2018 17:09:03 -0800
Message-ID: <CAKmqyKPAmzwFkY5MAiPA-epY-HCbBfBpHGWdanvEef2keaSXew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/3] xlnx-zynqmp-rtc: Add basic time
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

On Thu, Jan 25, 2018 at 3:36 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 January 2018 at 22:24, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> Allow the guest to determine the time set from the QEMU command line.
>>
>> This includes adding a trace event to debug the new time.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>  static const VMStateDescription vmstate_rtc = {
>>      .name = TYPE_XLNX_ZYNQMP_RTC,
>>      .version_id = 1,
>>      .minimum_version_id = 1,
>> +    .post_load = rtc_post_load,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
>> +        VMSTATE_INT32(current_tm.tm_sec, XlnxZynqMPRTC),
>> +        VMSTATE_INT32(current_tm.tm_min, XlnxZynqMPRTC),
>> +        VMSTATE_INT32(current_tm.tm_hour, XlnxZynqMPRTC),
>> +        VMSTATE_INT32(current_tm.tm_wday, XlnxZynqMPRTC),
>> +        VMSTATE_INT32(current_tm.tm_mday, XlnxZynqMPRTC),
>> +        VMSTATE_INT32(current_tm.tm_mon, XlnxZynqMPRTC),
>> +        VMSTATE_INT32(current_tm.tm_year, XlnxZynqMPRTC),
>
> I'm still not sure about having the current_tm struct fields
> here rather than whatever the hardware's natural representation
> of the current time is. Can you explain why you think this
> is the best approach?

This means that the only thing we have to track is the time that the
user set, either through the QEMU command line arguments as an
override or the original starting time. Then from there we can always
calculate the correct offset based on our current time.

I don't see a nicer way, otherwise we need to recalculate the natural
representation before and after migration using something more
complex. This way it's always the same logic, we just run it at init
and after migration.

Alistair

>
> thanks
> -- PMM
