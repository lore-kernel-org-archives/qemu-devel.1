Received: from eggs.gnu.org ([2001:4830:134:3::10]:43813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daMoJ-0001em-U0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daMoG-0001Eg-TK
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:57:12 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:49702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daMoG-0001EA-N1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:57:08 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9E5E11161E0
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 15:57:05 +0200 (CEST)
Date: Wed, 26 Jul 2017 15:56:53 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726155653.234fb967@bahia.lan>
In-Reply-To: <98e260fa-cb10-3d02-e240-7d7bc2a61fd2@ozlabs.ru>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100555881.27487.6700589734222986048.stgit@bahia>
	<98e260fa-cb10-3d02-e240-7d7bc2a61fd2@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WkDW6Eb8/TJhnf3DF1lrxTU";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 06/26] spapr_pci:
 parent the MSI memory region to the PHB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/WkDW6Eb8/TJhnf3DF1lrxTU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 14:29:26 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 26/07/17 03:59, Greg Kurz wrote:
> > This memory region should be owned by the PHB. This ensures the PHB
> > cannot be finalized as long as the the region is guest visible, or
> > used by a CPU or a device. =20
>=20
> Out of curiosity - does it really ensure this? Passing a parent to
> memory_region_init_io() adds a reference to a child (i.e. "msi" region),
> not to the PHB object.=20

You're right, being owner of the MR means the PHB is parent and takes
a reference on the MR. But it also means a reference on the PHB is
taken/dropped each time the MR gets referenced/unreferenced (ie, "guest
visible or used by a CPU or a device").

> It is probably a good thing to have an owner for
> every MR anyway, I am just not sure about the commit log, what does not
> work if you do not do this?
>=20

The PHB could theorically get unrealized while the MSI region is still acti=
ve.
But since the associated MMIO op spapr_msi_write() only uses the machine
object and not the PHB, I admit I don't have a scenario where this could
break something...

So even if doesn't fix anything obvious, as you say, it is probably a good
thing to have an owner for every MR anyway :)

>=20
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_pci.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 3fe7f3145467..4e4165b44b9a 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1703,7 +1703,7 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >      }
> >  #endif
> > =20
> > -    memory_region_init_io(&sphb->msiwindow, NULL, &spapr_msi_ops, spap=
r,
> > +    memory_region_init_io(&sphb->msiwindow, OBJECT(sphb), &spapr_msi_o=
ps, spapr,
> >                            "msi", msi_window_size);
> >      memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MSI_WINDO=
W,
> >                                  &sphb->msiwindow);
> >=20
> >  =20
>=20
>=20


--Sig_/WkDW6Eb8/TJhnf3DF1lrxTU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4n6UACgkQAvw66wEB28KE5wCgmvKoDhUM44vL6K3CoRobFTyu
dJsAmwQFiMGcyj07afs6bJyK6cQBN6jl
=Yf7t
-----END PGP SIGNATURE-----

--Sig_/WkDW6Eb8/TJhnf3DF1lrxTU--
