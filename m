Received: from eggs.gnu.org ([2001:4830:134:3::10]:56122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1flZsp-0007Ob-CB
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1flZsm-0003kJ-Og
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:12:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1flZsm-0003k9-JD
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:12:40 -0400
Date: Fri, 3 Aug 2018 15:12:33 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180803131233.7wt7skawns3wdzqc@kamzik.brq.redhat.com>
References: <20180720153942.26821-1-andre.przywara@arm.com>
	<20180720153942.26821-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720153942.26821-4-andre.przywara@arm.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v2 3/4] arm/arm64: GICv2:
 add GICD_IPRIORITYR testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On Fri, Jul 20, 2018 at 04:39:41PM +0100, Andre Przywara wrote:
> Some tests for the IPRIORITY registers. The significant number of bits
> is IMPLEMENTATION DEFINED, but should be the same for every IRQ.
> Also these registers must be byte-accessible.
> Check that accesses beyond the implemented IRQ limit are actually
> read-as-zero/write-ignore.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/gic.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index 23cb9a4..57a2995 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -354,6 +354,83 @@ static void test_typer_v2(uint32_t reg)
>  	       nr_gic_cpus);
>  }
>  
> +#define BYTE(reg32, byte) (((reg32) >> ((byte) * 8)) & 0xff)
> +#define REPLACE_BYTE(reg32, byte, new) (((reg32) & ~(0xff << ((byte) * 8))) |\
> +					((new) << ((byte) * 8)))
> +
> +/*
> + * Some registers are byte accessible, do a byte-wide read and write of known
> + * content to check for this.
> + * Apply a @mask to cater for special register properties.
> + * @pattern contains the value already in the register.
> + */
> +static void test_byte_access(void *base_addr, u32 pattern, u32 mask)
> +{
> +	u32 reg = readb(base_addr + 1);
> +
> +	report("byte reads successful (0x%08x => 0x%02x)",
> +	       reg == (BYTE(pattern, 1) & (mask >> 8)),
> +	       pattern & mask, reg);
> +
> +	pattern = REPLACE_BYTE(pattern, 2, 0x1f);
> +	writeb(BYTE(pattern, 2), base_addr + 2);
> +	reg = readl(base_addr);
> +	report("byte writes successful (0x%02x => 0x%08x)",
> +	       reg == (pattern & mask), BYTE(pattern, 2), reg);
> +}

Hmm, should the above test prepare itself for a potential alignment fault?

Thanks,
drew
