Received: from eggs.gnu.org ([2001:4830:134:3::10]:50197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTyVH-0004xR-T2
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 19:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTyVF-0004Pu-DU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 19:23:55 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:50785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gTyV4-0004HX-QH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 19:23:47 -0500
Date: Tue, 4 Dec 2018 11:18:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181204001848.GA1682@umbus.fritz.box>
References: <154385426086.17724.4390242199797858265.stgit@gimli.home>
	<154385451622.17724.12272989665681200621.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <154385451622.17724.12272989665681200621.stgit@gimli.home>
Subject: Re: [Qemu-devel] [for-4.0 PATCH v2 8/9] q35/440fx/arm/spapr: Add
 QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 09:28:36AM -0700, Alex Williamson wrote:
> Including all machine types that might have a pcie-root-port.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/arm/virt.c        |   19 +++++++++++++++++--
>  hw/i386/pc_piix.c    |   15 ++++++++++++---
>  hw/i386/pc_q35.c     |   13 +++++++++++--
>  hw/ppc/spapr.c       |   25 ++++++++++++++++++++++---
>  include/hw/compat.h  |    3 +++
>  include/hw/i386/pc.h |    3 +++
>  6 files changed, 68 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f69e7eb39977..beaf6bc43905 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1797,7 +1797,7 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
> =20
> -static void virt_3_1_instance_init(Object *obj)
> +static void virt_4_0_instance_init(Object *obj)
>  {
>      VirtMachineState *vms =3D VIRT_MACHINE(obj);
>      VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
> @@ -1867,10 +1867,25 @@ static void virt_3_1_instance_init(Object *obj)
>      vms->irqmap =3D a15irqmap;
>  }
> =20
> +static void virt_machine_4_0_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(4, 0)
> +
> +#define VIRT_COMPAT_3_1 \
> +    HW_COMPAT_3_1
> +
> +static void virt_3_1_instance_init(Object *obj)
> +{
> +    virt_4_0_instance_init(obj);
> +}
> +
>  static void virt_machine_3_1_options(MachineClass *mc)
>  {
> +    virt_machine_4_0_options(mc);
> +    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_1);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
> +DEFINE_VIRT_MACHINE(3, 1)
> =20
>  #define VIRT_COMPAT_3_0 \
>      HW_COMPAT_3_0
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 7092d6d13f66..cfaa83ee2fad 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -428,21 +428,30 @@ static void pc_i440fx_machine_options(MachineClass =
*m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>  }
> =20
> -static void pc_i440fx_3_1_machine_options(MachineClass *m)
> +static void pc_i440fx_4_0_machine_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>      m->alias =3D "pc";
>      m->is_default =3D 1;
>  }
> =20
> +DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
> +                      pc_i440fx_4_0_machine_options);
> +
> +static void pc_i440fx_3_1_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_4_0_machine_options(m);
> +    m->is_default =3D 0;
> +    m->alias =3D NULL;
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
> +}
> +
>  DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
>                        pc_i440fx_3_1_machine_options);
> =20
>  static void pc_i440fx_3_0_machine_options(MachineClass *m)
>  {
>      pc_i440fx_3_1_machine_options(m);
> -    m->is_default =3D 0;
> -    m->alias =3D NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
>  }
> =20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 4702bb13c472..e245db096dc1 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -311,19 +311,28 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus =3D 288;
>  }
> =20
> -static void pc_q35_3_1_machine_options(MachineClass *m)
> +static void pc_q35_4_0_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias =3D "q35";
>  }
> =20
> +DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
> +                   pc_q35_4_0_machine_options);
> +
> +static void pc_q35_3_1_machine_options(MachineClass *m)
> +{
> +    pc_q35_4_0_machine_options(m);
> +    m->alias =3D NULL;
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
> +}
> +
>  DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
>                     pc_q35_3_1_machine_options);
> =20
>  static void pc_q35_3_0_machine_options(MachineClass *m)
>  {
>      pc_q35_3_1_machine_options(m);
> -    m->alias =3D NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
>  }
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7afd1a175bf2..80d8498867a6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3956,19 +3956,38 @@ static const TypeInfo spapr_machine_info =3D {
>      }                                                                \
>      type_init(spapr_machine_register_##suffix)
> =20
> - /*
> +/*
> + * pseries-4.0
> + */
> +static void spapr_machine_4_0_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void spapr_machine_4_0_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> +
> +/*
>   * pseries-3.1
>   */
> +#define SPAPR_COMPAT_3_1                                              \
> +    HW_COMPAT_3_1
> +
>  static void spapr_machine_3_1_instance_options(MachineState *machine)
>  {
> +    spapr_machine_4_0_instance_options(machine);
>  }
> =20
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_3_1_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
>  }
> =20
> -DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
> +DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> =20
>  /*
>   * pseries-3.0
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 6f4d5fc64704..70958328fe7a 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
> =20
> +#define HW_COMPAT_3_1 \
> +    /* empty */
> +
>  #define HW_COMPAT_3_0 \
>      /* empty */
> =20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 136fe497b6b2..cb645bf368a3 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -294,6 +294,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> =20
> +#define PC_COMPAT_3_1 \
> +    HW_COMPAT_3_1 \
> +
>  #define PC_COMPAT_3_0 \
>      HW_COMPAT_3_0 \
>      {\
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwFx+YACgkQbDjKyiDZ
s5IVqw/2NQhhJupeefY6GSIH8RMLeiJAV4w28am2q3pwIctRxzv81qGf8VL46sZJ
xWI/YsVM00DlhwMOKsdWNSyUJjU31us/mxq4hMnVQ2OHYLTuEPwX/RLrW3C/Efq9
tTDyZNi2raovLLU0Lz5pisSit+x351YZDpDw0gkYpUqEYjsTkv8mYe2oHF9vwsrR
JzryJd1dJbX0s40N66K3nSfdMOrVbOkI5koccvI49LaSc3XPQGSSv0UkzcRiB7D1
R+bEO9WPTkyrLHdJ3+niEnl/LqmkIWLN95QrLeIbnDFs/sq0r6scNnJ9khKelK/U
2XCQFCyx0kV+4OwRE93iX9rZbbevgqqb67X9nDysdFuiFzHS5tg+hcbluagwShSd
+xeT6t3/X9sRi06AVUiRNpAvfCiDV1Zo89Pe7TQ2LUKQx76ouszx5jciEN+I2OXF
sL5BySQTgmOtGDQi7X+gjz0EvGLlcM7gzlyWGraLLDGVaGaOdGnG7eCYqicuRHi5
+jDmlhtmY0wDnhcdjMPAMF9s+BQ3hdhrajNQHBMCzhPY84dmz9OImrSsvElWugMX
9kHL8NcBke0rVEePAer30qew9Obn4hL0a4p9ytGu6gE4GVnzfe8R67wnPMz0XeY1
Uw1F5PGmzCjYgSZAW4fmCcMkYlVM1DaNJqbFfoA6UbKxuVKgfQ==
=Py5F
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
