Received: from eggs.gnu.org ([2001:4830:134:3::10]:34427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cEC4A-0006zG-Lg
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cEC49-0007Mx-KS
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:29:38 -0500
Date: Tue, 6 Dec 2016 10:29:25 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161206092925.mk4gwx7jbomzxsfz@kamzik.brq.redhat.com>
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
	<1480974406-29345-6-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480974406-29345-6-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests RFC 05/15] arm/arm64: GICv3: add
 cpu count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, marc.zyngier@arm.com, christoffer.dall@linaro.org, andre.przywara@arm.com, pbonzini@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org

On Mon, Dec 05, 2016 at 10:46:36PM +0100, Eric Auger wrote:
> Add a new cpu_count field in gicv3_data indicating the
> number of redistributors. This will be useful for enumeration
> of their resources such as LPI pending tables.

I'm fine with the additional state, but just curious, will it
ever be possible for gicv3.cpu_count != nr_cpus?

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  lib/arm/asm/gic-v3.h | 1 +
>  lib/arm/gic-v3.c     | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
> index ed330af..039b7c2 100644
> --- a/lib/arm/asm/gic-v3.h
> +++ b/lib/arm/asm/gic-v3.h
> @@ -58,6 +58,7 @@ struct gicv3_data {
>  	void *dist_base;
>  	void *redist_base[NR_CPUS];
>  	unsigned int irq_nr;
> +	unsigned int cpu_count;
>  };
>  extern struct gicv3_data gicv3_data;
>  
> diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
> index 6246221..9921f4d 100644
> --- a/lib/arm/gic-v3.c
> +++ b/lib/arm/gic-v3.c
> @@ -12,12 +12,14 @@ void gicv3_set_redist_base(size_t stride)
>  	void *ptr = gicv3_data.redist_base[0];
>  	u64 typer;
>  
> +	gicv3_data.cpu_count = 0;
>  	do {
>  		typer = gicv3_read_typer(ptr + GICR_TYPER);
>  		if ((typer >> 32) == aff) {
>  			gicv3_redist_base() = ptr;
>  			return;
>  		}
> +		gicv3_data.cpu_count++;
>  		ptr += stride; /* skip RD_base, SGI_base, etc. */
>  	} while (!(typer & GICR_TYPER_LAST));
>  
> -- 
> 2.5.5
> 
> 
