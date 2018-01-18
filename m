Received: from eggs.gnu.org ([2001:4830:134:3::10]:50561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fw-0005wy-Cv
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fu-0001Ff-Up
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:44 -0500
Date: Thu, 18 Jan 2018 16:20:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118052029.GR30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-7-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fV3mxwFPWhsKHyX"
Content-Disposition: inline
In-Reply-To: <20180115063235.7518-7-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 6/6] target/ppc/spapr: Add
 H-Call H_GET_CPU_CHARACTERISTICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org


--2fV3mxwFPWhsKHyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 05:32:35PM +1100, Suraj Jitindar Singh wrote:
> The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to query
> behaviours and available characteristics of the cpu.
>=20
> Implement the handler for this new H-Call which formulates its response
> based on the setting of the spapr_caps cap-cfpc, cap-sbbc and cap-ibs.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |  1 +
>  2 files changed, 67 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 51eba52e86..a693d3b852 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1654,6 +1654,69 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
> +                                              sPAPRMachineState *spapr,
> +                                              target_ulong opcode,
> +                                              target_ulong *args)
> +{
> +    uint64_t characteristics =3D H_CPU_CHAR_HON_BRANCH_HINTS &
> +			       ~H_CPU_CHAR_THR_RECONF_TRIG;
> +    uint64_t behaviour =3D H_CPU_BEHAV_FAVOUR_SECURITY;
> +    uint8_t safe_cache =3D spapr_get_cap(spapr, SPAPR_CAP_CFPC);
> +    uint8_t safe_bounds_check =3D spapr_get_cap(spapr, SPAPR_CAP_SBBC);
> +    uint8_t safe_indirect_branch =3D spapr_get_cap(spapr, SPAPR_CAP_IBS);
> +
> +    switch (safe_cache) {
> +    case SPAPR_CAP_WORKAROUND:
> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_ORI30;
> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_TRIG2;
> +        characteristics |=3D H_CPU_CHAR_L1D_THREAD_PRIV;
> +        behaviour |=3D H_CPU_BEHAV_L1D_FLUSH_PR;
> +        break;
> +    case SPAPR_CAP_FIXED:
> +        break;
> +    default: /* broken */
> +        if (safe_cache !=3D SPAPR_CAP_BROKEN) {

I think you just assert() for this.  The only way these could get a
different value is if there's a bug elsewhere.

> +            error_report("Invalid value for cap-cfpc (%d), assuming brok=
en",
> +                         safe_cache);
> +        }
> +        behaviour |=3D H_CPU_BEHAV_L1D_FLUSH_PR;
> +        break;
> +    }
> +
> +    switch (safe_bounds_check) {
> +    case SPAPR_CAP_WORKAROUND:
> +        characteristics |=3D H_CPU_CHAR_SPEC_BAR_ORI31;
> +        behaviour |=3D H_CPU_BEHAV_BNDS_CHK_SPEC_BAR;
> +        break;
> +    case SPAPR_CAP_FIXED:
> +        break;
> +    default: /* broken */
> +        if (safe_bounds_check !=3D SPAPR_CAP_BROKEN) {
> +            error_report("Invalid value for cap-sbbc (%d), assuming brok=
en",
> +                         safe_bounds_check);
> +        }
> +        behaviour |=3D H_CPU_BEHAV_BNDS_CHK_SPEC_BAR;
> +        break;
> +    }
> +
> +    switch (safe_indirect_branch) {
> +    case SPAPR_CAP_FIXED:
> +        characteristics |=3D H_CPU_CHAR_BCCTRL_SERIALISED;
> +    default: /* broken */
> +        if (safe_indirect_branch !=3D SPAPR_CAP_BROKEN) {
> +            error_report("Invalid value for cap-ibs (%d), assuming broke=
n",
> +                         safe_indirect_branch);
> +        }
> +        break;
> +    }
> +
> +    args[0] =3D characteristics;
> +    args[1] =3D behaviour;
> +
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1733,6 +1796,9 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(H_INVALIDATE_PID, h_invalidate_pid);
>      spapr_register_hypercall(H_REGISTER_PROC_TBL, h_register_process_tab=
le);
> =20
> +    /* hcall-get-cpu-characteristics */
> +    spapr_register_hypercall(H_GET_CPU_CHARACTERISTICS, h_get_cpu_charac=
teristics);
> +
>      /* "debugger" hcalls (also used by SLOF). Note: We do -not- differen=
ciate
>       * here between the "CI" and the "CACHE" variants, they will use wha=
tever
>       * mapping attributes qemu is using. When using KVM, the kernel will
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 549d7a4134..62c077ac20 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -404,6 +404,7 @@ struct sPAPRMachineState {
>  #define H_GET_HCA_INFO          0x1B8
>  #define H_GET_PERF_COUNT        0x1BC
>  #define H_MANAGE_TRACE          0x1C0
> +#define H_GET_CPU_CHARACTERISTICS 0x1C8
>  #define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
>  #define H_QUERY_INT_STATE       0x1E4
>  #define H_POLL_PENDING          0x1D8

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2fV3mxwFPWhsKHyX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgLp0ACgkQbDjKyiDZ
s5LWEQ/+NN5GiJne7Fmp3Tbz1+vRhw0ScdJpKzTRdfzCPjnDY5UCeapNLYh149fS
by+6ougpTlt9W8Qy4EsZP0JENdYaiQDg7/YJa3XtyvFslpYh3Ph5uufkVGD8HDWJ
56mgYTIUPO/2rfkSGYZZcMofYTqjGPXOurEhiVGL88YQG6DshUKNCWZMAdpfdQkt
b7a1SpZJcQ00ulNCWT5qA5kAd6LfMLiq4VenQM2Q8gY4i0ecbrbOxi8ymEzSWyAj
UGYs2huFXU7xkbq1yES5dJr94LZPMKx9rM4/iZqpVj2QBXLNpSB6LdPw0/WJWHHk
R7mrcGyQUgOt+2ADUrWG2V7LM5XMvzESun0mCQu8VQlIL9jbcUDp1PeIexk4XmPg
5iIsory3wXBYfpmHUSEvNqGz7rEkF87UIqaJ0g2ggZQlE99vlORUKZ5XZkMbSNT0
u/2Nph4xU1wXnSsYe5qTg423s/0hwv3RiTc6I+WX5Wakawuk4wH0X7KDMTnaXude
wK+2hslR8QOOosABgVvswfHS/ZzK42xUnVbFwTYVeyPDlVaOYLWWriJmmGQzsdzR
32L/b/R3FMMBPypnAhSz+SCtLXAXNrPjJFLVNFxg2sR/tlDzK046xtm8ofawSm1C
iskfwampeQnnnr31B9bDBMuR91d9BH0eWwFzwFu77q2Q1TR6R6M=
=6cII
-----END PGP SIGNATURE-----

--2fV3mxwFPWhsKHyX--
