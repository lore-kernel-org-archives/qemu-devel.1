Received: from eggs.gnu.org ([2001:4830:134:3::10]:59352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cmnYf-0004h6-Sq
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cmnYb-0005DP-VO
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:24:09 -0500
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:56185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cmnYb-0005BN-LP
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:24:05 -0500
References: <20170227193857.9368-1-marex@denx.de>
From: Marek Vasut <marex@denx.de>
Message-ID: <1458a0a7-7ed6-c314-95af-1a2f056968be@denx.de>
Date: Sat, 11 Mar 2017 21:23:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170227193857.9368-1-marex@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] nios2: iic: Convert CPU prop to qom link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Chris Wulff <crwulff@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>

On 02/27/2017 08:38 PM, Marek Vasut wrote:
> Add a const qom link between the CPU and the IIC instead
> of passing the CPU link through a qom property.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Jeff Da Silva <jdasilva@altera.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Sandra Loosemore <sandra@codesourcery.com>
> Cc: Yves Vandervennet <yvanderv@altera.com>

Why is this patch not applied yet ?

> ---
> V2: Retain dc->cannot_instantiate_with_device_add_yet = true
>     in altera_iic_class_init() since the device is still not
>     device_add() creatable.
> ---
>  hw/intc/nios2_iic.c       | 12 ++++--------
>  hw/nios2/10m50_devboard.c |  3 ++-
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
> index 818ab1b315..fe15621202 100644
> --- a/hw/intc/nios2_iic.c
> +++ b/hw/intc/nios2_iic.c
> @@ -62,17 +62,15 @@ static void altera_iic_init(Object *obj)
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &pv->parent_irq);
>  }
>  
> -static Property altera_iic_properties[] = {
> -    DEFINE_PROP_PTR("cpu", AlteraIIC, cpu),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void altera_iic_realize(DeviceState *dev, Error **errp)
>  {
>      struct AlteraIIC *pv = ALTERA_IIC(dev);
> +    Error *err = NULL;
>  
> +    pv->cpu = object_property_get_link(OBJECT(dev), "cpu", &err);
>      if (!pv->cpu) {
> -        error_setg(errp, "altera,iic: CPU not connected");
> +        error_setg(errp, "altera,iic: CPU link not found: %s",
> +                   error_get_pretty(err));
>          return;
>      }
>  }
> @@ -81,8 +79,6 @@ static void altera_iic_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    dc->props = altera_iic_properties;
> -    /* Reason: pointer property "cpu" */
>      dc->cannot_instantiate_with_device_add_yet = true;
>      dc->realize = altera_iic_realize;
>  }
> diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
> index 0d8b9aa58f..c18e0b2a17 100644
> --- a/hw/nios2/10m50_devboard.c
> +++ b/hw/nios2/10m50_devboard.c
> @@ -83,7 +83,8 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
>  
>      /* Register: Internal Interrupt Controller (IIC) */
>      dev = qdev_create(NULL, "altera,iic");
> -    qdev_prop_set_ptr(dev, "cpu", cpu);
> +    object_property_add_const_link(OBJECT(dev), "cpu", OBJECT(cpu),
> +                                   &error_abort);
>      qdev_init_nofail(dev);
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
>      for (i = 0; i < 32; i++) {
> 


-- 
Best regards,
Marek Vasut
