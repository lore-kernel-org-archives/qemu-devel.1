Received: from eggs.gnu.org ([2001:4830:134:3::10]:48003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbqT-0006kV-A4
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbqQ-0004N6-4R
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:58:49 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33106)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbqP-0004Ju-Ni
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:58:46 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-6-contrib@steffen-goertz.de>
	<20181101111743.GM24946@stefanha-x1.localdomain>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <d39f2690-5ad5-72e5-17d1-61323232db76@steffen-goertz.de>
Date: Fri, 2 Nov 2018 11:58:43 -0400
MIME-Version: 1.0
In-Reply-To: <20181101111743.GM24946@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/13] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>

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
sysbus_init_mmio(sbd, &s->uicr);

That should do the trick.
A reset without loading of a new firmware blob will not change the (flash) user memory any longer, which should match the real device.

Best,
Steffen


[1] http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
