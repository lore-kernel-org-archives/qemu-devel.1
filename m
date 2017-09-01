Received: from eggs.gnu.org ([2001:4830:134:3::10]:33233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnkGn-0006ix-1Q
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnkGi-0000Xo-CU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:37:53 -0400
References: <20170901110706.429-1-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fecde0d9-8289-af04-e1aa-79d0be06ca32@redhat.com>
Date: Fri, 1 Sep 2017 13:37:34 +0200
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
Cc: qemu-trivial@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org

On 01.09.2017 13:07, Eduardo Otubo wrote:
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

Maybe add the reproducer to the commit message:

 qemu-system-ppc64 -S -machine powernv -device isa-fdc

Reviewed-by: Thomas Huth <thuth@redhat.com>
