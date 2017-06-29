Received: from eggs.gnu.org ([2001:4830:134:3::10]:47012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1dQeWO-0007Ey-7e
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1dQeWK-00006T-9v
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:50:32 -0400
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <804c9b1a-6803-e920-9d3d-60fc33dd2fea@redhat.com>
Date: Thu, 29 Jun 2017 14:50:15 -0400
MIME-Version: 1.0
In-Reply-To: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: libvir-list@redhat.com
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, alex.williamson@redhat.com, abologna@redhat.com, pkrempa@redhat.com, berrange@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

On 06/28/2017 08:24 PM, Michael Roth wrote:
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

Since we don't support hotplug with managed='yes' of individual (or
multiple) functions of a multifunction host device, I don't know that
it's very useful to support hot *un*plug of it - it would only be useful
if the multi-function device were present in the guest when it was
started, and then was hot-unplugged later. And this is all a lot of
extra complexity, though, so it would be useful to know what are the
scenarios where it would actually be used (i.e. is this a legitimate
need, or just an interesting exercise?)

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

I agree with Dan that the situation described here should be considered
a qemu bug - according to my understanding (from back at the time
DEVICE_DELETED was added to qemu (I think at libvirt's request) qemu
should never emit the DEVICE_DELETED event until *everything* related to
the device is finished - that was the whole point of adding the event in
the first palce. Covering up this bug with a bunch of extra libvirt
complexity is just creating the potential for even more bugs in the more
complex code.

> 
> Patches 1-4 address 1) by deferring rebinding of a hostdev to the host driver
> until all the devices in the group have been detached, at which point all
> the hostdevs are rebound as a group. Until that point, the devices are traced
> by the drvManager's inactiveList in a similar manner to hostdevs that are
> assigned to VFIO via the nodedev-detach interface.

What happens if libvirtd is restarted during this period? Is the
inactiveList rebuilt with all the info necessary to assure that the
nodedev-reattach does/doesn't happen (as appropriate) for all devices?


> 
> Patch 5 addresses 2) by adding an additional check that, when the last device
> from a group is detached, polls /proc for open FDs referencing the VFIO group
> path in /dev/vfio/<iommu_group> and waiting for the FD to be closed. If we
> time out, we abandon rebinding the hostdevs back to the host.
> 
> There are a couple alternatives to Patch 5 that might be worth considering:
> 
> a) Add a DEVICE_FINALIZED event to QEMU and wait for that instead of
>    DEVICE_DELETED.

Is the "device is *almost* completely deleted" event (current
DEVIE_DELETED) really something that anyone wants/needs to know about?
Or is the only useful event just the one that you're calling
DEVICE_FINALIZED? If the latter, then I think it would be better to just
change when DEVICE_DELETED is emitted.

 Paired with patches 1-4 this would let us drop patch 5 in
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

I don't think we should add such a complex patch as a fallback to
support older versions of qemu that don't have the bug fixed. Instead,
just tell people to upgrade qemu (after all, they're going to need to
update *something* (either libvirt or qemu); no need to update libvirt
just in order to avoid updating qemu).


>     - synchronizing sync/async device-detach threads with sync/async
>       handlers for this would be a bit hairy, but I have a WIP in progress
>       that seems *fairly reasonable*
> 
> c) Take the approach in Patch 5, either as a precursor to implementing b) or
>    something else, or just sticking with that for now.
> 
> d) ???
> 
> Personally I'm leaning toward c), but I'm wondering if that's "good enough"
> for now, or if we should pursue something more robust from the start, or
> perhaps something else entirely?
> 
> Any feedback is greatly appreciated!
> 
>  src/libvirt_private.syms |   5 ++
>  src/qemu/qemu_hostdev.c  |  16 +++++
>  src/qemu/qemu_hostdev.h  |   4 ++
>  src/qemu/qemu_hotplug.c  |  56 ++++++++++++++----
>  src/util/virfile.c       |  52 +++++++++++++++++
>  src/util/virfile.h       |   1 +
>  src/util/virhostdev.c    | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  src/util/virhostdev.h    |  16 +++++
>  src/util/virpci.c        |  69 ++++++++++++++++++----
>  src/util/virpci.h        |   4 ++
>  10 files changed, 360 insertions(+), 36 deletions(-)
> 
> 
