Received: from eggs.gnu.org ([2001:4830:134:3::10]:40598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQe5j-0002qI-RX
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQe5g-0003nm-KQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:22:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36464
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dQe5g-0003nM-De
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:22:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TIIjjL007094
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:22:55 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bd4aqppkr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:22:55 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 29 Jun 2017 12:22:53 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170629083319.GA19941@redhat.com>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170629083319.GA19941@redhat.com>
Date: Thu, 29 Jun 2017 13:22:44 -0500
Message-Id: <149876056453.10485.3122787367160530626@loki>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, alex.williamson@redhat.com, abologna@redhat.com, laine@laine.org, pkrempa@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

Quoting Daniel P. Berrange (2017-06-29 03:33:19)
> On Wed, Jun 28, 2017 at 07:24:55PM -0500, Michael Roth wrote:
> > Hi everyone. Hoping to get some feedback on this approach, or some
> > alternatives proposed below, to the following issue:
> > =

> > Currently libvirt immediately attempts to rebind a managed device back =
to the
> > host driver when it receives a DEVICE_DELETED event from QEMU. This is
> > problematic for 2 reasons:
> > =

> > 1) If multiple devices from a group are attached to a guest, this can m=
ove
> >    the group into a "non-viable" state where some devices are assigned =
to
> >    the host and some to the guest.
> > =

> > 2) When QEMU emits the DEVICE_DELETED event, there's still a "finalize"=
 phase
> >    where additional cleanup occurs. In most cases libvirt can ignore th=
is
> >    cleanup, but in the case of VFIO devices this is where closing of a =
VFIO
> >    group FD occurs, and failing to wait before rebinding the device to =
the
> >    host driver can result in unexpected behavior. In the case of powernv
> >    hosts at least, this can lead to a host driver crashing due to the d=
efault
> >    DMA windows not having been fully-restored yet. The window between t=
his is
> >    and the initial DEVICE_DELETED seems to be ~6 seconds in practice. W=
e've
> >    seen host dumps with Mellanox CX4 VFs being rebound to host driver d=
uring
> >    this period (on powernv hosts).
> =

> Why on earth does QEMU's device finalization take 6 seconds to complete.
> That feels very broken to me, unless QEMU is not being schedled due to
> host being overcomitted. If that's not the case, then we have a bug to
> investigate in QEMU to find out why cleanup is delayed so long.

In this particular case QEMU starts finalization almost immediately
after the DEVICE_DELETED, but it looks like most of the time between that a=
nd
closing of the group FD is spent in the kernel. Here's what it looks
like from QEMU with vfio*/monitor* traces enabled (in this case
unplugging a Mellanox CX3 PF):

# device_del called
...
# vfio device's device_unparent() called:
  # unrealize->exit->vfio_exitfn called:
61948@1498759308.951038:vfio_intx_disable  (0002:01:00.0)
61948@1498759308.953657:vfio_region_exit Device 0002:01:00.0, region 0
61948@1498759308.954532:vfio_region_exit Device 0002:01:00.0, region 2
  # unrealize->exit->vfio_exitfn returns, DEVICE_DELETED sent:
61948@1498759308.954633:monitor_protocol_event_queue event=3D9 data=3D0x3ff=
f6c508690 rate=3D0
61948@1498759308.954669:monitor_protocol_event_emit event=3D9 data=3D0x3fff=
6c508690
  # last unref of vfio device, vfio_instance_finalize() called:
61948@1498759308.955660:vfio_region_finalize Device 0002:01:00.0, region 0
61948@1498759308.955742:vfio_region_finalize Device 0002:01:00.0, region 2
61948@1498759308.955751:vfio_put_base_device close vdev->fd=3D30

    # close(VFIODevice.fd) <- 5 SECOND DELAY

61948@1498759313.140515:vfio_put_base_device_completed close completed vdev=
->fd=3D30
61948@1498759313.181124:vfio_disconnect_container close container->fd=3D102
61948@1498759313.181152:vfio_put_group close group->fd=3D101
    # close(VFIOGroup.fd)
