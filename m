Received: from eggs.gnu.org ([2001:4830:134:3::10]:55142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eBsDo-0004wv-Kv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eBsDl-0003Pf-En
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:58:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1eBsDl-0003PF-7c
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:58:29 -0500
References: <20171026064635.7179-1-aik@ozlabs.ru>
From: John Snow <jsnow@redhat.com>
Message-ID: <13277057-669f-cd77-95f1-f0e54f7ae222@redhat.com>
Date: Mon, 6 Nov 2017 19:58:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171026064635.7179-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] fdc: Exit if ISA controller does not
 support DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 10/26/2017 02:46 AM, Alexey Kardashevskiy wrote:
> A "powernv" machine type defines an ISA bus but it does not add any DMA
> controller to it so it is possible to hit assert(fdctrl->dma) by
> adding "-machine powernv -device isa-fdc".
> 
> This replaces assert() with an error message.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> Is it a must for ISA to have DMA controllers?
> 
> 
> ---
>  hw/block/fdc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 67f78ac702..ed8b367572 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2700,7 +2700,10 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
>      fdctrl->dma_chann = isa->dma;
>      if (fdctrl->dma_chann != -1) {
>          fdctrl->dma = isa_get_dma(isa_bus_from_device(isadev), isa->dma);
> -        assert(fdctrl->dma);
> +        if (!fdctrl->dma) {
> +            error_setg(errp, "ISA controller does not support DMA, exiting");
> +            return;
> +        }
>      }
>  
>      qdev_set_legacy_instance_id(dev, isa->iobase, 2);
> 

I've been MIA for a little while, so I'm out of the loop -- but I am not
sure this is entirely the right way to fix this problem. I think it is
more the case that certain boards should not be able to ask for certain
types of devices, and we should prohibit e.g. powernv from being able to
ask for an ISA floppy disk controller.

(It doesn't seem to have an ISA DMA controller by default, but I have no
idea if that means it can't EVER have one...)

Papering over this by making it a soft error when we fail to execute
isa_get_dma and then assuming in retrospect it's because the machine
type we're on cannot have an ISA DMA controller seems a little
wrong-headed. It also leaves side-effects from isa_register_portio_list
and isa_init_irq, so we can't just bail here -- it's only marginally
better than the assert() it's doing.

That said, I am not really sure what the right thing to do is ... I
suspect the "right thing" is to express the dependency that isa-fdc
requires an ISA DMA controller -- and maybe that check happens here when
isa_get_dma fails and we have to unwind the realize function, but we
need to do it gracefully.

Give me a day to think about it, but I do want to make sure this is in
the next release.

--John
