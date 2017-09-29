Received: from eggs.gnu.org ([2001:4830:134:3::10]:56750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxoog-0002S1-1t
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 02:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxoob-0002F8-R1
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 02:30:30 -0400
Date: Fri, 29 Sep 2017 16:17:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170929061735.GD7712@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659505839.25889.2018054058894535368.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <150659505839.25889.2018054058894535368.stgit@aravinda>
Subject: Re: [Qemu-devel] [PATCH v5 1/6] ppc: spapr: Register and handle
 HCALL to receive updated RTAS region
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com
List-ID: <qemu-devel.nongnu.org>


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 04:07:38PM +0530, Aravinda Prasad wrote:
> Receive updates from SLOF about the updated rtas-base.
> A separate patch for SLOF [1] (commit f9a60de3) adds
> functionality to invoke a private HCALL whenever OS
> issues instantiate-rtas with a new rtas-base.
>=20
> This is required as QEMU needs to know the updated rtas-base
> as it allocates error reporting structure in RTAS space upon
> a machine check exception.
>=20
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120386.ht=
ml
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Ao I acked this earlier, but I've now realized there might be some
connection between this and discussions taking place elsewhere about
qemu not knowing what SLOF does with the device tree.

At what point will SLOF call the UPDATE_RTAS hcall?  I'm guessing at
the time of instantiate-rtas, is that right?

Does SLOF put the RTAS blob address in its internal device tree, or
does it only pass it to the guest via the return parameters from
instantiate-rtas?

> ---
>  hw/ppc/spapr.c         |   11 +++++++++++
>  hw/ppc/spapr_hcall.c   |    8 ++++++++
>  include/hw/ppc/spapr.h |    4 +++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ff87f15..5deae30 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1675,6 +1675,16 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
>      },
>  };
> =20
> +static const VMStateDescription vmstate_spapr_rtas_addr =3D {
> +    .name =3D "spapr_rtas_addr",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(rtas_addr, sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -1694,6 +1704,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
>          &vmstate_spapr_pending_events,
> +        &vmstate_spapr_rtas_addr,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8d72bb7..c15a93c 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1088,6 +1088,13 @@ static target_ulong h_rtas(PowerPCCPU *cpu, sPAPRM=
achineState *spapr,
>                             nret, rtas_r3 + 12 + 4*nargs);
>  }
> =20
> +static target_ulong h_rtas_update(PowerPCCPU *cpu, sPAPRMachineState *sp=
apr,
> +                                  target_ulong opcode, target_ulong *arg=
s)
> +{
> +    spapr->rtas_addr =3D args[0];
> +    return 0;
> +}
> +
>  static target_ulong h_logical_load(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
>                                     target_ulong opcode, target_ulong *ar=
gs)
>  {
> @@ -1750,6 +1757,7 @@ static void hypercall_register_types(void)
> =20
>      /* qemu/KVM-PPC specific hcalls */
>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> +    spapr_register_hypercall(KVMPPC_H_RTAS_UPDATE, h_rtas_update);
> =20
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c1b365f..b395aa7 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -90,6 +90,7 @@ struct sPAPRMachineState {
> =20
>      hwaddr rma_size;
>      int vrma_adjust;
> +    hwaddr rtas_addr;
>      ssize_t rtas_size;
>      void *rtas_blob;
>      long kernel_size;
> @@ -400,7 +401,8 @@ struct sPAPRMachineState {
>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> +#define KVMPPC_H_RTAS_UPDATE    (KVMPPC_HCALL_BASE + 0x3)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_RTAS_UPDATE
> =20
>  typedef struct sPAPRDeviceTreeUpdateHeader {
>      uint32_t version_id;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnN5XwACgkQbDjKyiDZ
s5L1ThAA21h18IjQXc0SD+Q/UMKgoS2tVd2F4KHwUOUokwoxsdPnEetSnTWvoZz4
uYvV0INcMIQZA/LsnDp+4XAu7R77DfAYujXck53Y/MLSx2zs4UUdwIR7KQbMVMBL
q7LVp6egZ4F/Gva8FWxabuDwojaYhKZJ+GpP8/dLRxUsJvL7OYrIXczUHkB5a455
6GHOph9C7db4IXJsJv1FVXXRaHkaHnCE1zidNQWBfdiawNP03iYv6cKtAK1S3OlJ
RE9W9ABpmkkb+3k4QJD3YBrjOf3sY30SM6VQ7N5Cuq6ZzkG0tK0ubzGADI2dob0t
xfaQPm2IaS0y3uVOxMgrj2QvProMK0QTSsQoNZYV098ob/UsaYbx84TQgeFQntmE
p/KAD9MezsjRpjbasDgzK9NIXf+fSyLvfDob2xhQCNbUJcaTyHtxCsJ5Taf6d+nn
zoWSFql5X5zmKTls+SjAIwGgO+vbkaUo2ZPMY0jFgbN6vAqGIVpzNEVsr8EJco/L
V9yTUROcT6ki4EWcfdKbuScKXbNLDKo+BuEBAWui7944jpkP9hgWRaefXbr3SERB
0L5Dy2o/wHajHvjImz/dse9tZThsGWsZsEWT9Mw9kJJm/tN1dw+lziibXbc7dA+j
38D7/2O7umX+/6i5WMOhUAJeyLoH7/OGVB/3QX2mgv9DnP9iK9Y=
=sxXN
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
