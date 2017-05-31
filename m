Received: from eggs.gnu.org ([2001:4830:134:3::10]:55741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFxFa-0008Ev-9m
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFxFW-0005J4-EI
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:36:58 -0400
Date: Wed, 31 May 2017 16:36:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170531063634.GM12163@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
	<20170524121402.50e62a75@nial.brq.redhat.com>
	<20170524175410.088f3285@bahia.ttt.fr.ibm.com>
	<33b6ab16-961b-2ba6-17b9-6667cd00a0fc@redhat.com>
	<149564763741.3207.16474489064736097451@loki>
	<20170525031626.GF12929@umbus.fritz.box>
	<149616455981.3207.7389722411843701645@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5V5c01chtBAiSHoy"
Content-Disposition: inline
In-Reply-To: <149616455981.3207.7389722411843701645@loki>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>


--5V5c01chtBAiSHoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 12:15:59PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-05-24 22:16:26)
> > On Wed, May 24, 2017 at 12:40:37PM -0500, Michael Roth wrote:
> > > Quoting Laurent Vivier (2017-05-24 11:02:30)
> > > > On 24/05/2017 17:54, Greg Kurz wrote:
> > > > > On Wed, 24 May 2017 12:14:02 +0200
> > > > > Igor Mammedov <imammedo@redhat.com> wrote:
> > > > >=20
> > > > >> On Wed, 24 May 2017 11:28:57 +0200
> > > > >> Greg Kurz <groug@kaod.org> wrote:
> > > > >>
> > > > >>> On Wed, 24 May 2017 15:07:54 +1000
> > > > >>> David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >>>  =20
> > > > >>>> On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote=
:   =20
> > > > >>>>> If the OS is not started, QEMU sends an event to the OS
> > > > >>>>> that is lost and cannot be recovered. An unplug is not
> > > > >>>>> able to restore QEMU in a coherent state.
> > > > >>>>> So, while the OS is not started, disable CPU and memory hotpl=
ug.
> > > > >>>>> We use option vector 6 to know if the OS is started
> > > > >>>>>
> > > > >>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>     =20
> > > > >>>>
> > > > >>>> Urgh.. I'm not terribly confident that this is really correct.=
  As
> > > > >>>> discussed on the previous patch, you're essentially using OV6 =
as a
> > > > >>>> flag that CAS is complete.
> > > > >>>>
> > > > >>>> But while it undoubtedly makes the race window much smaller, I=
 don't
> > > > >>>> see that there's any guarantee the guest OS will really be abl=
e to
> > > > >>>> handle hotplug events immediately after CAS.
> > > > >>>>
> > > > >>>> In particular if the CAS process completes partially but then =
needs to
> > > > >>>> trigger a reboot, I think that would end up setting the ov6 va=
riable,
> > > > >>>> but the OS would definitely not be in a state to accept events=
=2E =20
> > > > >> wouldn't guest on reboot pick up updated fdt and online hotplugg=
ed
> > > > >> before crash cpu along with initial cpus?
> > > > >>
> > > > >=20
> > > > > Yes and that's what actually happens with cpus.
> > > > >=20
> > > > > But catching up with the background for this series, I have the
> > > > > impression that the issue isn't the fact we loose an event if the=
 OS
> > > > > isn't started (which is not true), but more something wrong happe=
ning
> > > > > when hotplugging+unplugging memory as described in this commit:
> > > > >=20
> > > > > commit fe6824d12642b005c69123ecf8631f9b13553f8b
> > > > > Author: Laurent Vivier <lvivier@redhat.com>
> > > > > Date:   Tue Mar 28 14:09:34 2017 +0200
> > > > >=20
> > > > >     spapr: fix memory hot-unplugging
> > > > >=20
> > > >=20
> > > > Yes, this commit try to fix that, but it's not possible. Some objec=
ts
> > > > remain in memory: you can see with "info cpus" or "info memory-devi=
ces"
> > > > that they are not really removed, and this prevents to hotplug them
> > > > again, and moreover in the case of the memory hot-unplug we can rer=
un
> > > > the device_del and crash qemu (as before the fix).
> > > >=20
> > > > Moreover all stuff normally cleared in detach() are not, and we can=
't do
> > > > it later in set_allocation_state() because some are in use by the
> > > > kernel, and this is the last call from the kernel.
> > >=20
> > > Focusing on the hotplug/add case, it's a bit odd that the guest would=
 be
