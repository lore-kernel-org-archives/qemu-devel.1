Received: from eggs.gnu.org ([2001:4830:134:3::10]:47681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbpj-00062e-5J
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbpi-000312-6b
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:58:03 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-13-contrib@steffen-goertz.de>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <bdcf79c4-d5af-0e03-0963-78603b268467@steffen-goertz.de>
Date: Fri, 2 Nov 2018 11:57:54 -0400
MIME-Version: 1.0
In-Reply-To: <20181031002526.14262-13-contrib@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/13] arm: Instantiate NRF51 Timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, "open list:NRF51" <qemu-arm@nongnu.org>

Hi Stefan,
> 
> Indentation is off here.  One way of formatting it:
> 
>                 address_space_write(&s->as, i * NRF51_PAGE_SIZE,
>                                     MEMTXATTRS_UNSPECIFIED, s->empty_page,
> 				    NRF51_PAGE_SIZE);

Good catch.

>> +static void nrf51_nvm_reset(DeviceState *dev)
>> +{
>> +    NRF51NVMState *s = NRF51_NVM(dev);
>> +
>> +    memset(s->uicr_content, '\0', sizeof(s->uicr_content));
>> +}
> 
> We will zero UICR.  Does UICR come zero-initialized on a real micro:bit?
> 
> I remember there was an issue with .hex files that set UICR values.
> Will nrf51_nvm_reset() overwrite values from .hex files when the generic
> loader devices is used (-device loader,file=test.hex)?
> 
UICR comes 0xFF initialized ([1] 8.1) and yes we had a conflict with the js-runtime.
I now moved the memset to init just before mapping the region:

memset(s->uicr_content, 0xFF, sizeof(s->uicr_content));
memory_region_init_io(&s->uicr, NULL, &uicr_ops, s, "nrf51_soc.uicr",
                      sizeof(s->uicr_content));
ysbus_init_mmio(sbd, &s->uicr);

That should do the trick.
A reset without loading of a new firmware blob will not change the (flash) user memory any longer, which should match the real device.

Best,
Steffen


[1] http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
