Received: from eggs.gnu.org ([2001:4830:134:3::10]:47891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g0Yno-0000X5-Ep
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g0Ynn-0004O5-Dy
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:05:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g0Ynn-0004Dj-28
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:05:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id z96-v6so8115617wrb.8
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 14:05:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180912123700.7708-1-kraxel@redhat.com>
	<20180912123700.7708-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8561141-d281-4a75-c82d-1598cd7e8c8d@amsat.org>
Date: Thu, 13 Sep 2018 23:05:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180912123700.7708-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] display/edid: add region helper.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 9/12/18 2:36 PM, Gerd Hoffmann wrote:
> Create a io region for an EDID data block.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/display/edid.h |  4 ++++
>  hw/display/edid-region.c  | 33 +++++++++++++++++++++++++++++++++
>  hw/display/Makefile.objs  |  1 +
>  3 files changed, 38 insertions(+)
>  create mode 100644 hw/display/edid-region.c
> 
> diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
> index 63b60015c3..c39d5cd77b 100644
> --- a/include/hw/display/edid.h
> +++ b/include/hw/display/edid.h
> @@ -1,6 +1,8 @@
>  #ifndef EDID_H
>  #define EDID_H
>  
> +#include "hw/hw.h"
> +
>  typedef struct qemu_edid_info {
>      const char *vendor;
>      const char *name;
> @@ -14,5 +16,7 @@ typedef struct qemu_edid_info {
>  
>  void qemu_edid_generate(uint8_t *edid, size_t size,
>                          qemu_edid_info *info);
> +void qemu_edid_region_io(MemoryRegion *region, Object *owner,
> +                         uint8_t *edid, size_t size);
>  
>  #endif /* EDID_H */
> diff --git a/hw/display/edid-region.c b/hw/display/edid-region.c
> new file mode 100644
> index 0000000000..9a15734d3a
> --- /dev/null
> +++ b/hw/display/edid-region.c
> @@ -0,0 +1,33 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "hw/display/edid.h"
> +
> +static uint64_t edid_region_read(void *ptr, hwaddr addr, unsigned size)
> +{
> +    uint8_t *edid = ptr;
> +
> +    return edid[addr];
> +}
> +
> +static void edid_region_write(void *ptr, hwaddr addr,
> +                             uint64_t val, unsigned size)
> +{
> +    /* read only */
> +}
> +
> +static const MemoryRegionOps edid_region_ops = {
> +    .read = edid_region_read,
> +    .write = edid_region_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 1,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +void qemu_edid_region_io(MemoryRegion *region, Object *owner,
> +                         uint8_t *edid, size_t size)
> +{
> +    memory_region_init_io(region, owner, &edid_region_ops,
> +                          edid, "edid", size);
> +}
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 492404c09e..780a76b9f0 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -15,6 +15,7 @@ common-obj-$(CONFIG_XEN) += xenfb.o
>  
>  common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
>  common-obj-$(CONFIG_VGA_PCI) += bochs-display.o
> +common-obj-$(CONFIG_VGA_PCI) += edid-region.o
>  common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
>  common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
>  common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
> 
