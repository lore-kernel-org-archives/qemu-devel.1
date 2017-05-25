Received: from eggs.gnu.org ([2001:4830:134:3::10]:51877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjGR-0002zh-Fp
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjGP-0002T7-Sv
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:16:39 -0400
Date: Thu, 25 May 2017 13:16:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170525031626.GF12929@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
	<20170524121402.50e62a75@nial.brq.redhat.com>
	<20170524175410.088f3285@bahia.ttt.fr.ibm.com>
	<33b6ab16-961b-2ba6-17b9-6667cd00a0fc@redhat.com>
	<149564763741.3207.16474489064736097451@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <149564763741.3207.16474489064736097451@loki>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] spapr: disable hotplugging
 without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 12:40:37PM -0500, Michael Roth wrote:
> Quoting Laurent Vivier (2017-05-24 11:02:30)
> > On 24/05/2017 17:54, Greg Kurz wrote:
> > > On Wed, 24 May 2017 12:14:02 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >=20
> > >> On Wed, 24 May 2017 11:28:57 +0200
> > >> Greg Kurz <groug@kaod.org> wrote:
> > >>
> > >>> On Wed, 24 May 2017 15:07:54 +1000
> > >>> David Gibson <david@gibson.dropbear.id.au> wrote:
> > >>>  =20
> > >>>> On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote:   =
=20
> > >>>>> If the OS is not started, QEMU sends an event to the OS
> > >>>>> that is lost and cannot be recovered. An unplug is not
> > >>>>> able to restore QEMU in a coherent state.
> > >>>>> So, while the OS is not started, disable CPU and memory hotplug.
> > >>>>> We use option vector 6 to know if the OS is started
> > >>>>>
> > >>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>     =20
> > >>>>
> > >>>> Urgh.. I'm not terribly confident that this is really correct.  As
> > >>>> discussed on the previous patch, you're essentially using OV6 as a
> > >>>> flag that CAS is complete.
> > >>>>
> > >>>> But while it undoubtedly makes the race window much smaller, I don=
't
> > >>>> see that there's any guarantee the guest OS will really be able to
> > >>>> handle hotplug events immediately after CAS.
> > >>>>
> > >>>> In particular if the CAS process completes partially but then need=
s to
> > >>>> trigger a reboot, I think that would end up setting the ov6 variab=
le,
> > >>>> but the OS would definitely not be in a state to accept events. =
=20
> > >> wouldn't guest on reboot pick up updated fdt and online hotplugged
> > >> before crash cpu along with initial cpus?
> > >>
> > >=20
> > > Yes and that's what actually happens with cpus.
> > >=20
> > > But catching up with the background for this series, I have the
> > > impression that the issue isn't the fact we loose an event if the OS
> > > isn't started (which is not true), but more something wrong happening
> > > when hotplugging+unplugging memory as described in this commit:
> > >=20
> > > commit fe6824d12642b005c69123ecf8631f9b13553f8b
> > > Author: Laurent Vivier <lvivier@redhat.com>
> > > Date:   Tue Mar 28 14:09:34 2017 +0200
> > >=20
> > >     spapr: fix memory hot-unplugging
> > >=20
> >=20
> > Yes, this commit try to fix that, but it's not possible. Some objects
> > remain in memory: you can see with "info cpus" or "info memory-devices"
> > that they are not really removed, and this prevents to hotplug them
> > again, and moreover in the case of the memory hot-unplug we can rerun
> > the device_del and crash qemu (as before the fix).
> >=20
> > Moreover all stuff normally cleared in detach() are not, and we can't do
> > it later in set_allocation_state() because some are in use by the
> > kernel, and this is the last call from the kernel.
>=20
> Focusing on the hotplug/add case, it's a bit odd that the guest would be
> using the memory even though the hotplug event is clearly still sitting
> in the queue.
>=20
> I think part of the issue is us not having a clear enough distinction in
> the code between what constitutes the need for "boot-time" handling vs.
> "hotplug" handling.
>=20
> We have this hook in spapr_add_lmbs:
>=20
>     if (!dev->hotplugged) {
>         /* guests expect coldplugged LMBs to be pre-allocated */
>         drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
>         drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATE=
D);
>     }
>=20
> Whereas the default allocation/isolation state for LMBs in spapr_drc.c is
> UNUSABLE/ISOLATED, which is what covers the dev->hotplugged =3D=3D true c=
ase.
>=20
> I need to spend some time testing to confirm, but trying to walk through =
the
> various scenarios looking at the code:
>=20
> case 1)
>=20
> If the hotplug occurs before reset (not sure how likely this is), the eve=
nt
> will get dropped by reset handler, and the DRC stuff will be left in
> UNUSABLE/ISOLATED. I think it's more appropriate to treat this as "boot-t=
ime"
> and set it to USABLE/UNISOLATED like the !dev->hotplugged case.

