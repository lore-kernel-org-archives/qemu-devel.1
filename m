Received: from eggs.gnu.org ([2001:4830:134:3::10]:56543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlbU-0006rQ-U9
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlbQ-0001oG-FH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:03:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170901110706.429-1-otubo@redhat.com>
Date: Fri, 01 Sep 2017 15:02:40 +0200
In-Reply-To: <20170901110706.429-1-otubo@redhat.com> (Eduardo Otubo's message
	of "Fri, 1 Sep 2017 13:07:06 +0200")
Message-ID: <87y3py372n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] isa-fdc: assert replaced by proper error
 exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org

Eduardo Otubo <otubo@redhat.com> writes:

> When not available, isa-fdc falls into assert instead of proper error
> exit. This patch fixes this behavior.

When what exactly isn't available?

>
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  hw/block/fdc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 401129073b..0b6def4e1d 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2699,11 +2699,15 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
>      fdctrl->dma_chann = isa->dma;
>      if (fdctrl->dma_chann != -1) {
>          fdctrl->dma = isa_get_dma(isa_bus_from_device(isadev), isa->dma);
> -        assert(fdctrl->dma);
> +        if (!fdctrl->dma) {
> +            error_setg(errp, "isa-fdc not supported");
> +            goto error;
> +        }
>      }
>  
>      qdev_set_legacy_instance_id(dev, isa->iobase, 2);
>      fdctrl_realize_common(dev, fdctrl, &err);
> +error:
>      if (err != NULL) {
>          error_propagate(errp, err);
>          return;

The actual patch makes me suspect it's "when ISA DMA isn't available".
