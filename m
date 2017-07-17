Received: from eggs.gnu.org ([2001:4830:134:3::10]:53086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWuTT-0001k0-Jw
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 21:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWuTS-00041j-AP
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 21:05:23 -0400
Date: Mon, 17 Jul 2017 11:05:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170717010505.GA4535@umbus>
References: <1500048838-16802-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <1500048838-16802-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix CPU hotplug when radix is
 enabled (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 06:13:58PM +0200, C=E9dric Le Goater wrote:
> But when a guest initializes radix mode, it issues a H_REGISTER_PROC_TBL
> to update the LPCR of all CPUs. Hot-plugged CPUs inherit from the same
> setting under KVM but not under TCG. So, Let's check for radix and update
> the default LPCR to keep new CPUs in sync.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.10, thanks.

> ---
>  target/ppc/translate_init.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 8b9807665dd5..8776e9b0f8fa 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9014,8 +9014,16 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualH=
ypervisor *vhyp)
>          /* By default we choose legacy mode and switch to new hash or ra=
dix
>           * when a register process table hcall is made. So disable proce=
ss
>           * tables and guest translation shootdown by default
> +         *
> +         * Hot-plugged CPUs inherit from the guest radix setting under
> +         * KVM but not under TCG. Update the default LPCR to keep new
> +         * CPUs in sync when radix is enabled.
>           */
> -        lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
> +        if (ppc64_radix_guest(cpu)) {
> +            lpcr->default_value |=3D LPCR_UPRT | LPCR_GTSE;
> +        } else {
> +            lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
> +        }
>          lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
>                                 LPCR_OEE;
>          break;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllsDT8ACgkQbDjKyiDZ
s5I0Xw//c2NWpToKwlhzrsCxewMKVYHvHwHqzbdnRWwyq8CX+KfqMOnL90Q4gXsn
1H+6oQI+0Fuk08PPc4ZpurcjxJjgYWSkYTVNc25HN5bzQxZHF6kNFXCdifZKDZtv
B6z6/n++K6NwBR2Xz/GQRAH5SWwgvT7nyzV97yS0I0i5R0zu2XWqJaxKUdjUs0YU
pNlQh2DL5IGqA0K/8C+GGFO4ePQcGO8kzl/BNrBkGKNHYiKnhfgnoXYle0dvc+gF
1XVc/Ukr97Nxr7tqwKU1+txw6m/Sut4gblrS4cC3l+R0ST6JYi8pv0cXWXV9dXxK
7KodcMBmlrR7WmFJQoOwzSwN+q/K9zLK5VWot+pzgIvCbLt7p1PQ3g3XMdrnI/K9
JpwNlEPXmOWq3mMHMItyetq83TLweiPawGR9JemoR+XMzNeAYD8FI3rBXN8T7K/O
SD8VemlNbbVzMBLbc+bSQRY+R5AshLiYo52jILblhF0X63s5ytlAD7xwJNLqqyRf
i1WrG33QPhuIWwXbmhaFlsUTbIuK6a9L7yhTVLjus4fYUi2/bUH1fMyrwRgfufzB
g+yrCang4ri44+xjt2cMbODQS3OLTsYfP98GoVeOT83W98eIEnomQsodGTFuTqqH
J98Xzj1odGYlB3Ea9yyJjvsYpI+b4UkMfFn5C/fmGJc3CMYxtvo=
=+s7h
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
