Received: from eggs.gnu.org ([2001:4830:134:3::10]:60236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4G7-0004TX-KJ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4G4-0000Fw-E1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:12:31 -0400
Date: Tue, 19 Jun 2018 10:09:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619000905.GE25461@umbus.fritz.box>
References: <152932479544.500483.1342368406182952616.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ggCU0ZO/FnK1VHVi"
Content-Disposition: inline
In-Reply-To: <152932479544.500483.1342368406182952616.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr_cpu_core: migrate per-CPU data
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


--ggCU0ZO/FnK1VHVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 02:26:35PM +0200, Greg Kurz wrote:
> A per-CPU machine data pointer was recently added to PowerPCCPU. The
> motivation is to to hide platform specific details from the core CPU
> code. This per-CPU data can hold state which is revelant to the guest
> though, eg, Virtual Processor Areas, and we whould migrate this state.
>=20
> This patch adds the plumbing so that we can migrate the per-CPU data
> for PAPR guests. We only do this for newer machine types for the sake
> of backword compatibility. No state is migrated for the moment: the
> vmstate_spapr_cpu_state structure will be populated by subsequent
> patches.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, though I fixed some spelling and spacing errors along the way.

> ---
>  hw/ppc/spapr.c                  |    5 +++++
>  hw/ppc/spapr_cpu_core.c         |   27 +++++++++++++++++++++++----
>  include/hw/ppc/spapr_cpu_core.h |    1 +
>  3 files changed, 29 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index db0fb385d4e0..37db3e8bc6ca 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4116,6 +4116,11 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
>      {                                                                  \
>          .driver =3D TYPE_POWERPC_CPU,                                   =
 \
>          .property =3D "pre-3.0-migration",                              \
> +        .value    =3D "on",                                             =
 \
> +            },                                                         \
> +    {                                                                  \
> +        .driver =3D TYPE_SPAPR_CPU_CORE,                                =
 \
> +        .property =3D "pre-3.0-migration",                              =
 \
>          .value    =3D "on",                                             =
 \
>      },
> =20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index aef3be33a3bb..96d1dfad00e1 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -129,6 +129,15 @@ static void spapr_cpu_core_unrealize(DeviceState *de=
v, Error **errp)
>      g_free(sc->threads);
>  }
> =20
> +static const VMStateDescription vmstate_spapr_cpu_state =3D {
> +    .name =3D "spapr_cpu",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                                 Error **errp)
>  {
> @@ -164,7 +173,8 @@ error:
>      error_propagate(errp, local_err);
>  }
> =20
> -static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **er=
rp)
> +static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i,
> +                                     sPAPRMachineState *spapr, Error **e=
rrp)
>  {
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
>      CPUCore *cc =3D CPU_CORE(sc);
> @@ -194,6 +204,10 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *s=
c, int i, Error **errp)
>      }
> =20
>      cpu->machine_data =3D g_new0(sPAPRCPUState, 1);
> +    if (!sc->pre_3_0_migration) {
> +        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
> +                         cpu->machine_data);
> +    }
> =20
>      object_unref(obj);
>      return cpu;
> @@ -204,10 +218,13 @@ err:
>      return NULL;
>  }
> =20
> -static void spapr_delete_vcpu(PowerPCCPU *cpu)
> +static void spapr_delete_vcpu(PowerPCCPU *cpu, sPAPRCPUCore *sc)
>  {
>      sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> =20
> +    if (!sc->pre_3_0_migration) {
> +        vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_=
data);
> +    }
>      cpu->machine_data =3D NULL;
>      g_free(spapr_cpu);
>      object_unparent(OBJECT(cpu));
> @@ -233,7 +250,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
> =20
>      sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        sc->threads[i] =3D spapr_create_vcpu(sc, i, &local_err);
> +        sc->threads[i] =3D spapr_create_vcpu(sc, i, spapr, &local_err);
>          if (local_err) {
>              goto err;
>          }
> @@ -253,7 +270,7 @@ err_unrealize:
>      }
>  err:
>      while (--i >=3D 0) {
> -        spapr_delete_vcpu(sc->threads[i]);
> +        spapr_delete_vcpu(sc->threads[i], sc);
>      }
>      g_free(sc->threads);
>      error_propagate(errp, local_err);
> @@ -261,6 +278,8 @@ err:
> =20
>  static Property spapr_cpu_core_properties[] =3D {
>      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_N=
ODE_ID),
> +    DEFINE_PROP_BOOL("pre-3.0-migration", sPAPRCPUCore, pre_3_0_migratio=
n,
> +                     false),
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 8ceea2973a93..9e2821e4b31f 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -31,6 +31,7 @@ typedef struct sPAPRCPUCore {
>      /*< public >*/
>      PowerPCCPU **threads;
>      int node_id;
> +    bool pre_3_0_migration; /* older machine don't know about sPAPRCPUSt=
ate */
>  } sPAPRCPUCore;
> =20
>  typedef struct sPAPRCPUCoreClass {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ggCU0ZO/FnK1VHVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoSZ8ACgkQbDjKyiDZ
s5KNzhAAr0PuRBezjEKUZFcaSk/tGEMzKaACQEB9oC115fY7gteJednfhlrKQTQn
+anZs4ef2oy52gkGnZnBQR9rYodPF7/UiONRyH3uH/53/CqxPxvXDMtrPIc9Dfb2
TcpaoHf/i1ZqrGrlElhHhkhhgbhVg3AuZEKzpV6a2rQf5HJswkF8jSJ7ng9qRfIR
7x3Wo9gCAxcLqrI+vVGnUNx5o0ta9GNYfwnplOXjlweR9RTQEI+mQBMlm3dXDvQ9
sW6R3isW1LcOi1Z/XjAZ7/7oluCwZ5T9xa9J2SGXIgqbhETWuXws3MafP+M/UPe+
s6LtNmVmvMdpQkNBJTToiKHYxQAv09S+6JuCqAET2VPsPT6YpFK2mOw3RS9Rf8SJ
7U/seD9mJLQy27LxgsaAPwriE6E41fxyQZtaT8z6arDJNHCy2FkGLrlhQoihDKeP
o+Ideb0lZHuD8WbhUVt5xkQcb4wgEb3Dnv73BUvkIN4r3zoQ8FK2C2r0encWwdaZ
jXJbEldlsgywhTgaBfFx1Q5KRzX/iFNMjDUEL8QFy8cBW18lliqujGGGnQEfVz29
8ifS0S+396uLWZ9fN4MzJ5PNr9DIckTYkiZ1I/07iLBu50I8BaElWhtZ4TgL/ztJ
UhCkR/pScXuLrxVwgEy/0gXA9r1whlDPDGomZTAGkHwSqzeGuBQ=
=bNej
-----END PGP SIGNATURE-----

--ggCU0ZO/FnK1VHVi--
