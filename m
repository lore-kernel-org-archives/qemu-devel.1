Received: from eggs.gnu.org ([2001:4830:134:3::10]:60396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAqS-0006VF-KY
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAqR-0001Fx-Az
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:08:28 -0500
Date: Thu, 15 Feb 2018 15:05:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180215040551.GG5247@umbus.fritz.box>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
	<151863725388.3003.620735626834741475.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
In-Reply-To: <151863725388.3003.620735626834741475.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 4/5] spapr: consolidate the VCPU id
 numbering logic in a single place
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


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 08:40:53PM +0100, Greg Kurz wrote:
> Several places in the code need to calculate a VCPU id:
>=20
>     (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads
>     (core_id / smp_threads) * spapr->vsmt (1 user)
>     index * spapr->vsmt (2 users)
>=20
> or guess that the VCPU id of a given VCPU is the first thread of a virtual
> core:
>=20
>     index % spapr->vsmt !=3D 0
>=20
> Even if the numbering logic isn't that complex, it is rather fragile to
> have these assumptions open-coded in several places. FWIW this was
> proved with recent issues related to VSMT.
>=20
> This patch moves the VCPU id formula to a single function to be called
> everywhere the code needs to compute one. It also adds an helper to
> guess if a VCPU is the first thread of a VCORE.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Good change.  I don't like the name 'spapr_is_vcore' though - cores
are a logically different thing from thread0 of the core.  So I've
renamed it to spapr_is_thread0_of_vcore() as I've applied it.

> ---
>  hw/ppc/spapr.c |   29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 18ebc058acdd..800d3f001253 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -99,6 +99,20 @@
> =20
>  #define PHANDLE_XICP            0x00001111
> =20
> +/* These two functions implement the VCPU id numbering: one to compute t=
hem
> + * all and one to identify thread 0 of a VCORE. Any change to the first =
one
> + * is likely to have an impact on the second one, so let's keep them clo=
se.
> + */
> +static int spapr_vcpu_id(sPAPRMachineState *spapr, int cpu_index)
> +{
> +    return
> +        (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_thread=
s;
> +}
> +static bool spapr_is_vcore(sPAPRMachineState *spapr, PowerPCCPU *cpu)
> +{
> +    return spapr_get_vcpu_id(cpu) % spapr->vsmt =3D=3D 0;
> +}
> +
>  static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
>                                    const char *type_ics,
>                                    int nr_irqs, Error **errp)
> @@ -345,7 +359,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
>          int index =3D spapr_get_vcpu_id(cpu);
>          int compat_smt =3D MIN(smp_threads, ppc_compat_max_vthreads(cpu)=
);
> =20
> -        if (index % spapr->vsmt !=3D 0) {
> +        if (!spapr_is_vcore(spapr, cpu)) {
>              continue;
>          }
> =20
> @@ -630,7 +644,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>          int offset;
> =20
> -        if (index % spapr->vsmt !=3D 0) {
> +        if (!spapr_is_vcore(spapr, cpu)) {
>              continue;
>          }
> =20
> @@ -2251,7 +2265,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
> =20
>          if (mc->has_hotpluggable_cpus) {
>              spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
> -                                   (core_id / smp_threads) * spapr->vsmt=
);
> +                                   spapr_vcpu_id(spapr, core_id));
>          }
> =20
>          if (i < boot_cores_nr) {
> @@ -3293,7 +3307,8 @@ void spapr_core_unplug_request(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * spapr->vsmt);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
> +                          spapr_vcpu_id(spapr, cc->core_id));
>      g_assert(drc);
> =20
>      spapr_drc_detach(drc);
> @@ -3322,7 +3337,8 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>                     cc->core_id);
>          return;
>      }
> -    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * spapr->vsmt);
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
> +                          spapr_vcpu_id(spapr, cc->core_id));
> =20
>      g_assert(drc || !mc->has_hotpluggable_cpus);
> =20
> @@ -3807,8 +3823,7 @@ void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_ind=
ex, Error **errp)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      int vcpu_id;
> =20
> -    vcpu_id =3D
> -        (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_thread=
s;
> +    vcpu_id =3D spapr_vcpu_id(spapr, cpu_index);
> =20
>      if (kvm_enabled() && !kvm_vcpu_id_is_valid(vcpu_id)) {
>          error_setg(errp, "Can't create CPU with id %d in KVM", vcpu_id);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqFBxwACgkQbDjKyiDZ
s5Iq3w//ZYJJrBpEpwOo0cFSMErGGQxRYBYrVFvBYYrBYpxuTX3rdk88IrPSJGdm
L1UX6aII6+7BZsqwbl5cvMxtfxEAkgkXerZI5p6EbM/TUtEhKsniBxUA4GvvoPhu
SgmS73eszSKPcl4WDgRhM2hkGr6DfOymefsQBg/zQKK3vAWWoQSQs5t8vfBJdhKT
fONQztVAvbpboj/E/y9Uedg80s0rhho2WtXqU+nHXOLTqtSq2FSFLD1jc8nu7K5d
47R0w9k7H37KivXtb38KZCFKoq26CHqlOaqC1fuFDmF9UVM9nu728gxR9K68ZOYT
xCJWTbg+KHpTeWatf9H7EGggQ89OZakPq78Dte5lYRUXGuJ/woxIf0ILNIJi/VOH
ZvIYN4W/LwHJusfq1Zv7huE+bhn7tah7OOAfRG3L+iG5QW09ZBkkAFyvFgwBCkOF
S9JjRig35tGmpYQ+pLJeYUcZUI+hbkHu0PBaXYjht8Q5Ej+Dj9aZ6JRubxgKmipq
dcbnd+UOkaQ2VPxtJZZr4xs3f0Cgy95nwjhv7+ERSHE7EMthEE0hny3OQcukiI0l
L43D4R2t+JhEzccpQdy+mE5H3gt70iQVKlxDq8GekNktWxGQvNV0BOGNCIdLNpfP
+L0aKYgprouT+tQ+1+mPYEHeox3jJnxKSh4Vo9mYQtOs0oTcqB4=
=1S/9
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