61948@1498759313.181157:vfio_put_group_completed close completed group->fd=
=3D101
  # vfio_instance_finalize() returns
# vfio device's device_unparent() returns

I poked around in the VFIO group close path and figured restoring ownership
of IOMMU to the host via vfio_iommu_driver_ops.release() (via
close(groupfd) was where all the time was spent, but didn't expect it to
be the close(VFIODevice.fd). Maybe Alexey/Alex have a better idea. I'll
look into it more as well.

But suffice to say there's not much QEMU can do about the delay other
than moving deferring the DEVICE_DELETED event or adding a later-stage
event.

> =

> =

> From libvirt's POV, we consider 'DEVICE_DELETED' as meaning both that the
> frontend has gone *and* the corresponding backend has gone. Aside from
> cleaning the VFIO group, we use this as a trigger for all other device
> related cleanup like SELinux labelling, cgroup device ACLs, etc. If the
> backend is not guaranteed to be closed in QEMU when this emit is emitted
> then either QEMU needs to delay the event until it is really cleaned up,
> or QEMU needs to add a further event to emit when the backend is clean.
> =

> =

> > Patches 1-4 address 1) by deferring rebinding of a hostdev to the host =
driver
> > until all the devices in the group have been detached, at which point a=
ll
> > the hostdevs are rebound as a group. Until that point, the devices are =
traced
> > by the drvManager's inactiveList in a similar manner to hostdevs that a=
re
> > assigned to VFIO via the nodedev-detach interface.
> > =

> > Patch 5 addresses 2) by adding an additional check that, when the last =
device
> > from a group is detached, polls /proc for open FDs referencing the VFIO=
 group
> > path in /dev/vfio/<iommu_group> and waiting for the FD to be closed. If=
 we
> > time out, we abandon rebinding the hostdevs back to the host.
> =

> That is just gross - it is tieing libvirt to details of the QEMU internal
> implementation. I really don't think we should be doing that. So NACK to
> this from my POV.
> =

> > There are a couple alternatives to Patch 5 that might be worth consider=
ing:
> > =

> > a) Add a DEVICE_FINALIZED event to QEMU and wait for that instead of
> >    DEVICE_DELETED. Paired with patches 1-4 this would let us drop patch=
 5 in
> >    favor of minimal changes to libvirt's event handlers.
> > =

> >    The downsides are:
> >     - that we'd incur some latency for all device-detach calls, but it'=
s not
> >       apparent to me whether this delay is significant for anything out=
side
> >       of VFIO.
> >     - there may be cases where finalization after DEVICE_DELETE/unparen=
t are
> >       is not guaranteed, and I'm not sure QOM would encourage such
> >       expectations even if that's currently the case.
> > =

> > b) Add a GROUP_DELETED event to VFIO's finalize callback. This is the m=
ost
> >    direct solution. With this we could completely separate out the hand=
ling
> >    of rebinding to host driver based on receival of this event.
> > =

> >    The downsides are:
> >     - this would only work for newer versions of QEMU, though we could =
use
> >       the poll-wait in patch 5 as a fallback.
> >     - synchronizing sync/async device-detach threads with sync/async
> >       handlers for this would be a bit hairy, but I have a WIP in progr=
ess
> >       that seems *fairly reasonable*
> > =

> > c) Take the approach in Patch 5, either as a precursor to implementing =
b) or
> >    something else, or just sticking with that for now.
> > =

> > d) ???
> =

> Fix DEVICE_DELETE so its only emitted when the backend associated with
> the device is fully cleaned up.

Need to explore same concerns I had WRT to DEVICE_FINALIZED above, but
assuming those aren't an issue this would indeed makes things even
simpler. Will look into this more.

Would patch 5 be out of the question even as a fallback for downlevel
QEMUs? Or is that scenario too unlikely to warrant it?

Thanks!

> =

> =

> Regards,
> Daniel
> -- =

> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20
