Received: from eggs.gnu.org ([2001:4830:134:3::10]:49635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTh-0000Jq-CO
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTg-0003VO-1y
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:57 -0400
Date: Tue, 16 May 2017 14:35:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516043555.GE30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484836649.20089.8174753739169885859.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <149484836649.20089.8174753739169885859.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/6] spapr: fix error path of required
 kernel-irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 01:39:26PM +0200, Greg Kurz wrote:
> QEMU should exit if the user explicitely asked for kernel-irqchip support
> and "xics-kvm" initialization fails.
>=20
> The changelog of commit 34f2af3d3edf ("spapr: Clean up misuse of qdev_ini=
t()
> in xics-kvm creation") reads:
>=20
>     While there, improve the error message when we can't satisfy an
>     explicit user request for "xics-kvm", and exit(1) instead of abort().
>     Simplify the abort when we can't create "xics".
>=20
> This patch adds the missing call to exit().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index abfb99b71b7d..f477d7b8a210 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -133,6 +133,7 @@ static void xics_system_init(MachineState *machine, i=
nt nr_irqs, Error **errp)
>          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
>              error_reportf_err(err,
>                                "kernel_irqchip requested but unavailable:=
 ");
> +            exit(EXIT_FAILURE);
>          } else {
>              error_free(err);
>          }
>=20


This doesn't look right.  We have an errp pointer in the caller.  So
on failure we should error_propagate(), rather than deciding for
ourselves that exiting is the right course of action.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGoGrAAoJEGw4ysog2bOSjSgP/jGfLPQ9yiUSxAIVkoYdY/v5
or8eib8Na4iT+CLa5fYeZKj0DauL7P/FFJ+nTNKF94q0QGlnmV4IKHUYUBz16bzq
GKcVm/IJKpbDkiRAMBFRIZ7Lvkc8THDq6QkXxyhHlG1gF4iv1t2jLXM1X6DQT7le
Nx+ssX+G8tAMzl2xFc7Suzlm9sRfPV2l/sxImhHB7KC+EOF2vK+5nD7A6ewKzTOd
vF8ZIsExd4tnRGuC5F5ensdy7V69X4uJDvqGErPU7gXffG+AsI5Q0j4Nxr6fjilX
9T8BF5/CO6vIVNS2PgBIlnxGew5+W6D+wMyMJtYbHtB29NDCyC9Iy7Y9mcK70nxh
IgblK8KZtRFrTB9khBLoL8ltscixDtzvfDNuGZKrFi35aIR1nQPBHmglXrLJY3EX
TmPCp6JCIXxXY0gkqCQ2lFbfpulRlMtpdqxdlt5hnpQUYIS+8kdA9KpC9BMtLzs7
0TXqbSOALGa0RK3Asgwb+ykrUkYNT2XPPuBtgk1ov9IqhrjssmwpE0I0rHYEdHkm
ZYrLVmRtmL60xSubdBx7lG0fvbLm9McItZEu/jONBJhK6c/E+H81xDTUgGp86WL+
kFgrXwvCM/QaiRLW2wks3Su+W/Umkn1UzZrXach/ailQdOh/Wi3Sm1hR6qBDz0JA
nCN4q3v4wukt8Fi5SKOI
=RKTj
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
