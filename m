Received: from eggs.gnu.org ([2001:4830:134:3::10]:40811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnrdM-0000mN-UH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnrdI-0007PB-9C
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:29:40 -0400
References: <20170901110706.429-1-otubo@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <af65a01a-d4a5-e043-b222-87bbaf797d2a@redhat.com>
Date: Fri, 1 Sep 2017 15:29:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170901110706.429-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org



On 09/01/2017 07:07 AM, Eduardo Otubo wrote:
> When not available, isa-fdc falls into assert instead of proper error
> exit. This patch fixes this behavior.
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
> 

I was going to ask if we needn't take care of undoing the portio or IRQ
registration, but it turns out that there is not one single caller of
portio_list_destroy in all of QEMU...

Paolo admitted as much in e3fb0ade83420a86464ee50c71f2daf5641cab10 when
he updated the destroy function :)

It looks like the way we assign IRQs to ISA devices is kind of simple
and not trivial to undo correctly, so instead of barking up that tree,
why don't we hoist the isa_get_dma call up and fail before we try to
initialize portio or IRQs?
