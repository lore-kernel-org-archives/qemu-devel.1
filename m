Received: from eggs.gnu.org ([2001:4830:134:3::10]:35387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRuxd-0004or-Sd
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRuxa-0001bp-Pn
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 02:35:53 -0400
Date: Mon, 3 Jul 2017 16:35:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170703063515.GR13989@umbus.fritz.box>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-6-david@gibson.dropbear.id.au>
	<20170621115008.350669a0@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ZpWocbG2H/Vq+uQ"
Content-Disposition: inline
In-Reply-To: <20170621115008.350669a0@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] spapr: Use unplug_request for PCI hot
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--0ZpWocbG2H/Vq+uQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 11:50:08AM +0200, Greg Kurz wrote:
> On Tue, 20 Jun 2017 09:53:32 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > AIUI, ->unplug_request in the HotplugHandler is used for "soft"
> > unplug, where acknowledgement from the guest is required before
> > completing the unplug, whereas ->unplug is used for "hard" unplug
> > where qemu unilaterally removes the device, and the guest just has to
> > cope with its sudden absence.  For spapr we (correctly) use
> > ->unplug_request for CPU and memory hot unplug but we use ->unplug for =
=20
> > PCI.
> >=20
> > While I think it might be possible to support "hard" PCI unplug within
> > the PAPR model, that's not how it actually works now.  Although it's
> > called from ->unplug, the PCI unplug path will usually just mark the
> > device for removal, with completion of the unplug delayed until
> > userspace responds to the unplug notification. If the guest doesn't
> > respond as expected, that could delay the unplug completiong
> > arbitrarily long.
> >=20
> > To reflect that, change the PCI unplug path to be called from
> > ->unplug_request. =20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_pci.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index f2543ef..bda8938 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1469,8 +1469,8 @@ out:
> >      }
> >  }
> > =20
> > -static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
> > -                                       DeviceState *plugged_dev, Error=
 **errp)
> > +static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
> > +                                     DeviceState *plugged_dev, Error *=
*errp)
> >  {
> >      sPAPRPHBState *phb =3D SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
> >      PCIDevice *pdev =3D PCI_DEVICE(plugged_dev);
> > @@ -1485,6 +1485,7 @@ static void spapr_phb_hot_unplug_child(HotplugHan=
dler *plug_handler,
> >      }
> > =20
> >      g_assert(drc);
> > +    g_assert(drc->dev =3D=3D plugged_dev);
> > =20
> >      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> >      if (!drck->release_pending(drc)) {
> > @@ -1973,7 +1974,7 @@ static void spapr_phb_class_init(ObjectClass *kla=
ss, void *data)
> >      dc->user_creatable =3D true;
> >      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >      hp->plug =3D spapr_phb_hot_plug_child;
>=20
> Maybe you can rename spapr_phb_hot_plug_child() to spapr_pci_plug() for
> consistency ?

Good idea.  I've made that change.

>=20
> Anyway,
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > -    hp->unplug =3D spapr_phb_hot_unplug_child;
> > +    hp->unplug_request =3D spapr_pci_unplug_request;
> >  }
> > =20
> >  static const TypeInfo spapr_phb_info =3D {
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0ZpWocbG2H/Vq+uQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZWeWhAAoJEGw4ysog2bOScJ0QAMFaSaoLo9yJ89ONnkMZIW/n
opc8j3d02kvAgdb61/IsaqGXxYi3uxuO5Rh6qez2zp045r+/3zJxIbgeqRRzCbXi
1uByo8ufKDzFfZiwFWLu5RvoAojztaFYlKTr1IAmjPwtgtjsZWUfZsUTCvNgobqX
TrFlkWk2tKatBPdTVCiFJ4zZuH/p8ahyWgHW+PTI+X8CW5UP83q7SbeQ9FKeugQR
PxrTG62a6GW5VHS17cnQXwNPmOHc9rdkYRV6Eb2hy/AyK8/hM6TMXwvMsl43mkU/
/+Va4cXFFcX9OnuY4+UciBImEr+FGtUhnBi3TKRAQ+dqxexykVHkCVK01OYT0ykN
pHge1dglnqCTRMlN3vatcBt2Bckzt3DjlTc3L8RYdZ18DNpyQR6LEkKMGOb33TC8
pNx0TSYkX15NMZcWsQcL6F9E5TAX03OxNxzvLfaimGiYxW1lKvdTLwq6TsK4USXG
2GfQn0EqPt2HPPc5lbouL5SrQqcfsxhqKYMag1wcLVDNsHxqjfg5vVX02UWCdS8v
CP0+gUr7GMGv6A0Rcy7AVwjEu+koK1zxzfaFlVlTcz6Nr+/NaXEhycV1VI0aUQD+
PZEfdnlLLESJOJoxVmw9OP9zSqeMmimxP6F9f6dEj53od+D703YVMW5ak8PdD83u
W4+HTHaX/Rwsjf7DkdLR
=SU+T
-----END PGP SIGNATURE-----

--0ZpWocbG2H/Vq+uQ--
