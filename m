Received: from eggs.gnu.org ([2001:4830:134:3::10]:38848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evn1P-0006UY-Aj
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evn1O-0007Yy-4F
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:43:31 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 13 Mar 2018 16:43:21 +0000
Message-ID: <MWHPR21MB0189A866E273E023FC1D73119ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-6-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-6-peter.maydell@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, "patches@linaro.org" <patches@linaro.org>

> From: Qemu-devel <qemu-devel-
> bounces+andrew.baumann=3Dmicrosoft.com@nongnu.org> On Behalf Of Peter
> Maydell
> Sent: Tuesday, 13 March 2018 08:35
>=20
> Our BCM2836 type is really a generic one that can be any of
> the bcm283x family. Rename it accordingly. We change only
> the names which are visible via the header file to the
> rest of the QEMU code, leaving private function names
> in bcm2836.c as they are.
>=20
> This is a preliminary to making bcm283x be an abstract
> parent class to specific types for the bcm2836 and bcm2837.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/bcm2836.h | 12 ++++++------
>  hw/arm/bcm2836.c         | 17 +++++++++--------
>  hw/arm/raspi.c           | 16 ++++++++--------
>  3 files changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 4758b4ae54..9a10a76631 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -15,12 +15,12 @@
>  #include "hw/arm/bcm2835_peripherals.h"
>  #include "hw/intc/bcm2836_control.h"
>=20
> -#define TYPE_BCM2836 "bcm2836"
> -#define BCM2836(obj) OBJECT_CHECK(BCM2836State, (obj), TYPE_BCM2836)
> +#define TYPE_BCM283X "bcm283x"
> +#define BCM283X(obj) OBJECT_CHECK(BCM283XState, (obj), TYPE_BCM283X)
>=20
> -#define BCM2836_NCPUS 4
> +#define BCM283X_NCPUS 4
>
>=20
> -typedef struct BCM2836State {
> +typedef struct BCM283XState {
>      /*< private >*/
>      DeviceState parent_obj;
>      /*< public >*/
> @@ -28,9 +28,9 @@ typedef struct BCM2836State {
>      char *cpu_type;
>      uint32_t enabled_cpus;
>=20
> -    ARMCPU cpus[BCM2836_NCPUS];
> +    ARMCPU cpus[BCM283X_NCPUS];
>      BCM2836ControlState control;
>      BCM2835PeripheralState peripherals;
> -} BCM2836State;
> +} BCM283XState;
>=20
>  #endif /* BCM2836_H */
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 9266f27c14..1d1908654b 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,7 +25,7 @@
>=20
>  static void bcm2836_init(Object *obj)
>  {
> -    BCM2836State *s =3D BCM2836(obj);
> +    BCM283XState *s =3D BCM283X(obj);
>=20
>      object_initialize(&s->control, sizeof(s->control), TYPE_BCM2836_CONT=
ROL);
>      object_property_add_child(obj, "control", OBJECT(&s->control), NULL)=
;
> @@ -44,7 +44,7 @@ static void bcm2836_init(Object *obj)
>=20
>  static void bcm2836_realize(DeviceState *dev, Error **errp)
>  {
> -    BCM2836State *s =3D BCM2836(dev);
> +    BCM283XState *s =3D BCM283X(dev);
>      Object *obj;
>      Error *err =3D NULL;
>      int n;
> @@ -52,7 +52,7 @@ static void bcm2836_realize(DeviceState *dev, Error
> **errp)
>      /* common peripherals from bcm2835 */
>=20
>      obj =3D OBJECT(dev);
> -    for (n =3D 0; n < BCM2836_NCPUS; n++) {
> +    for (n =3D 0; n < BCM283X_NCPUS; n++) {
>          object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
>                            s->cpu_type);
>          object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
> @@ -102,7 +102,7 @@ static void bcm2836_realize(DeviceState *dev, Error
> **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
>          qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
>=20
> -    for (n =3D 0; n < BCM2836_NCPUS; n++) {
> +    for (n =3D 0; n < BCM283X_NCPUS; n++) {
>          /* Mirror bcm2836, which has clusterid set to 0xf
>           * TODO: this should be converted to a property of ARM_CPU
>           */
> @@ -150,8 +150,9 @@ static void bcm2836_realize(DeviceState *dev, Error
> **errp)
>  }
>=20
>  static Property bcm2836_props[] =3D {
> -    DEFINE_PROP_STRING("cpu-type", BCM2836State, cpu_type),
> -    DEFINE_PROP_UINT32("enabled-cpus", BCM2836State, enabled_cpus,
> BCM2836_NCPUS),
> +    DEFINE_PROP_STRING("cpu-type", BCM283XState, cpu_type),
> +    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
> +                       BCM283X_NCPUS),
>      DEFINE_PROP_END_OF_LIST()
>  };
>=20
> @@ -164,9 +165,9 @@ static void bcm2836_class_init(ObjectClass *oc, void
> *data)
>  }
>=20
>  static const TypeInfo bcm2836_type_info =3D {
> -    .name =3D TYPE_BCM2836,
> +    .name =3D TYPE_BCM283X,
>      .parent =3D TYPE_DEVICE,
> -    .instance_size =3D sizeof(BCM2836State),
> +    .instance_size =3D sizeof(BCM283XState),
>      .instance_init =3D bcm2836_init,
>      .class_init =3D bcm2836_class_init,
>  };
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 1ac0737149..58c6e80a17 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -32,7 +32,7 @@
>  static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, [3] =
=3D 0xc44};
>=20
>  typedef struct RasPiState {
> -    BCM2836State soc;
> +    BCM283XState soc;
>      MemoryRegion ram;
>  } RasPiState;
>=20
> @@ -136,7 +136,7 @@ static void raspi_init(MachineState *machine, int
> version)
>      BusState *bus;
>      DeviceState *carddev;
>=20
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM2836);
> +    object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM283X);
>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
>                                &error_abort);
>=20
> @@ -189,9 +189,9 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->no_floppy =3D 1;
>      mc->no_cdrom =3D 1;
>      mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
> -    mc->max_cpus =3D BCM2836_NCPUS;
> -    mc->min_cpus =3D BCM2836_NCPUS;
> -    mc->default_cpus =3D BCM2836_NCPUS;
> +    mc->max_cpus =3D BCM283X_NCPUS;
> +    mc->min_cpus =3D BCM283X_NCPUS;
> +    mc->default_cpus =3D BCM283X_NCPUS;
>      mc->default_ram_size =3D 1024 * 1024 * 1024;
>      mc->ignore_memory_transaction_failures =3D true;
>  };
> @@ -212,9 +212,9 @@ static void raspi3_machine_init(MachineClass *mc)
>      mc->no_floppy =3D 1;
>      mc->no_cdrom =3D 1;
>      mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
> -    mc->max_cpus =3D BCM2836_NCPUS;
> -    mc->min_cpus =3D BCM2836_NCPUS;
> -    mc->default_cpus =3D BCM2836_NCPUS;
> +    mc->max_cpus =3D BCM283X_NCPUS;
> +    mc->min_cpus =3D BCM283X_NCPUS;
> +    mc->default_cpus =3D BCM283X_NCPUS;
>      mc->default_ram_size =3D 1024 * 1024 * 1024;
>  }
>  DEFINE_MACHINE("raspi3", raspi3_machine_init)

Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
