Received: from eggs.gnu.org ([2001:4830:134:3::10]:57780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87Pc-0004NT-MC
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87Pb-0000WH-OY
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:55:28 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:45631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f87Pb-0000VT-Fa
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:55:27 -0400
Received: by mail-ot0-x231.google.com with SMTP id w2-v6so7202490otj.12
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 09:55:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-15-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-15-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 17:55:05 +0100
Message-ID: <CAFEAcA8zMJvdRhf=f7O6GuRhqejbgb7moD43TPvVHJowBGeoug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 14/17] hw/arm/virt: Introduce the iommu
 option
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

On 12 April 2018 at 08:38, Eric Auger <eric.auger@redhat.com> wrote:
> ARM virt machine now exposes a new "iommu" option.
> The SMMUv3 IOMMU is instantiated using -machine virt,iommu=smmuv3.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>
> ---
> v9 -> v10:
> - remove no_iommu
>
> v7 -> v8:
> - Revert to machine option, now dubbed "iommu", preparing for virtio
>   instantiation.
>
> v5 -> v6: machine 2_11
> ---
>  hw/arm/virt.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 1799702..a3398d6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1560,6 +1560,34 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
>      }
>  }
>
> +static char *virt_get_iommu(Object *obj, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    switch (vms->iommu) {
> +    case VIRT_IOMMU_NONE:
> +        return g_strdup("none");
> +    case VIRT_IOMMU_SMMUV3:
> +        return g_strdup("smmuv3");
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void virt_set_iommu(Object *obj, const char *value, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(obj);
> +
> +    if (!strcmp(value, "smmuv3")) {
> +        vms->iommu = VIRT_IOMMU_SMMUV3;
> +    } else if (!strcmp(value, "none")) {
> +        vms->iommu = VIRT_IOMMU_NONE;
> +    } else {
> +        error_setg(errp, "Invalid iommu value");
> +        error_append_hint(errp, "Valid values are none, smmuv3.\n");
> +    }
> +}
> +
>  static CpuInstanceProperties
>  virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  {
> @@ -1692,6 +1720,14 @@ static void virt_2_12_instance_init(Object *obj)
>                                          NULL);
>      }
>
> +    /* Default disallows iommu instantiation */
> +    vms->iommu = VIRT_IOMMU_NONE;
> +    object_property_add_str(obj, "iommu", virt_get_iommu, virt_set_iommu, NULL);
> +    object_property_set_description(obj, "iommu",
> +                                    "Set the IOMMU model among "
> +                                    "none, smmuv3 (default none)",
> +                                    NULL);

We should phrase this consistently with how we're describing other
options like the GIC version, so
   "Set the IOMMU type. Valid values are none and smmuv3"

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
