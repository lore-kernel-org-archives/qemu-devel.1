Received: from eggs.gnu.org ([209.51.188.92]:33309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtodV-0003Ky-JR
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtoQr-0003oE-Od
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:54:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gtoQr-0003mc-Ea
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:54:09 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed, 13 Feb 2019 08:53:47 +0200
Message-Id: <20190213065357.16076-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 0/9] Misc fixes to pvrdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

Hi,
Please review the following patch-set which consist of cosmetics fixes to
device's user interface (traces, error_report and monitor) and some bug
fixes.

Thanks Markus, Eric, Marcel and David for reviewing v0.
Appreciate your review to this v2.

Still missing r-b for patches 2, 4 and 6.

v0 -> v1:
    * Explain why device attributes are exposed only in HMP interface.
    * Squash the 3 patches related to HMP interface into one.
    * Make monitor dump function simple.
    * Make HMP interface available only if pvrdma is included (detected by
      build robot).
    * Remove patch 03/10 ("Warn when too many consecutive poll CQ triggered
      on an empty CQ) and add the two counters to patch 0/7 (monitor).
    * Add Marcel's R-Bs.
    * Add mutex protection to cqe_ctx list.
    * Add two new patches.

v1 -> v2:
    * Rename locked-lists to protected-lists in patch 2 and patch 6.
    * Add Marcel's R-Bs.

Thanks,
Yuval


Yuval Shaia (9):
  hw/rdma: Switch to generic error reporting way
  hw/rdma: Introduce protected qlist
  hw/rdma: Protect against concurrent execution of poll_cq
  {monitor,hw/pvrdma}: Expose device internals via monitor interface
  hw/rdma: Free all MAD receive buffers when device is closed
  hw/rdma: Free all receive buffers when QP is destroyed
  hw/pvrdma: Delete unneeded function argument
  hw/pvrdma: Delete pvrdma_exit function
  hw/pvrdma: Unregister from shutdown notifier when device goes down

 hmp-commands-info.hx          |  16 ++
 hw/rdma/rdma_backend.c        | 483 +++++++++++++++++-----------------
 hw/rdma/rdma_backend.h        |   3 +-
 hw/rdma/rdma_backend_defs.h   |  10 +-
 hw/rdma/rdma_rm.c             | 134 +++++-----
 hw/rdma/rdma_rm_defs.h        |  28 +-
 hw/rdma/rdma_utils.c          |  79 +++++-
 hw/rdma/rdma_utils.h          |  61 ++---
 hw/rdma/trace-events          |  32 ++-
 hw/rdma/vmw/pvrdma.h          |   7 +-
 hw/rdma/vmw/pvrdma_cmd.c      | 113 ++------
 hw/rdma/vmw/pvrdma_dev_ring.c |  26 +-
 hw/rdma/vmw/pvrdma_hmp.h      |  21 ++
 hw/rdma/vmw/pvrdma_main.c     | 217 ++++++++-------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  52 +---
 hw/rdma/vmw/trace-events      |  16 +-
 monitor.c                     |  10 +
 17 files changed, 709 insertions(+), 599 deletions(-)
 create mode 100644 hw/rdma/vmw/pvrdma_hmp.h

-- 
2.17.2
