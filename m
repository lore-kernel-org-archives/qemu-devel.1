Received: from eggs.gnu.org ([2001:4830:134:3::10]:46332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f83K5-0006Sh-7d
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f83K4-00057L-9l
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:33:29 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f83K4-00056v-45
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:33:28 -0400
Received: by mail-oi0-x242.google.com with SMTP id 126-v6so14310600oig.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 05:33:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-3-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-3-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 13:33:06 +0100
Message-ID: <CAFEAcA-SM6DkdpEcC6eSOvrjLOMC2cpxyaWjS3ezcp_EnvCjFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 02/17] hw/arm/smmu-common: IOMMU memory
 region and address space setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 12 April 2018 at 08:37, Eric Auger <eric.auger@redhat.com> wrote:
> We set up the infrastructure to enumerate all the PCI devices
> attached to the SMMU and create an associated IOMMU memory
> region and address space.
>
> Those info are stored in SMMUDevice objects. The devices are
> grouped according to the PCIBus they belong to. A hash table
> indexed by the PCIBus pointer is used. Also an array indexed by
> the bus number allows to find the list of SMMUDevices.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>
> ---
> v9 -> v10:
> - comment functions added to the header
> - g_free(name)
> - renamed smmu_find_as_from_bus_num into smmu_find_smmu_pcibus
> - add a comment about lazy init in smmu_find_smmu_pcibus
> - add a trace event when creating the smmu iommu mr
>
> v8 -> v9:
> - fix key value for lookup
>
> v7 -> v8:
> - introduce SMMU_MAX_VA_BITS
> - use PCI bus handle as a key
> - do not clear s->smmu_as_by_bus_num
> - use g_new0 instead of g_malloc0
> - use primary_bus field
> ---
>  hw/arm/smmu-common.c         | 69 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events          |  3 ++
>  include/hw/arm/smmu-common.h |  8 +++++
>  3 files changed, 80 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index e086ff5..9a966bb 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -28,8 +28,69 @@
>  #include "qemu/error-report.h"
>  #include "hw/arm/smmu-common.h"
>
> +/**
> + * The bus number is used for lookup when SID based invalidatation occurs.

"invalidation"

> + * In that case we lazily populate the SMMUPciBus array from the bus hash
> + * table. At the time the SMMUPciBus is created (smmu_find_add_as), the bus
> + * numbers may not be always initialized yet.
> + */


> +/* Return the stream ID of an SMMU device */
> +static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
> +{
> +    return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;

I think this is PCI_BUILD_BDF(pci_bus_num(sdev->bus), sdev->devfn)
and I suspect the mask with 0xff is unneeded (compare pci_get_bdf()
and amdvi_do_translate(), which just assume the bus number is sane).

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
