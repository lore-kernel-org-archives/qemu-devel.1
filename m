Received: from eggs.gnu.org ([2001:4830:134:3::10]:36807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ8Wl-00025N-Es
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ8Wi-0002VR-Ad
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 00:02:15 -0500
Date: Wed, 10 Jan 2018 16:02:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180110050204.GB19773@umbus.fritz.box>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-4-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20180109092103.18458-4-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [RFC 3/3] target/ppc: Add H-Call
 H_GET_CPU_CHARACTERISTICS
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


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 08:21:03PM +1100, Suraj Jitindar Singh wrote:
> The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to query
> behaviours and available characteristics of the cpu.
>=20
> Implement the handler for this new H-Call which formulates its response
> based on the setting of the new capabilities added in the previous
> patch.
>=20
> Note: Currently we return H_FUNCTION under TCG which will direct the
>       guest to fall back to doing a displacement flush
>=20
> Discussion:
> Is TCG affected?

Very likely :(.

> Is there any point in telling the guest to do these workarounds on TCG
> given they're unlikely to translate to host instructions which have the
> desired effect?

Probably not.  We might have to just advertise broken on TCG, at least
until someone has time to figure out the details.

> ---
>  hw/ppc/spapr_hcall.c   | 81 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |  1 +
>  2 files changed, 82 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 51eba52e86..b62b47c8d9 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1654,6 +1654,84 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +#define CPU_CHARACTERISTIC_SPEC_BARRIER         (1ULL << (63 - 0))
> +#define CPU_CHARACTERISTIC_BCCTR_SERIAL         (1ULL << (63 - 1))
> +#define CPU_CHARACTERISTIC_ORI_L1_CACHE         (1ULL << (63 - 2))
> +#define CPU_CHARACTERISTIC_MTTRIG_L1_CACHE      (1ULL << (63 - 3))
> +#define CPU_CHARACTERISTIC_L1_CACHE_PRIV        (1ULL << (63 - 4))
> +#define CPU_CHARACTERISTIC_BRANCH_HINTS         (1ULL << (63 - 5))
> +#define CPU_CHARACTERISTIC_MTTRIG_THR_RECONF    (1ULL << (63 - 6))
> +#define CPU_BEHAVIOUR_FAVOUR_SECURITY           (1ULL << (63 - 0))
> +#define CPU_BEHAVIOUR_L1_CACHE_FLUSH            (1ULL << (63 - 1))
> +#define CPU_BEHAVIOUR_SPEC_BARRIER              (1ULL << (63 - 2))
> +
> +static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
> +                                              sPAPRMachineState *spapr,
> +                                              target_ulong opcode,
> +                                              target_ulong *args)
> +{
> +    uint64_t characteristics =3D CPU_CHARACTERISTIC_BRANCH_HINTS;
> +    uint64_t behaviour =3D CPU_BEHAVIOUR_FAVOUR_SECURITY;

I guess we're going to want another knob for the favour security vs
favour performance bit here.

> +    uint8_t safe_cache =3D spapr_get_cap(spapr, SPAPR_CAP_CFPC);
> +    uint8_t safe_bounds_check =3D spapr_get_cap(spapr, SPAPR_CAP_SBBC);
> +    uint8_t safe_indirect_branch =3D spapr_get_cap(spapr, SPAPR_CAP_IBS);
> +
> +    /* TODO: Is TCG vulnerable? */

Good question, but in any case..

> +    if (!kvm_enabled()) {
> +        return H_FUNCTION;
> +    }

=2E.this should still advertise things based on the caps.  The point we
apply the caps to the virtual hardware is where we need to consider
TCG's vulnerability.

> +
> +    switch (safe_cache) {
> +    case SPAPR_CAP_WORKAROUND:
> +        characteristics |=3D CPU_CHARACTERISTIC_ORI_L1_CACHE;
> +        characteristics |=3D CPU_CHARACTERISTIC_MTTRIG_L1_CACHE;
> +        characteristics |=3D CPU_CHARACTERISTIC_L1_CACHE_PRIV;
> +        behaviour |=3D CPU_BEHAVIOUR_L1_CACHE_FLUSH;
> +        break;
> +    case SPAPR_CAP_FIXED:
> +        break;
> +    default: /* broken */
> +        if (safe_cache !=3D SPAPR_CAP_BROKEN) {
> +            error_report("Invalid value for KVM_CAP_PPC_SAFE_CACHE (%d),=
 assuming broken",
> +                         safe_cache);
> +        }
> +        behaviour |=3D CPU_BEHAVIOUR_L1_CACHE_FLUSH;
> +        break;
> +    }
> +
> +    switch (safe_bounds_check) {
> +    case SPAPR_CAP_WORKAROUND:
> +        characteristics |=3D CPU_CHARACTERISTIC_SPEC_BARRIER;
> +        behaviour |=3D CPU_BEHAVIOUR_SPEC_BARRIER;
> +        break;
> +    case SPAPR_CAP_FIXED:
> +        break;
> +    default: /* broken */
> +        if (safe_bounds_check !=3D SPAPR_CAP_BROKEN) {
> +            error_report("Invalid value for KVM_CAP_PPC_SAFE_BOUNDS_CHEC=
K (%d), assuming broken",
> +                         safe_bounds_check);
> +        }
> +        behaviour |=3D CPU_BEHAVIOUR_SPEC_BARRIER;
> +        break;
> +    }
> +
> +    switch (safe_indirect_branch) {
> +    case SPAPR_CAP_FIXED:
> +        characteristics |=3D CPU_CHARACTERISTIC_BCCTR_SERIAL;
> +    default: /* broken */
> +        if (safe_indirect_branch !=3D SPAPR_CAP_BROKEN) {
> +            error_report("Invalid value for KVM_CAP_PPC_SAFE_INDIRECT_BR=
ANCH (%d), assuming broken",
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
> @@ -1733,6 +1811,9 @@ static void hypercall_register_types(void)
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
> index 2db2f3e2e2..5677c38d2a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -396,6 +396,7 @@ struct sPAPRMachineState {
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

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpVnkwACgkQbDjKyiDZ
s5Lrsw/9ELi3+ZLohFCm0KVTh/WfT9LppvgeuA51t/fCygXU3fW9ffjfLsSsKgeN
kq79D7C8oADumKwH6iGEqu4gKfLojt8pUX+FJonUXWtFI6UVFvPwQL9r5lTART7Q
3kDWEZgSGqLMgggC4UVATto9kxhgbSYlu8qqxw4ZsocaR+aY7h6thkLUgvwcZ9sG
XwTBABWoeFd89BLUyKDAdt6ht2BntUdqY724/j9paenE4bnloAGTzwxZWv5W8sAy
0Idok3iox7n45UiPsNMRyESJU383GWkOa5+msVdo5diPGNUUc/DM/C+q2d8kQ3qI
Dc+2PCrXMXgcxotHXNMkhO1EjbpvpSZSophvLPxLJb6WLlZqT0oRnSwIKS+IyE8g
zc9ouw6RBQf/Ckt7CDopZqYDm5gTtAKcFw5IFEfJFmvlhzKfunljbFiQZODVQY7e
Xv8quTYqslY7V/NaXsm1Wup2Ax7SGcRMEVdL9bNdAWvguabcl1pvIxoncPjYsNo4
N9smI7m1YdbaDqL5FDgbIYiLYUlpmLdUz5Rrd+K5bWHjxV6wv/Lee0Pl1FlW6C9J
11z0h9wbChZzvnVmpTm22T+pzj55xgtGk2I6S+yYo0EPeUo9W4T8MLLiV0uqUbVF
aIXwTr6ENsf9nNJk7EwYLZNaXqxMiltYEX84yCBGbrX8TmF73UI=
=3XRk
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
