Received: from eggs.gnu.org ([2001:4830:134:3::10]:58396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWv-0004mU-Jl
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWu-0005VI-9q
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:41 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIzWu-0005Us-3m
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 11:11:40 -0500
Received: by mail-qt0-x241.google.com with SMTP id 33so27491790qtv.1
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 08:11:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1511703326-25325-7-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a2b54ccd-d779-d866-e9af-bd7626c94485@amsat.org>
Date: Sun, 26 Nov 2017 12:17:05 -0300
MIME-Version: 1.0
In-Reply-To: <1511703326-25325-7-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/8] sun4u_iommu: update to reflect IOMMU
 is no longer part of the APB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/26/2017 10:35 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sparc64/sun4u_iommu.c       |   35 ++++++++++++++++++-----------------
>  include/hw/sparc/sun4u_iommu.h |    2 +-
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
> index e5aa817..612fec4 100644
> --- a/hw/sparc64/sun4u_iommu.c
> +++ b/hw/sparc64/sun4u_iommu.c
> @@ -81,8 +81,9 @@ do { printf("IOMMU: " fmt , ## __VA_ARGS__); } while (0)
>  
>  
>  /* Called from RCU critical section */
> -static IOMMUTLBEntry pbm_translate_iommu(IOMMUMemoryRegion *iommu, hwaddr addr,
> -                                         IOMMUAccessFlags flag)
> +static IOMMUTLBEntry sun4u_translate_iommu(IOMMUMemoryRegion *iommu,
> +                                           hwaddr addr,
> +                                           IOMMUAccessFlags flag)
>  {
>      IOMMUState *is = container_of(iommu, IOMMUState, iommu);
>      hwaddr baseaddr, offset;
> @@ -233,7 +234,7 @@ static void iommu_mem_write(void *opaque, hwaddr addr,
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP,
> -                  "apb iommu: Unimplemented register write "
> +                  "sun4u-iommu: Unimplemented register write "
>                    "reg 0x%" HWADDR_PRIx " size 0x%x value 0x%" PRIx64 "\n",
>                    addr, size, val);
>          break;
> @@ -272,7 +273,7 @@ static uint64_t iommu_mem_read(void *opaque, hwaddr addr, unsigned size)
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP,
> -                      "apb iommu: Unimplemented register read "
> +                      "sun4u-iommu: Unimplemented register read "
>                        "reg 0x%" HWADDR_PRIx " size 0x%x\n",
>                        addr, size);
>          val = 0;
> @@ -304,9 +305,9 @@ static void iommu_init(Object *obj)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>  
>      memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
> -                             TYPE_APB_IOMMU_MEMORY_REGION, OBJECT(s),
> -                             "iommu-apb", UINT64_MAX);
> -    address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "pbm-as");
> +                             TYPE_SUN4U_IOMMU_MEMORY_REGION, OBJECT(s),
> +                             "iommu-sun4u", UINT64_MAX);
> +    address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "iommu-as");
>  
>      memory_region_init_io(&s->iomem, obj, &iommu_mem_ops, s, "iommu",
>                            IOMMU_NREGS * sizeof(uint64_t));
> @@ -320,7 +321,7 @@ static void iommu_class_init(ObjectClass *klass, void *data)
>      dc->reset = iommu_reset;
>  }
>  
> -static const TypeInfo pbm_iommu_info = {
> +static const TypeInfo iommu_info = {
>      .name          = TYPE_SUN4U_IOMMU,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(IOMMUState),
> @@ -328,23 +329,23 @@ static const TypeInfo pbm_iommu_info = {
>      .class_init    = iommu_class_init,
>  };
>  
> -static void pbm_iommu_memory_region_class_init(ObjectClass *klass, void *data)
> +static void sun4u_iommu_memory_region_class_init(ObjectClass *klass, void *data)
>  {
>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>  
> -    imrc->translate = pbm_translate_iommu;
> +    imrc->translate = sun4u_translate_iommu;
>  }
>  
> -static const TypeInfo pbm_iommu_memory_region_info = {
> +static const TypeInfo sun4u_iommu_memory_region_info = {
>      .parent = TYPE_IOMMU_MEMORY_REGION,
> -    .name = TYPE_APB_IOMMU_MEMORY_REGION,
> -    .class_init = pbm_iommu_memory_region_class_init,
> +    .name = TYPE_SUN4U_IOMMU_MEMORY_REGION,
> +    .class_init = sun4u_iommu_memory_region_class_init,
>  };
>  
> -static void pbm_register_types(void)
> +static void iommu_register_types(void)
>  {
> -    type_register_static(&pbm_iommu_info);
> -    type_register_static(&pbm_iommu_memory_region_info);
> +    type_register_static(&iommu_info);
> +    type_register_static(&sun4u_iommu_memory_region_info);
>  }
>  
> -type_init(pbm_register_types)
> +type_init(iommu_register_types)
> diff --git a/include/hw/sparc/sun4u_iommu.h b/include/hw/sparc/sun4u_iommu.h
> index bc4506b..a760172 100644
> --- a/include/hw/sparc/sun4u_iommu.h
> +++ b/include/hw/sparc/sun4u_iommu.h
> @@ -45,6 +45,6 @@ typedef struct IOMMUState {
>  #define TYPE_SUN4U_IOMMU "sun4u-iommu"
>  #define SUN4U_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4U_IOMMU)
>  
> -#define TYPE_APB_IOMMU_MEMORY_REGION "pbm-iommu-memory-region"
> +#define TYPE_SUN4U_IOMMU_MEMORY_REGION "sun4u-iommu-memory-region"
>  
>  #endif
> 
