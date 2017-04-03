Received: from eggs.gnu.org ([2001:4830:134:3::10]:56190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv3BQ-0000Xn-1z
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv3BP-0002hP-2e
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:42:16 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv3BO-0002gv-RM
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:42:14 -0400
Received: by mail-wr0-x229.google.com with SMTP id l43so174325033wre.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 07:42:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403073550.29162-1-shah.suramya@gmail.com>
References: <20170403073550.29162-1-shah.suramya@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 15:41:53 +0100
Message-ID: <CAFEAcA8S_h+2jT0P_ZoJX3QYHmgf=6ufsrpNguZifErCqqZBeQ@mail.gmail.com>
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
To: Suramya Shah <shah.suramya@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On 3 April 2017 at 08:35, Suramya Shah <shah.suramya@gmail.com> wrote:
> The lance device needs pointer to ISA DMA device to operate. But according to
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

Hi. I'm afraid that this doesn't pass "make check":

TEST: tests/qom-test... (pid=5185)
  /sparc/qom/SS-10:
qemu-system-sparc:
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/qdev-properties.c:1037:
qdev_prop_set_ptr: Assertion `prop && prop->info == &qdev_prop_ptr'
failed.
Broken pipe
FAIL

This is because you've changed the device implementation from
a pointer property to a link, but you haven't changed the code
that uses it, so now when that code tries to set the pointer
property it crashes.

It's always a good idea to use "make check" to do at least
a basic test of your changes (and if you can find test images
that exercise the devices you're changing that's also good,
because 'make check' often doesn't cover as much as we'd like).

> @@ -164,7 +169,6 @@ static void lance_class_init(ObjectClass *klass, void *data)
>      dc->reset = lance_reset;
>      dc->vmsd = &vmstate_lance;
>      dc->props = lance_properties;
> -    /* Reason: pointer property "dma" */
>      dc->cannot_instantiate_with_device_add_yet = true;

This comment is describing the reason why the line below it
sets dc->cannot_instantiate_with_device_add_yet, so you
can't remove only the comment. Either:
 (1) this change means it is now possible to instantiate with
device-add, in which case remove both the comment and the
setting of the flag, or
 (2) it's still not possible to instantiate with device-add,
in which case update the comment to give the new reason.

thanks
-- PMM
