Received: from eggs.gnu.org ([2001:4830:134:3::10]:58780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1di9ht-0004Qj-Mw
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 21:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1di9hs-0001QM-GS
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 21:34:45 -0400
Date: Thu, 17 Aug 2017 11:34:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170817013426.GB5509@umbus.fritz.box>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287473305.9760.9007559736340136424.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <150287473305.9760.9007559736340136424.stgit@aravinda>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] ppc: spapr: Register and handle
 HCALL to receive updated RTAS region
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


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 02:42:13PM +0530, Aravinda Prasad wrote:
> Receive updates from SLOF about the updated rtas-base.
> A separate patch for SLOF [1] adds functionality to invoke
> a private HCALL whenever OS issues instantiate-rtas with
> a new rtas-base.
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

Actually, I take back this R-b, see below.

In any case I'm not willing to apply the patches which depend on this
until the corresponding SLOF update is merged as well.

> ---
>  hw/ppc/spapr_hcall.c   |    8 ++++++++
>  include/hw/ppc/spapr.h |    4 +++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 72ea5a8..e66c72e 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1062,6 +1062,13 @@ static target_ulong h_rtas(PowerPCCPU *cpu, sPAPRM=
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
> @@ -1717,6 +1724,7 @@ static void hypercall_register_types(void)
> =20
>      /* qemu/KVM-PPC specific hcalls */
>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> +    spapr_register_hypercall(KVMPPC_H_RTAS_UPDATE, h_rtas_update);
> =20
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2a303a7..46012b3 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -90,6 +90,7 @@ struct sPAPRMachineState {
> =20
>      hwaddr rma_size;
>      int vrma_adjust;
> +    hwaddr rtas_addr;

This can now change at runtime, which means it needs to be migrated -
that's not happening in your patches yet.

>      ssize_t rtas_size;
>      void *rtas_blob;
>      long kernel_size;
> @@ -399,7 +400,8 @@ struct sPAPRMachineState {
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

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmU8qIACgkQbDjKyiDZ
s5JP0Q//Z80Mwhc2EP9RqOJwRRJRtuy45zJbN42gTjyd/Jsa0KGTQT3i6mGJcLqy
EZtqkcj5y0Ad1aMRVbnJIYATrX3ZjdUhMz+CR9LcAZeb9iJyVqKwG8VKfrg+krci
0HjnW0mTQg5gv2S3sa/Dr6W7CM7184KSCANr3c6BGEheznhmobBfagytRSqcjkAM
F5YqzBLUHXiL0AubrXT4+Dww7/+DLi+jWHZv3GtaBjmoI9XNBvFTAs0KmxotFJ/G
kI5mRugG36yyW3RmA1pCxSDDIz9bRVSJ3+4bsVeHNZXLe/mN6D31bbaqDs959Uis
kdrKYatg1YGwFi9QoRhDRULfVgsRreto0A5jBeZlldyOx6EFOJ5VSGusP1ZiyJjG
rAS1UuZNigm9L1Q3NAPxJFZRUa5OGHMuAp0f4c+s7/YFgyAYsqnV3RrmsmjaqsbC
BD1kXJVeCzOfW2UZDteWYkjzLymNfrO05A4rX42WfCnyrOdf92mnkKWEj4WCUo37
8euDDRlFmBBwdn0jG66vclrmWx/TbPJ7uxrcClglcd4khiayjjUCgiBFCyZLoWyK
mqd6waq+wGSc4HTWhWNiE4fL+i6j4KF+gvZK7rPdGJ3BL/0VRSQ63nxAWOEV+M4X
/OSMkPbprt61Tqbqh4o1YWqrLF7yArUkm9C8wd/zjACfKScM/fE=
=D06Y
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
