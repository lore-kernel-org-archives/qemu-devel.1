Received: from eggs.gnu.org ([2001:4830:134:3::10]:39330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQUtU-0008KI-FW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQUtQ-0005hT-Fu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:33:44 -0400
Date: Thu, 29 Jun 2017 09:33:19 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170629083319.GA19941@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, alex.williamson@redhat.com, abologna@redhat.com, laine@laine.org, pkrempa@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

On Wed, Jun 28, 2017 at 07:24:55PM -0500, Michael Roth wrote:
> Hi everyone. Hoping to get some feedback on this approach, or some
> alternatives proposed below, to the following issue:
> 
> Currently libvirt immediately attempts to rebind a managed device back to the
> host driver when it receives a DEVICE_DELETED event from QEMU. This is
> problematic for 2 reasons:
> 
> 1) If multiple devices from a group are attached to a guest, this can move
>    the group into a "non-viable" state where some devices are assigned to
>    the host and some to the guest.
> 
> 2) When QEMU emits the DEVICE_DELETED event, there's still a "finalize" phase
>    where additional cleanup occurs. In most cases libvirt can ignore this
>    cleanup, but in the case of VFIO devices this is where closing of a VFIO
>    group FD occurs, and failing to wait before rebinding the device to the
>    host driver can result in unexpected behavior. In the case of powernv
>    hosts at least, this can lead to a host driver crashing due to the default
>    DMA windows not having been fully-restored yet. The window between this is
>    and the initial DEVICE_DELETED seems to be ~6 seconds in practice. We've
>    seen host dumps with Mellanox CX4 VFs being rebound to host driver during
>    this period (on powernv hosts).

Why on earth does QEMU's device finalization take 6 seconds to complete.
That feels very broken to me, unless QEMU is not being schedled due to
host being overcomitted. If that's not the case, then we have a bug to
investigate in QEMU to find out why cleanup is delayed so long.


>From libvirt's POV, we consider 'DEVICE_DELETED' as meaning both that the
frontend has gone *and* the corresponding backend has gone. Aside from
cleaning the VFIO group, we use this as a trigger for all other device
related cleanup like SELinux labelling, cgroup device ACLs, etc. If the
backend is not guaranteed to be closed in QEMU when this emit is emitted
then either QEMU needs to delay the event until it is really cleaned up,
or QEMU needs to add a further event to emit when the backend is clean.


> Patches 1-4 address 1) by deferring rebinding of a hostdev to the host driver
> until all the devices in the group have been detached, at which point all
> the hostdevs are rebound as a group. Until that point, the devices are traced
> by the drvManager's inactiveList in a similar manner to hostdevs that are
> assigned to VFIO via the nodedev-detach interface.
> 
> Patch 5 addresses 2) by adding an additional check that, when the last device
> from a group is detached, polls /proc for open FDs referencing the VFIO group
> path in /dev/vfio/<iommu_group> and waiting for the FD to be closed. If we
> time out, we abandon rebinding the hostdevs back to the host.

That is just gross - it is tieing libvirt to details of the QEMU internal
implementation. I really don't think we should be doing that. So NACK to
this from my POV.

> There are a couple alternatives to Patch 5 that might be worth considering:
> 
> a) Add a DEVICE_FINALIZED event to QEMU and wait for that instead of
>    DEVICE_DELETED. Paired with patches 1-4 this would let us drop patch 5 in
>    favor of minimal changes to libvirt's event handlers.
> 
>    The downsides are:
>     - that we'd incur some latency for all device-detach calls, but it's not
>       apparent to me whether this delay is significant for anything outside
>       of VFIO.
>     - there may be cases where finalization after DEVICE_DELETE/unparent are
>       is not guaranteed, and I'm not sure QOM would encourage such
>       expectations even if that's currently the case.
> 
> b) Add a GROUP_DELETED event to VFIO's finalize callback. This is the most
>    direct solution. With this we could completely separate out the handling
>    of rebinding to host driver based on receival of this event.
> 
>    The downsides are:
>     - this would only work for newer versions of QEMU, though we could use
>       the poll-wait in patch 5 as a fallback.
>     - synchronizing sync/async device-detach threads with sync/async
>       handlers for this would be a bit hairy, but I have a WIP in progress
>       that seems *fairly reasonable*
> 
> c) Take the approach in Patch 5, either as a precursor to implementing b) or
>    something else, or just sticking with that for now.
> 
> d) ???

Fix DEVICE_DELETE so its only emitted when the backend associated with
the device is fully cleaned up.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
