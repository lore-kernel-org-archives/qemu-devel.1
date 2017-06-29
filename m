Received: from eggs.gnu.org ([2001:4830:134:3::10]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHc-0001ri-52
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHX-00032o-0A
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39713
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dQNHW-00031j-Mw
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5T0OJg7116041
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:01 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcnmqajju-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:00 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 20:26:00 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 19:24:55 -0500
Message-Id: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/5] hotplug: fix premature rebinding of
 VFIO devices to host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libvir-list@redhat.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, alex.williamson@redhat.com, abologna@redhat.com, laine@laine.org, pkrempa@redhat.com, berrange@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

Hi everyone. Hoping to get some feedback on this approach, or some
alternatives proposed below, to the following issue:

Currently libvirt immediately attempts to rebind a managed device back to the
host driver when it receives a DEVICE_DELETED event from QEMU. This is
problematic for 2 reasons:

1) If multiple devices from a group are attached to a guest, this can move
   the group into a "non-viable" state where some devices are assigned to
   the host and some to the guest.

2) When QEMU emits the DEVICE_DELETED event, there's still a "finalize" phase
   where additional cleanup occurs. In most cases libvirt can ignore this
   cleanup, but in the case of VFIO devices this is where closing of a VFIO
   group FD occurs, and failing to wait before rebinding the device to the
   host driver can result in unexpected behavior. In the case of powernv
   hosts at least, this can lead to a host driver crashing due to the default
   DMA windows not having been fully-restored yet. The window between this is
   and the initial DEVICE_DELETED seems to be ~6 seconds in practice. We've
   seen host dumps with Mellanox CX4 VFs being rebound to host driver during
   this period (on powernv hosts).

Patches 1-4 address 1) by deferring rebinding of a hostdev to the host driver
until all the devices in the group have been detached, at which point all
the hostdevs are rebound as a group. Until that point, the devices are traced
by the drvManager's inactiveList in a similar manner to hostdevs that are
assigned to VFIO via the nodedev-detach interface.

Patch 5 addresses 2) by adding an additional check that, when the last device
from a group is detached, polls /proc for open FDs referencing the VFIO group
path in /dev/vfio/<iommu_group> and waiting for the FD to be closed. If we
time out, we abandon rebinding the hostdevs back to the host.

There are a couple alternatives to Patch 5 that might be worth considering:

a) Add a DEVICE_FINALIZED event to QEMU and wait for that instead of
   DEVICE_DELETED. Paired with patches 1-4 this would let us drop patch 5 in
   favor of minimal changes to libvirt's event handlers.

   The downsides are:
    - that we'd incur some latency for all device-detach calls, but it's not
      apparent to me whether this delay is significant for anything outside
      of VFIO.
    - there may be cases where finalization after DEVICE_DELETE/unparent are
      is not guaranteed, and I'm not sure QOM would encourage such
      expectations even if that's currently the case.

b) Add a GROUP_DELETED event to VFIO's finalize callback. This is the most
   direct solution. With this we could completely separate out the handling
   of rebinding to host driver based on receival of this event.

   The downsides are:
    - this would only work for newer versions of QEMU, though we could use
      the poll-wait in patch 5 as a fallback.
    - synchronizing sync/async device-detach threads with sync/async
      handlers for this would be a bit hairy, but I have a WIP in progress
      that seems *fairly reasonable*

c) Take the approach in Patch 5, either as a precursor to implementing b) or
   something else, or just sticking with that for now.

d) ???

Personally I'm leaning toward c), but I'm wondering if that's "good enough"
for now, or if we should pursue something more robust from the start, or
perhaps something else entirely?

Any feedback is greatly appreciated!

 src/libvirt_private.syms |   5 ++
 src/qemu/qemu_hostdev.c  |  16 +++++
 src/qemu/qemu_hostdev.h  |   4 ++
 src/qemu/qemu_hotplug.c  |  56 ++++++++++++++----
 src/util/virfile.c       |  52 +++++++++++++++++
 src/util/virfile.h       |   1 +
 src/util/virhostdev.c    | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 src/util/virhostdev.h    |  16 +++++
 src/util/virpci.c        |  69 ++++++++++++++++++----
 src/util/virpci.h        |   4 ++
 10 files changed, 360 insertions(+), 36 deletions(-)
