Received: from eggs.gnu.org ([2001:4830:134:3::10]:41514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvl-00068p-47
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvf-0006FI-DK
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadvd-0006DN-EL
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id z5so7496656wrt.11
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:50:40 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:05 +0200
Message-Id: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 00/31] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

The following changes since commit 891ff9f4a371da2dbd5244590eb35e8d803e18d8:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20181221' into staging (2018-12-21 15:49:59 +0000)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to f1e2e38ee0136b7710a2caa347049818afd57a1b:

  pvrdma: check return value from pvrdma_idx_ring_has_ routines (2018-12-22 11:09:57 +0200)

----------------------------------------------------------------
RDMA queue
 * Add support for RDMA MAD
 * Various fixes for the pvrdma backend

----------------------------------------------------------------
Prasad J Pandit (7):
      pvrdma: release device resources in case of an error
      rdma: check num_sge does not exceed MAX_SGE
      pvrdma: add uar_read routine
      pvrdma: check number of pages when creating rings
      pvrdma: release ring object in case of an error
      rdma: remove unused VENDOR_ERR_NO_SGE macro
      pvrdma: check return value from pvrdma_idx_ring_has_ routines

Yuval Shaia (24):
      hw/pvrdma: Check the correct return value
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
 contrib/rdmacm-mux/main.c        | 798 +++++++++++++++++++++++++++++++++++++++
 contrib/rdmacm-mux/rdmacm-mux.h  |  61 +++
 docs/pvrdma.txt                  | 126 ++++++-
 hw/net/vmxnet3.c                 | 116 +-----
 hw/net/vmxnet3_defs.h            | 133 +++++++
 hw/rdma/rdma_backend.c           | 524 +++++++++++++++++++++----
 hw/rdma/rdma_backend.h           |  28 +-
 hw/rdma/rdma_backend_defs.h      |  19 +-
 hw/rdma/rdma_rm.c                | 120 +++++-
 hw/rdma/rdma_rm.h                |  17 +-
 hw/rdma/rdma_rm_defs.h           |  21 +-
 hw/rdma/rdma_utils.h             |  25 ++
 hw/rdma/vmw/pvrdma.h             |  10 +-
 hw/rdma/vmw/pvrdma_cmd.c         | 273 +++++++-------
 hw/rdma/vmw/pvrdma_dev_ring.c    |  29 +-
 hw/rdma/vmw/pvrdma_main.c        |  70 ++--
 hw/rdma/vmw/pvrdma_qp_ops.c      |  62 ++-
 include/sysemu/sysemu.h          |   1 +
 qapi/qapi-schema.json            |   1 +
 qapi/rdma.json                   |  38 ++
 vl.c                             |  15 +-
 25 files changed, 2082 insertions(+), 418 deletions(-)
 create mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/main.c
 create mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
 create mode 100644 hw/net/vmxnet3_defs.h
 create mode 100644 qapi/rdma.json

-- 
2.17.1
