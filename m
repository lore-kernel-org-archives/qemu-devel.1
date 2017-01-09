Received: from eggs.gnu.org ([2001:4830:134:3::10]:52123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cQfFd-0005YB-HS
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cQfFa-0002qt-TW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:05:01 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cQfFa-0002pS-Lx
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:04:58 -0500
Received: by mail-lf0-x243.google.com with SMTP id v186so6475182lfa.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 11:04:58 -0800 (PST)
References: <20170104220624.26557-1-jcd@tribudubois.net>
	<CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <1be7123c-acee-7d16-8a10-c8965d5805ff@gmail.com>
Date: Mon, 9 Jan 2017 20:04:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] [i.MX] fix CS handling during SPI
 access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>



W dniu 09.01.2017 o 11:46, Peter Maydell pisze:
> On 4 January 2017 at 22:06, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>> The i.MX SPI device was not de-asserting the CS line at the end of
>> memory access.
>>
>> This triggered a SIGSEGV in Qemu when the sabrelite emulator was acessing
>> a SPI flash memory.
>>
>> Whith this path the CS signal is correctly asserted and deasserted arround
>> memory access.
>>
>> Assertion level is now based on SPI device configuration.
>>
>> This was tested by:
>> * booting linux on Sabrelite Qemu emulator.
>> * booting xvisor on Sabrelite Qemu emultor.
>>
>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>> Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
>>   static void imx_spi_reset(DeviceState *dev)
>>   {
>>       IMXSPIState *s = IMX_SPI(dev);
>> +    uint32_t i;
>>
>>       DPRINTF("\n");
>>
>> @@ -243,6 +263,11 @@ static void imx_spi_reset(DeviceState *dev)
>>       imx_spi_update_irq(s);
>>
>>       s->burst_length = 0;
>> +
>> +    /* Disable all CS lines */
>> +    for (i = 0; i < 4; i++) {
>> +        qemu_set_irq(s->cs_lines[i], !imx_spi_channel_pol(s, i));
>> +    }
> Calling qemu_set_irq() in a device reset function is a bit
> tricky, because in a full system reset the device at the other
> end might have already reset or might not, and calling into
> its handler function for the irq line change might provoke
> an unwanted change of its state. We don't really have a coherent
> model here but for the moment we just try to avoid calling
> set_irq in a reset method.
JC, if you remove qemu_set_irq() call from reset, at least m25p80 behavior
should not change since m25p80 reset handler will reset it's whole 
internal state.

Thanks,
Marcin
>
> thanks
> -- PMM
>
