Received: from eggs.gnu.org ([2001:4830:134:3::10]:55671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6Iaf-0000uK-Lh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6Iae-0007Ki-DQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:49 -0400
Date: Thu, 4 May 2017 17:27:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170504072707.GD14413@umbus.fritz.box>
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
	<820e7037-13a7-c478-e119-ed64599cb3cb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <820e7037-13a7-c478-e119-ed64599cb3cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/ppc: removing spapr_drc_detach_cb
 opaques
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 04:33:56PM +0200, Laurent Vivier wrote:
> On 30/04/2017 19:25, Daniel Henrique Barboza wrote:
> > Following up the previous detach_cb change, this patch removes the
> > detach_cb_opaque entirely from the code.
> >=20
> > The reason is that the drc->detach_cb_opaque object can't be
> > restored in the post load of the upcoming DRC migration and no detach
> > callbacks actually need this opaque. 'spapr_core_release' is
> > receiving it as NULL, 'spapr_phb_remove_pci_device_cb' is receiving
> > a phb object as opaque but is't using it. These were trivial removal
> > cases.
> >=20
> > However, the LM removal callback 'spapr_lmb_release' is receiving
> > and using the opaque object, a 'sPAPRDIMMState' struct. This struct
> > holds the number of LMBs the DIMM object contains and the callback
> > was using this counter as a countdown to check if all LMB DRCs were
> > release before proceeding to the DIMM unplug. To remove the need of
> > this callback we have choices such as:
> >=20
> > - migrate the 'sPAPRDIMMState' struct. This would require creating a
> > QTAILQ to store all DIMMStates and an additional 'dimm_id' field to
> > associate the DIMMState with the DIMM object. We could attach this
> > QTAILQ to the 'sPAPRPHBState' and retrieve it later in the callback.
> >=20
>=20
> Did you think about adding the nr_lmbs into PCDIMMDevice structure?

I think that's unlikely to fly, because it's very platform specific
state to put into the supposedly general DIMM object.

> Or to create a SPAPRPCDIMMDevice with PCDIMMDevice parent_obj and
> nr_lmbs field we can retrieve from the DeviceState pointer?

I wondered about that.  In some ways it is the simplest way forward;
however it means the user (and/or libvirt) has to be aware that they
need an spapr dimm not a pc-dimm for this platform, which is pretty
awful UX.

Plus, if we were going to have an SPAPR specific way of handling
memory hotplug, I'd prefer to really base it on sPAPR, which would let
us get rid of a bunch of the ugly glue between DIMMs and LMBs.

>=20
> I don't know if it is a good idea or an acceptable way to do that, but
> I'd like to know if you have thought about that.
>=20
> Thanks,
> Laurent
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCtfLAAoJEGw4ysog2bOS2NoP/iHBne7WJ50jycThDTM1MjRu
Od7mV+O5tFS8YHPiQIfk/fdTQ2689K7i22tFmc/2kvSBQbdkeUgBX/03rcKyfwmZ
fc5pFq9i2AHZuQAQABL8jh152txD71Pfwec4QFYEdxpCVmNgwsJ+M7/wdxAJRFPK
NIWBDBvwzvsTN8g0VAiGVYFxS2+aNg0BjSmCRZxJGBEVtUWsUFwxDorL8Pcw8eEX
BhiaJHfOSfVkhVhNGsGlWc3EyzIn4PezC9fuY4Y8pjsFGqYqHFuHlCUBMS0ax7fH
VZH74nPwIuHIMBim+WmrrwysPJvnmuFyibjFI12H0BGFsxeO1Z4v9s63AImDFvuv
xEZ9isEcBX9WlTJoyNex6pcqTHcFnE7QPb4+B+FKWSkTi5Mh84vrhIxVzn53+5Zm
JwiE/L49H7N1cO7yIJBl0pl8KV/OpB8NxIO/610CsxFRpVrlgI4Po5vZnu76D190
ez032B9il1v9jz8FHETx7Y4DygYNzwCmjU/UGcpqFyAtVGNuk8p1Il2kEPzujh01
q3M5hV5CuaYMl6Qx79XadteCbBbJ024nrZ25mO004ow2bDe3tldKMtFSxS7metne
9NI/XvJe3ZRMM00D+rX/201DYsDGI4iyNxebZ1Is0ZK02TAY6LPFN6cTDfENp7ge
ze2MYjCt/EejFvbHwJPQ
=TXa6
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
