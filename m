Received: from eggs.gnu.org ([2001:4830:134:3::10]:43933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e4DnW-0002TV-Lf
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e4DnR-0002Gc-HV
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:23:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e4DnR-0002F0-8h
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:23:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9GMJWKg028890
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 18:23:36 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dn1u1h0sb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 18:23:36 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 16 Oct 2017 16:23:35 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 17:23:12 -0500
Message-Id: <20171016222315.407-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/3] qdev/vfio: defer DEVICE_DEL to avoid
 races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

This series was motivated by the discussion in this thread:

  https://www.redhat.com/archives/libvir-list/2017-June/msg01370.html

The issue this series addresses is that when libvirt unplugs a VFIO PCI device,
it may attempt to bind the host device back to the host driver when QEMU emits
the DEVICE_DELETED event for the corresponding vfio-pci device. However, the
VFIO group FD is not actually cleaned up until vfio-pci device is *finalized*
by QEMU, whereas the event is emitted earlier during device_unparent.
Depending on the host device and how long certain operations like resetting the
device might take, this can in result in libvirt trying to rebind the device
back to the host while it is still in use by VFIO, leading to host crashes or
other unexpected behavior.

In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
quiesced by vfio-pci's finalize() routine until up to 6s after the
DEVICE_DELETED was emitted, leading to detach-device on the libvirt side pretty
much always crashing the host.

Implementing this change requires 2 prereqs to ensure the same information is
available when the DEVICE_DELETED is finally emitted:

1) Storing the path in the composition patch, which is addressed by PATCH 1,
   which was plucked from another pending series from Greg Kurz:

   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07922.html

   since we are now "disconnected" at the time the event is emitted, and

2) Deferring qemu_opts_del of the DeviceState->QemuOpts till finalize, since
   that is where DeviceState->id is stored. This was actually how it was
   done in the past, so PATCH 2 simply reverts the change which moved it to
   device_unparent.

>From there it's just a mechanical move of the event from device_unparent to
device_finalize.

Since this was originally posted a kernel fix was merged to address the race
on the kernel side (6586b561), but it would still be good to fix this on the
QEMU side for older host kernel and for clearer semantics on the
libvirt/management side.

v3:
 - rebased on master
 - fixed comment typo in PATCH 1 (Eric Blake)

v2:
 - rebased on master
 - fixed up inaccurate comment in PATCH 1 (Eric Auger)

 hw/core/qdev.c         | 31 ++++++++++++++++++++-----------
 include/hw/qdev-core.h |  1 +
 2 files changed, 21 insertions(+), 11 deletions(-)
