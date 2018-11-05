Received: from eggs.gnu.org ([2001:4830:134:3::10]:35603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHD-0007T1-7x
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeGu-0002Us-Q8
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gJeGs-0002Ja-OZ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:24 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon,  5 Nov 2018 14:45:41 +0200
Message-Id: <20181105124559.21561-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 00/18] Add support for RDMA MAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

Hi all.

This is a major enhancement to the pvrdma device to allow it to work with
state of the art applications such as MPI.

As described in patch #5, MAD packets are management packets that are used
for many purposes including but not limited to communication layer above IB
verbs API.

Patch 1 exposes new external executable (under contrib) that aims to
address a specific limitation in the RDMA usrespace MAD stack.

This patch-set mainly present MAD enhancement but during the work on it i
came across some bugs and enhancement needed to be implemented before doing
any MAD coding. This is the role of patches 2 to 4, 7 to 9 and 15 to 17.

Patches 6 and 18 are cosmetic changes while not relevant to this patchset
still introduce with it since (at least for 6) hard to decouple.

Patches 12 to 15 couple pvrdma device with vmxnet3 device as this is the
configuration enforced by pvrdma driver in guest - a vmxnet3 device in
function 0 and pvrdma device in function 1 in the same PCI slot. Patch 12
moves needed code from vmxnet3 device to a new header file that can be used
by pvrdma code while Patches 13 to 15 use of it.

Along with this patch-set there is a parallel patch posted to libvirt to
apply the change needed there as part of the process implemented in patches
10 and 11. This change is needed so that guest would be able to configure
any IP to the Ethernet function of the pvrdma device.
https://www.redhat.com/archives/libvir-list/2018-November/msg00135.html

Thanks,
Yuval

Yuval Shaia (18):
  contrib/rdmacm-mux: Add implementation of RDMA User MAD multiplexer
  hw/rdma: Add ability to force notification without re-arm
  hw/rdma: Return qpn 1 if ibqp is NULL
  hw/rdma: Abort send-op if fail to create addr handler
  hw/rdma: Add support for MAD packets
  hw/pvrdma: Make function reset_device return void
  hw/pvrdma: Make default pkey 0xFFFF
  hw/pvrdma: Set the correct opcode for recv completion
  hw/pvrdma: Set the correct opcode for send completion
  json: Define new QMP message for pvrdma
  hw/pvrdma: Add support to allow guest to configure GID table
  vmxnet3: Move some definitions to header file
  hw/pvrdma: Make sure PCI function 0 is vmxnet3
  hw/rdma: Initialize node_guid from vmxnet3 mac address
  hw/pvrdma: Make device state depend on Ethernet function state
  hw/pvrdma: Fill all CQE fields
  hw/pvrdma: Fill error code in command's response
  hw/rdma: Remove unneeded code that handles more that one port

 MAINTAINERS                      |   2 +
 Makefile                         |   6 +-
 Makefile.objs                    |   5 +
 contrib/rdmacm-mux/Makefile.objs |   3 +
 contrib/rdmacm-mux/main.c        | 734 +++++++++++++++++++++++++++++++
 contrib/rdmacm-mux/rdmacm-mux.h  |  47 ++
 hw/net/vmxnet3.c                 | 116 +----
 hw/net/vmxnet3_defs.h            | 133 ++++++
 hw/rdma/rdma_backend.c           | 439 +++++++++++++++---
 hw/rdma/rdma_backend.h           |  28 +-
 hw/rdma/rdma_backend_defs.h      |  13 +-
 hw/rdma/rdma_rm.c                | 111 ++++-
 hw/rdma/rdma_rm.h                |  17 +-
 hw/rdma/rdma_rm_defs.h           |  21 +-
 hw/rdma/rdma_utils.h             |  24 +
 hw/rdma/vmw/pvrdma.h             |   8 +-
 hw/rdma/vmw/pvrdma_cmd.c         | 112 +++--
 hw/rdma/vmw/pvrdma_main.c        |  37 +-
 hw/rdma/vmw/pvrdma_qp_ops.c      |  62 ++-
 qapi/qapi-schema.json            |   1 +
 qapi/rdma.json                   |  34 ++
 21 files changed, 1667 insertions(+), 286 deletions(-)
 create mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/main.c
 create mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
 create mode 100644 hw/net/vmxnet3_defs.h
 create mode 100644 qapi/rdma.json

-- 
2.17.2
