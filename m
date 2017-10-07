Received: from eggs.gnu.org ([2001:4830:134:3::10]:42664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hSD-0002KF-7W
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hSC-0008Rt-0Z
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:15:13 -0400
Date: Sat, 7 Oct 2017 15:40:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171007044037.GF10050@umbus.fritz.box>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-58-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline
In-Reply-To: <20171006235023.11952-58-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 57/88] ppc: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-ppc@nongnu.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 08:49:52PM -0300, Philippe Mathieu-Daud=E9 wrote:
> From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> [PMD: replaced g_new0() -> g_new() in mac_newworld.c, added
> virtex_ml507]

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/heathrow_pic.c | 2 +-
>  hw/ppc/mac_newworld.c  | 5 ++---
>  hw/ppc/mac_oldworld.c  | 2 +-
>  hw/ppc/virtex_ml507.c  | 2 +-
>  4 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
> index 171f5ed814..90c1e6a4b1 100644
> --- a/hw/intc/heathrow_pic.c
> +++ b/hw/intc/heathrow_pic.c
> @@ -201,7 +201,7 @@ qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
>  {
>      HeathrowPICS *s;
> =20
> -    s =3D g_malloc0(sizeof(HeathrowPICS));
> +    s =3D g_new0(HeathrowPICS, 1);
>      /* only 1 CPU */
>      s->irqs =3D irqs[0];
>      memory_region_init_io(&s->mem, NULL, &heathrow_pic_ops, s,
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 6d0ace20ca..59cded95b8 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -295,7 +295,7 @@ static void ppc_core99_init(MachineState *machine)
>      memory_region_init_io(unin2_memory, NULL, &unin_ops, token, "unin", =
0x1000);
>      memory_region_add_subregion(get_system_memory(), 0xf3000000, unin2_m=
emory);
> =20
> -    openpic_irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
> +    openpic_irqs =3D g_new0(qemu_irq *, smp_cpus);
>      openpic_irqs[0] =3D
>          g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
>      for (i =3D 0; i < smp_cpus; i++) {
> @@ -339,8 +339,6 @@ static void ppc_core99_init(MachineState *machine)
>          }
>      }
> =20
> -    pic =3D g_new0(qemu_irq, 64);
> -
>      dev =3D qdev_create(NULL, TYPE_OPENPIC);
>      qdev_prop_set_uint32(dev, "model", OPENPIC_MODEL_KEYLARGO);
>      qdev_init_nofail(dev);
> @@ -353,6 +351,7 @@ static void ppc_core99_init(MachineState *machine)
>          }
>      }
> =20
> +    pic =3D g_new(qemu_irq, 64);
>      for (i =3D 0; i < 64; i++) {
>          pic[i] =3D qdev_get_gpio_in(dev, i);
>      }
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index bc7c8b7bd7..50ad9c56cb 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -232,7 +232,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      memory_region_add_subregion(sysmem, 0xfe000000, isa);
> =20
>      /* XXX: we register only 1 output pin for heathrow PIC */
> -    heathrow_irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
> +    heathrow_irqs =3D g_new0(qemu_irq *, smp_cpus);
>      heathrow_irqs[0] =3D
>          g_malloc0(smp_cpus * sizeof(qemu_irq) * 1);
>      /* Connect the heathrow PIC outputs to the 6xx bus */
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index ed9b406fd3..ed6e054611 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -104,7 +104,7 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram=
_size,
>      ppc_dcr_init(env, NULL, NULL);
> =20
>      /* interrupt controller */
> -    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
> +    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_INP=
UT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_IN=
PUT_CINT];
>      ppcuic_init(env, irqs, 0x0C0, 0, 1);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnYWsUACgkQbDjKyiDZ
s5IciRAAoYze7hsdm1B2PNRBC+tZsP3+u6RAi2L/B9UwuOGBZ2lHtvor5JYIxhcO
6P8T8NiygQMnEBiLFDRe2+ZV+8C78MyjcqREj4OqbukLrjGuwDwq/yYOV1ft6e+B
lAv7A8LbERHWEEWzXS9CMJmoGQeTkNm2zQmregYCjNbks7tjFJLfTD23vk3C5/G4
215DB5pXpnqVhdnnHm5c1W0Ls8A/gHD7MlgDkmjKVBKWIw3WoG3Q6XOoTx2YICvZ
TxHuTVpB8zKiL/GkFb4efFCZQVAhKPW5nrZNfhX+Gs196Q472UlRAITsa5ofU55R
TM4Tn3+hMdykEjkS+yStKK1Sg36oQek9XmrH76EZxNifOuDObmPjw9uj04WMykJX
Wkbf9gEY5F1ngR1/M+tScZ1yTEB1iGbii5K3ydLxd5uvHuqPI/ke8OjoUV6J4tGD
QtBqwPUTmq8Q3BYYCpu3bXjL7u0k06Zo+bB+dRtl/0FHWh56sBu6rTD5Sm0jffSI
f7XwaXvxmfp2iOrUzABWf4/xam/5tEfU7zF27/ybO85sfVLzAGGu3ISiCzU+bFw9
eBqIXuKxezAeKh57yGI16fNqJ7/+TcocupVChM74CzVzOPsG9cIwegAsuAdCRvt+
nhx4iaxsbz1FHwdGFnGpZwt+xxTjWj3RQVmeniAtpj4MIMznR94=
=p/H8
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
