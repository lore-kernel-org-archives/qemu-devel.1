Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQq3K-0000qj-O6
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQq3H-000601-HX
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:09:18 -0400
Date: Fri, 30 Jun 2017 16:59:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170630065905.GD13989@umbus.fritz.box>
References: <20170628194731.15742-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <20170628194731.15742-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr.c: do not adjust rma_size
 with KVM RADIX in ppc_spapr_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 04:47:31PM -0300, Daniel Henrique Barboza wrote:
> In ppc_spapr_init when setting rma_size we have the following verificatio=
n:
>=20
>     if (rma_alloc_size && (rma_alloc_size < node0_size)) {
>         spapr->rma_size =3D rma_alloc_size;
>     } else {
>         spapr->rma_size =3D node0_size;
>=20
>         /* With KVM, we don't actually know whether KVM supports an
>          * unbounded RMA (PR KVM) or is limited by the hash table size
>          * (HV KVM using VRMA), so we always assume the latter
>          *
>          * In that case, we also limit the initial allocations for RTAS
>          * etc... to 256M since we have no way to know what the VRMA size
>          * is going to be as it depends on the size of the hash table
>          * isn't determined yet.
>          */
>         if (kvm_enabled()) {
>             spapr->vrma_adjust =3D 1;
>             spapr->rma_size =3D MIN(spapr->rma_size, 0x10000000);
>         }
>=20
> This code (and the comment that precedes it) is taking constraints and co=
nditions
> related to KVM HPT guests and filtering them with "if (kvm_enabled())". N=
ote that
> this also means that, for KVM RADIX guests, we'll change rma_size and set=
 the
> vrma_adjust flag as well.
>=20
> The flag vrma_adjust is used inside 'spapr_setup_hpt_and_vrma', which in =
turn is
> called from ppc_spapr_reset as follows:
>=20
>     if (kvm_enabled() && kvmppc_has_cap_mmu_radix()) {
>         /* If using KVM with radix mode available, VCPUs can be started
>          * without a HPT because KVM will start them in radix mode.
>          * Set the GR bit in PATB so that we know there is no HPT. */
>         spapr->patb_entry =3D PATBE1_GR;
>     } else {
>         spapr_setup_hpt_and_vrma(spapr);
>     }
>=20
> In short, when running a KVM HPT guest, rma_size is shrinked, the flag vr=
ma_adjust
> is set and later on spapr_setup_hpt_and_vrma() is called to make the prop=
er
> adjustments. When running a KVM RADIX guest no post adjustment is made, l=
eaving
> rma_size with the value MIN(spapr->rma_size, 0x10000000).
>=20
> This changed rma_size value is causing the code to populate more memory n=
odes
> in 'spapr_populate_memory', which in turn results in differences in the m=
emory
> layout at SLOF init (alloc_top and rmo_top). At first this isn't causing =
bugs or
> guest misbehavior in case of KVM RADIX - the problem is that this is happ=
ening
> due to KVM HPT code.
>=20
> This patch changes the if conditional inside ppc_spapr_init to:
>=20
>         if (kvm_enabled() && !kvmppc_has_cap_mmu_radix()) {
>             spapr->vrma_adjust =3D 1;
>             spapr->rma_size =3D MIN(spapr->rma_size, 0x10000000);
>         }
>=20
> To restrict the rma changes only to KVM HPT guests. If we need to do
> adjustments for RADIX we should either do it explicitly in its own code
> or make it clearer that a common code applies to both HPT and RADIX.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This doesn't seem right to me, on a few levels.

First, if the guest is RPT, then AFAIK, the whole concept of an RMA is
basically meaningless - so we should be reflecting that throughout not
just removing one adjustment to it.

We probably need some cleanup of the existing code here - at the
moment these RMA adjustments make guest-visible changes based on
whether we're KVM or not, which is not an ideal situation at all.

> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7d9af75..117ea9d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2164,7 +2164,7 @@ static void ppc_spapr_init(MachineState *machine)
>           * is going to be as it depends on the size of the hash table
>           * isn't determined yet.
>           */
> -        if (kvm_enabled()) {
> +        if (kvm_enabled() && !kvmppc_has_cap_mmu_radix()) {

In addition, this looks like the wrong test.  This tests if KVM is
_capable_ of doing radix, not if we actually _are_ doing radix.  At
the moment an RPT host can't run an HPT guest, but I believe we're
planning to change that at some point.

>              spapr->vrma_adjust =3D 1;
>              spapr->rma_size =3D MIN(spapr->rma_size, 0x10000000);
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZVfa5AAoJEGw4ysog2bOSQm0QAMPgKvT8hCyEsATd6Y4whs7T
xiOOmhD/p8CmxHLe5CduMUszFxxZP5Hr8FOhsmCVsqvMoCJP/jJhxi0vYgZBKVbO
jduawDbYc6P9dY/v7Yp79LnNoRApV7gKT751fgpGPXUf3DlQB/kZsh9PANIB1VjV
blm1CPlSDk1K3hFg2UhbVST2tVR34hhBAP2BYL75CZwiQfRC8/XqDC+b3c8U6so8
wwATCCBI9EpQEHY3urGPeGawRSBiFDehmjO5F5oYXi5z+4cH85E8e4ACRegPnaV7
AiixJOZ5hhnyu8tJGOLGG3wRdC/1nlIprekXmI/4dRxOBKkZw16aQ61II0x4CHYB
uIzH0n5hjX+TpfqLUxH0FWXVA1h7yCEzqD7aEDzmb0f+fUDwLnTsiFxiWD8mRwhL
uex+SeSCJaoRP836V1i+YTe29fWiKYZcWhECOaPxO6QN6M3RCZS8z3NEPSkrni8w
Hd8xD2OmiqyLZ1cLXfETl653m2iGyOjTmtCab1RKSEgYnISGK+QMcG3pWCsAidZR
wEs1YQ3ocw+PC6zujmARkoPnxhK0V7JRDHz7tbnSL0d5YIXAbOvbDHvnmSDQBAMs
oXTAGgfgoLuMvWCB5Ebm5cUlWyul27Mqjp7glDWCXNx7bSyNG2g+LUsWU8sLdG6c
e5y82pKojLJ3nYOw8X0C
=vTY3
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
