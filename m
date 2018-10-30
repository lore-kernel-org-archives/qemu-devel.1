Received: from eggs.gnu.org ([2001:4830:134:3::10]:36913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHPV4-0007DO-PJ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHPUz-00074p-OF
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:35:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHPUx-0006tT-0U
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:35:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so11550900wrs.5
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 01:35:29 -0700 (PDT)
References: <20181029232100.8454-1-philmd@redhat.com>
	<20181029232100.8454-3-philmd@redhat.com>
	<d3a957a8-754a-5d25-b776-d1ab9583c93a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e0ce22e6-7a71-98f2-abbc-ec430fda5178@redhat.com>
Date: Tue, 30 Oct 2018 09:35:25 +0100
MIME-Version: 1.0
In-Reply-To: <d3a957a8-754a-5d25-b776-d1ab9583c93a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/dma/pl330: Factor out pl330_init()
 from hw/arm/xilinx_zynq.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 30/10/18 9:18, Richard Henderson wrote:
> On 10/29/18 11:20 PM, Philippe Mathieu-Daudé wrote:
>> +static inline void pl330_init(uint32_t base, qemu_irq irq, int nreq)
>> +{
>> +    SysBusDevice *busdev;
>> +    DeviceState *dev;
>> +
>> +    dev = qdev_create(NULL, TYPE_PL330);
>> +    qdev_prop_set_uint8(dev, "num_chnls", 8);
>> +    qdev_prop_set_uint8(dev, "num_periph_req", nreq);
>> +    qdev_prop_set_uint8(dev, "num_events", 16);
>> +    qdev_prop_set_uint8(dev, "data_width", 64);
>> +    qdev_prop_set_uint8(dev, "wr_cap", 8);
>> +    qdev_prop_set_uint8(dev, "wr_q_dep", 16);
>> +    qdev_prop_set_uint8(dev, "rd_cap", 8);
>> +    qdev_prop_set_uint8(dev, "rd_q_dep", 16);
>> +    qdev_prop_set_uint16(dev, "data_buffer_dep", 256);
>> +    qdev_init_nofail(dev);
>> +
>> +    busdev = SYS_BUS_DEVICE(dev);
>> +    sysbus_mmio_map(busdev, 0, base);
>> +    sysbus_connect_irq(busdev, 0, irq);
>> +}
> 
> Why is this inline instead of in hw/dma/pl300.c?
> There should be nothing performance sensative here...

Yeah I didn't like it much neither and wondered the same :)
I was looking a examples in hw/char:

[phil@x1w qemu]$ git grep -hA 2 'static inline' include/hw/char/
52:static inline DeviceState *cadence_uart_create(hwaddr addr,
53-                                        qemu_irq irq,
54-                                        Chardev *chr)
--
52:static inline DeviceState *cmsdk_apb_uart_create(hwaddr addr,
53-                                                 qemu_irq txint,
54-                                                 qemu_irq rxint,
--
18:static inline DeviceState *pl011_create(hwaddr addr,
19-                                        qemu_irq irq,
20-                                        Chardev *chr)
--
35:static inline DeviceState *pl011_luminary_create(hwaddr addr,
36-                                                 qemu_irq irq,
37-                                                 Chardev *chr)
--
18:static inline DeviceState *xilinx_uartlite_create(hwaddr addr,
19-                                        qemu_irq irq,
20-                                        Chardev *chr)

I'll clean it and add a docstring.

Thanks for the review,

Phil.
