Received: from eggs.gnu.org ([2001:4830:134:3::10]:40343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPI-0004XQ-JN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPH-0008HJ-KL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:56 -0400
Date: Fri, 6 Oct 2017 19:54:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006085439.GC10961@umbus.fritz.box>
References: <20171005192458.610-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20171005192458.610-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/ppc/spapr_drc.c: adding drc->dev
 into detach quiesce condition
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


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 04:24:58PM -0300, Daniel Henrique Barboza wrote:
> In cases where a device is hotplugged and hot-unplugged shortly after,
> there is a chance of QEMU breaking with the following message:
>=20
> hw/ppc/spapr_drc.c:417:spapr_drc_detach: assertion failed: (drc->dev)
> Aborted
>=20
> spapr_drc_detach makes a g_assert(drc->dev) to ensure that the following
> spapr_drc_release call is able to execute the appropriate callback
> using drc->dev as a parameter. However, in a scenario where a hotplug
> is quickly followed by a hot-unplug, this g_assert can be reached before
> the hotplug operation sets drc->dev in spapr_drc_attach.
>=20
> This patch makes use of the awaiting quiesce mechanism inside
> spapr_drc_detach to fix this scenario. Inside spapr_drc_detach there is a
> quiesce condition that relies on drc->state being equal to drck->empty_st=
ate.
> If this doesn't happen, it is considered that the drc is not ready to be
> detached. By extending this condition to include drc->dev being non-null
> we cover this situation where the drc is still being attached and drc->dev
> isn't set yet during the detach.

Hrm.  I thought the plug and unplug operations were serialized by the
BQL.  So, we need some more explanation of exactly how we get here.

But, more importantly, this is broken.  If we get here and attach
hasn't completed yet, then we abort, *leaving the attach actions in
place* meaning the device *isn't* unplugged.

>=20
> Fixes: https://bugs.launchpad.net/qemu/+bug/1718118
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_drc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 915e9b51c4..6ad8190360 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -414,11 +414,9 @@ void spapr_drc_detach(sPAPRDRConnector *drc)
> =20
>      trace_spapr_drc_detach(spapr_drc_index(drc));
> =20
> -    g_assert(drc->dev);
> -
>      drc->unplug_requested =3D true;
> =20
> -    if (drc->state !=3D drck->empty_state) {
> +    if (!drc->dev || (drc->state !=3D drck->empty_state)) {
>          trace_spapr_drc_awaiting_quiesce(spapr_drc_index(drc));
>          return;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXRM8ACgkQbDjKyiDZ
s5LNEA//VS/dTlX9UYOAgtso9dEZS5999QFiw2X18QuKs/b6v3bYLDUBg56DLppk
TiIDLZ1cj2uD+rTSlekG69lW6sUt9q3IhrkRpvW05clfWusSNJQOYHU47Vxb57ds
fni7GeV00df01sjRgpFcGl9L+LOa/MH/r6po0fu+7Onpce6uCKUjA24EqdMnXzd+
gXqKJ20mOD3OQqe/grLJhLDPsQtWCUFcS586dKN9X33xE3QsTi+m2ZPOG5bkUKfv
xuVWoFRnwwIz4L1aImE4IAU/5wMLw7RxEGmJVFX5T2DO6MsqKTBZLBOxtWIFmroG
7IUpmNxLVSWcgT3G3t/mDTq13FSczVa402UJlT/kPfpJN9CIA2ELgmOt2msP2Dtz
cFCWVTAFTWvD4eh5XWCzGnsqToZ92FhfAd5bMU/c6ZOHUXR4uNS51bTSAmP2mF5y
9o+P2KconjvQavN/nxjXWG4D/++Pb4RiynFKTfTrVDJ2Xwyi1Pfp8wZ+ysoAoVBB
CS7koZR8SC2tRC64PXEckW1c7Q3pEr0z1tCaz545zswfXzDdFlmSR1RJ2sBzRa+P
ny0VxmpiIS3tDUwGmCzlwzjQpZEyppGE0spmHOCUwBX3dWBHgZ6f33bWIcwXpYOU
YL3XvmOymNJOLsd2y8lkX6mywzTMKVKmk9VDknwXEKUd5zYcOHc=
=B1gk
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