> > > using the memory even though the hotplug event is clearly still sitti=
ng
> > > in the queue.
> > >=20
> > > I think part of the issue is us not having a clear enough distinction=
 in
> > > the code between what constitutes the need for "boot-time" handling v=
s.
> > > "hotplug" handling.
> > >=20
> > > We have this hook in spapr_add_lmbs:
> > >=20
> > >     if (!dev->hotplugged) {
> > >         /* guests expect coldplugged LMBs to be pre-allocated */
> > >         drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USA=
BLE);
> > >         drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISO=
LATED);
> > >     }
> > >=20
> > > Whereas the default allocation/isolation state for LMBs in spapr_drc.=
c is
> > > UNUSABLE/ISOLATED, which is what covers the dev->hotplugged =3D=3D tr=
ue case.
> > >=20
> > > I need to spend some time testing to confirm, but trying to walk thro=
ugh the
> > > various scenarios looking at the code:
> > >=20
> > > case 1)
> > >=20
> > > If the hotplug occurs before reset (not sure how likely this is), the=
 event
> > > will get dropped by reset handler, and the DRC stuff will be left in
> > > UNUSABLE/ISOLATED. I think it's more appropriate to treat this as "bo=
ot-time"
> > > and set it to USABLE/UNISOLATED like the !dev->hotplugged case.
> >=20
> > Right.  It looks like we might need to go through all DRCs and sanitize
> > their state at reset time.  Essentially whatever their state before
> > the reset, they should appear as cold-plugged after the reset, I
> > think.
> >=20
> > > case 2)
> > >=20
> > > If the hotplug it occurs after reset, but before CAS,
> > > spapr_populate_drconf_memory will be called to populate the DT with a=
ll active
> > > LMBs. AFAICT, for hotplugged LMBs it marks everything where
> > > memory_region_preset(get_system_memory(), addr) =3D=3D true as
> > > SPAPR_LMB_FLAGS_ASSIGNED. Since the region is mapped regardless of wh=
ether the
> > > guest has acknowledged the hotplug, I think this would end up present=
ing the
> > > LMB as having been present at boot-time. However, they will still be =
in the
> > > UNUSABLE/ISOLATED state because dev->hotplugged =3D=3D true.
> > >=20
> > > I would think that the delayed hotplug event would move them to the a=
ppropriate
> > > state later, allowing the unplug to succeed later, but it totally pos=
sible the
> > > guest code bails out during the hotplug path since it already has the=
 LMB marked
> > > as being in use via the CAS-generated DT.
> > >=20
> > > So it seems like we need to either:
> > >=20
> > > a) not mark these LMBs as SPAPR_LMB_FLAGS_ASSIGNED in the DT and let =
them get
> > > picked up by the deferred hotplug event (which seems to also be in ne=
ed of an
> > > extra IRQ pulse given that it's not getting picked up till later), or
> > >=20
> > > b) let them get picked up as boot-time LMBs and add a CAS hook to mov=
e the
> > > state to USABLE/UNISOLATED at that point. optionally we could also pu=
rge any
> > > pending hotplug events from the event queue but that gets weird if we=
 have
> > > subsequent unplug events and whatnot sitting there as well. Hopefully=
 letting
