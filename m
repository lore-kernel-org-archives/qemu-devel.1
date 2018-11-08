Received: from eggs.gnu.org ([2001:4830:134:3::10]:59113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmrW-0004ll-Au
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmrQ-0000JD-2y
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:08:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gKmrP-0000Aq-Oq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:08:47 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu,  8 Nov 2018 18:07:56 +0200
Message-Id: <20181108160818.5485-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 00/22] Add support for RDMA MAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

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

Since we maintain external resources such as GIDs on host GID table we need
to do some cleanup before going down. This is the job of patches 19 and 20.
Patches 20 and 21 contain a fixes for bugs detected during the work on
processing cleanup code during shutdown.

v1 -> v2:
    * Fix compilation issue detected when compiling for mingw
    * Address comment from Eric Blake re version of QEMU in json
      message
    * Fix example from QMP message in json file
    * Fix case where a VM tries to remove an invalid GID from GID table
    * rdmacm-mux: Cleanup entries in socket-gids table when socket is
      closed
    * Cleanup resources (GIDs, QPs etc) when VM goes down

Thanks,
Yuval

Yuval Shaia (22):
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
  vl: Introduce shutdown_notifiers
  hw/pvrdma: Clean device's resource when system is shutdown
  rdma: Do not use bitmap_zero_extend to fee bitmap
  rdma: Do not call rdma_backend_del_gid on an empty gid

 MAINTAINERS                      |   2 +
 Makefile                         |   6 +-
 Makefile.objs                    |   5 +
 contrib/rdmacm-mux/Makefile.objs |   4 +
 contrib/rdmacm-mux/main.c        | 770 +++++++++++++++++++++++++++++++
 contrib/rdmacm-mux/rdmacm-mux.h  |  56 +++
 hw/net/vmxnet3.c                 | 116 +----
 hw/net/vmxnet3_defs.h            | 133 ++++++
 hw/rdma/rdma_backend.c           | 461 +++++++++++++++---
 hw/rdma/rdma_backend.h           |  28 +-
 hw/rdma/rdma_backend_defs.h      |  13 +-
 hw/rdma/rdma_rm.c                | 120 ++++-
 hw/rdma/rdma_rm.h                |  17 +-
 hw/rdma/rdma_rm_defs.h           |  21 +-
 hw/rdma/rdma_utils.h             |  24 +
 hw/rdma/vmw/pvrdma.h             |  10 +-
 hw/rdma/vmw/pvrdma_cmd.c         | 119 +++--
 hw/rdma/vmw/pvrdma_main.c        |  49 +-
 hw/rdma/vmw/pvrdma_qp_ops.c      |  62 ++-
 include/sysemu/sysemu.h          |   1 +
 qapi/qapi-schema.json            |   1 +
 qapi/rdma.json                   |  38 ++
 vl.c                             |  15 +-
 23 files changed, 1783 insertions(+), 288 deletions(-)
 create mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/main.c
 create mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
 create mode 100644 hw/net/vmxnet3_defs.h
 create mode 100644 qapi/rdma.json

-- 
2.17.2
