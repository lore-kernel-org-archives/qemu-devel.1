Received: from eggs.gnu.org ([2001:4830:134:3::10]:32905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1ZKB-0007xz-MM
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1ZKA-0004UV-IY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:46:31 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:47564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1ZKA-0004TU-AE
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:46:30 -0400
Received: by mail-wm0-x231.google.com with SMTP id t69so23234967wmt.2
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 07:46:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-4-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-4-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 15:46:08 +0100
Message-ID: <CAFEAcA_N+7F__C-xdiB+HqmRY0H=8q5rzBGkxwrjhbBrgqSKPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 03/20] hw/arm/smmu-common:
 smmu_read/write_sysmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> Those two functions will be used to access configuration
> data (STE, CD) and page table entries in guest RAM.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmu-common.c         | 37 +++++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmu-common.h |  5 +++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3e67992..2a94547 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,43 @@
>  #include "qemu/error-report.h"
>  #include "hw/arm/smmu-common.h"
>
> +inline MemTxResult smmu_read_sysmem(dma_addr_t addr, void *buf, dma_addr_t len,
> +                                    bool secure)
> +{
> +    MemTxAttrs attrs = {.unspecified = 1, .secure = secure};

This isn't right. .unspecified = 1 means "transaction master has
not explicitly specified any attributes", but you are specifying
one (the secure one).

> +    switch (len) {
> +    case 4:
> +        *(uint32_t *)buf = ldl_le_phys(&address_space_memory, addr);
> +        break;
> +    case 8:
> +        *(uint64_t *)buf = ldq_le_phys(&address_space_memory, addr);
> +        break;
> +    default:
> +        return address_space_rw(&address_space_memory, addr,
> +                                attrs, buf, len, false);

Why do we have the special cases for 4 and 8? In particular, those
code paths will not correctly detect memory transaction failures.

> +    }
> +    return MEMTX_OK;
> +}
> +
> +inline void
> +smmu_write_sysmem(dma_addr_t addr, void *buf, dma_addr_t len, bool secure)
> +{
> +    MemTxAttrs attrs = {.unspecified = 1, .secure = secure};
> +
> +    switch (len) {
> +    case 4:
> +        stl_le_phys(&address_space_memory, addr, *(uint32_t *)buf);
> +        break;
> +    case 8:
> +        stq_le_phys(&address_space_memory, addr, *(uint64_t *)buf);
> +        break;
> +    default:
> +        address_space_rw(&address_space_memory, addr,
> +                         attrs, buf, len, true);
> +    }
> +}
> +
>  /******************/
>  /* Infrastructure */
>  /******************/
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 20f3fe6..a5999b0 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -111,4 +111,9 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>  {
>      return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
>  }
> +
> +MemTxResult smmu_read_sysmem(dma_addr_t addr, void *buf,
> +                             dma_addr_t len, bool secure);
> +void smmu_write_sysmem(dma_addr_t addr, void *buf, dma_addr_t len, bool secure);
> +

There are so few callers of this that I'm inclined to think you
should just open code the right kind of memory accessor function
in the callsites rather than having a weird switch statement.

>  #endif  /* HW_ARM_SMMU_COMMON */
> --
> 2.5.5
>

thanks
-- PMM
