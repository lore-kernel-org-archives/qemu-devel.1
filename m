Received: from eggs.gnu.org ([2001:4830:134:3::10]:33155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evstw-0008Eg-ER
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evsts-0002oc-EN
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:00:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a16c5078-cae8-f9ca-c6bf-ab60937c0dc3@amsat.org>
Date: Wed, 14 Mar 2018 00:00:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180313153458.26822-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/9] hw/arm/bcm2836: Create proper bcm2837
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 03/13/2018 04:34 PM, Peter Maydell wrote:
> The bcm2837 is pretty similar to the bcm2836, but it does have
> some differences. Notably, the MPIDR affinity aff1 values it
> sets for the CPUs are 0x0, rather than the 0xf that the bcm2836
> uses, and if this is wrong Linux will not boot.
> 
> Rather than trying to have one device with properties that
> configure it differently for the two cases, create two
> separate QOM devices for the two SoCs. We use the same approach
> as hw/arm/aspeed_soc.c and share code and have a data table
> that might differ per-SoC. For the moment the two types don't
> actually have different behaviour.

:)

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/bcm2836.h | 19 +++++++++++++++++++
>  hw/arm/bcm2836.c         | 37 ++++++++++++++++++++++++++++++++-----
>  hw/arm/raspi.c           |  3 ++-
>  3 files changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 9a10a76631..93248399ba 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -20,6 +20,13 @@
>  
>  #define BCM283X_NCPUS 4
>  
> +/* These type names are for specific SoCs; other than instantiating
> + * them, code using these devices should always handle them via the
> + * BCM283x base class, so they have no BCM2836(obj) etc macros.
> + */
> +#define TYPE_BCM2836 "bcm2836"
> +#define TYPE_BCM2837 "bcm2837"
> +
>  typedef struct BCM283XState {
>      /*< private >*/
>      DeviceState parent_obj;
> @@ -33,4 +40,16 @@ typedef struct BCM283XState {
>      BCM2835PeripheralState peripherals;
>  } BCM283XState;
>  
> +typedef struct BCM283XInfo BCM283XInfo;
> +
> +typedef struct BCM283XClass {
> +    DeviceClass parent_class;
> +    const BCM283XInfo *info;
> +} BCM283XClass;
> +
> +#define BCM283X_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(BCM283XClass, (klass), TYPE_BCM283X)
> +#define BCM283X_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
> +
>  #endif /* BCM2836_H */
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 1d1908654b..07d2705f96 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -23,6 +23,19 @@
>  /* "QA7" (Pi2) interrupt controller and mailboxes etc. */
>  #define BCM2836_CONTROL_BASE    0x40000000
>  
> +struct BCM283XInfo {
> +    const char *name;
> +};
> +
> +static const BCM283XInfo bcm283x_socs[] = {
> +    {
> +        .name = TYPE_BCM2836,
> +    },
> +    {
> +        .name = TYPE_BCM2837,
> +    },
> +};
> +
>  static void bcm2836_init(Object *obj)
>  {
>      BCM283XState *s = BCM283X(obj);
> @@ -156,25 +169,39 @@ static Property bcm2836_props[] = {
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> -static void bcm2836_class_init(ObjectClass *oc, void *data)
> +static void bcm283x_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> +    BCM283XClass *bc = BCM283X_CLASS(oc);
>  
> -    dc->props = bcm2836_props;
> +    bc->info = data;
>      dc->realize = bcm2836_realize;
> +    dc->props = bcm2836_props;
>  }
>  
> -static const TypeInfo bcm2836_type_info = {
> +static const TypeInfo bcm283x_type_info = {
>      .name = TYPE_BCM283X,
>      .parent = TYPE_DEVICE,
>      .instance_size = sizeof(BCM283XState),
>      .instance_init = bcm2836_init,
> -    .class_init = bcm2836_class_init,
> +    .class_size = sizeof(BCM283XClass),
> +    .abstract = true,
>  };
>  
>  static void bcm2836_register_types(void)
>  {
> -    type_register_static(&bcm2836_type_info);
> +    int i;
> +
> +    type_register_static(&bcm283x_type_info);
> +    for (i = 0; i < ARRAY_SIZE(bcm283x_socs); i++) {
> +        TypeInfo ti = {
> +            .name = bcm283x_socs[i].name,
> +            .parent = TYPE_BCM283X,
> +            .class_init = bcm283x_class_init,
> +            .class_data = (void *) &bcm283x_socs[i],
> +        };
> +        type_register(&ti);
> +    }
>  }
>  
>  type_init(bcm2836_register_types)
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 58c6e80a17..f588720138 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -136,7 +136,8 @@ static void raspi_init(MachineState *machine, int version)
>      BusState *bus;
>      DeviceState *carddev;
>  
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM283X);
> +    object_initialize(&s->soc, sizeof(s->soc),
> +                      version == 3 ? TYPE_BCM2837 : TYPE_BCM2836);
>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
>                                &error_abort);
>  
> 
