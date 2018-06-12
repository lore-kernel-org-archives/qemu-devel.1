Received: from eggs.gnu.org ([2001:4830:134:3::10]:60817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fShkH-0006MF-Ot
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fShkB-0002il-V5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:45:53 -0400
Date: Tue, 12 Jun 2018 21:19:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612111917.GF30690@umbus.fritz.box>
References: <20180612051630.17854-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20180612051630.17854-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 1/2] target/ppc: Don't
 require private l1d cache on POWER8 for cap_ppc_safe_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, muriloo@linux.ibm.com


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 03:16:29PM +1000, Suraj Jitindar Singh wrote:
> For cap_ppc_safe_cache to be set to workaround, we require both a l1d
> cache flush instruction and private l1d cache.
>=20
> On POWER8 don't require private l1d cache. This means a guest on a
> POWER8 machine can make use of the cache flush workarounds.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to ppc-for-3.0, thanks.

>=20
> ---
>=20
> V1 -> V2:
> - Use mfpvr() to detect host type
>=20
> ---
>  target/ppc/kvm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 2c0c34e125..7fe9d0126b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2412,11 +2412,28 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
> +static bool kvmppc_power8_host(void)
> +{
> +    bool ret =3D false;
> +#ifdef TARGET_PPC64
> +    {
> +        uint32_t base_pvr =3D CPU_POWERPC_POWER_SERVER_MASK & mfpvr();
> +        ret =3D (base_pvr =3D=3D CPU_POWERPC_POWER8E_BASE) ||
> +              (base_pvr =3D=3D CPU_POWERPC_POWER8NVL_BASE) ||
> +              (base_pvr =3D=3D CPU_POWERPC_POWER8_BASE);
> +    }
> +#endif /* TARGET_PPC64 */
> +    return ret;
> +}
> +
>  static int parse_cap_ppc_safe_cache(struct kvm_ppc_cpu_char c)
>  {
> +    bool l1d_thread_priv_req =3D !kvmppc_power8_host();
> +
>      if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
>          return 2;
> -    } else if ((c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_P=
RIV) &&
> +    } else if ((!l1d_thread_priv_req ||
> +                c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_P=
RIV) &&
>                 (c.character & c.character_mask
>                  & (H_CPU_CHAR_L1D_FLUSH_ORI30 | H_CPU_CHAR_L1D_FLUSH_TRI=
G2))) {
>          return 1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfrDMACgkQbDjKyiDZ
s5IgBRAAwHW1Q3wx2xAtgl69LDtuKr4WCN71nNeNZSK7KTd867/FVUxtkzVpeDHP
OV/KIcpfrf7oxYrCJ4lKXDp8q8fmXn4Yn6UNrzMleIQCT/D1nIhGoss2ywMnu6Cr
i7H4MQn/r8q4mXP4w/j1hueqMF/RYI4LI66Bqzc9evnJMh2XSeySRmnR38ZkGi8q
l1V0I5bKpTnrKraUT9E5n5oO0Li577rQ1PymYHSsHWvosUHsL237xIE7iCNfANXw
QNu95nYiSsunPr04Pr2++h+7WrnwCXxwcrk0DCznjJsnkYp57VZYB4DvxV54u0Nf
Ry9W88PUMS+3MAFTxL504otJh9gWMfOWR5A0tENTPdNtKsiJI7xi+08YQGNLIcLC
j7mRjYC135NuvSQf7i9In1hEK1uA4FksfTbKcNhkMi5gMD/mldQlVXANdEKsx3vU
uTV4LcLCZnniLqHs1b7Lu48EKjLPH0y71nh2aHzXXnaE6vlhUlYy/LvkKeenekgn
fC5qJ5/Hk+2WsAoI+zdYTakMQeReBIr9aIiW1HYiz9c99kWf8sFJox4IqO/I8NXb
0ItsCgjPthH+v3yZk+ucJvS+Ef6Dk3warjuV4+KSOUFa0krKw1TJGenlWDSijjaX
oXv459l2C5CzKEUBtCAfWTVsPmYaN46ppNjDa74V7k4sAXS1HX4=
=dAXB
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
