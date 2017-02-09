Received: from eggs.gnu.org ([2001:4830:134:3::10]:46754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepp-0007cT-J5
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepn-0006ys-St
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:49 -0500
Date: Thu, 9 Feb 2017 13:34:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209023440.GU17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<2152049c2d1291babfe2c7af9df23961a9748a17.1486436186.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xku3GkZTJumTa1rO"
Content-Disposition: inline
In-Reply-To: <2152049c2d1291babfe2c7af9df23961a9748a17.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 7/9] spapr: Set ISA 3.00 radix and hash
 bits in OV5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--xku3GkZTJumTa1rO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 01:56:50PM +1100, Sam Bobroff wrote:
> Set new option vector 5 bits to indicate KVM support for in-memory
> radix or hash modes and related options. The existing logic will
> propagate the results back to the guest in the device tree. This
> allows guests to perform client architecture support negotiation on
> the new radix and hash MMU modes and will cause ISA 3.00 guests to
> start using h_register_process_table().
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  hw/ppc/spapr.c              | 8 ++++++++
>  include/hw/ppc/spapr_ovec.h | 6 ++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1411e470c0..c6a3a638cd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1862,6 +1862,14 @@ static void ppc_spapr_init(MachineState *machine)
>      }
> =20
>      spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
> +    if (kvmppc_has_cap_mmu_radix()) {
> +        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX);
> +    }
> +    if (kvmppc_has_cap_mmu_hash()) {
> +        spapr_ovec_set(spapr->ov5, OV5_MMU_HASH);
> +    }
> +    spapr_ovec_set(spapr->ov5, OV5_SEG_HCALL);
> +    spapr_ovec_set(spapr->ov5, OV5_SHOOTDOWN);

What are these last two bits about?  AFAICT nothing has been
implemented for them, and they shouldn't be set until that's the case.

> =20
>      /* advertise support for dedicated HP event source to guests */
>      if (spapr->use_hotplug_event_source) {
> diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
> index 0f14753ff8..0a77e2a14b 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -47,6 +47,12 @@ typedef struct sPAPROptionVector sPAPROptionVector;
>  #define OV5_DRCONF_MEMORY       OV_BIT(2, 2)
>  #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
>  #define OV5_HP_EVT              OV_BIT(6, 5)
> +#define OV5_INT_ARCH_LVL        OV_BIT(23, 7)
> +#define OV5_MMU_RADIX           OV_BIT(24, 0)
> +#define OV5_MMU_HASH            OV_BIT(24, 1)
> +#define OV5_SEG_RADIX           OV_BIT(24, 2)
> +#define OV5_SEG_HCALL           OV_BIT(24, 3)
> +#define OV5_SHOOTDOWN           OV_BIT(24, 4)
> =20
>  /* interfaces */
>  sPAPROptionVector *spapr_ovec_new(void);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xku3GkZTJumTa1rO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm9VAAAoJEGw4ysog2bOS3xAP/iZC3S9yX/QpECzVwQXI0A8t
gusZNEETiAg9NNmwJleCWChopZeKEfsgjo9wVcGK19/ZcwsmhFx04yU/lhj3tbdb
q/ITuwlaxGNmtOAZXnBnxjGWTm6R7bN8Islqwjmt7A1nO67Zt6STptKcoMKSI1Ay
Rn2LXzPWqN8o+Uwc3TmMNzptNeS4myFSP174UZmqMx7VarEM6rj3mP6UdtqBUSJN
21DL6WipF3ttMkifyMkGe5HMJ5EM+gV5HWOpsUD+fTG4qokQupnGshZG8XNdc6wh
2Z81eCwSw0IoeGfQoG5lcBGeN98qE5Ibl0hYvPZCsupOeyfudgeOmE1sYV7KvKbB
DhvvRBS+537Tujl+Oh7aj+2NTZvgnRSaJn/t1DjbC/8kM0jC9rX1TPuVyjWAf1Vl
vRB+EIbZ0vASo5JmgN67ioRUq3ZI3900OYsGofVxQlqFw1hpCKERm0sSe/Sw/IB5
TAI7VFTr7WezeIrvBYVy0FBTQdY8Bg/tbtXhG8AYMepmP5vXw51Dslqql08SqVA2
I7W2qScP4xJOyHsXHFp4roO9ZU6YZR+Oiub1oXvHkW0Q/fKB4WDiXfDX/9EbpMJ1
/HVch02eBZ89uJqxRPrzwIMQrif/EtcawFf9Fp5AI8G0iBJSnO1TrSCKWFPidX7s
XKn15x7SwC1UL4Ck10KP
=M2MD
-----END PGP SIGNATURE-----

--xku3GkZTJumTa1rO--
