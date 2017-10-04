Received: from eggs.gnu.org ([2001:4830:134:3::10]:57462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzYf3-000728-6y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzYf0-0007BE-4w
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:39:45 -0400
Date: Wed, 4 Oct 2017 12:39:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004013931.GS3260@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659511184.25889.10868411111377268218.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1Sa0i77dkqaUxqYg"
Content-Disposition: inline
In-Reply-To: <150659511184.25889.10868411111377268218.stgit@aravinda>
Subject: Re: [Qemu-devel] [PATCH v5 6/6] migration: Block migration while
 handling machine check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--1Sa0i77dkqaUxqYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 04:08:31PM +0530, Aravinda Prasad wrote:
> Block VM migration requests until the machine check
> error handling is complete as (i) these errors are
> specific to the source hardware and is irrelevant on
> the target hardware, (ii) these errors cause data
> corruption and should be handled before migration.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_rtas.c    |    3 +++
>  include/hw/ppc/spapr.h |    2 ++
>  target/ppc/kvm.c       |   17 +++++++++++++++++
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d017a67..17f6567 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -47,6 +47,7 @@
>  #include "trace.h"
>  #include "hw/ppc/fdt.h"
>  #include "kvm_ppc.h"
> +#include "migration/blocker.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
> @@ -390,6 +391,8 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>          spapr->mc_status =3D -1;
>          qemu_cond_signal(&spapr->mc_delivery_cond);
>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +        migrate_del_blocker(spapr->migration_blocker);
> +        error_free(spapr->migration_blocker);
>      }
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a75e9cf..0890a44 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -7,6 +7,7 @@
>  #include "hw/ppc/spapr_drc.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/ppc/spapr_ovec.h"
> +#include "qapi/error.h"
> =20
>  struct VIOsPAPRBus;
>  struct sPAPRPHBState;
> @@ -136,6 +137,7 @@ struct sPAPRMachineState {
>      MemoryHotplugState hotplug_memory;
> =20
>      const char *icp_type;
> +    Error *migration_blocker;

This isn't a good name, because it's _specifically_ the fwnmi as a
migration blocker - trying to put another migration blocker in here
would break horribly, because nmi-interlock would clear it regardless.

>  };
> =20
>  #define H_SUCCESS         0
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 59b3322..58de7ea 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -52,6 +52,7 @@
>  #endif
>  #include "elf.h"
>  #include "sysemu/kvm_int.h"
> +#include "migration/blocker.h"
> =20
>  //#define DEBUG_KVM
> =20
> @@ -2770,10 +2771,26 @@ int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_ru=
n *run)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      target_ulong msr =3D 0;
> +    Error *local_err =3D NULL;
> +    int ret;
>      bool type, le;
> =20
>      cpu_synchronize_state(CPU(cpu));
> =20
> +    error_setg(&spapr->migration_blocker,
> +            "Live migration not supported during machine check error han=
dling");

In fact, there's no real reason to generate the error here.  The
error's always the same so you could just create it at startup as a
global and just add/remove it to the block list.

> +    ret =3D migrate_add_blocker(spapr->migration_blocker, &local_err);
> +    if (ret < 0) {
> +        /*
> +         * We don't want to abort and let the migration to continue. In a
> +         * rare case, the machine check handler will run on the target
> +         * hardware. Though this is not preferable, it is better than ab=
orting

Why is it not preferable?  I mean it's an edge case, but AFAICT it's
still the correct behaviour.

> +         * the migration or killing the VM.
> +         */
> +        error_free(spapr->migration_blocker);
> +        fprintf(stderr, "Warning: Machine check during VM migration\n");

Use error_report(), not fprintf().

> +    }
> +
>      /*
>       * Properly set bits in MSR before we invoke the handler.
>       * SRR0/1, DAR and DSISR are properly set by KVM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1Sa0i77dkqaUxqYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUO9MACgkQbDjKyiDZ
s5I8Hw/8CYj2aTnY3MNv8gAcwYSCuKC/lIONFhc6o19l8lESAaM25w13wYhIDKjx
z0f4hBXapLfhszTbLtRsyeyZLkQNlu9eyEuNr3nei66Uc/ChnkQzCYWXlSa5t83Y
DxH/QiTWsrRHqQREC/4RPapplbBcF4tCdGLOQdO/lneHgKiGdHu4iLxYxbvfakfV
DIz1cF09MQOei0lwGcdABWS0hHPd3Y1P6MNu82nydkgxMzJOf3T3x6yLIb7BiNLB
wmrDX6Vjmc6Vkbk5e8Ooy7YGJqyxlHppvEOmw4ojt4myUmJyvq6Bpp+CZ+MruW7K
HYbunwQC5qmZrJXC/3ocU2Bj0thFEc4Eu9NH5jwRfyDzCV6LmgycAZfWfwO2zpCI
k/ZgyDfZxBLriHOvk10/rrSd1pLjTDb0hhZX4MRD1+u/bXsYMt+FtblmKyIMDfEw
5oTCdGo2p2NlQMLIcTJLDJkdp3nCfzTBSTu+Q/nr6xmUnMLuJ/wm1hksfRKcWNXP
GgNnywQr0cZN0sPm9ln8J7un7VA9XubdY4aSsK4HrkwU9fEuoPd77A7utsLgh5Yz
gr7UZgRckP9hsB2Zz1CEQntYzx9gEvwNd3Lfl5HRNqedaZlxq1KH/4AAJi0B5AG3
oj7rPBfWwXdPSyVzK1HqdvA8kL1T7W8c8TRh/DWj6N+Bk+C4RdA=
=8r3C
-----END PGP SIGNATURE-----

--1Sa0i77dkqaUxqYg--
