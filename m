Received: from eggs.gnu.org ([2001:4830:134:3::10]:52063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWJ3-0005l2-2d
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWJ2-0005Be-1v
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:22:29 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWJ1-0005BI-Qo
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:22:28 -0500
Received: by mail-wr0-x232.google.com with SMTP id l37so59725331wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:22:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c554a16417ef22dbc29919a2747801be5ed7fede.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<c554a16417ef22dbc29919a2747801be5ed7fede.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 19:22:06 +0000
Message-ID: <CAFEAcA-G8_yOjmHBb9S+ErCoxSAje4gr1S0Y=FQjwCsxK+GYGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 05/14] sm501: Add emulation of chip
 connected via PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 25 February 2017 at 18:31, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Only the display controller part is created automatically on PCI
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>
> v2: Split off removing dependency on base address to separate patch
>
>  hw/display/sm501.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 1cda127..d9219bd 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -31,6 +31,7 @@
>  #include "ui/console.h"
>  #include "hw/devices.h"
>  #include "hw/sysbus.h"
> +#include "hw/pci/pci.h"
>  #include "qemu/range.h"
>  #include "ui/pixel_ops.h"
>  #include "exec/address-spaces.h"
> @@ -1507,9 +1508,60 @@ static const TypeInfo sm501_sysbus_info = {
>      .class_init    = sm501_sysbus_class_init,
>  };
>
> +#define TYPE_PCI_SM501 "sm501"
> +#define PCI_SM501(obj) OBJECT_CHECK(SM501PCIState, (obj), TYPE_PCI_SM501)
> +
> +typedef struct {
> +    /*< private >*/
> +    PCIDevice parent_obj;
> +    /*< public >*/
> +    SM501State state;
> +    uint32_t vram_size;
> +} SM501PCIState;
> +
> +static void sm501_realize_pci(PCIDevice *dev, Error **errp)
> +{
> +    SM501PCIState *s = PCI_SM501(dev);
> +
> +    sm501_init(&s->state, DEVICE(dev), s->vram_size);
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY,
> +                     &s->state.local_mem_region);
> +    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY,
> +                     &s->state.mmio_region);
> +}
> +
> +static Property sm501_pci_properties[] = {
> +    DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size,
> +                       64 * 1024 * 1024),

Something needs to sanity check this value, because it's
user settable in the PCI device. (In the sysbus version you
can only create it from board code, and we can assume board
code doesn't pass us silly values.)

Or you could just hardcode the PCI device to always be 64MB,
I guess :-)

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void sm501_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = sm501_realize_pci;
> +    k->vendor_id = 0x126f;
> +    k->device_id = 0x0501;

We could define some constants in include/hw/pci/pci_ids.h
for these, I suppose.

> +    k->class_id = PCI_CLASS_DISPLAY_OTHER;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    dc->desc = "SM501 Display Controller";
> +    dc->props = sm501_pci_properties;
> +    dc->hotpluggable = false;

This needs a reset and vmsd as well.

> +}
> +
> +static const TypeInfo sm501_pci_info = {
> +    .name          = TYPE_PCI_SM501,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(SM501PCIState),
> +    .class_init    = sm501_pci_class_init,
> +};
> +
>  static void sm501_register_types(void)
>  {
>      type_register_static(&sm501_sysbus_info);
> +    type_register_static(&sm501_pci_info);
>  }
>
>  type_init(sm501_register_types)
> --
> 2.7.4

thanks
-- PMM
