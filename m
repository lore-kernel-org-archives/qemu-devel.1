Received: from eggs.gnu.org ([2001:4830:134:3::10]:39861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec1Pk-0002GU-N7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 23:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec1Pj-0000vE-2Q
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 23:02:56 -0500
Date: Thu, 18 Jan 2018 14:43:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118034340.GD30352@umbus.fritz.box>
References: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
	<151618083506.20461.14178623580944316317.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7QsOHKuLbhbLTwLB"
Content-Disposition: inline
In-Reply-To: <151618083506.20461.14178623580944316317.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr_cpu_core: don't reset CPUs
 during realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--7QsOHKuLbhbLTwLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 10:20:35AM +0100, Greg Kurz wrote:
> When QEMU is started, all cold-plugged CPUs are reset twice: first
> during initialization and then during machine reset. This is sub-
> optimal.
>=20
> The first reset is only needed for hot-plugged CPUs because the CPU
> hotplug code doesn't reset them. This patch adds the necessary code
> to reset hot-plugged CPUs on the CPU core hotplug path, and removes
> the now useless initial CPU reset.
>=20
> We just need to mark the newly created CPU as halted to prevent it
> to run until it is put online later.
>=20
> Full CPU reset is now explicitely triggered from the machine code
> only, either during system reset or during CPU hotplug.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Hrm, this looks ok in outline, but makes me nervous in a couple of
ways.


> ---
>  hw/ppc/spapr.c                  |    8 ++++++++
>  hw/ppc/spapr_cpu_core.c         |    8 ++++++--
>  include/hw/ppc/spapr_cpu_core.h |    2 ++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bca838fce638..a2ff401f738a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3336,6 +3336,14 @@ static void spapr_core_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
>          void *fdt;
>          int fdt_offset;
> =20
> +        if (hotplugged) {

First, I'm always wary of using the hotplugged parameter, because what
qemu means by it often doesn't line up with what PAPR means by it.

> +            int i;
> +
> +            for (i =3D 0; i < cc->nr_threads; i++) {
> +                spapr_cpu_reset(core->threads[i]);
> +            }
> +        }
> +
>          fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> =20
>          spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ac19b2e0b72c..268be7784efb 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -22,7 +22,7 @@
>  #include "sysemu/hw_accel.h"
>  #include "qemu/error-report.h"
> =20
> -static void spapr_cpu_reset(void *opaque)
> +void spapr_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
>      CPUState *cs =3D CPU(cpu);
> @@ -63,7 +63,11 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, P=
owerPCCPU *cpu,
>      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> =20
>      qemu_register_reset(spapr_cpu_reset, cpu);
> -    spapr_cpu_reset(cpu);
> +
> +    /* CPU must not execute anything until explicitely started otherwise=
 the
> +     * guest will crash.
> +     */
> +    CPU(cpu)->halted =3D 1;

And poking specifics in a CPU that hasn't already been set to a known
state by a reset also worries me.

>  }
> =20
>  /*
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 1129f344aa0c..763a2168461e 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -38,4 +38,6 @@ typedef struct sPAPRCPUCoreClass {
>  } sPAPRCPUCoreClass;
> =20
>  const char *spapr_get_cpu_core_type(const char *cpu_type);
> +void spapr_cpu_reset(void *opaque);
> +
>  #endif
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7QsOHKuLbhbLTwLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgF+oACgkQbDjKyiDZ
s5I0zQ//WVpm4eoMs45cWDag4pJZIUjx4N/j/KAgTy+uZhOXBYLzi2YlXEZw06+s
kMjPNjeKaeIP3vc4R5oFXOYd4RBtsFBbWnZb6qRR63Qxo1aXdx5FUNK3bzaPg5zh
oip640oOy++dexj+onmaQsSv6i/5ocSInKLl6TSL0vrFkML6g7LTzmrbRQ5h65Fj
CNQXz3mJX0IOCjW2i/OiOVXZJPSrkt+iYl8IxcxobuEmHGLMu1jKYb0afdct4t+Y
WtfHlIxQhinKI3mmpDYz9Sm6csiOJMkHxoykxDN2BKn+sQQKJFpVjYb2Yfvw8cD/
9ugQXX2jZRwINHWli4gAgcR+iqKazXkIvXX4UqWiBJOpAfNlUXpYvHt29IXmb4mX
+y5oQVfEsCoTin4xFrMAoa6MRHo9/Kq8gePy1Ebaxg7vNUMwwf0TpmeertltSCz4
rwRmri40AIaiCLTuOyGQzpc81Rl4Y7p5e9o5d5vqKkun5k6+m8lA+nElge+VoxxZ
TOFZfyjRbtIld4X40Ypg/pUKWzChbcXP+G9u9Qm98Q3j1uxldWtfrHS3+eEFyVaH
OUJdrTX1pRhxuiqSSwoaMSugAiBRCxPSU9sn2fBF/NS/gMX3LIa+JeFr6XG8CmfQ
gUava01CuVYEjn+fz7QJTm0KM2dMAb6RWrKozs5/HFA3B5mVbYo=
=+jgE
-----END PGP SIGNATURE-----

--7QsOHKuLbhbLTwLB--
