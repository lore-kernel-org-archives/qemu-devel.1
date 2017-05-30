Received: from eggs.gnu.org ([2001:4830:134:3::10]:49967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dFkkh-0002H5-ME
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dFkkc-00059N-CQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:16:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dFkkc-00058M-3i
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:16:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UHDgkZ139271
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:16:07 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ascnj0wj6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:16:07 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 30 May 2017 11:16:06 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170525031626.GF12929@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
	<20170524121402.50e62a75@nial.brq.redhat.com>
	<20170524175410.088f3285@bahia.ttt.fr.ibm.com>
	<33b6ab16-961b-2ba6-17b9-6667cd00a0fc@redhat.com>
	<149564763741.3207.16474489064736097451@loki>
	<20170525031626.GF12929@umbus.fritz.box>
Date: Tue, 30 May 2017 12:15:59 -0500
Message-Id: <149616455981.3207.7389722411843701645@loki>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Quoting David Gibson (2017-05-24 22:16:26)
> On Wed, May 24, 2017 at 12:40:37PM -0500, Michael Roth wrote:
> > Quoting Laurent Vivier (2017-05-24 11:02:30)
> > > On 24/05/2017 17:54, Greg Kurz wrote:
> > > > On Wed, 24 May 2017 12:14:02 +0200
> > > > Igor Mammedov <imammedo@redhat.com> wrote:
> > > > =

> > > >> On Wed, 24 May 2017 11:28:57 +0200
> > > >> Greg Kurz <groug@kaod.org> wrote:
> > > >>
> > > >>> On Wed, 24 May 2017 15:07:54 +1000
> > > >>> David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >>>   =

> > > >>>> On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote: =
   =

> > > >>>>> If the OS is not started, QEMU sends an event to the OS
> > > >>>>> that is lost and cannot be recovered. An unplug is not
> > > >>>>> able to restore QEMU in a coherent state.
> > > >>>>> So, while the OS is not started, disable CPU and memory hotplug.
> > > >>>>> We use option vector 6 to know if the OS is started
> > > >>>>>
> > > >>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>      =

> > > >>>>
> > > >>>> Urgh.. I'm not terribly confident that this is really correct.  =
As
> > > >>>> discussed on the previous patch, you're essentially using OV6 as=
 a
> > > >>>> flag that CAS is complete.
> > > >>>>
> > > >>>> But while it undoubtedly makes the race window much smaller, I d=
on't
> > > >>>> see that there's any guarantee the guest OS will really be able =
to
> > > >>>> handle hotplug events immediately after CAS.
> > > >>>>
> > > >>>> In particular if the CAS process completes partially but then ne=
eds to
> > > >>>> trigger a reboot, I think that would end up setting the ov6 vari=
able,
> > > >>>> but the OS would definitely not be in a state to accept events.  =

> > > >> wouldn't guest on reboot pick up updated fdt and online hotplugged
> > > >> before crash cpu along with initial cpus?
> > > >>
> > > > =

> > > > Yes and that's what actually happens with cpus.
> > > > =

> > > > But catching up with the background for this series, I have the
> > > > impression that the issue isn't the fact we loose an event if the OS
> > > > isn't started (which is not true), but more something wrong happeni=
ng
> > > > when hotplugging+unplugging memory as described in this commit:
> > > > =

> > > > commit fe6824d12642b005c69123ecf8631f9b13553f8b
> > > > Author: Laurent Vivier <lvivier@redhat.com>
> > > > Date:   Tue Mar 28 14:09:34 2017 +0200
> > > > =

> > > >     spapr: fix memory hot-unplugging
> > > > =

> > > =

> > > Yes, this commit try to fix that, but it's not possible. Some objects
> > > remain in memory: you can see with "info cpus" or "info memory-device=
s"
> > > that they are not really removed, and this prevents to hotplug them
> > > again, and moreover in the case of the memory hot-unplug we can rerun
> > > the device_del and crash qemu (as before the fix).
> > > =

> > > Moreover all stuff normally cleared in detach() are not, and we can't=
 do
> > > it later in set_allocation_state() because some are in use by the
> > > kernel, and this is the last call from the kernel.
> > =

> > Focusing on the hotplug/add case, it's a bit odd that the guest would be
> > using the memory even though the hotplug event is clearly still sitting
> > in the queue.
> > =

> > I think part of the issue is us not having a clear enough distinction in
> > the code between what constitutes the need for "boot-time" handling vs.
> > "hotplug" handling.
> > =

> > We have this hook in spapr_add_lmbs:
> > =

> >     if (!dev->hotplugged) {
> >         /* guests expect coldplugged LMBs to be pre-allocated */
> >         drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABL=
E);
> >         drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLA=
TED);
> >     }
> > =

