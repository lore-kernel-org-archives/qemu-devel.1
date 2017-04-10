Received: from eggs.gnu.org ([2001:4830:134:3::10]:48753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxUqM-0008SI-3h
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxUqL-0001D3-6t
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:38:38 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxUqK-0001CB-Vp
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:38:37 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u2so31332550wmu.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 01:38:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170408143639.2524-1-shah.suramya@gmail.com>
References: <20170408143639.2524-1-shah.suramya@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 09:38:13 +0100
Message-ID: <CAFEAcA-TnbTDWCP_1zdCQ2OvKNQf6caC0E2pOU9Vf+2NmhEXcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/net: convert "dma" property type
 from ptr to link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On 8 April 2017 at 15:36, Suramya Shah <shah.suramya@gmail.com> wrote:
> The lance device needs pointer to ISA DMA device to operate. But according to
> qdev-properties.h, properties of pointer type should be avoided.
> A link type property is a good substitution.
>
> Changes since v1
>  -changed the code in hw/sparc/sun4m.c which uses the device.
>
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  hw/net/lance.c   | 8 ++++++--
>  hw/sparc/sun4m.c | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
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
> @@ -164,7 +169,6 @@ static void lance_class_init(ObjectClass *klass, void *data)
>      dc->reset = lance_reset;
>      dc->vmsd = &vmstate_lance;
>      dc->props = lance_properties;
> -    /* Reason: pointer property "dma" */
>      dc->cannot_instantiate_with_device_add_yet = true;

Please don't remove the comment but not the line it refers
to; either the comment needs updating or the cannot_instantiate
setting is no longer correct and needs removing.

thanks
-- PMM
