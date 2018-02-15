Received: from eggs.gnu.org ([2001:4830:134:3::10]:59358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAiR-0001Hg-2N
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAiN-0004Aj-1A
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:00:11 -0500
Date: Thu, 15 Feb 2018 14:42:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180215034257.GE5247@umbus.fritz.box>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
	<151863722617.3003.10199760495589842414.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <151863722617.3003.10199760495589842414.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/5] spapr: use spapr->vsmt to compute VCPU
 ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, Laurent Vivier <lvivier@redhat.com>


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 08:40:26PM +0100, Greg Kurz wrote:
> Since the introduction of VSMT in 2.11, the spacing of VCPU ids
> between cores is controllable through a machine property instead
> of being only dictated by the SMT mode of the host:
>=20
>     cpu->vcpu_id =3D (cc->core_id * spapr->vsmt / smp_threads) + i
>=20
> Until recently, the machine code would try to change the SMT mode
> of the host to be equal to VSMT or exit. This allowed the rest of
> the code to assume that kvmppc_smt_threads() =3D=3D spapr->vsmt is
> always true.
>=20
> Recent commit "8904e5a75005 spapr: Adjust default VSMT value for
> better migration compatibility" relaxed the rule. If the VSMT
> mode cannot be set in KVM for some reasons, but the requested
> CPU topology is compatible with the current SMT mode, then we
> let the guest run with  kvmppc_smt_threads() !=3D spapr->vsmt.
>=20
> This breaks quite a few places in the code, in particular when
> calculating DRC indexes.
>=20
> This is what happens on a POWER host with subcores-per-core=3D2 (ie,
> supports up to SMT4) when passing the following topology:
>=20
>     -smp threads=3D4,maxcpus=3D16 \
>     -device host-spapr-cpu-core,core-id=3D4,id=3Dcore1 \
>     -device host-spapr-cpu-core,core-id=3D8,id=3Dcore2
>=20
> qemu-system-ppc64: warning: Failed to set KVM's VSMT mode to 8 (errno -22)
>=20
> This is expected since KVM is limited to SMT4, but the guest is started
> anyway because this topology can run on SMT4 even with a VSMT8 spacing.
>=20
> But when we look at the DT, things get nastier:
>=20
> cpus {
>         ...
>         ibm,drc-indexes =3D <0x4 0x10000000 0x10000004 0x10000008 0x10000=
00c>;
>=20
> This means that we have the following association:
>=20
>  CPU core device |     DRC    | VCPU id
> -----------------+------------+---------
>    boot core     | 0x10000000 | 0
>    core1         | 0x10000004 | 4
>    core2         | 0x10000008 | 8
>    core3         | 0x1000000c | 12
>=20
> But since the spacing of VCPU ids is 8, the DRC for core1 points to a
> VCPU that doesn't exist, the DRC for core2 points to the first VCPU of
> core1 and and so on...
>=20
>         ...
>=20
>         PowerPC,POWER8@0 {
>                 ...
>                 ibm,my-drc-index =3D <0x10000000>;
>                 ...
>         };
>=20
>         PowerPC,POWER8@8 {
>                 ...
>                 ibm,my-drc-index =3D <0x10000008>;
>                 ...
>         };
>=20
>         PowerPC,POWER8@10 {
>                 ...
>=20
> No ibm,my-drc-index property for this core since 0x10000010 doesn't
> exist in ibm,drc-indexes above.
>=20
>                 ...
>         };
> };
>=20
> ...
>=20
> interrupt-controller {
>         ...
>         ibm,interrupt-server-ranges =3D <0x0 0x10>;
>=20
> With a spacing of 8, the highest VCPU id for the given topology should be:
>         16 * 8 / 4 =3D 32 and not 16
>=20
>         ...
>         linux,phandle =3D <0x7e7323b8>;
>         interrupt-controller;
> };
>=20
> And CPU hot-plug/unplug is broken:
>=20
> (qemu) device_del core1
> pseries-hotplug-cpu: Cannot find CPU (drc index 10000004) to remove
>=20
> (qemu) device_del core2
> cpu 4 (hwid 8) Ready to die...
> cpu 5 (hwid 9) Ready to die...
> cpu 6 (hwid 10) Ready to die...
> cpu 7 (hwid 11) Ready to die...
>=20
> These are the VCPU ids of core1 actually
>=20
> (qemu) device_add host-spapr-cpu-core,core-id=3D12,id=3Dcore3
> (qemu) device_del core3
> pseries-hotplug-cpu: Cannot find CPU (drc index 1000000c) to remove
>=20
> This patches all the code in hw/ppc/spapr.c to assume the VSMT
> spacing when manipulating VCPU ids.
>=20
> Fixes: 8904e5a75005
> Signed-off-by: Greg Kurz <groug@kaod.org>

Ouch, good catch.  That's a lot of nasty bugs I hadn't realised were
there.  Applied, thanks.

> ---
>  hw/ppc/spapr.c |   24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)



>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9f29434819bd..ea7429c92a97 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -160,9 +160,9 @@ static void pre_2_10_vmstate_unregister_dummy_icp(int=
 i)
