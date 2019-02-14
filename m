Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKeW-0007PH-5J
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKUP-0001fi-Qj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:07:58 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guKUP-0001ZZ-IC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:07:57 -0500
Received: by mail-ot1-x344.google.com with SMTP id w25so11636708otm.13
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-6-eric.auger@redhat.com>
In-Reply-To: <20190205173306.20483-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 17:07:42 +0000
Message-ID: <CAFEAcA9z83y2Xfp0QC5-uKY-6d5zOvxiD=vy7=oG9N2onqCnmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 05/18] hw/arm/virt: Split the memory map
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>
> In the prospect to introduce an extended memory map supporting more
> RAM, let's split the memory map array into two parts:
>
> - the former a15memmap contains regions below and including the RAM
> - extended_memmap, only initialized with entries located after the RAM.
>   Only the size of the region is initialized there since their base
>   address will be dynamically computed, depending on the top of the
>   RAM (initial RAM at the moment), with same alignment as their size.
>
> This new split will allow to grow the RAM size without changing the
> description of the high regions.

This change makes it clear that "a15memmap" is badly misnamed.
I think we should change it to "base_memmap" here.

>
> The patch also moves the memory map setup into machvirt_init().
> The rationale is the memory map will be soon affected by the
> kvm_type() call that happens after virt_instance_init() and
> before machvirt_init().
>
> At that point the memory map is not changed, ie. the initial RAM can

"At this point" ?

> grow up to 256GiB. Then come the high IO regions with same layout as
> before.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> v5 -> v6
> - removal of many macros in units.h
> - introduce the virt_set_memmap helper
> - new computation for offsets of high IO regions
> - add comments
> ---
>  hw/arm/virt.c         | 45 ++++++++++++++++++++++++++++++++++++++-----
>  include/hw/arm/virt.h | 14 ++++++++++----
>  2 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a1955e7764..2b15839d0b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -29,6 +29,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "hw/arm/arm.h"
> @@ -149,11 +150,20 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
>      [VIRT_MEM] =                { 0x40000000, RAMLIMIT_BYTES },
> +};
> +
> +/*
> + * Highmem IO Regions: This memory map is floating, located after the RAM.
> + * Each IO region offset will be dynamically computed, depending on the
> + * top of the RAM, so that its base get the same alignment as the size,
> + * ie. a 512GiB region will be aligned on a 512GiB boundary.

I think you should say here that if there is less than 256GiB of RAM
then the floating area starts at the 256GiB mark.

> + */
> +static MemMapEntry extended_memmap[] = {
>      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> -    [VIRT_HIGH_GIC_REDIST2] =   { 0x4000000000ULL, 0x4000000 },
> -    [VIRT_HIGH_PCIE_ECAM] =     { 0x4010000000ULL, 0x10000000 },
> -    /* Second PCIe window, 512GB wide at the 512GB boundary */
> -    [VIRT_HIGH_PCIE_MMIO] =     { 0x8000000000ULL, 0x8000000000ULL },
> +    [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> +    [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
> +    /* Second PCIe window */
> +    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
>  };
>
>  static const int a15irqmap[] = {
> @@ -1354,6 +1364,30 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>      return arm_cpu_mp_affinity(idx, clustersz);
>  }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
