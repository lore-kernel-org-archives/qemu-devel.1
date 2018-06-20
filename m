Received: from eggs.gnu.org ([2001:4830:134:3::10]:49614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfeO-0003ie-2Z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfeM-0000lg-Tk
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:08:04 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVfeM-0000lJ-ML
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:08:02 -0400
Received: by mail-ot0-x241.google.com with SMTP id r18-v6so130584otk.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:08:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528790908-23441-4-git-send-email-eric.auger@redhat.com>
References: <1528790908-23441-1-git-send-email-eric.auger@redhat.com>
	<1528790908-23441-4-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 17:07:41 +0100
Message-ID: <CAFEAcA-EpZ6uzLmjr_1w9nno6C5-tyvqU9MfWR8XZwup4hKKDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/arm/smmuv3: IOTLB emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, jia.he@hxt-semitech.com, Jia He <hejianet@gmail.com>

On 12 June 2018 at 09:08, Eric Auger <eric.auger@redhat.com> wrote:
> We emulate a TLB cache of size SMMU_IOTLB_MAX_SIZE=256.
> It is implemented as a hash table whose key is a combination
> of the 16b asid and 48b IOVA (Jenkins hash).
>
> Entries are invalidated on TLB invalidation commands, either
> globally, or per asid, or per asid/iova.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v1 -> v2:
> - add comment about Jenkins Hash
> - remove init of iotlb_hits, misses
>
> v1:
> - Add new trace point when smmu is bypassed
> - s/iotlb_miss/iotlb_misses, s/iotlb_hit/iotlb_hits
> - use SMMUIOTLBKey as a key
>
> Credit to Tomasz Nowicki who did the first implementation of
> this IOTLB implementation, inspired of intel_iommu implementation.
> ---
>  hw/arm/smmu-common.c         | 60 +++++++++++++++++++++++++++
>  hw/arm/smmuv3.c              | 98 ++++++++++++++++++++++++++++++++++++++++++--
>  hw/arm/trace-events          |  9 ++++
>  include/hw/arm/smmu-common.h | 13 ++++++
>  4 files changed, 176 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 264e096..16cd33a 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -24,11 +24,43 @@
>  #include "qom/cpu.h"
>  #include "hw/qdev-properties.h"
>  #include "qapi/error.h"
> +#include "qemu/jhash.h"
>
>  #include "qemu/error-report.h"
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>
> +/* IOTLB Management */
> +
> +inline void smmu_iotlb_inv_all(SMMUState *s)
> +{
> +    trace_smmu_iotlb_inv_all();
> +    g_hash_table_remove_all(s->iotlb);
> +}
> +
> +static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
> +                                         gpointer user_data)
> +{
> +    uint16_t asid = *(uint16_t *)user_data;
> +    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
> +
> +    return iotlb_key->asid == asid;
> +}
> +
> +inline void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova)
> +{
> +    SMMUIOTLBKey key = {.asid = asid, .iova = iova};
> +
> +    trace_smmu_iotlb_inv_iova(asid, iova);
> +    g_hash_table_remove(s->iotlb, &key);
> +}
> +
> +inline void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
> +{
> +    trace_smmu_iotlb_inv_asid(asid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
> +}
> +
>  /* VMSAv8-64 Translation */
>
>  /**
> @@ -328,6 +360,31 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
>      return NULL;
>  }
>
> +static guint smmu_iotlb_key_hash(gconstpointer v)
> +{
> +    SMMUIOTLBKey *key = (SMMUIOTLBKey *)v;
> +    uint32_t a, b, c;
> +
> +    /* Henkins hash */

"Jenkins"

> +    a = b = c = JHASH_INITVAL + sizeof(*key);

Why do we add the sizeof(SMMUIOTLBKey) here ?

> +    a += key->asid;
> +    b += extract64(key->iova, 0, 32);
> +    c += extract64(key->iova, 32, 32);
> +
> +    __jhash_mix(a, b, c);
> +    __jhash_final(a, b, c);
> +
> +    return c;
> +}


> +static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    SMMUIOTLBKey *k1 = (SMMUIOTLBKey *)v1;
> +    SMMUIOTLBKey *k2 = (SMMUIOTLBKey *)v2;

These should have a 'const', at which point I think you'll
find that you don't need the explicit casts.

Otherwise looks OK I think.

thanks
-- PMM
