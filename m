Received: from eggs.gnu.org ([2001:4830:134:3::10]:56925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cywjX-0006jg-2g
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cywjW-0008O6-7u
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:37:35 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 14 Apr 2017 10:37:13 +0200
Message-Id: <20170414083717.13641-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] qdev: remove all remaining
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alistair Francis <alistair.francis@xilinx.com>, Antony Pavlov <antonynpavlov@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>

This series removes all the remaining uses of
cannot_destroy_with_object_finalize_yet to finally remove
the flag itself.

The ARM patch has already been sent alone and reviewed by Markus.
I have tested the ppc one on ppc64 machine with KVM and using
QDM device-list-properties command.

For the versatile one, the flag allowed to workaround a problem
in the bus unparent function: the bus unparent is trying to
unparent all the children of the bus. To do that, it has a list
of the children of the bus, and calls object_unparent() for each
child, and object_unparent() calls object_property_del_child() if
obj->parent is not NULL.  As qdev_set_parent_bus() set only
parent_bus and the list of children, parent is NULL and the child
is never deleted.  We can avoid the problem by moving the
qdev_set_parent_bus() to the realize part.

I've tested all the changes with "make check" (including
device-introspect-test). I've booted a versatilepb machine
with a 3.16.0-4 debian installer kernel.

Laurent Vivier (4):
  arm: remove remaining cannot_destroy_with_object_finalize_yet
  ppc: remove cannot_destroy_with_object_finalize_yet
  versatile: remove cannot_destroy_with_object_finalize_yet
  qdev: remove cannot_destroy_with_object_finalize_yet

 hw/arm/allwinner-a10.c  |  6 ------
 hw/arm/bcm2836.c        |  6 ------
 hw/arm/digic.c          |  6 ------
 hw/arm/fsl-imx25.c      |  5 -----
 hw/arm/fsl-imx31.c      |  5 -----
 hw/arm/fsl-imx6.c       |  5 -----
 hw/arm/xlnx-zynqmp.c    |  6 ------
 hw/pci-host/versatile.c | 35 ++++++++++++-----------------------
 include/hw/qdev-core.h  | 13 -------------
 qmp.c                   |  5 -----
 target/ppc/kvm.c        | 10 ----------
 11 files changed, 12 insertions(+), 90 deletions(-)

-- 
2.9.3
