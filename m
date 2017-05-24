Received: from eggs.gnu.org ([2001:4830:134:3::10]:47325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dDaHD-0004dZ-Ry
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dDaHA-00051S-Nk
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:40:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42616
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dDaHA-00051J-Hs
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:40:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4OHeAsr115871
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 13:40:47 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2anb3kkey5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 13:40:47 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 24 May 2017 11:40:46 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <33b6ab16-961b-2ba6-17b9-6667cd00a0fc@redhat.com>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
	<20170524121402.50e62a75@nial.brq.redhat.com>
	<20170524175410.088f3285@bahia.ttt.fr.ibm.com>
	<33b6ab16-961b-2ba6-17b9-6667cd00a0fc@redhat.com>
Date: Wed, 24 May 2017 12:40:37 -0500
Message-Id: <149564763741.3207.16474489064736097451@loki>
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
To: Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting Laurent Vivier (2017-05-24 11:02:30)
> On 24/05/2017 17:54, Greg Kurz wrote:
> > On Wed, 24 May 2017 12:14:02 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > =

> >> On Wed, 24 May 2017 11:28:57 +0200
> >> Greg Kurz <groug@kaod.org> wrote:
> >>
> >>> On Wed, 24 May 2017 15:07:54 +1000
> >>> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>>   =

> >>>> On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote:    =

> >>>>> If the OS is not started, QEMU sends an event to the OS
> >>>>> that is lost and cannot be recovered. An unplug is not
> >>>>> able to restore QEMU in a coherent state.
> >>>>> So, while the OS is not started, disable CPU and memory hotplug.
> >>>>> We use option vector 6 to know if the OS is started
> >>>>>
> >>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>      =

> >>>>
> >>>> Urgh.. I'm not terribly confident that this is really correct.  As
> >>>> discussed on the previous patch, you're essentially using OV6 as a
> >>>> flag that CAS is complete.
> >>>>
> >>>> But while it undoubtedly makes the race window much smaller, I don't
> >>>> see that there's any guarantee the guest OS will really be able to
> >>>> handle hotplug events immediately after CAS.
> >>>>
> >>>> In particular if the CAS process completes partially but then needs =
to
> >>>> trigger a reboot, I think that would end up setting the ov6 variable,
> >>>> but the OS would definitely not be in a state to accept events.  =

> >> wouldn't guest on reboot pick up updated fdt and online hotplugged
> >> before crash cpu along with initial cpus?
> >>
> > =

> > Yes and that's what actually happens with cpus.
> > =

> > But catching up with the background for this series, I have the
> > impression that the issue isn't the fact we loose an event if the OS
> > isn't started (which is not true), but more something wrong happening
> > when hotplugging+unplugging memory as described in this commit:
> > =

> > commit fe6824d12642b005c69123ecf8631f9b13553f8b
> > Author: Laurent Vivier <lvivier@redhat.com>
> > Date:   Tue Mar 28 14:09:34 2017 +0200
> > =

> >     spapr: fix memory hot-unplugging
> > =

> =

> Yes, this commit try to fix that, but it's not possible. Some objects
> remain in memory: you can see with "info cpus" or "info memory-devices"
> that they are not really removed, and this prevents to hotplug them
> again, and moreover in the case of the memory hot-unplug we can rerun
> the device_del and crash qemu (as before the fix).
> =

> Moreover all stuff normally cleared in detach() are not, and we can't do
> it later in set_allocation_state() because some are in use by the
> kernel, and this is the last call from the kernel.

Focusing on the hotplug/add case, it's a bit odd that the guest would be
using the memory even though the hotplug event is clearly still sitting
in the queue.

I think part of the issue is us not having a clear enough distinction in
the code between what constitutes the need for "boot-time" handling vs.
"hotplug" handling.

We have this hook in spapr_add_lmbs:

    if (!dev->hotplugged) {
        /* guests expect coldplugged LMBs to be pre-allocated */
        drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
        drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
    }

Whereas the default allocation/isolation state for LMBs in spapr_drc.c is
UNUSABLE/ISOLATED, which is what covers the dev->hotplugged =3D=3D true cas=
e.

I need to spend some time testing to confirm, but trying to walk through the
various scenarios looking at the code:

case 1)

If the hotplug occurs before reset (not sure how likely this is), the event
will get dropped by reset handler, and the DRC stuff will be left in
UNUSABLE/ISOLATED. I think it's more appropriate to treat this as "boot-tim=
e"
and set it to USABLE/UNISOLATED like the !dev->hotplugged case.

case 2)

If the hotplug it occurs after reset, but before CAS,
spapr_populate_drconf_memory will be called to populate the DT with all act=
ive
LMBs. AFAICT, for hotplugged LMBs it marks everything where
memory_region_preset(get_system_memory(), addr) =3D=3D true as
SPAPR_LMB_FLAGS_ASSIGNED. Since the region is mapped regardless of whether =
the
guest has acknowledged the hotplug, I think this would end up presenting the
LMB as having been present at boot-time. However, they will still be in the
UNUSABLE/ISOLATED state because dev->hotplugged =3D=3D true.

I would think that the delayed hotplug event would move them to the appropr=
iate
state later, allowing the unplug to succeed later, but it totally possible =
the
guest code bails out during the hotplug path since it already has the LMB m=
arked
as being in use via the CAS-generated DT.

So it seems like we need to either:

a) not mark these LMBs as SPAPR_LMB_FLAGS_ASSIGNED in the DT and let them g=
et
picked up by the deferred hotplug event (which seems to also be in need of =
an
extra IRQ pulse given that it's not getting picked up till later), or

b) let them get picked up as boot-time LMBs and add a CAS hook to move the
state to USABLE/UNISOLATED at that point. optionally we could also purge any
pending hotplug events from the event queue but that gets weird if we have
subsequent unplug events and whatnot sitting there as well. Hopefully letti=
ng
guest process the hotplug event later and possible fail still leaves us in
a recoverable state where we can still complete the unplug after boot.

Does this seem like an accurate assessment of the issues you're seeing?

> =

> Laurent
>=20
