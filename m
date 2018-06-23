Received: from eggs.gnu.org ([2001:4830:134:3::10]:60403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWpZ7-0002Fr-TX
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWpZ4-00005c-Rh
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:55:25 -0400
Date: Sat, 23 Jun 2018 22:55:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180623023420.GA28312@roeck-us.net>
Message-ID: <alpine.BSF.2.21.1806232245010.73730@zero.eik.bme.hu>
References: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
	<20180622050334.GG612@umbus.fritz.box>
	<alpine.BSF.2.21.1806220930470.66303@zero.eik.bme.hu>
	<c59b2d3e-384a-f3d9-41a7-74439cd3c78e@roeck-us.net>
	<alpine.BSF.2.21.1806222322110.86811@zero.eik.bme.hu>
	<20180623023420.GA28312@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 22 Jun 2018, Guenter Roeck wrote:
> The problem is this (from the kernel diffs provided by aCube):
>
> #if defined(CONFIG_PPC32)
> -#define smc501_readl(addr)             ioread32be((addr))
> -#define smc501_writel(val, addr)       iowrite32be((val), (addr))
> +#define smc501_readl(addr)             ioread32((addr))
> +#define smc501_writel(val, addr)       iowrite32((val), (addr))
> #else
> #define smc501_readl(addr)             readl(addr)
> #define smc501_writel(val, addr)       writel(val, addr)
>
> This is a bit fishy since the cpu is big endian and iowrite32be()
> should be identical to iowrite32(), but apparently that is not the
> case here. I don't think I'll have time to track this down, though.

Thanks for finding this, it helps even if you don't have time to track it 
down completely. Could this be related to using little endian PCI device 
on a big endian CPU? Not sure which implementation will this use but in 
arch/powerpc/kernel/iomap.c:

unsigned int ioread32(void __iomem *addr)
{
         return readl(addr);
}
unsigned int ioread32be(void __iomem *addr)
{
         return readl_be(addr);
}

so they don't look identical.
