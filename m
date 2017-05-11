Received: from eggs.gnu.org ([2001:4830:134:3::10]:57818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8dJA-0004V5-NN
	for qemu-devel@nongnu.org; Wed, 10 May 2017 21:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8dJ7-0004jc-HP
	for qemu-devel@nongnu.org; Wed, 10 May 2017 21:54:24 -0400
Date: Thu, 11 May 2017 10:14:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170511001458.GC14408@umbus.fritz.box>
References: <1494234377-1773-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494234377-1773-2-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <1494234377-1773-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] spapr: Make
 h_register_process_table hcall flags global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 02:36:16PM +0530, Bharata B Rao wrote:
> The flags used in h_register_process_table hcall are needed in spapr.c
> and hence move them to a header file. While doing so, give them
> slightly specific names.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_hcall.c   | 31 ++++++++++++++-----------------
>  include/hw/ppc/spapr.h | 10 ++++++++++
>  2 files changed, 24 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 0d608d6..3600b0e 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -924,13 +924,6 @@ static void spapr_check_setup_free_hpt(sPAPRMachineS=
tate *spapr,
>      return;
>  }
> =20
> -#define FLAGS_MASK              0x01FULL
> -#define FLAG_MODIFY             0x10
> -#define FLAG_REGISTER           0x08
> -#define FLAG_RADIX              0x04
> -#define FLAG_HASH_PROC_TBL      0x02
> -#define FLAG_GTSE               0x01
> -
>  static target_ulong h_register_process_table(PowerPCCPU *cpu,
>                                               sPAPRMachineState *spapr,
>                                               target_ulong opcode,
> @@ -943,12 +936,13 @@ static target_ulong h_register_process_table(PowerP=
CCPU *cpu,
>      target_ulong table_size =3D args[3];
>      uint64_t cproc;
> =20
> -    if (flags & ~FLAGS_MASK) { /* Check no reserved bits are set */
> +    if (flags & ~SPAPR_PROC_TABLE_MASK) { /* Check no reserved bits are =
set */
>          return H_PARAMETER;
>      }
> -    if (flags & FLAG_MODIFY) {
> -        if (flags & FLAG_REGISTER) {
> -            if (flags & FLAG_RADIX) { /* Register new RADIX process tabl=
e */
> +    if (flags & SPAPR_PROC_TABLE_MODIFY) {
> +        if (flags & SPAPR_PROC_TABLE_REGISTER) {
> +            if (flags & SPAPR_PROC_TABLE_RADIX) {
> +                /* Register new RADIX process table */
>                  if (proc_tbl & 0xfff || proc_tbl >> 60) {
>                      return H_P2;
>                  } else if (page_size) {
> @@ -958,7 +952,8 @@ static target_ulong h_register_process_table(PowerPCC=
PU *cpu,
>                  }
>                  cproc =3D PATBE1_GR | proc_tbl | table_size;
>              } else { /* Register new HPT process table */
> -                if (flags & FLAG_HASH_PROC_TBL) { /* Hash with Segment T=
ables */
> +                if (flags & SPAPR_PROC_TABLE_HPT_PT) {
> +                    /* Hash with Segment Tables */
>                      /* TODO - Not Supported */
>                      /* Technically caused by flag bits =3D> H_PARAMETER =
*/
>                      return H_PARAMETER;
> @@ -981,7 +976,8 @@ static target_ulong h_register_process_table(PowerPCC=
PU *cpu,
>              cproc =3D spapr->patb_entry & PATBE1_GR;
>          }
>      } else { /* Maintain current registration */
> -        if (!(flags & FLAG_RADIX) !=3D !(spapr->patb_entry & PATBE1_GR))=
 {
> +        if (!(flags & SPAPR_PROC_TABLE_RADIX) !=3D
> +            !(spapr->patb_entry & PATBE1_GR)) {
>              /* Technically caused by flag bits =3D> H_PARAMETER */
>              return H_PARAMETER; /* Existing Process Table Mismatch */
>          }
> @@ -996,13 +992,14 @@ static target_ulong h_register_process_table(PowerP=
CCPU *cpu,
>      /* Update the UPRT and GTSE bits in the LPCR for all cpus */
>      CPU_FOREACH(cs) {
>          set_spr(cs, SPR_LPCR, LPCR_UPRT | LPCR_GTSE,
> -                ((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UPRT=
 : 0) |
> -                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0));
> +                ((flags & (SPAPR_PROC_TABLE_RADIX | SPAPR_PROC_TABLE_HPT=
_PT)) ?
> +                LPCR_UPRT : 0) | ((flags & SPAPR_PROC_TABLE_GTSE) ?
> +                SPAPR_PROC_TABLE_GTSE : 0));
>      }
> =20
>      if (kvm_enabled()) {
> -        return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
> -                                       flags & FLAG_GTSE, cproc);
> +        return kvmppc_configure_v3_mmu(cpu, flags & SPAPR_PROC_TABLE_RAD=
IX,
> +                                       flags & SPAPR_PROC_TABLE_GTSE, cp=
roc);
>      }
>      return H_SUCCESS;
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f88..a692e63 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -681,4 +681,14 @@ int spapr_rng_populate_dt(void *fdt);
> =20
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
> =20
> +/*
> + * Defines for flag value used in H_REGISTER_PROC_TBL hcall.
> + */
> +#define SPAPR_PROC_TABLE_MASK        0x01FULL
> +#define SPAPR_PROC_TABLE_MODIFY      0x10
> +#define SPAPR_PROC_TABLE_REGISTER    0x08
> +#define SPAPR_PROC_TABLE_RADIX       0x04
> +#define SPAPR_PROC_TABLE_HPT_PT      0x02
> +#define SPAPR_PROC_TABLE_GTSE        0x01
> +
>  #endif /* HW_SPAPR_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZE60AAAoJEGw4ysog2bOSONAQAL1T3D2m0eIgj3sYj+mGxfqM
BbvLCD1Kj/aJtruHGZbjO8hFPmBPBbGOn7LVBShHgvlq9nD3Yf3KNj9/H1/Qyft8
erZ2QdHVxCmKPCHVRzNf8gjsVHWZdpX1rDcXUQr1M3I33hGQlgWNg8xBCuj102RU
Xq2RYhGDLrerR2k19F9pl4C3LJYZ7xFArug1j4FR7Dw6Dd8drAl6bsOR1mjksx+o
SdNvCfMi71sFjBPUYWhDT23QkfiZdMCjo/1ScJFx1VB7CKZA6Hf2MSRLKzdOSuJ4
JMfX8Mz7Zvoo7wnRvV1hjyH27LHHOkAR34yGiISjaRPl57s4vCJTPYPAyKbc6cDc
GG/jKb4+YBauruNuZV6uVZUbspw4/tgeGGFuN14g5fJchEvpgvGDITxW9A2kAPBn
YI0KQNIuGJr5tfYUIq5MiRxI/Vdj9O0x1UaUF8zGxVcA2Mhml6PQWltGUpL8mpe+
+25VtMKKZ8L4YIfhpa8v5XT+uR6gWE5iMDGEnOR8UA+wtSIUAGhT8U2mS3pGNucj
BdhSGjvZpNCn4yJOY6lMtJPt9RtfsmxKKg6+m63ahZf+ZnpY40pa6FeMoJbaxY3c
iZnhNyQUuOD908qyK71kXKaa5mWqyxM2TCX3qO/wFltC1YCxAk90WadYmU91xUjR
ReO4TvEYAGFiYR22DIf1
=xBHx
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
