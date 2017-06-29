Received: from eggs.gnu.org ([2001:4830:134:3::10]:50844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQgXl-0003qj-Ff
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQgXh-0005mm-Ik
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:00:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49369
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dQgXh-0005mC-Dh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:00:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TKx1OI144906
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 17:00:00 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcv5rkkv1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 17:00:00 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 29 Jun 2017 16:59:59 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170629132811.77cd8144@w520.home>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170629083319.GA19941@redhat.com> <20170629132811.77cd8144@w520.home>
Date: Thu, 29 Jun 2017 15:21:34 -0500
Message-Id: <149876769479.10485.16519476069665973271@loki>
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] hotplug: fix premature rebinding
 of VFIO devices to host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, abologna@redhat.com, laine@laine.org, pkrempa@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

Quoting Alex Williamson (2017-06-29 14:28:11)
> On Thu, 29 Jun 2017 09:33:19 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> =

> > On Wed, Jun 28, 2017 at 07:24:55PM -0500, Michael Roth wrote:
> > > Hi everyone. Hoping to get some feedback on this approach, or some
> > > alternatives proposed below, to the following issue:
> > > =

> > > Currently libvirt immediately attempts to rebind a managed device bac=
k to the
> > > host driver when it receives a DEVICE_DELETED event from QEMU. This is
> > > problematic for 2 reasons:
> > > =

> > > 1) If multiple devices from a group are attached to a guest, this can=
 move
> > >    the group into a "non-viable" state where some devices are assigne=
d to
> > >    the host and some to the guest.
> > > =

> > > 2) When QEMU emits the DEVICE_DELETED event, there's still a "finaliz=
e" phase
> > >    where additional cleanup occurs. In most cases libvirt can ignore =
this
> > >    cleanup, but in the case of VFIO devices this is where closing of =
a VFIO
> > >    group FD occurs, and failing to wait before rebinding the device t=
o the
> > >    host driver can result in unexpected behavior. In the case of powe=
rnv
> > >    hosts at least, this can lead to a host driver crashing due to the=
 default
> > >    DMA windows not having been fully-restored yet. The window between=
 this is
> > >    and the initial DEVICE_DELETED seems to be ~6 seconds in practice.=
 We've
> > >    seen host dumps with Mellanox CX4 VFs being rebound to host driver=
 during
> > >    this period (on powernv hosts).  =

> =

> I've been trying to tackle this from the kernel side too, currently
> Linux's driver model really neither allows vfio bus drivers to nak
> unbinding a device from an in-use group nor nak binding a device
> from an in-use group to an incompatible driver.  The issue you identify
> in QEMU/libvirt exacerbates the problem as QEMU has not yet finalized
> the device/group references before libvirt tries to unbind the device
> from the vfio bus driver and attach it to a host driver.  I'd love to
> solve this from both sides by allowing the kernel to prevent driver
> binds that we'd consider compromising and also introduce a bit of
> patience in the QEMU/libvirt path to avoid the kernel needing to impose
> that driver blocking.

Perfect, I'd meant to ask about this and it skipped my mind. I had some
concerns about the fact that even with these qemu/libvirt changes in place
we could still trigger these sorts of crashes by issuing such a rebind
outside of libvirt, so good to know that aspect is being looked at as well
and that the 2 aren't in conflict.

> =

> > Why on earth does QEMU's device finalization take 6 seconds to complete.
> > That feels very broken to me, unless QEMU is not being schedled due to
> > host being overcomitted. If that's not the case, then we have a bug to
> > investigate in QEMU to find out why cleanup is delayed so long.
> =

> I wouldn't necessarily jump to the conclusion that this is a bug, if
> it's relating to tearing down the IOMMU mappings for the device, gigs
> of mappings can take non-trivial time.  Is that the scenario here?  Is
> that 6s somehow proportional to guest memory size?

I think you're right that the teardown is via group close. Since the traces
seem to pin it on the vfio device FD close, the device reset you mentioned
is probably what's going on here, but I'll try to confirm.

> =

