Received: from eggs.gnu.org ([2001:4830:134:3::10]:40370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7S1-0002QL-Dw
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 23:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7Rw-0006l9-Bi
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 23:09:17 -0500
Date: Fri, 7 Dec 2018 15:07:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207040742.GD10945@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-16-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20181205232251.10446-16-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 15/37] spapr: export and rename the
 xics_max_server_number() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:22:29AM +0100, C=E9dric Le Goater wrote:
> The XIVE sPAPR IRQ backend will use it to define the number of ENDs of
> the IC controller.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Again, this makes sense on its own, so I've applied.

> ---
>  include/hw/ppc/spapr.h | 1 +
>  hw/ppc/spapr.c         | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 6279711fe8f7..198764066dc9 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -737,6 +737,7 @@ int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
>  void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
>                            Error **errp);
>  void spapr_clear_pending_events(sPAPRMachineState *spapr);
> +int spapr_max_server_number(sPAPRMachineState *spapr);
> =20
>  /* CPU and LMB DRC release callbacks. */
>  void spapr_core_release(DeviceState *dev);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e470efe7993c..a689f853e020 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -150,7 +150,7 @@ static void pre_2_10_vmstate_unregister_dummy_icp(int=
 i)
>                         (void *)(uintptr_t) i);
>  }
> =20
> -static int xics_max_server_number(sPAPRMachineState *spapr)
> +int spapr_max_server_number(sPAPRMachineState *spapr)
>  {
>      assert(spapr->vsmt);
>      return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
> @@ -1270,7 +1270,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
> +    spapr_dt_xics(spapr_max_server_number(spapr), fdt, PHANDLE_XICP);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> @@ -2469,7 +2469,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>      if (smc->pre_2_10_has_unused_icps) {
>          int i;
> =20
> -        for (i =3D 0; i < xics_max_server_number(spapr); i++) {
> +        for (i =3D 0; i < spapr_max_server_number(spapr); i++) {
>              /* Dummy entries get deregistered when real ICPState objects
>               * are registered during CPU core hotplug.
>               */
> @@ -2589,7 +2589,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> =20
>      /* VSMT must be set in order to be able to compute VCPU ids, ie to
> -     * call xics_max_server_number() or spapr_vcpu_id().
> +     * call spapr_max_server_number() or spapr_vcpu_id().
>       */
>      spapr_set_vsmt_mode(spapr, &error_fatal);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJ8g4ACgkQbDjKyiDZ
s5JOOQ//QXUuxVpKGrHIJpi3/NReP3J/QhJhcu5AhIbs5dDX54/WXZmdTx3l7GwS
sDDsALmorG3hXU9MaR+Fj6PtoLue/RkIagLhMWfR2/YQzcJCJdCAFY8OsMow6wgy
OMkVJa2aLFOazaYhvvaRmaAPKeqWQNS7gPw8E4/bkzVSkf01+xlHr+8jybj2L5o8
wrk30FfxtNf6mexboCX8gIvRkJ90pcuVc5+FjkU1JI7eFPJu5a1tEDwNwwpWU8dS
1Tzy0ELAJK+qJQ0x08s+gZlTTKyTiuj36Ccef6BJhwGtBvcyhfeaFwu51FAAHOXX
SnS1DojYKTJwO6BIGPpEgxG3FWSCzutSem/I57/WPmGNgUG7UbfiAtAW7TlJLJVi
4t7e5QFzGz1kks7tZ/kqo2GZXyZO0J2dDVrTY69yfgpokL/TMkPknADZlr86bULg
oX8lH5k6wi+KLM0njsy6L/aDnvU+dZUYAtbprgj0zW6hEXqQwh3G8p7rlnYfGkXd
Ia/lgM5ZPqxcJX3JvJaJcjCfEwnIj1zVB0cV7/Rc/GEVRXnxCFJP3YiUabUQkuC1
pQRKdz67ZKqyHrMeB8WyvQC/9dt19qCqRUjlfF2LDU4DZ7WD8Mlphye4mWOIjdgH
WtV+Lnv72nyZIN2y3XvNU1wQXPm/rb0QO4KLMZWngDro3difIng=
=oyEM
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
