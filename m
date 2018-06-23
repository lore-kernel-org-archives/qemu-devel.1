Received: from eggs.gnu.org ([2001:4830:134:3::10]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fWpsw-0006Lu-L0
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fWpst-0007iL-Cz
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:15:54 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
References: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
	<20180622050334.GG612@umbus.fritz.box>
	<alpine.BSF.2.21.1806220930470.66303@zero.eik.bme.hu>
	<c59b2d3e-384a-f3d9-41a7-74439cd3c78e@roeck-us.net>
	<alpine.BSF.2.21.1806222322110.86811@zero.eik.bme.hu>
	<20180623023420.GA28312@roeck-us.net>
	<alpine.BSF.2.21.1806232245010.73730@zero.eik.bme.hu>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9e6234ca-ac7f-6605-6e3f-16a84b51a241@roeck-us.net>
Date: Sat, 23 Jun 2018 14:15:47 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806232245010.73730@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix sam460ex devicetree when booting
 the Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/23/2018 01:55 PM, BALATON Zoltan wrote:
> On Fri, 22 Jun 2018, Guenter Roeck wrote:
>> The problem is this (from the kernel diffs provided by aCube):
>>
>> #if defined(CONFIG_PPC32)
>> -#define smc501_readl(addr)             ioread32be((addr))
>> -#define smc501_writel(val, addr)       iowrite32be((val), (addr))
>> +#define smc501_readl(addr)             ioread32((addr))
>> +#define smc501_writel(val, addr)       iowrite32((val), (addr))
>> #else
>> #define smc501_readl(addr)             readl(addr)
>> #define smc501_writel(val, addr)       writel(val, addr)
>>
>> This is a bit fishy since the cpu is big endian and iowrite32be()
>> should be identical to iowrite32(), but apparently that is not the
>> case here. I don't think I'll have time to track this down, though.
> 
> Thanks for finding this, it helps even if you don't have time to track it down completely. Could this be related to using little endian PCI device on a big endian CPU? Not sure which implementation will this use but in arch/powerpc/kernel/iomap.c:
> 
> unsigned int ioread32(void __iomem *addr)
> {
>          return readl(addr);
> }
> unsigned int ioread32be(void __iomem *addr)
> {
>          return readl_be(addr);
> }
> 
> so they don't look identical.
>

Sure, but normally I would assume that readl_be() matches readl() on a big endian system.
This is not the case here - it specifically maps to an assembler instruction which
afaics always swaps the byte order. Other architectures typically have something like

#define ioread32be(p) be32_to_cpu(ioread32(p))

or similar. FWIW, using ioread32() instead of ioread32be() does improve the situation:

sm501 0002:00:06.0: enabling device (0000 -> 0002)
sm501 0002:00:06.0: SM501 At (ptrval): Version 050100a0, 64 Mb, IRQ 0
sm501 0002:00:06.0: setting M1XCLK to 144000000
sm501 0002:00:06.0: setting MCLK to 72000000
sm501-usb[0] [mem 0xd84040000-0xd8405ffff]
sm501-usb[1] [mem 0xd83fc0000-0xd83ffffff]
sm501-usb[2] [irq 0]
sm501-fb[0] [mem 0xd84080000-0xd8408ffff]
sm501-fb[1] [mem 0xd84100000-0xd8414ffff]
sm501-fb[2] [mem 0xd80000000-0xd83fbffff]
sm501-fb[3] [irq 0]

even though irq 0 looks fishy. This may be related to:

qemu-system-ppc: ppc440_pcix_set_irq: PCI irq -1

seen when starting qemu.

Also:

sm501-usb sm501-usb.80: cannot declare coherent memory
sm501-usb: probe of sm501-usb.80 failed with error -38

This is as far as I got. Fixing this may require a new configuration option -
something like CONFIG_MFD_SM501_NATIVE_ENDIAN which would be set to false
by default. I think this should be tested on real HW, though, not only on
sam460ex but also on some other PPC32 system with SM501. Unfortunately
I have neither the hardware nor the time to do all the testing.

Guenter
