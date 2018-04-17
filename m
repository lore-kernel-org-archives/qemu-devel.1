Received: from eggs.gnu.org ([2001:4830:134:3::10]:48748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8ODb-00063F-Bk
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8ODa-0007Mg-Cc
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:52:11 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8ODa-0007Jf-6x
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:52:10 -0400
Received: by mail-oi0-x242.google.com with SMTP id e11-v6so6116563oii.11
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 03:52:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-11-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-11-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 11:51:48 +0100
Message-ID: <CAFEAcA88j0HfbJUYfXY-EejjvA3asLE+qJ3aSsCebwZDkpytTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 10/17] hw/arm/smmuv3: Abort on vfio or
 vhost case
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
> At the moment, the SMMUv3 does not support notification on
> TLB invalidation. So let's log an error as soon as such notifier
> gets enabled.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 4be676b..6e0d7ad 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1147,12 +1147,23 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
>      dc->realize = smmu_realize;
>  }
>
> +static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> +                                       IOMMUNotifierFlag old,
> +                                       IOMMUNotifierFlag new)
> +{
> +    if (old == IOMMU_NOTIFIER_NONE) {
> +        warn_report("SMMUV3 does not support vhost/vfio integration yet: "
> +                    "devices of those types will not function properly");
> +    }
> +}
> +
>  static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>                                                    void *data)
>  {
>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>
>      imrc->translate = smmuv3_translate;
> +    imrc->notify_flag_changed = smmuv3_notify_flag_changed;
>  }
>
>  static const TypeInfo smmuv3_type_info = {
> --
> 2.5.5

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
