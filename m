Received: from eggs.gnu.org ([2001:4830:134:3::10]:52158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daD8O-0006pR-S9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daD8K-0002Ou-7j
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:37:16 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1daD8K-0002OR-0x
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:37:12 -0400
Received: by mail-pf0-x241.google.com with SMTP id c23so14372044pfe.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:37:11 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100552078.27487.390170136970607382.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <506fd8f5-15e1-8b24-a942-f59fa8f52312@ozlabs.ru>
Date: Wed, 26 Jul 2017 13:37:03 +1000
MIME-Version: 1.0
In-Reply-To: <150100552078.27487.390170136970607382.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.11 PATCH 03/26] spapr_iommu: use
 g_strdup_printf() instead of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 26/07/17 03:58, Greg Kurz wrote:
> Passing a stack allocated buffer of arbitrary length to snprintf()
> without checking the return value can cause the resultant strings
> to be silently truncated.

The strings it is touching cannot be silently truncated as
"tce-iommu-XXXXXXXX" are shorter than 32 chars.


> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_iommu.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index e614621a8317..740d42608b61 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -252,17 +252,19 @@ static int spapr_tce_table_realize(DeviceState *dev)
>  {
>      sPAPRTCETable *tcet = SPAPR_TCE_TABLE(dev);
>      Object *tcetobj = OBJECT(tcet);
> -    char tmp[32];
> +    gchar *tmp;
>  
>      tcet->fd = -1;
>      tcet->need_vfio = false;
> -    snprintf(tmp, sizeof(tmp), "tce-root-%x", tcet->liobn);
> +    tmp = g_strdup_printf("tce-root-%x", tcet->liobn);
>      memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
> +    g_free(tmp);
>  
> -    snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
> +    tmp = g_strdup_printf("tce-iommu-%x", tcet->liobn);
>      memory_region_init_iommu(&tcet->iommu, sizeof(tcet->iommu),
>                               TYPE_SPAPR_IOMMU_MEMORY_REGION,
>                               tcetobj, tmp, 0);
> +    g_free(tmp);
>  
>      QLIST_INSERT_HEAD(&spapr_tce_tables, tcet, list);
>  
> @@ -307,7 +309,7 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
>  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
>  {
>      sPAPRTCETable *tcet;
> -    char tmp[32];
> +    gchar *tmp;
>  
>      if (spapr_tce_find_by_liobn(liobn)) {
>          error_report("Attempted to create TCE table with duplicate"
> @@ -318,8 +320,9 @@ sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
>      tcet = SPAPR_TCE_TABLE(object_new(TYPE_SPAPR_TCE_TABLE));
>      tcet->liobn = liobn;
>  
> -    snprintf(tmp, sizeof(tmp), "tce-table-%x", liobn);
> +    tmp = g_strdup_printf("tce-table-%x", liobn);
>      object_property_add_child(OBJECT(owner), tmp, OBJECT(tcet), NULL);
> +    g_free(tmp);
>  
>      object_property_set_bool(OBJECT(tcet), true, "realized", NULL);
>  
> 
> 


-- 
Alexey
