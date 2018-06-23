Received: from eggs.gnu.org ([2001:4830:134:3::10]:51167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fWYNg-000050-Qp
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 22:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fWYNf-0005We-PD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 22:34:28 -0400
Date: Fri, 22 Jun 2018 19:34:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180623023420.GA28312@roeck-us.net>
References: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
	<20180622050334.GG612@umbus.fritz.box>
	<alpine.BSF.2.21.1806220930470.66303@zero.eik.bme.hu>
	<c59b2d3e-384a-f3d9-41a7-74439cd3c78e@roeck-us.net>
	<alpine.BSF.2.21.1806222322110.86811@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806222322110.86811@zero.eik.bme.hu>
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

On Fri, Jun 22, 2018 at 11:37:30PM +0200, BALATON Zoltan wrote:
> 
> >>The version of the Linux kernel I've tried (which is from the Linux CD
> >>on ACube's site) did not try to access the power management register,
> >>neither any guest OSes I've tested with. Looks like it may be specific
> >>to the kernel config you're using.
> >>
> >Interesting. This is with the standard upstream kernel, using
> >canyonlands_defconfig.
> >The code seems to have been in the upstream kernel forever.
> 
> Maybe the Sam460ex specific image has some patches not in upstream kernel.
> 

Yes, it does. To start with, the DesignWare sata driver is different.

This is not the reason for the problem, though. canyonlands_defconfig
in the upstream kernel has CONFIG_SUSPEND enabled, but the configuration
used by aCube doesn't. The kernel code accessing the power management
registers is only enabled with CONFIG_SUSPEND.

> >>By the way, when I've tried with a more recent Linux kernel (4.15.10)
> >>I've noticed that the sm501 driver seemed like having endianness
> >>problems and thus did not find the chip, while it works with other older
> >>kernels made for sam460ex. I did not try to debug or bisect this yet. Do
> >>you know anything about that?
> >>
> >
> >No, I had not noticed. SM501 is disabled in the latest canyonlands_defconfig,
> >and I only use the serial console for my testing. It fails as far back as
> >3.18.y,
> >so I am not sure if this is a Linux or a qemu problem, or if it is a
> >problem that
> >was never fixed in the upstream kernel. What kernels did you try ?
> 

The problem is this (from the kernel diffs provided by aCube):

 #if defined(CONFIG_PPC32)
-#define smc501_readl(addr)             ioread32be((addr))
-#define smc501_writel(val, addr)       iowrite32be((val), (addr))
+#define smc501_readl(addr)             ioread32((addr))
+#define smc501_writel(val, addr)       iowrite32((val), (addr))
 #else
 #define smc501_readl(addr)             readl(addr)
 #define smc501_writel(val, addr)       writel(val, addr)

This is a bit fishy since the cpu is big endian and iowrite32be()
should be identical to iowrite32(), but apparently that is not the
case here. I don't think I'll have time to track this down, though.

Guenter