> > Whereas the default allocation/isolation state for LMBs in spapr_drc.c =
is
> > UNUSABLE/ISOLATED, which is what covers the dev->hotplugged =3D=3D true=
 case.
> > =

> > I need to spend some time testing to confirm, but trying to walk throug=
h the
> > various scenarios looking at the code:
> > =

> > case 1)
> > =

> > If the hotplug occurs before reset (not sure how likely this is), the e=
vent
> > will get dropped by reset handler, and the DRC stuff will be left in
> > UNUSABLE/ISOLATED. I think it's more appropriate to treat this as "boot=
-time"
> > and set it to USABLE/UNISOLATED like the !dev->hotplugged case.
> =

> Right.  It looks like we might need to go through all DRCs and sanitize
> their state at reset time.  Essentially whatever their state before
> the reset, they should appear as cold-plugged after the reset, I
> think.
> =

> > case 2)
> > =

> > If the hotplug it occurs after reset, but before CAS,
> > spapr_populate_drconf_memory will be called to populate the DT with all=
 active
> > LMBs. AFAICT, for hotplugged LMBs it marks everything where
> > memory_region_preset(get_system_memory(), addr) =3D=3D true as
> > SPAPR_LMB_FLAGS_ASSIGNED. Since the region is mapped regardless of whet=
her the
> > guest has acknowledged the hotplug, I think this would end up presentin=
g the
> > LMB as having been present at boot-time. However, they will still be in=
 the
> > UNUSABLE/ISOLATED state because dev->hotplugged =3D=3D true.
> > =

> > I would think that the delayed hotplug event would move them to the app=
ropriate
> > state later, allowing the unplug to succeed later, but it totally possi=
ble the
> > guest code bails out during the hotplug path since it already has the L=
MB marked
> > as being in use via the CAS-generated DT.
> > =

> > So it seems like we need to either:
> > =

> > a) not mark these LMBs as SPAPR_LMB_FLAGS_ASSIGNED in the DT and let th=
em get
> > picked up by the deferred hotplug event (which seems to also be in need=
 of an
> > extra IRQ pulse given that it's not getting picked up till later), or
> > =

> > b) let them get picked up as boot-time LMBs and add a CAS hook to move =
the
> > state to USABLE/UNISOLATED at that point. optionally we could also purg=
e any
> > pending hotplug events from the event queue but that gets weird if we h=
ave
> > subsequent unplug events and whatnot sitting there as well. Hopefully l=
etting
> > guest process the hotplug event later and possible fail still leaves us=
 in
> > a recoverable state where we can still complete the unplug after boot.
> > =

> > Does this seem like an accurate assessment of the issues you're seeing?
> =

> It seems plausible from my limited understanding of the situation.
> The variety of possible state transitions in the PAPR hotplug model
> hurts my brain.
> =

> I think plan (a) sounds simpler than plan (b).  Basically any hotplug
> events that occur between reset and CAS we want to queue until CAS is
> complete.  AIUI we're already effectively queuing the event that goes
> to the guest, but we've already - incorrectly - made some qemu side
> state changes that show up in the DT fragments handed out by CAS.

I agree. The one thing I'm a bit iffy on is why the guest is missing
the interrupt (or handling at least) for the initially-queued events;
if we go this route we need to make sure the guest acts on them as part
of boot.

I assume pending interrupts get dropped by CAS because the guest doesn't
initialize the hotplug interrupt handler until that point. If that's the
case, a CAS hook to scan through the event queue to re-signal if needed
would hopefully do the trick, but I'm still a bit uncertain about whether
that's sufficient.

If it's something we can't do deterministically, we might need to consider
plan (b).

> =

> Can we just in general postpone the qemu side updates until the
> hotplug event is presented to the guest, rather than when it's
> submitted from the host?  Or will that raise a different bunch of problem=
s?

It seems like that might be problematic for migration.

Not updating the device tree with LMBs still pending delivery of hotplug
event during CAS seems fairly easy. We generate a new DT fragment for
the LMB at hp time anyways, so I think we can safely "throw away" the
updates and not worry about tracking any additional intermediate state.

Going to the extent of delaying the call to pc_dimm_memory_plug would be
problematic though I think. We would need a hook to make sure the call
is made if CAS completes after migration, and for cases where we do
migration by re-creating DIMMs via cmdline, we'd need some way to
synchonize state for these "pending" DIMMs, else that deferred call to
pc_dimm_memory_plug will probably generate errors due to duplicate
DIMM mappings (and if we relax/ignore those errors we still have the
original issue with CAS picking up the LMBs prematurely). This ends up
seeming really similar to the stuff that necessitated DRC migration,
which we probably want to avoid if possible.

> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
