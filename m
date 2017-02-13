Received: from eggs.gnu.org ([2001:4830:134:3::10]:46138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd7ya-0004Xa-UR
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd7yX-0003t0-P2
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:10:56 -0500
Date: Mon, 13 Feb 2017 15:10:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213041042.GS25381@umbus>
References: <1486956627-11123-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cbvl/UgeRTPlujdB"
Content-Disposition: inline
In-Reply-To: <1486956627-11123-1-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Stop parsing pvr
 list in H_CAS when exact match found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--Cbvl/UgeRTPlujdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 02:30:27PM +1100, Suraj Jitindar Singh wrote:
> The pvr-list passed in H_Client_Architecture_Support is used to
> communicate the supported pvrs of the client program. When an
> exact match is found you are allowed to stop parsing the list and continue
> the boot process.
>=20
> Currently while explicit_match is set when we find an exact match, we sti=
ll
> set a compat mode based on best_compat irrespective of whether an exact
> match was found or not. This is wrong since it means we can only ever run
> in an architected state, not a raw state since we always set a compat mod=
e.
> We are basically ignoring the case were we find an exact match.
>=20
> Fix the code to stop parsing the pvr list when an exact match is found.
> This means that best_compat will always be zero in the case of an exact
> match which means we will not set a compat mode an thus run in raw mode,
> which is the desired functionality when we have an exact match.
>=20
> Fixes: 152ef803ceb1 ("pseries: Rewrite CAS PVR compatibility logic")
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Nack.  That change was deliberately intended to prefer compatibility
modes, only ever using a "raw" mode if there's no matching
compatibility mode.

Using compatibility modes as often as possible makes migration across
different host types substantially easier to handle and more likely to
succeed.

>=20
> ---
>  hw/ppc/spapr_hcall.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 590105a..215c385 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1028,6 +1028,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
> =20
>          if ((cpu->env.spr[SPR_PVR] & pvr_mask) =3D=3D (pvr & pvr_mask)) {
>              explicit_match =3D true;
> +            break;
>          } else {
>              if (ppc_check_compat(cpu, pvr, best_compat, max_compat)) {
>                  best_compat =3D pvr;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cbvl/UgeRTPlujdB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoTHCAAoJEGw4ysog2bOSSq0P/R3DBeB8B3NHYYW9ocvm1sjJ
mItCfC0eN+uvyU3er7JzX44L1EoP5b/SWIyjT08fp6cND7+Jk3pKSKhMG6IGkiOb
70CPGojLDjBJVTvOpx9Y9+BnoVbhzCuCjQI/entU8C29KQP5MJ2JdqrhfNio5f7f
ZuZCCcwH5KNj9J5Oc3D+r0cGa+I0Y1yk/w+vD7dfJfroHzTqY2ur4zhoVxlbHPzN
GrkLLXiMF2Iw2cqfHsracNj7/juYhIOwEK+dPf+9p4GbnLjv4dT04cMWUJ4l4ArQ
t8RTYcpe9BmspCCgr/92laYXIJc3Sjo2zM/uPbSL+fqf7H/zVh6RhpSnroef5OwL
cfL86C8gRJ/H+1m4EmLNHSnSJDWCbD528EkwP98VA31xYx5NrjUp5dmD62Asw+JV
LmtrjS7CBNJxKgtc6Ly8SHlhThkaCQUBlDKdPenOVIAl2TqWb5bErmF+9FzA5PbC
i46Zw7XWuf72VJKCCGG9RBtZEiRp7qtRylAPkFHROYudcUsKTPVBftfwBm9MO0dG
L6eZ6IGXfdyFhf3dlU96Ti9iPveOxFuVFV5glyGWhraQbpvkQo9k4xlw0DL/9iYR
MnJtKn8p7b8P6QRYnGey5XfPADC22xFe9PAaq7FPhJRGQPFmpbCmAl2roDQ7JIAd
EN2yTHjoI2EQM/7kHqWV
=/uDQ
-----END PGP SIGNATURE-----

--Cbvl/UgeRTPlujdB--
