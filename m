Received: from eggs.gnu.org ([2001:4830:134:3::10]:59598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHSBy-0005XI-Ns
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHSBt-00016U-Lp
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:28:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHSBt-00014k-Dy
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:28:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so12164952wrw.3
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 04:28:09 -0700 (PDT)
References: <20181029232100.8454-1-philmd@redhat.com>
	<20181029232100.8454-3-philmd@redhat.com>
	<CAFEAcA_yde+Ppuqet7KFE-AvZrjnrfYeY=R1aWD86cox+WYsxg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2832be6-83ab-83ac-2063-13bf0b556d80@redhat.com>
Date: Tue, 30 Oct 2018 12:28:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_yde+Ppuqet7KFE-AvZrjnrfYeY=R1aWD86cox+WYsxg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 30/10/18 10:36, Peter Maydell wrote:
> On 29 October 2018 at 23:20, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   MAINTAINERS            |  1 +
>>   hw/arm/xilinx_zynq.c   | 18 ++----------------
>>   hw/dma/pl330.c         |  2 +-
>>   include/hw/dma/pl330.h | 41 +++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 45 insertions(+), 17 deletions(-)
>>   create mode 100644 include/hw/dma/pl330.h
> 
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
> 
> These are the settings the Xilinx board uses, but are
> they really the settings every SoC that has a PL330 will use ?

Except "num_periph_req", all are pl330_properties defaults.

> 
> thanks
> -- PMM
> 
