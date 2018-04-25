Received: from eggs.gnu.org ([2001:4830:134:3::10]:49499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBMH6-0007sN-4p
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBMH2-0005Mc-Qd
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:24:04 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBMH2-0005MT-Lm
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:24:00 -0400
Received: by mail-qt0-x242.google.com with SMTP id h2-v6so15224144qtp.7
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:24:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-10-peter.maydell@linaro.org>
	<2116cce5-6920-a42a-a4c0-880c102b30e6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4106d86f-82f8-727d-62b4-82374b16bccb@amsat.org>
Date: Wed, 25 Apr 2018 12:23:56 -0300
MIME-Version: 1.0
In-Reply-To: <2116cce5-6920-a42a-a4c0-880c102b30e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/13] hw/char/exynos4210_uart.c: Remove
 unneeded handling of NULL chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

Hi Thomas,

On 04/25/2018 12:05 PM, Thomas Huth wrote:
> On 20.04.2018 16:52, Peter Maydell wrote:
>> The handling of NULL chardevs in exynos4210_uart_create() is now
>> all unnecessary: we don't need to create 'null' chardevs, and we
>> don't need to enforce a bounds check on serial_hd().
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/char/exynos4210_uart.c | 20 --------------------
>>  1 file changed, 20 deletions(-)
>>
>> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
>> index c2bba03362..a5a285655f 100644
>> --- a/hw/char/exynos4210_uart.c
>> +++ b/hw/char/exynos4210_uart.c
>> @@ -589,28 +589,8 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
>>      DeviceState  *dev;
>>      SysBusDevice *bus;
>>  
>> -    const char chr_name[] = "serial";
>> -    char label[ARRAY_SIZE(chr_name) + 1];
>> -
>>      dev = qdev_create(NULL, TYPE_EXYNOS4210_UART);
>>  
>> -    if (!chr) {
>> -        if (channel >= MAX_SERIAL_PORTS) {
>> -            error_report("Only %d serial ports are supported by QEMU",
>> -                         MAX_SERIAL_PORTS);
>> -            exit(1);
>> -        }
> 
> If I get the EXYNOS 4210 data sheet right, this chip has only 4 channels
> indeed:
> 
> http://www.samsung.com/global/business/semiconductor/file/product/Exynos_4_Dual_45nm_User_Manaul_Public_REV1.00-0.pdf
> 
> So I think you should at least keep an "assert(channel < 4)" in here?

This file models a single UART, I don't think a such assert belongs here.

Although it is named EXYNOS4210, I'm pretty sure it should works to
model UARTs from other SoCs from the Exynos4xxx series.

There are no restriction on newer SoCs to have > 4 UARTs.

For this particular Exynos4210 SoC, the 4 channels are correctly limited
in exynos4210_init().

Regards,

Phil.

> 
> Apart from that, the patch looks sane to me, so when you add that assert():
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
