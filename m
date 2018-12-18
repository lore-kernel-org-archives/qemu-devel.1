Received: from eggs.gnu.org ([2001:4830:134:3::10]:35564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZ5jA-0007LQ-LI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 22:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZ5j7-00007U-HW
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 22:07:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gZ5j7-00007A-Av
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 22:07:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89BC37FD43
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 03:07:20 +0000 (UTC)
Date: Tue, 18 Dec 2018 11:07:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181218030713.GB16723@xz-x1>
References: <20181217073114.11984-1-peterx@redhat.com>
	<20181217073114.11984-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181217073114.11984-6-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] intel_iommu: turn on IR by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>

On Mon, Dec 17, 2018 at 03:31:14PM +0800, Peter Xu wrote:
> IR has been there for a long time and long time no bug reported.
> Let's turn it on by default to match general hardwares.  Providing
> compatibility bit for QEMU<=3.1.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

I forgot that IR will depend on split kernel irqchip and by default
that's still "on" so "-M q35 -device intel-iommu" may not be able to
boot correctly with all the default values and instead QEMU will ask
user to turn on split irqchip.

Paolo/Michael, do you think it would make any sense to turn the
default kernel-irqchip machine parameter to split starting from qemu
4.0?  Since AFAIU it should have little degradation to performance but
at the same time it reduces kvm attack serface, which seems good.

Thanks,

> ---
>  hw/i386/x86-iommu.c  | 2 +-
>  include/hw/i386/pc.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index abc3c03158..0150ceda14 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -135,7 +135,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
>  }
>  
>  static Property x86_iommu_properties[] = {
> -    DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),
> +    DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, true),
>      DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
>      DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c7c0c944e8..ed958b9af1 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -300,6 +300,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = "intel-iommu",\
>          .property = "dma-drain",\
>          .value    = "off",\
> +    },{\
> +        .driver   = "x86-iommu",\
> +        .property = "intremap",\
> +        .value    = "off",\
>      },
>  
>  #define PC_COMPAT_3_0 \
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu
