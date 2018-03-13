Received: from eggs.gnu.org ([2001:4830:134:3::10]:42609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evnD3-0000B0-Uc
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evnD2-0004Wi-TJ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:55:33 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 13 Mar 2018 16:55:23 +0000
Message-ID: <MWHPR21MB018983B74A652443B70680F19ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-9-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-9-peter.maydell@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/arm/bcm2836: Hardcode correct CPU
 type
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
> Now we have separate types for BCM2386 and BCM2387, we might as well
> just hard-code the CPU type they use rather than having it passed
> through as an object property. This then lets us put the initialization
> of the CPU object in init rather than realize.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/bcm2836.c | 22 +++++++++++++---------
>  hw/arm/raspi.c   |  2 --
>  2 files changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 7140257c98..12f75b55a7 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,16 +25,19 @@
>=20
>  struct BCM283XInfo {
>      const char *name;
> +    const char *cpu_type;
>      int clusterid;
>  };
>=20
>  static const BCM283XInfo bcm283x_socs[] =3D {
>      {
>          .name =3D TYPE_BCM2836,
> +        .cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15"),

At some point I remember seeing a patch to change this to cortex-a7. Is the=
re a reason we didn't make that change?

(Background: the real Pi2 has an A7. When I first implemented the machine m=
odel there was no A7 emulation in QEMU, so I used the A15 which was the clo=
sest equivalent.)

>          .clusterid =3D 0xf,
>      },
>      {
>          .name =3D TYPE_BCM2837,
> +        .cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53"),
>          .clusterid =3D 0x0,
>      },
>  };
> @@ -42,6 +45,16 @@ static const BCM283XInfo bcm283x_socs[] =3D {
>  static void bcm2836_init(Object *obj)
>  {
>      BCM283XState *s =3D BCM283X(obj);
> +    BCM283XClass *bc =3D BCM283X_GET_CLASS(obj);
> +    const BCM283XInfo *info =3D bc->info;
> +    int n;
> +
> +    for (n =3D 0; n < BCM283X_NCPUS; n++) {
> +        object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
> +                          info->cpu_type);
> +        object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
> +                                  &error_abort);
> +    }
>=20
>      object_initialize(&s->control, sizeof(s->control), TYPE_BCM2836_CONT=
ROL);
>      object_property_add_child(obj, "control", OBJECT(&s->control), NULL)=
;
> @@ -69,14 +82,6 @@ static void bcm2836_realize(DeviceState *dev, Error
> **errp)
>=20
>      /* common peripherals from bcm2835 */
>=20
> -    obj =3D OBJECT(dev);
> -    for (n =3D 0; n < BCM283X_NCPUS; n++) {
> -        object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
> -                          s->cpu_type);
> -        object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
> -                                  &error_abort);
> -    }
> -
>      obj =3D object_property_get_link(OBJECT(dev), "ram", &err);
>      if (obj =3D=3D NULL) {
>          error_setg(errp, "%s: required ram link not found: %s",
> @@ -168,7 +173,6 @@ static void bcm2836_realize(DeviceState *dev, Error
> **errp)
>  }
>=20
>  static Property bcm2836_props[] =3D {
> -    DEFINE_PROP_STRING("cpu-type", BCM283XState, cpu_type),
>      DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
>                         BCM283X_NCPUS),
>      DEFINE_PROP_END_OF_LIST()
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index f588720138..ae15997669 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -150,8 +150,6 @@ static void raspi_init(MachineState *machine, int
> version)
>      /* Setup the SOC */
>      object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ra=
m),
>                                     &error_abort);
> -    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-typ=
e",
> -                            &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
>                              &error_abort);
>      int board_rev =3D version =3D=3D 3 ? 0xa02082 : 0xa21041;

What about the default_cpu_type field of MachineClass set in raspi[23]_mach=
ine_init? That seems irrelevant now... Also, if anyone cares (I don't), we =
also just lost the ability to override the CPU type of a raspi model.=20

Otherwise,
Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>

Cheers,
Andrew