> > From libvirt's POV, we consider 'DEVICE_DELETED' as meaning both that t=
he
> > frontend has gone *and* the corresponding backend has gone. Aside from
> > cleaning the VFIO group, we use this as a trigger for all other device
> > related cleanup like SELinux labelling, cgroup device ACLs, etc. If the
> > backend is not guaranteed to be closed in QEMU when this emit is emitted
> > then either QEMU needs to delay the event until it is really cleaned up,
> > or QEMU needs to add a further event to emit when the backend is clean.
> =

> Clearly libvirt and QEMU's idea of what DEVICE_DELETED means don't
> align.
> =

> > > Patches 1-4 address 1) by deferring rebinding of a hostdev to the hos=
t driver
> > > until all the devices in the group have been detached, at which point=
 all
> > > the hostdevs are rebound as a group. Until that point, the devices ar=
e traced
> > > by the drvManager's inactiveList in a similar manner to hostdevs that=
 are
> > > assigned to VFIO via the nodedev-detach interface.
> =

> There are certainly some benefits to group-awareness here, currently
> an admin user like libvirt can trigger a BUG_ON by trying to bind a
> device back to a host driver when a group is still in use, at best we
> might improve that to rejecting the compromising bind.  =

> =

> > > Patch 5 addresses 2) by adding an additional check that, when the las=
t device
> > > from a group is detached, polls /proc for open FDs referencing the VF=
IO group
> > > path in /dev/vfio/<iommu_group> and waiting for the FD to be closed. =
If we
> > > time out, we abandon rebinding the hostdevs back to the host.  =

> > =

> > That is just gross - it is tieing libvirt to details of the QEMU intern=
al
> > implementation. I really don't think we should be doing that. So NACK to
> > this from my POV.
> =

> It seems a little silly for QEMU to emit the event while it's still in
> use, clearly emitting the event at the right point would negate any
> need for snooping around in proc.
> =

> > > There are a couple alternatives to Patch 5 that might be worth consid=
ering:
> > > =

> > > a) Add a DEVICE_FINALIZED event to QEMU and wait for that instead of
> > >    DEVICE_DELETED. Paired with patches 1-4 this would let us drop pat=
ch 5 in
> > >    favor of minimal changes to libvirt's event handlers.
> > > =

> > >    The downsides are:
> > >     - that we'd incur some latency for all device-detach calls, but i=
t's not
> > >       apparent to me whether this delay is significant for anything o=
utside
> > >       of VFIO.
> > >     - there may be cases where finalization after DEVICE_DELETE/unpar=
ent are
> > >       is not guaranteed, and I'm not sure QOM would encourage such
> > >       expectations even if that's currently the case.
> > > =

> > > b) Add a GROUP_DELETED event to VFIO's finalize callback. This is the=
 most
> > >    direct solution. With this we could completely separate out the ha=
ndling
> > >    of rebinding to host driver based on receival of this event.
> > > =

> > >    The downsides are:
> > >     - this would only work for newer versions of QEMU, though we coul=
d use
> > >       the poll-wait in patch 5 as a fallback.
> > >     - synchronizing sync/async device-detach threads with sync/async
> > >       handlers for this would be a bit hairy, but I have a WIP in pro=
gress
> > >       that seems *fairly reasonable*
> > > =

> > > c) Take the approach in Patch 5, either as a precursor to implementin=
g b) or
> > >    something else, or just sticking with that for now.
> > > =

> > > d) ???  =

> > =

> > Fix DEVICE_DELETE so its only emitted when the backend associated with
> > the device is fully cleaned up.
> =

> Adding a FINALIZE seems to require a two-step fix, fix QEMU then fix
> libvirt, whereas moving DELETE to the correct location automatically
> fixes the behavior with existing libvirt.  I don't know that a
> GROUP_DELETED makes much sense, libvirt can know about groups on its
> own and it just leads to a vfio specific path.  Thanks,

Ok, seems like there's a consensus there. I'll report back if there's
any obvious showstopper with this, but otherwise I'll work on a patch to
defer the DEVICE_DELETED, and drop patch 5 from the libvirt side of
things.

Thanks!

> =

> Alex
>=20