Right.  It looks like we might need to go through all DRCs and sanitize
their state at reset time.  Essentially whatever their state before
the reset, they should appear as cold-plugged after the reset, I
think.

> case 2)
>=20
> If the hotplug it occurs after reset, but before CAS,
> spapr_populate_drconf_memory will be called to populate the DT with all a=
ctive
> LMBs. AFAICT, for hotplugged LMBs it marks everything where
> memory_region_preset(get_system_memory(), addr) =3D=3D true as
> SPAPR_LMB_FLAGS_ASSIGNED. Since the region is mapped regardless of whethe=
r the
> guest has acknowledged the hotplug, I think this would end up presenting =
the
> LMB as having been present at boot-time. However, they will still be in t=
he
> UNUSABLE/ISOLATED state because dev->hotplugged =3D=3D true.
>=20
> I would think that the delayed hotplug event would move them to the appro=
priate
> state later, allowing the unplug to succeed later, but it totally possibl=
e the
> guest code bails out during the hotplug path since it already has the LMB=
 marked
> as being in use via the CAS-generated DT.
>=20
> So it seems like we need to either:
>=20
> a) not mark these LMBs as SPAPR_LMB_FLAGS_ASSIGNED in the DT and let them=
 get
> picked up by the deferred hotplug event (which seems to also be in need o=
f an
> extra IRQ pulse given that it's not getting picked up till later), or
>=20
> b) let them get picked up as boot-time LMBs and add a CAS hook to move the
> state to USABLE/UNISOLATED at that point. optionally we could also purge =
any
> pending hotplug events from the event queue but that gets weird if we have
> subsequent unplug events and whatnot sitting there as well. Hopefully let=
ting
> guest process the hotplug event later and possible fail still leaves us in
> a recoverable state where we can still complete the unplug after boot.
>=20
> Does this seem like an accurate assessment of the issues you're seeing?

It seems plausible from my limited understanding of the situation.
The variety of possible state transitions in the PAPR hotplug model
hurts my brain.

I think plan (a) sounds simpler than plan (b).  Basically any hotplug
events that occur between reset and CAS we want to queue until CAS is
complete.  AIUI we're already effectively queuing the event that goes
to the guest, but we've already - incorrectly - made some qemu side
state changes that show up in the DT fragments handed out by CAS.

Can we just in general postpone the qemu side updates until the
hotplug event is presented to the guest, rather than when it's
submitted from the host?  Or will that raise a different bunch of problems?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJkyIAAoJEGw4ysog2bOS1mYQAMEvm3u6/jESp3M5XYgM7vSZ
mauPUiAvxExHFFe9cttnZL+qzei+HEbCf2R2BGsJL5WBiT/NHWr7J8wQT4+GTwVF
uyKXsRbjVsIUtg6YY1WX2yFZt2ccfbDJ63/WtRB8XWwuwBZujTetFEPOueGypHhg
BChgbF/KNXRzQmcySHyDxRJ4NgNrMCvHY8nlnrn3/Hd4hQMnQBilrGR07vsEN+g9
h4BoLklq0RXnwhU7305KaEd8VQ5UN6PY5EFamkakc9eMBEGqWVXm0fHhX3eG3P5G
4kLi3kXrSYav18mT4Mu3z5RyokX9YeIaBEMdcFLvzxBaK2SR+dDXQ1Bei7qKCHNp
0pZE06DfSRbczcT/TacyHBHVG07wm58pAUP+Gadv8yCiIHyJ8NIDgR1BWNyFetd1
gUfx2/pv/vdkX7e4YkcOBbVvbAH4HmbVyxUx1Nx9Jga1cFZPx/03aP7Y5WKBSI7v
IVWROjd0l+K8MnZllTUm6vNxPg3KOIVSCSAI9UbMtUAl+wTBSpQfitEKfNZHBCA7
eQ09dRYrX/5sPcUWnj6IuOq1tYK/e0ok5Bljsevaxynxn8iNipmE4IqdHEZTiyWu
4YyPuBt0luaQqv87bThy/pDBTkdqOf1ypxFd54Bkusb043Db2t1tVBmjB47qWHxl
jGoWfxJWZfbnd995zx7Z
=ip5N
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
