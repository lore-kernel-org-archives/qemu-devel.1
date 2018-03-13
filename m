Received: from eggs.gnu.org ([2001:4830:134:3::10]:60855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evsrw-0006GO-RX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evsrs-0001zJ-QO
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:58:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <85567144-145d-40ed-ce32-4b1a7606aeef@amsat.org>
Date: Tue, 13 Mar 2018 23:58:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180313153458.26822-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/9] hw/arm/bcm2836: Rename bcm2836
 type/struct to bcm283x
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
> Our BCM2836 type is really a generic one that can be any of
> the bcm283x family. Rename it accordingly. We change only
> the names which are visible via the header file to the
> rest of the QEMU code, leaving private function names
> in bcm2836.c as they are.
> 
> This is a preliminary to making bcm283x be an abstract
> parent class to specific types for the bcm2836 and bcm2837.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/bcm2836.h | 12 ++++++------
>  hw/arm/bcm2836.c         | 17 +++++++++--------
>  hw/arm/raspi.c           | 16 ++++++++--------
>  3 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 4758b4ae54..9a10a76631 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -15,12 +15,12 @@
>  #include "hw/arm/bcm2835_peripherals.h"
>  #include "hw/intc/bcm2836_control.h"
>  
> -#define TYPE_BCM2836 "bcm2836"
> -#define BCM2836(obj) OBJECT_CHECK(BCM2836State, (obj), TYPE_BCM2836)
> +#define TYPE_BCM283X "bcm283x"
> +#define BCM283X(obj) OBJECT_CHECK(BCM283XState, (obj), TYPE_BCM283X)
>  
> -#define BCM2836_NCPUS 4
> +#define BCM283X_NCPUS 4
>  
> -typedef struct BCM2836State {
> +typedef struct BCM283XState {
>      /*< private >*/
>      DeviceState parent_obj;
>      /*< public >*/
> @@ -28,9 +28,9 @@ typedef struct BCM2836State {
>      char *cpu_type;
>      uint32_t enabled_cpus;
>  
> -    ARMCPU cpus[BCM2836_NCPUS];
> +    ARMCPU cpus[BCM283X_NCPUS];
>      BCM2836ControlState control;
>      BCM2835PeripheralState peripherals;
> -} BCM2836State;
> +} BCM283XState;
>  
>  #endif /* BCM2836_H */
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 9266f27c14..1d1908654b 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,7 +25,7 @@
>  
>  static void bcm2836_init(Object *obj)
>  {
> -    BCM2836State *s = BCM2836(obj);
> +    BCM283XState *s = BCM283X(obj);
>  
>      object_initialize(&s->control, sizeof(s->control), TYPE_BCM2836_CONTROL);
>      object_property_add_child(obj, "control", OBJECT(&s->control), NULL);
> @@ -44,7 +44,7 @@ static void bcm2836_init(Object *obj)
>  
>  static void bcm2836_realize(DeviceState *dev, Error **errp)
>  {
> -    BCM2836State *s = BCM2836(dev);
> +    BCM283XState *s = BCM283X(dev);
>      Object *obj;
>      Error *err = NULL;
>      int n;
> @@ -52,7 +52,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
>      /* common peripherals from bcm2835 */
>  
>      obj = OBJECT(dev);
> -    for (n = 0; n < BCM2836_NCPUS; n++) {
> +    for (n = 0; n < BCM283X_NCPUS; n++) {
>          object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
>                            s->cpu_type);
>          object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
> @@ -102,7 +102,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
>          qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
>  
> -    for (n = 0; n < BCM2836_NCPUS; n++) {
> +    for (n = 0; n < BCM283X_NCPUS; n++) {
>          /* Mirror bcm2836, which has clusterid set to 0xf
>           * TODO: this should be converted to a property of ARM_CPU
>           */
> @@ -150,8 +150,9 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
>  }
>  
>  static Property bcm2836_props[] = {
> -    DEFINE_PROP_STRING("cpu-type", BCM2836State, cpu_type),
> -    DEFINE_PROP_UINT32("enabled-cpus", BCM2836State, enabled_cpus, BCM2836_NCPUS),
> +    DEFINE_PROP_STRING("cpu-type", BCM283XState, cpu_type),
> +    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
> +                       BCM283X_NCPUS),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> @@ -164,9 +165,9 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
>  }
>  
>  static const TypeInfo bcm2836_type_info = {
> -    .name = TYPE_BCM2836,
> +    .name = TYPE_BCM283X,
>      .parent = TYPE_DEVICE,
> -    .instance_size = sizeof(BCM2836State),
> +    .instance_size = sizeof(BCM283XState),
>      .instance_init = bcm2836_init,
>      .class_init = bcm2836_class_init,
>  };
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 1ac0737149..58c6e80a17 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -32,7 +32,7 @@
>  static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43, [3] = 0xc44};
>  
>  typedef struct RasPiState {
> -    BCM2836State soc;
> +    BCM283XState soc;
>      MemoryRegion ram;
>  } RasPiState;
>  
> @@ -136,7 +136,7 @@ static void raspi_init(MachineState *machine, int version)
>      BusState *bus;
>      DeviceState *carddev;
>  
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM2836);
> +    object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM283X);
>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
>                                &error_abort);
>  
> @@ -189,9 +189,9 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
> -    mc->max_cpus = BCM2836_NCPUS;
> -    mc->min_cpus = BCM2836_NCPUS;
> -    mc->default_cpus = BCM2836_NCPUS;
> +    mc->max_cpus = BCM283X_NCPUS;
> +    mc->min_cpus = BCM283X_NCPUS;
> +    mc->default_cpus = BCM283X_NCPUS;
>      mc->default_ram_size = 1024 * 1024 * 1024;
>      mc->ignore_memory_transaction_failures = true;
>  };
> @@ -212,9 +212,9 @@ static void raspi3_machine_init(MachineClass *mc)
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
> -    mc->max_cpus = BCM2836_NCPUS;
> -    mc->min_cpus = BCM2836_NCPUS;
> -    mc->default_cpus = BCM2836_NCPUS;
> +    mc->max_cpus = BCM283X_NCPUS;
> +    mc->min_cpus = BCM283X_NCPUS;
> +    mc->default_cpus = BCM283X_NCPUS;
>      mc->default_ram_size = 1024 * 1024 * 1024;
>  }
>  DEFINE_MACHINE("raspi3", raspi3_machine_init)
> 
