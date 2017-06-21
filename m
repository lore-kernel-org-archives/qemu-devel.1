Received: from eggs.gnu.org ([2001:4830:134:3::10]:48935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNcHE-0001nL-L9
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNcHB-000149-Iz
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:50:20 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:40895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNcHB-00013m-Bb
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:50:17 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 72C4610875F
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 11:50:15 +0200 (CEST)
Date: Wed, 21 Jun 2017 11:50:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170621115008.350669a0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170620015332.13874-6-david@gibson.dropbear.id.au>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-6-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/jQiXn_JqqBoQ_sO9Eio/xXj";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/jQiXn_JqqBoQ_sO9Eio/xXj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2017 09:53:32 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> AIUI, ->unplug_request in the HotplugHandler is used for "soft"
> unplug, where acknowledgement from the guest is required before
> completing the unplug, whereas ->unplug is used for "hard" unplug
> where qemu unilaterally removes the device, and the guest just has to
> cope with its sudden absence.  For spapr we (correctly) use
> ->unplug_request for CPU and memory hot unplug but we use ->unplug for =20
> PCI.
>=20
> While I think it might be possible to support "hard" PCI unplug within
> the PAPR model, that's not how it actually works now.  Although it's
> called from ->unplug, the PCI unplug path will usually just mark the
> device for removal, with completion of the unplug delayed until
> userspace responds to the unplug notification. If the guest doesn't
> respond as expected, that could delay the unplug completiong
> arbitrarily long.
>=20
> To reflect that, change the PCI unplug path to be called from
> ->unplug_request. =20
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_pci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index f2543ef..bda8938 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1469,8 +1469,8 @@ out:
>      }
>  }
> =20
> -static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
> -                                       DeviceState *plugged_dev, Error *=
*errp)
> +static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
> +                                     DeviceState *plugged_dev, Error **e=
rrp)
>  {
>      sPAPRPHBState *phb =3D SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
>      PCIDevice *pdev =3D PCI_DEVICE(plugged_dev);
> @@ -1485,6 +1485,7 @@ static void spapr_phb_hot_unplug_child(HotplugHandl=
er *plug_handler,
>      }
> =20
>      g_assert(drc);
> +    g_assert(drc->dev =3D=3D plugged_dev);
> =20
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>      if (!drck->release_pending(drc)) {
> @@ -1973,7 +1974,7 @@ static void spapr_phb_class_init(ObjectClass *klass=
, void *data)
>      dc->user_creatable =3D true;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      hp->plug =3D spapr_phb_hot_plug_child;

Maybe you can rename spapr_phb_hot_plug_child() to spapr_pci_plug() for
consistency ?

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

> -    hp->unplug =3D spapr_phb_hot_unplug_child;
> +    hp->unplug_request =3D spapr_pci_unplug_request;
>  }
> =20
>  static const TypeInfo spapr_phb_info =3D {


--Sig_/jQiXn_JqqBoQ_sO9Eio/xXj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllKQVAACgkQAvw66wEB28JijACfWO9JuhOphNwjAEW/G7jkHBCH
SAsAoIsoHMD4ObUVzBOZpYqVZuU46xRj
=sq4o
-----END PGP SIGNATURE-----

--Sig_/jQiXn_JqqBoQ_sO9Eio/xXj--