> > > guest process the hotplug event later and possible fail still leaves =
us in
> > > a recoverable state where we can still complete the unplug after boot.
> > >=20
> > > Does this seem like an accurate assessment of the issues you're seein=
g?
> >=20
> > It seems plausible from my limited understanding of the situation.
> > The variety of possible state transitions in the PAPR hotplug model
> > hurts my brain.
> >=20
> > I think plan (a) sounds simpler than plan (b).  Basically any hotplug
> > events that occur between reset and CAS we want to queue until CAS is
> > complete.  AIUI we're already effectively queuing the event that goes
> > to the guest, but we've already - incorrectly - made some qemu side
> > state changes that show up in the DT fragments handed out by CAS.
>=20
> I agree. The one thing I'm a bit iffy on is why the guest is missing
> the interrupt (or handling at least) for the initially-queued events;
> if we go this route we need to make sure the guest acts on them as part
> of boot.
>=20
> I assume pending interrupts get dropped by CAS because the guest doesn't
> initialize the hotplug interrupt handler until that point. If that's the
> case, a CAS hook to scan through the event queue to re-signal if needed
> would hopefully do the trick, but I'm still a bit uncertain about whether
> that's sufficient.

Have we confirmed that events are actually being dropped here, it's
not just that once the guest gets to them other state is incorrect
meaning they don't get processed as expected?

> If it's something we can't do deterministically, we might need to consider
> plan (b).
>=20
> >=20
> > Can we just in general postpone the qemu side updates until the
> > hotplug event is presented to the guest, rather than when it's
> > submitted from the host?  Or will that raise a different bunch of probl=
ems?
>=20
> It seems like that might be problematic for migration.

Why?  We're now migrating the contents of the event queue...

> Not updating the device tree with LMBs still pending delivery of hotplug
> event during CAS seems fairly easy. We generate a new DT fragment for
> the LMB at hp time anyways, so I think we can safely "throw away" the
> updates and not worry about tracking any additional intermediate state.
>=20
> Going to the extent of delaying the call to pc_dimm_memory_plug would be
> problematic though I think. We would need a hook to make sure the call
> is made if CAS completes after migration, and for cases where we do
> migration by re-creating DIMMs via cmdline, we'd need some way to
> synchonize state for these "pending" DIMMs, else that deferred call to
> pc_dimm_memory_plug will probably generate errors due to duplicate
> DIMM mappings (and if we relax/ignore those errors we still have the
> original issue with CAS picking up the LMBs prematurely). This ends up
> seeming really similar to the stuff that necessitated DRC migration,
> which we probably want to avoid if possible.

Hm, ok.  My brain hurts.  Any thoughts on what the next logical step
should be?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5V5c01chtBAiSHoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLmRyAAoJEGw4ysog2bOSBXUP/35gNpyk/yjSMUCD1W3RxUNE
JxojbZPWTI0Lr4sYNPCZakmsc4hdiHoPfV7V1Q5wSfz7T6ePDamHYV7trcgeCZc3
4PKGdZGmRMLc7QrtUjg/T/E/VzHmDaRjvjOyEp0F2lb1Griv4tC+2ENvkNoMTGwL
0oofUGntbgg+nq18bGYKwAE98gEkYdSYs4VYf4pi8IzS+L1GOq2BvT3mp5f1M0oE
7LUa9f6BKT1CUsplO5rlJ2XyGCIf1V8KHYdiynG0zlegS40keG20UowVvLwIXedZ
Pmj+dxnF3QCQ+sDfmcdOgPfp+622eYQGEQ9hCxgi4803E0H2Kx71Z9NEj3HJGKrC
NuyVuGfd0DuAUGxnlh21dzuIXMZVu7llk27EdtGQ+sBPTj4TFbfV8nw7bNKycs2w
Ci47u/r5K+7j3bW0uFfg85+0rk/pG4/4ADCxTXp8qzptETtXRTIJIfhaygjl2GMd
7I/lGgsedXrK6cWfJUFHBjATrBHmK/xZWFSeIPGkZzKPiVjFYRA4Wb4oPFdVb7xY
5piHY+zhrSF2urowSSTNkXgGiyZZUNrAq4HVAXgG/YQv3vE4mLCow5yHxqhmEGKM
LHf/EU7nfTrAmMPNDDpbqnSoug90A6geefIyne6N00SipJpMbFyM87YEesMrQDnK
DtlZE1dP7062qXhjMnXi
=XkZd
-----END PGP SIGNATURE-----

--5V5c01chtBAiSHoy--
