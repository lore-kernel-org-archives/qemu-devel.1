Received: from eggs.gnu.org ([2001:4830:134:3::10]:54777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzX-00023X-5d
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzT-00076U-Uk
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYnzT-00074D-Dk
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:03 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 10:10:24 +0200
Message-Id: <20181217081047.2039-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v7 00/23] Add support for RDMA MAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

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

Patches 21 to 22 contain a fixes for bugs detected during the work on
processing VM shutdown notification.

Patch 23 fixes documentation.

Optional second review is welcome for:
[10] qapi: Define new QMP message for pvrdma
[17] hw/pvrdma: Fill error code in command's response

v1 -> v2:
    * Fix compilation issue detected when compiling for mingw.
    * Address comment from Eric Blake re version of QEMU in json
      message.
    * Fix example from QMP message in json file.
    * Fix case where a VM tries to remove an invalid GID from GID table.
    * rdmacm-mux: Cleanup entries in socket-gids table when socket is
      closed.
    * Cleanup resources (GIDs, QPs etc) when VM goes down.

v2 -> v3:
    * Address comment from Cornelia Huck for patch #19.
    * Add some R-Bs from Marcel Apfelbaum and Dmitry Fleytman.
    * Update docs/pvrdma.txt with the changes made by this patchset.
    * Address comments from Shamir Rabinovitch for UMAD multiplexer.

v3 -> v4:
    * Address some comments from Marcel.
    * Add some R-Bs from Cornelia Huck and Shamir Rabinovitch.

v4 -> v5:
    * Add one more patch that deletes code that performs unneeded (and
      buggy) cleanup of resources during VM shutdown.
    * Fix race condition that might happen when MAD response arrive before
      ack for the send is received.
    * Based qapi patch on Eric Blake's patch "qapi: Reduce Makefile
      boilerplate" per Markus Armbruster's suggestion.
      Please note that this will cause build error until Eric's patch will
      be applied.
    * Add some debug log messages to rdmacm-mux.

v5 -> v6
    * Add some R-Bs from Marcel.
    * Set hop_limit to 0xFF in mad_send.
    * Accept comment from Marcel re clearing response in execute_command.
    * Change version for QMP message per Eric Blake comment.
    * Add some notes to docs/pvrdma.txt as suggested by Marcel.
    * in rdmacm-mux, do not default to rxe0.

v6 -> v7:
    * Fix formating (checkpatch) in patch #17.
    * Undo wrong setting done in patch #17 (found after testing with
      Prasad's patchset).
    * Add Marcel's r-b for patches #11 and #17.

Thanks,
Yuval

Yuval Shaia (23):
  contrib/rdmacm-mux: Add implementation of RDMA User MAD multiplexer
  hw/rdma: Add ability to force notification without re-arm
  hw/rdma: Return qpn 1 if ibqp is NULL
  hw/rdma: Abort send-op if fail to create addr handler
  hw/rdma: Add support for MAD packets
  hw/pvrdma: Make function reset_device return void
  hw/pvrdma: Make default pkey 0xFFFF
  hw/pvrdma: Set the correct opcode for recv completion
  hw/pvrdma: Set the correct opcode for send completion
  qapi: Define new QMP message for pvrdma
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
  hw/rdma: Do not use bitmap_zero_extend to free bitmap
  hw/rdma: Do not call rdma_backend_del_gid on an empty gid
  docs: Update pvrdma device documentation

 MAINTAINERS                      |   2 +
 Makefile                         |   3 +
 Makefile.objs                    |   4 +-
 contrib/rdmacm-mux/Makefile.objs |   4 +
 contrib/rdmacm-mux/main.c        | 798 +++++++++++++++++++++++++++++++
 contrib/rdmacm-mux/rdmacm-mux.h  |  61 +++
 docs/pvrdma.txt                  | 126 ++++-
 hw/net/vmxnet3.c                 | 116 +----
 hw/net/vmxnet3_defs.h            | 133 ++++++
 hw/rdma/rdma_backend.c           | 515 +++++++++++++++++---
 hw/rdma/rdma_backend.h           |  28 +-
 hw/rdma/rdma_backend_defs.h      |  19 +-
 hw/rdma/rdma_rm.c                | 120 ++++-
 hw/rdma/rdma_rm.h                |  17 +-
 hw/rdma/rdma_rm_defs.h           |  21 +-
 hw/rdma/rdma_utils.h             |  25 +
 hw/rdma/vmw/pvrdma.h             |  10 +-
 hw/rdma/vmw/pvrdma_cmd.c         | 225 ++++-----
 hw/rdma/vmw/pvrdma_main.c        |  61 ++-
 hw/rdma/vmw/pvrdma_qp_ops.c      |  62 ++-
 include/sysemu/sysemu.h          |   1 +
 qapi/qapi-schema.json            |   1 +
 qapi/rdma.json                   |  38 ++
 vl.c                             |  15 +-
 24 files changed, 2022 insertions(+), 383 deletions(-)
 create mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/main.c
 create mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
 create mode 100644 hw/net/vmxnet3_defs.h
 create mode 100644 qapi/rdma.json

-- 
2.17.2
