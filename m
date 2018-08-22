Received: from eggs.gnu.org ([2001:4830:134:3::10]:42097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOUG-0007kJ-J4
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOUF-0002Ws-63
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:32 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-10-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <fd18e480-a9ea-bfa1-bab3-d395fb9b6079@greensocs.com>
Date: Wed, 22 Aug 2018 10:27:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-10-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="swI1fgIQCeOdDQ0EkmQjC3cL8UK87s06t"
Subject: Re: [Qemu-devel] [PATCH 9/9] hw/arm/vexpress: Add "virtualization"
 property controlling presence of EL2
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
--swI1fgIQCeOdDQ0EkmQjC3cL8UK87s06t
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <fd18e480-a9ea-bfa1-bab3-d395fb9b6079@greensocs.com>
Subject: Re: [PATCH 9/9] hw/arm/vexpress: Add "virtualization" property
 controlling presence of EL2
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-10-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/21/18 3:28 PM, Peter Maydell wrote:
> Add a "virtualization" property to the vexpress-a15 board,
> controlling presence of EL2. As with EL3, we default to
> enabling it, but the user can disable it if they have an
> older guest which can't cope with it being present.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/vexpress.c | 56 ++++++++++++++++++++++++++++++++++++++++++++---=

>  1 file changed, 53 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 3631f4de3a4..c02d18ee618 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -172,6 +172,7 @@ typedef struct {
>  typedef struct {
>      MachineState parent;
>      bool secure;
> +    bool virt;
>  } VexpressMachineState;
> =20
>  #define TYPE_VEXPRESS_MACHINE   "vexpress"
> @@ -203,7 +204,7 @@ struct VEDBoardInfo {
>  };
> =20
>  static void init_cpus(const char *cpu_type, const char *privdev,
> -                      hwaddr periphbase, qemu_irq *pic, bool secure)
> +                      hwaddr periphbase, qemu_irq *pic, bool secure, b=
ool virt)
>  {
>      DeviceState *dev;
>      SysBusDevice *busdev;
> @@ -216,6 +217,11 @@ static void init_cpus(const char *cpu_type, const =
char *privdev,
>          if (!secure) {
>              object_property_set_bool(cpuobj, false, "has_el3", NULL);
>          }
> +        if (!virt) {
> +            if (object_property_find(cpuobj, "has_el2", NULL)) {
> +                object_property_set_bool(cpuobj, false, "has_el2", NUL=
L);
> +            }
> +        }
> =20
>          if (object_property_find(cpuobj, "reset-cbar", NULL)) {
>              object_property_set_int(cpuobj, periphbase,
> @@ -289,7 +295,8 @@ static void a9_daughterboard_init(const VexpressMac=
hineState *vms,
>      memory_region_add_subregion(sysmem, 0x60000000, ram);
> =20
>      /* 0x1e000000 A9MPCore (SCU) private memory region */
> -    init_cpus(cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic, vms->secu=
re);
> +    init_cpus(cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic,
> +              vms->secure, vms->virt);
> =20
>      /* Daughterboard peripherals : 0x10020000 .. 0x20000000 */
> =20
> @@ -370,7 +377,8 @@ static void a15_daughterboard_init(const VexpressMa=
chineState *vms,
>      memory_region_add_subregion(sysmem, 0x80000000, ram);
> =20
>      /* 0x2c000000 A15MPCore private memory region (GIC) */
> -    init_cpus(cpu_type, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->sec=
ure);
> +    init_cpus(cpu_type, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->sec=
ure,
> +              vms->virt);
> =20
>      /* A15 daughterboard peripherals: */
> =20
> @@ -724,6 +732,20 @@ static void vexpress_set_secure(Object *obj, bool =
value, Error **errp)
>      vms->secure =3D value;
>  }
> =20
> +static bool vexpress_get_virt(Object *obj, Error **errp)
> +{
> +    VexpressMachineState *vms =3D VEXPRESS_MACHINE(obj);
> +
> +    return vms->virt;
> +}
> +
> +static void vexpress_set_virt(Object *obj, bool value, Error **errp)
> +{
> +    VexpressMachineState *vms =3D VEXPRESS_MACHINE(obj);
> +
> +    vms->virt =3D value;
> +}
> +
>  static void vexpress_instance_init(Object *obj)
>  {
>      VexpressMachineState *vms =3D VEXPRESS_MACHINE(obj);
> @@ -738,6 +760,32 @@ static void vexpress_instance_init(Object *obj)
>                                      NULL);
>  }
> =20
> +static void vexpress_a15_instance_init(Object *obj)
> +{
> +    VexpressMachineState *vms =3D VEXPRESS_MACHINE(obj);
> +
> +    /*
> +     * For the vexpress-a15, EL2 is by default enabled if EL3 is,
> +     * but can also be specifically set to on or off.
> +     */
> +    vms->virt =3D true;
> +    object_property_add_bool(obj, "virtualization", vexpress_get_virt,=

> +                             vexpress_set_virt, NULL);
> +    object_property_set_description(obj, "virtualization",
> +                                    "Set on/off to enable/disable the =
ARM "
> +                                    "Virtualization Extensions "
> +                                    "(defaults to same as 'secure')",
> +                                    NULL);
> +}
> +
> +static void vexpress_a9_instance_init(Object *obj)
> +{
> +    VexpressMachineState *vms =3D VEXPRESS_MACHINE(obj);
> +
> +    /* The A9 doesn't have the virt extensions */
> +    vms->virt =3D false;
> +}
> +
>  static void vexpress_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -784,12 +832,14 @@ static const TypeInfo vexpress_a9_info =3D {
>      .name =3D TYPE_VEXPRESS_A9_MACHINE,
>      .parent =3D TYPE_VEXPRESS_MACHINE,
>      .class_init =3D vexpress_a9_class_init,
> +    .instance_init =3D vexpress_a9_instance_init,
>  };
> =20
>  static const TypeInfo vexpress_a15_info =3D {
>      .name =3D TYPE_VEXPRESS_A15_MACHINE,
>      .parent =3D TYPE_VEXPRESS_MACHINE,
>      .class_init =3D vexpress_a15_class_init,
> +    .instance_init =3D vexpress_a15_instance_init,
>  };
> =20
>  static void vexpress_machine_init(void)
>=20


--swI1fgIQCeOdDQ0EkmQjC3cL8UK87s06t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9HmIACgkQd8knW3Qn
Tr7HvQ//Y4pw3ROnV8isIgrbS7K3IRmj99BCI3/R9u2z9xM6IxEh4N4czHcS/QIZ
jwPzJNKaao/6QizuDT5inkMGjpUBsO7bz9WkokfUHHAJK9zustTU2ofvbW/PGWmO
+4qS7hQQkHyB43WFOuc5QLtDcsmJoEef04hBFff62yji7eXYtyhUxGx1r3/4ovdt
k6or/as+/+r98OWWPkb4Co+NNMT4NvQP1t2yqNrQbgHQ6rakzg3225p0fLhB6/K7
7joKYIcyOM/zSnfSJzmTP0cna7PlqTuOe6I7p11O/PxUsGO+1Yly4+gAoCGYc1GW
qNDKdMB4NiJDLcfFELx1TtI014U6DgXh1T94NwIU0bg0U7GmUn6mpyvQBWo8I0xu
T3BN81kkyuFdYFzZcu8qFiIH07pbivIDNkjRS54Lbe6JyOKxs19DIdZaSzU+HMPT
b5LI1HGiyH+o+SfrfJMxRJDMc5jKJG9TYPaQw7RFDP30I2RowMBDZpqoxdg0UcRf
NciZamfWfSnpDEwG4azlVoxIxVIpuovnVEUog5xpmH3AdMz9aCNpmqvYAYwl7ni8
U+MW+zltFIGj7Pfz7AhrpBVaDdAFOcimREvlira+O/+h6aXxcpPUGP8zvJzQYdbD
ZMya2djuSPhpHej0pxkGwWs5oCMQXffReT1Ruq8zO/JCIVyfeEA=
=dHfh
-----END PGP SIGNATURE-----

--swI1fgIQCeOdDQ0EkmQjC3cL8UK87s06t--
