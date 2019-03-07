Received: from eggs.gnu.org ([209.51.188.92]:56781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1h9y-0003YT-Dw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1h9w-0007hU-Iw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:45:18 -0500
Date: Thu, 7 Mar 2019 11:25:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307002520.GB25123@umbus.fritz.box>
References: <20190306060608.19935-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20190306060608.19935-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc/spapr: Enable
 H_PAGE_INIT in-kernel handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 05:06:08PM +1100, Suraj Jitindar Singh wrote:
> The H_CALL H_PAGE_INIT can be used to zero or copy a page of guest
> memory. Enable the in-kernel H_PAGE_INIT handler.
>=20
> The in-kernel handler takes half the time to complete compared to
> handling the H_CALL in userspace.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied, thanks.

> ---
>  hw/ppc/spapr.c       | 3 +++
>  target/ppc/kvm.c     | 5 +++++
>  target/ppc/kvm_ppc.h | 5 +++++
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cf1ef9ebd4..8ce97ff1e7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2822,6 +2822,9 @@ static void spapr_machine_init(MachineState *machin=
e)
> =20
>          /* H_CLEAR_MOD/_REF are mandatory in PAPR, but off by default */
>          kvmppc_enable_clear_ref_mod_hcalls();
> +
> +        /* Enable H_PAGE_INIT */
> +        kvmppc_enable_h_page_init();
>      }
> =20
>      /* allocate RAM */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 4e3f1e4b78..d0bfb076df 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2043,6 +2043,11 @@ void kvmppc_enable_clear_ref_mod_hcalls(void)
>      kvmppc_enable_hcall(kvm_state, H_CLEAR_MOD);
>  }
> =20
> +void kvmppc_enable_h_page_init(void)
> +{
> +    kvmppc_enable_hcall(kvm_state, H_PAGE_INIT);
> +}
> +
>  void kvmppc_set_papr(PowerPCCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 2937b36cae..2c2ea30e87 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -23,6 +23,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int =
level);
>  void kvmppc_enable_logical_ci_hcalls(void);
>  void kvmppc_enable_set_mode_hcall(void);
>  void kvmppc_enable_clear_ref_mod_hcalls(void);
> +void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> @@ -138,6 +139,10 @@ static inline void kvmppc_enable_clear_ref_mod_hcall=
s(void)
>  {
>  }
> =20
> +static inline void kvmppc_enable_h_page_init(void)
> +{
> +}
> +
>  static inline void kvmppc_set_papr(PowerPCCPU *cpu)
>  {
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAZO4ACgkQbDjKyiDZ
s5ILrxAAzutApXlLYzTgpN4vHsL+IY28fJBDHUaIeXaIHvxLV91rHAplrnLKZrpv
wTqlL/pbMjQlvDTnZK0WEE1KBNnReJRTOXD+UIW2WjU251S6iTwwt8UeXgRmqgYW
lf9VYYNBUrPKV3nJ8rSDy1maBuh9Kc9PNKzK3mSQxfS9ycEaTgUGQ1fDIbToxxcZ
LBYLv+Q9xzSs+caSh9mMHasMGgcWMNPz6qskj+2peOSy6qUBk2q1b8CFTC+gjwtY
Ef8cafG55gz3vaBP2EX+iaelLDBw2vs5qH8JlafQ/1MYZmbK7J8Dwc/83hufcLxT
aMyHbFu1iJRnIWxltysKwg7U6y9ImxLIgeo3ASZBxYNDbas17xDJFypXL9nU7j3i
rBj+T/tW2GS/RniPbYjJNuahK37xCaO5mxS79a2yrJgZdGG6jdkcM6iibUgH1lFO
qGNVZbSVfl0q8LHr1rVWoWcrNMSDIbEzNwl409hChoela86ri1qN/819g6o9EqZ9
h5xpiUKnzaiEjvPYU97eWpR+0tdcBYmlp4BtUHcaqiF4f4aAjByATxcbudHtUFZ5
LpYZk/OiPwVLO+JP4hxHZH782sV+GrOTkQv8P3zLOZQYg4LTlF7u/ofVwN1oVhT0
+Pl4my7duubbO9Lrk0r6VjwOqiJ4LaQQUNBe9nAaGbSNdnO4opU=
=GiiY
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
