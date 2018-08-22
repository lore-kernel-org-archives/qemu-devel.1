Received: from eggs.gnu.org ([2001:4830:134:3::10]:41985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOU9-0007dp-ME
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOU4-0002Mq-4j
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:25 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-8-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <7d6caa58-618e-c082-5db4-6eabafd99797@greensocs.com>
Date: Wed, 22 Aug 2018 10:27:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-8-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W3Rsh7aAb63yOvbwnuB67x1rMzphAJFjR"
Subject: Re: [Qemu-devel] [PATCH 7/9] hw/cpu/a15mpcore: If CPU has EL2,
 enable it on the GIC and wire it up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W3Rsh7aAb63yOvbwnuB67x1rMzphAJFjR
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <7d6caa58-618e-c082-5db4-6eabafd99797@greensocs.com>
Subject: Re: [PATCH 7/9] hw/cpu/a15mpcore: If CPU has EL2, enable it on the
 GIC and wire it up
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-8-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/21/18 3:28 PM, Peter Maydell wrote:
> For the A15MPCore internal peripheral object, we handle GIC
> security extensions support by checking whether the CPUs
> have EL3 enabled; if so then we enable it also on the GIC.
> Handle the virtualization extensions in the same way: if the
> CPU has EL2 then enable it on the GIC and wire up the
> virtualization-specific memory regions and the maintenance
> interrupt.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/cpu/a15mpcore.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
> index 43c10794938..226ce8900f2 100644
> --- a/hw/cpu/a15mpcore.c
> +++ b/hw/cpu/a15mpcore.c
> @@ -53,6 +53,7 @@ static void a15mp_priv_realize(DeviceState *dev, Erro=
r **errp)
>      int i;
>      Error *err =3D NULL;
>      bool has_el3;
> +    bool has_el2;
>      Object *cpuobj;
> =20
>      gicdev =3D DEVICE(&s->gic);
> @@ -67,6 +68,10 @@ static void a15mp_priv_realize(DeviceState *dev, Err=
or **errp)
>          has_el3 =3D object_property_find(cpuobj, "has_el3", NULL) &&
>              object_property_get_bool(cpuobj, "has_el3", &error_abort);=

>          qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);=

> +        /* Similarly for virtualization support */
> +        has_el2 =3D object_property_find(cpuobj, "has_el2", NULL) &&
> +            object_property_get_bool(cpuobj, "has_el2", &error_abort);=

> +        qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has=
_el2);
>      }
> =20
>      object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);=

> @@ -103,20 +108,40 @@ static void a15mp_priv_realize(DeviceState *dev, =
Error **errp)
>                                    qdev_get_gpio_in(gicdev,
>                                                     ppibase + timer_irq=
[irq]));
>          }
> +        if (has_el2) {
> +            /* Connect the GIC maintenance interrupt to PPI ID 25 */
> +            sysbus_connect_irq(SYS_BUS_DEVICE(gicdev), i + 4 * s->num_=
cpu,
> +                               qdev_get_gpio_in(gicdev, ppibase + 25))=
;
> +        }
>      }
> =20
>      /* Memory map (addresses are offsets from PERIPHBASE):
>       *  0x0000-0x0fff -- reserved
>       *  0x1000-0x1fff -- GIC Distributor
>       *  0x2000-0x3fff -- GIC CPU interface
> -     *  0x4000-0x4fff -- GIC virtual interface control (not modelled)
> -     *  0x5000-0x5fff -- GIC virtual interface control (not modelled)
> -     *  0x6000-0x7fff -- GIC virtual CPU interface (not modelled)
> +     *  0x4000-0x4fff -- GIC virtual interface control for this CPU
> +     *  0x5000-0x51ff -- GIC virtual interface control for CPU 0
> +     *  0x5200-0x53ff -- GIC virtual interface control for CPU 1
> +     *  0x5400-0x55ff -- GIC virtual interface control for CPU 2
> +     *  0x5600-0x57ff -- GIC virtual interface control for CPU 3
> +     *  0x6000-0x7fff -- GIC virtual CPU interface
>       */
>      memory_region_add_subregion(&s->container, 0x1000,
>                                  sysbus_mmio_get_region(busdev, 0));
>      memory_region_add_subregion(&s->container, 0x2000,
>                                  sysbus_mmio_get_region(busdev, 1));
> +    if (has_el2) {
> +        memory_region_add_subregion(&s->container, 0x4000,
> +                                    sysbus_mmio_get_region(busdev, 2))=
;
> +        memory_region_add_subregion(&s->container, 0x6000,
> +                                    sysbus_mmio_get_region(busdev, 3))=
;
> +        for (i =3D 0; i < s->num_cpu; i++) {
> +            hwaddr base =3D 0x5000 + i * 0x200;
> +            MemoryRegion *mr =3D sysbus_mmio_get_region(busdev,
> +                                                      4 + s->num_cpu +=
 i);
> +            memory_region_add_subregion(&s->container, base, mr);
> +        }
> +    }
>  }
> =20
>  static Property a15mp_priv_properties[] =3D {
>=20


--W3Rsh7aAb63yOvbwnuB67x1rMzphAJFjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9HlQACgkQd8knW3Qn
Tr7tIRAAlC2FYWPfHwElKjZguCBS5pwga5JxdXmUT0ghyPMBKRqlsqmUFMtJXAzi
c5gjEmu8Y7MunRPPwua3cDCGinTzmFFamVkguFgYZnHcmgExhfPwlPQQ3h5iBfk3
Ho3aTjaaC12IuCOEFu9NxvS34Pyc8O3N4xpeegwM1zJ9KQPV2W5TwTtkP0S/4LRv
e5XIHzoaur/x+jIrVdmJ4dz7z6EIZgBONXVogbCcTzdjMa0FAOW3KF0xKAjHoZ19
GSzy/uFSed6Nt949ZlFjbvCNoHLE57DheWB6Wcpu6HLe2WgXwk3pYh/DZzyRr4dT
4Exx/8+XM4KLgpmj8FWUPkdE25bY/sxitIpaAigQn89tTKHuZjLLE6TkoJH78VbU
sF7stcmC3kjnSYmNfGOzZpmAvjhn2qQ6y18PuWqxncX9Y/yDDo/QGqFk1TtLmlC7
RMSox5xo18KW92wafxBWoir8JLAP8Eq4qTrNnmZHYkhuc7iPIkQ+d9bB8yw18f02
ZuvYWVIhgZQ0td7I9+vz6KF/SIT6W8opWVcK/S4puhA/7Cthid9/mbMP3c/huEBc
BssY6S6l0a5h3v67DmvaBrklfNBFJqX6ftwbAgx/c6HCkKAAOzMTB1EsrFLs3LAd
8RKT4EdIBPXc0lrs3ZicgX3mgcMxPhpXFvjoUFXESrI37Mde2mQ=
=r3el
-----END PGP SIGNATURE-----

--W3Rsh7aAb63yOvbwnuB67x1rMzphAJFjR--
