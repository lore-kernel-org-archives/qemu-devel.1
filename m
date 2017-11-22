Received: from eggs.gnu.org ([2001:4830:134:3::10]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOn-0002hV-HO
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOk-0002WU-Aa
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:33 -0500
Date: Wed, 22 Nov 2017 14:28:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122032852.GG2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-2-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-2-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] e500: add board config options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:09PM -0600, Michael Davidsaver wrote:
> allow board code to skip common NIC and guest image setup
> and configure decrementor frequency.
> Existing boards unchanged.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

So, it's spelled "decrementer".

Other than that, the patch looks correct.  However having a big common
function for overall init with a pile of ad-hoc configuration
parameters is usually not a great way to go.  I think what we want
instead is to eliminate ppce500_init(), instead doing the setup logic
separately in each of the e500 machines.   The large common slabs of
code can be helpers in e500.c, but the overall logic - including most
of the things controlled by the current params - would be under the
individual machine's control.

> ---
>  hw/ppc/e500.c      | 8 ++++++--
>  hw/ppc/e500.h      | 3 +++
>  hw/ppc/e500plat.c  | 1 +
>  hw/ppc/mpc8544ds.c | 1 +
>  4 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 5cf0dabef3..9e7e1b29c4 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -826,7 +826,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>          env->mpic_iack =3D params->ccsrbar_base +
>                           MPC8544_MPIC_REGS_OFFSET + 0xa0;
> =20
> -        ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
> +        ppc_booke_timers_init(cpu, params->decrementor_freq, PPC_TIMER_E=
500);
> =20
>          /* Register reset handler */
>          if (!i) {
> @@ -899,7 +899,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      if (!pci_bus)
>          printf("couldn't create PCI controller!\n");
> =20
> -    if (pci_bus) {
> +    if (pci_bus && !params->tsec_nic) {
>          /* Register network interfaces. */
>          for (i =3D 0; i < nb_nics; i++) {
>              pci_nic_init_nofail(&nd_table[i], pci_bus, "virtio", NULL);
> @@ -948,6 +948,10 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>                                      sysbus_mmio_get_region(s, 0));
>      }
> =20
> +    if (params->skip_load) {
> +        return;
> +    }
> +
>      /* Load kernel. */
>      if (machine->kernel_filename) {
>          kernel_base =3D cur_base;
> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
> index 70ba1d8f4f..40f72f2de2 100644
> --- a/hw/ppc/e500.h
> +++ b/hw/ppc/e500.h
> @@ -22,6 +22,9 @@ typedef struct PPCE500Params {
>      hwaddr pci_mmio_base;
>      hwaddr pci_mmio_bus_base;
>      hwaddr spin_base;
> +    uint32_t decrementor_freq; /* in Hz */
> +    bool skip_load;
> +    bool tsec_nic;
>  } PPCE500Params;
> =20
>  void ppce500_init(MachineState *machine, PPCE500Params *params);
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index e59e80fb9e..3d07987bd1 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -47,6 +47,7 @@ static void e500plat_init(MachineState *machine)
>          .pci_mmio_base =3D 0xC00000000ULL,
>          .pci_mmio_bus_base =3D 0xE0000000ULL,
>          .spin_base =3D 0xFEF000000ULL,
> +        .decrementor_freq =3D 400000000,
>      };
> =20
>      /* Older KVM versions don't support EPR which breaks guests when we =
announce
> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
> index 1717953ec7..6d9931c475 100644
> --- a/hw/ppc/mpc8544ds.c
> +++ b/hw/ppc/mpc8544ds.c
> @@ -40,6 +40,7 @@ static void mpc8544ds_init(MachineState *machine)
>          .pci_mmio_bus_base =3D 0xC0000000ULL,
>          .pci_pio_base =3D 0xE1000000ULL,
>          .spin_base =3D 0xEF000000ULL,
> +        .decrementor_freq =3D 400000000,
>      };
> =20
>      if (machine->ram_size > 0xc0000000) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU7vQACgkQbDjKyiDZ
s5J4lA//W+5qyawXBhi2CH3xloLPBjnnqDpx4GZHhpki/oiCzr8GXKqjCFXvUABM
7gviv+KPOdqLbxEeRZ6JKN7yRdAV8Al+2maIWNSYk+a8EJ6NIz/ydzF14boFjAxR
ooac34xMaNahC2biaRGAG0QlLtmK5B4nSiXEn8DxT5+V2GLDiY7CawRnXEJyyIhC
QJtPTbf3S3WJlzMlVpbI89ueoxt7fDw9LOuM8KSr70CACg9sreXbPubMMy36gI2k
yMx3KuJmiUu0iCKnLCeJN6o9NijBg+6ZduL3Q8mshbp+jSipft8ilShd6573j6+0
H4zRCU2hvR24xRp9XG3KMoILxUW5hXbQ36VhpVei/SKM7ShaJeBcwzIng9zhrou3
8ZDkM/bvdpzrI/WYvpbECVjrAWkBGs2pfA/vxizsNdxdkqXllngCnvrxBu5tcW0h
+GQ9x+iMN2IoJDqXObL/H53xGm26vFHbRKnt6BFxu1qwAhOaaFUuuvDLz5PCoD07
gQkX3InZ6wcab3PDMOrHj4ZetBmLtj/s+e/BlLAtQvb43YZs63vuYXVX4DvWZIUa
DAZP7RzyR6OjDzPP65HaU/lFVQLbzR8olYrPY3qy3xntLAjY0xAVPRiLHSFyHLLO
iiju7nvvW2TG/w7MDNODzv0lEAIllaLBhr5R6UKeVUaeYU2V0ow=
=9Wl/
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
