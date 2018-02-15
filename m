Received: from eggs.gnu.org ([2001:4830:134:3::10]:59336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAiO-0001GG-Aj
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAiM-0004AU-Sy
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:00:08 -0500
Date: Thu, 15 Feb 2018 14:50:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180215035007.GF5247@umbus.fritz.box>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
	<151863724465.3003.14485203815672867421.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <151863724465.3003.14485203815672867421.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/5] spapr: rename spapr_vcpu_id() to
 spapr_get_vcpu_id()
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


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 08:40:44PM +0100, Greg Kurz wrote:
> The spapr_vcpu_id() function is an accessor actually. Let's rename it
> for symmetry with the recently added spapr_set_vcpu_id() helper.
>=20
> The motivation behind this is that a later patch will consolidate
> the VCPU id formula in a function and spapr_vcpu_id looks like an
> appropriate name.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

There's some minor details I'm not sure I like about this patch and
the previous one, but nothing important enough to delay the later
parts of the series.  So, applied.

> ---
>  hw/ppc/spapr.c         |   16 ++++++++--------
>  include/hw/ppc/spapr.h |    2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 30cc48fd5264..18ebc058acdd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -209,7 +209,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offs=
et, PowerPCCPU *cpu,
>      int i, ret =3D 0;
>      uint32_t servers_prop[smt_threads];
>      uint32_t gservers_prop[smt_threads * 2];
> -    int index =3D spapr_vcpu_id(cpu);
> +    int index =3D spapr_get_vcpu_id(cpu);
> =20
>      if (cpu->compat_pvr) {
>          ret =3D fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat=
_pvr);
> @@ -238,7 +238,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offs=
et, PowerPCCPU *cpu,
> =20
>  static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cp=
u)
>  {
> -    int index =3D spapr_vcpu_id(cpu);
> +    int index =3D spapr_get_vcpu_id(cpu);
>      uint32_t associativity[] =3D {cpu_to_be32(0x5),
>                                  cpu_to_be32(0x0),
>                                  cpu_to_be32(0x0),
> @@ -342,7 +342,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> -        int index =3D spapr_vcpu_id(cpu);
> +        int index =3D spapr_get_vcpu_id(cpu);
>          int compat_smt =3D MIN(smp_threads, ppc_compat_max_vthreads(cpu)=
);
> =20
>          if (index % spapr->vsmt !=3D 0) {
> @@ -492,7 +492,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
> -    int index =3D spapr_vcpu_id(cpu);
> +    int index =3D spapr_get_vcpu_id(cpu);
>      uint32_t segs[] =3D {cpu_to_be32(28), cpu_to_be32(40),
>                         0xffffffff, 0xffffffff};
>      uint32_t tbfreq =3D kvm_enabled() ? kvmppc_get_tbfreq()
> @@ -626,7 +626,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
>       */
>      CPU_FOREACH_REVERSE(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        int index =3D spapr_vcpu_id(cpu);
> +        int index =3D spapr_get_vcpu_id(cpu);
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>          int offset;
> =20
> @@ -3234,7 +3234,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState=
 *cs, int *fdt_offset,
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> -    int id =3D spapr_vcpu_id(cpu);
> +    int id =3D spapr_get_vcpu_id(cpu);
>      void *fdt;
>      int offset, fdt_size;
>      char *nodename;
> @@ -3791,7 +3791,7 @@ static void spapr_pic_print_info(InterruptStatsProv=
ider *obj,
>      ics_pic_print_info(spapr->ics, mon);
>  }
> =20
> -int spapr_vcpu_id(PowerPCCPU *cpu)
> +int spapr_get_vcpu_id(PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> =20
> @@ -3828,7 +3828,7 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -        if (spapr_vcpu_id(cpu) =3D=3D vcpu_id) {
> +        if (spapr_get_vcpu_id(cpu) =3D=3D vcpu_id) {
>              return cpu;
>          }
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index af19320d2f8a..36942b378daa 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -766,7 +766,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_o=
n_cpu_data arg);
> =20
>  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> =20
> -int spapr_vcpu_id(PowerPCCPU *cpu);
> +int spapr_get_vcpu_id(PowerPCCPU *cpu);
>  void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqFA28ACgkQbDjKyiDZ
s5J5dhAAjEgRQoMM/UK7kPDB23+3fUchyQL6tkH4F/iWu5UNI5miqIZ3SLBCXeVk
Qsu//uVmAIDqQDDNS8FQJTuqaA9Ms7MMC3JoT53BvPFkfbkalNmbk+mtMvSgHj+h
wytJKgVU9eFRa/kLT+9D+UySwRmKsIvlvFVRnVc4zB8vTwJFTBrTubKR6y7QyM/W
aFlE8B9nXyd3g9bIRtKBZsYKa21rms1MKCpj58HeUvJaP2yTAy2/fCmb3jl5nWlr
fYP3O5stlwF7Z7yTZGJK/y2uvUTTO9sY/1BzmD9f1S+QS47Kqsl1m22XhkvsF0BD
bvJxhqwWmh0kTH2Gc/wxC9opHFGQeVHQdKiXOlVb6feD8PR5viQJTJr4syJnaIBf
fl9j+kjTvRm41kP+Y2/MU8xDr/xn+hNpDeS5Orz3P9hXVB8JsfQSU7v5o+Fl4s2B
Hcz2Y9mWr262IuAV6JVihO/P6WiGw1gKtvqDnKB50Guq/pnkUgzu6/jDVWM5k4HM
hGudCP1mf48PLxUZPK1dcCzIi7IA3waw2VSArXjf7jZuZtg+cxG/aAvAp5bj/du6
4qiiemQyp1hBycrnwRd3wTKtPKZY4eIVf1tzcAYWsxFLTFv+00eKTlDhoh2K6jqp
IOyNInbFs58jqKoq7tQOdi6iWMSAlq4sp3dvb6AdxiQwjqWH/XE=
=x9+W
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