>                         (void *)(uintptr_t) i);
>  }
> =20
> -static inline int xics_max_server_number(void)
> +static int xics_max_server_number(sPAPRMachineState *spapr)
>  {
> -    return DIV_ROUND_UP(max_cpus * kvmppc_smt_threads(), smp_threads);
> +    return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
>  }
> =20
>  static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
> @@ -194,7 +194,7 @@ static void xics_system_init(MachineState *machine, i=
nt nr_irqs, Error **errp)
>      if (smc->pre_2_10_has_unused_icps) {
>          int i;
> =20
> -        for (i =3D 0; i < xics_max_server_number(); i++) {
> +        for (i =3D 0; i < xics_max_server_number(spapr); i++) {
>              /* Dummy entries get deregistered when real ICPState objects
>               * are registered during CPU core hotplug.
>               */
> @@ -337,7 +337,6 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
>      int ret =3D 0, offset, cpus_offset;
>      CPUState *cs;
>      char cpu_model[32];
> -    int smt =3D kvmppc_smt_threads();
>      uint32_t pft_size_prop[] =3D {0, cpu_to_be32(spapr->htab_shift)};
> =20
>      CPU_FOREACH(cs) {
> @@ -346,7 +345,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
>          int index =3D spapr_vcpu_id(cpu);
>          int compat_smt =3D MIN(smp_threads, ppc_compat_max_vthreads(cpu)=
);
> =20
> -        if ((index % smt) !=3D 0) {
> +        if (index % spapr->vsmt !=3D 0) {
>              continue;
>          }
> =20
> @@ -614,7 +613,6 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
>      CPUState *cs;
>      int cpus_offset;
>      char *nodename;
> -    int smt =3D kvmppc_smt_threads();
> =20
>      cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
>      _FDT(cpus_offset);
> @@ -632,7 +630,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>          int offset;
> =20
> -        if ((index % smt) !=3D 0) {
> +        if (index % spapr->vsmt !=3D 0) {
>              continue;
>          }
> =20
> @@ -1131,7 +1129,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
> +    spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> @@ -2224,7 +2222,6 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>      MachineState *machine =3D MACHINE(spapr);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      const char *type =3D spapr_get_cpu_core_type(machine->cpu_type);
> -    int smt =3D kvmppc_smt_threads();
>      const CPUArchIdList *possible_cpus;
>      int boot_cores_nr =3D smp_cpus / smp_threads;
>      int i;
> @@ -2254,7 +2251,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
> =20
>          if (mc->has_hotpluggable_cpus) {
>              spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
> -                                   (core_id / smp_threads) * smt);
> +                                   (core_id / smp_threads) * spapr->vsmt=
);
>          }
> =20
>          if (i < boot_cores_nr) {
> @@ -3281,10 +3278,10 @@ static
>  void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState =
*dev,
>                                 Error **errp)
>  {
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
>      int index;
>      sPAPRDRConnector *drc;
>      CPUCore *cc =3D CPU_CORE(dev);
> -    int smt =3D kvmppc_smt_threads();
> =20
>      if (!spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index))=
 {
>          error_setg(errp, "Unable to find CPU core with core-id: %d",
> @@ -3296,7 +3293,7 @@ void spapr_core_unplug_request(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * spapr->vsmt);
>      g_assert(drc);
> =20
>      spapr_drc_detach(drc);
> @@ -3315,7 +3312,6 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>      CPUState *cs =3D CPU(core->threads[0]);
>      sPAPRDRConnector *drc;
>      Error *local_err =3D NULL;
> -    int smt =3D kvmppc_smt_threads();
>      CPUArchId *core_slot;
>      int index;
>      bool hotplugged =3D spapr_drc_hotplugged(dev);
> @@ -3326,7 +3322,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>                     cc->core_id);
>          return;
>      }
> -    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * spapr->vsmt);
> =20
>      g_assert(drc || !mc->has_hotpluggable_cpus);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqFAcEACgkQbDjKyiDZ
s5L0oxAAh79om3fZwZlbGfklh1lS+i2xXTZlIbgBQ+1vE+J8HWRDm0U/lLj+BdUX
c/q8ypn393YSms6WpsTb78aIxWoaMJZR20y50H2pNMZU72KvvJ58Kq0cNUFs6EEg
RusXrZpb5CK0BMt6Ofzvate5i9iETOLIVO5mNvnN781TzhlFunx8h2u38EKAObo6
Apt1/xPc7VfBnry5tyKkZ76VBrWlG3EL4Y4oyq+3scWeYcOUG7As1RoIRZyW7agC
dLVPE/UhemRwkVQoB+kLooW+2tBKn3vnu/xaD0SfRZwMX0gHQbPSFjUFvYgRLY+K
8rU6qA9AT5/O326pnGgM4cQeOqGhMn8wNcqNiwO78B6TlerA7AIKig8zsac0qG96
82zxoAfOmuRpPtbAzuEsFDpvjQQUuRuwCcOnnP/B6a/Kmq17vVSg6g3IUYVy20LM
yFPssU3tf7Aw21ccoVorNHATuqstC0Lxt0LTUD9bkElNiaWQNRI3twkZh+ewSGyu
hj/8N6135P+KiRjdeLNt6MtpFgxk/xV4ekUeH3Y05NXCIY0HCniuRX8rE9nygSHE
cfbNA0kZOXFrLgFlmHyWTboWWxJ08x/XF5CgF3YRuxwxSVxy3lnwIDgrMF8ocLtf
VI1KVcmjh4BgJyauH5ox9Qlc21XkBhN/BrdkTKwtL7zkMz2CqX4=
=4lLu
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
