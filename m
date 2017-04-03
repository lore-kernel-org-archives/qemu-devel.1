Received: from eggs.gnu.org ([2001:4830:134:3::10]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cv2ku-0003tx-Qn
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cv2ko-0007nb-Ni
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:14:52 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1cv2ko-0007nX-Hu
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:14:46 -0400
Received: by mail-it0-x243.google.com with SMTP id w11so8254550itb.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 07:14:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403073550.29162-1-shah.suramya@gmail.com>
References: <20170403073550.29162-1-shah.suramya@gmail.com>
From: Suramya Shah <shah.suramya@gmail.com>
Date: Mon, 3 Apr 2017 19:44:45 +0530
Message-ID: <CABH=oPwih9z1FgOEgDjHFQq_E4BayZ-gz4oF=c6gBKbg8RmdoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/net: convert "dma" property type from
 ptr to link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com

On 03-Apr-2017 1:06 PM, "Suramya Shah" <shah.suramya@gmail.com> wrote:

> The lance device needs pointer to ISA DMA device to operate. But according
> to
> qdev-properties.h, properties of pointer type should be avoided.
> A link type property is a good substitution.
>
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  hw/net/lance.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/lance.c b/hw/net/lance.c
> index 573d724..3996b9c 100644
> --- a/hw/net/lance.c
> +++ b/hw/net/lance.c
> @@ -44,6 +44,7 @@
>  #include "pcnet.h"
>  #include "trace.h"
>  #include "sysemu/sysemu.h"
> +#include "qapi/error.h"
>
>  #define TYPE_LANCE "lance"
>  #define SYSBUS_PCNET(obj) \
> @@ -145,10 +146,14 @@ static void lance_instance_init(Object *obj)
>      device_add_bootindex_property(obj, &s->conf.bootindex,
>                                    "bootindex", "/ethernet-phy@0",
>                                    DEVICE(obj), NULL);
> +
> +    object_property_add_link(obj, "dma", TYPE_LANCE,
> +                             (Object **)&d->state.dma_opaque,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, &error_abort);
>  }
>
>  static Property lance_properties[] = {
> -    DEFINE_PROP_PTR("dma", SysBusPCNetState, state.dma_opaque),
>      DEFINE_NIC_PROPERTIES(SysBusPCNetState, state.conf),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -164,7 +169,6 @@ static void lance_class_init(ObjectClass *klass, void
> *data)
>      dc->reset = lance_reset;
>      dc->vmsd = &vmstate_lance;
>      dc->props = lance_properties;
> -    /* Reason: pointer property "dma" */
>      dc->cannot_instantiate_with_device_add_yet = true;
>  }
>
> --
> 2.9.3
>
>
