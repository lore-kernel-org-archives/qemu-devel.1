Received: from eggs.gnu.org ([209.51.188.92]:47471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6A-0000XD-A4
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u69-0007Mk-FK
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h2u69-0007Lv-5Q
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:21 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun, 10 Mar 2019 10:46:00 +0200
Message-Id: <20190310084610.23077-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v5 00/10] Misc fixes to pvrdma device
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

Thanks Markus, Eric, Marcel and David for your review

Review is needed for patch #4 - "hw/pvrdma: Collect debugging statistics"

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

v2 -> v3:
    * Address some 32 bit host compilation issues.

v3 -> v4:
    * Per suggestion from Markus rebase HMP report on
      object_child_foreach_recursive().
    * Strip off David's r-b from HMP patch (#4) because of the above.

v4 -> v5:
    * Accept comments from Marcus and David
        * Rename RDMA device interface
        * Split patch #4 into 2 patches
        * Add some more counters
    * Add Marcus and David ack-by to hmp patch

Yuval Shaia (10):
  hw/rdma: Switch to generic error reporting way
  hw/rdma: Introduce protected qlist
  hw/rdma: Protect against concurrent execution of poll_cq
  hw/pvrdma: Collect debugging statistics
  {hmp, hw/pvrdma}: Expose device internals via monitor interface
  hw/rdma: Free all MAD receive buffers when device is closed
  hw/rdma: Free all receive buffers when QP is destroyed
  hw/pvrdma: Delete unneeded function argument
  hw/pvrdma: Delete pvrdma_exit function
  hw/pvrdma: Unregister from shutdown notifier when device goes down

 hmp-commands-info.hx          |  14 +
 hmp.c                         |  27 ++
 hmp.h                         |   1 +
 hw/rdma/Makefile.objs         |   2 +-
 hw/rdma/rdma.c                |  30 +++
 hw/rdma/rdma_backend.c        | 483 +++++++++++++++++-----------------
 hw/rdma/rdma_backend.h        |   3 +-
 hw/rdma/rdma_backend_defs.h   |  10 +-
 hw/rdma/rdma_rm.c             | 193 ++++++++------
 hw/rdma/rdma_rm.h             |   7 +-
 hw/rdma/rdma_rm_defs.h        |  28 +-
 hw/rdma/rdma_utils.c          |  83 +++++-
 hw/rdma/rdma_utils.h          |  61 ++---
 hw/rdma/trace-events          |  32 ++-
 hw/rdma/vmw/pvrdma.h          |  12 +-
 hw/rdma/vmw/pvrdma_cmd.c      | 115 +++-----
 hw/rdma/vmw/pvrdma_dev_ring.c |  26 +-
 hw/rdma/vmw/pvrdma_main.c     | 168 ++++++------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  52 +---
 hw/rdma/vmw/trace-events      |  16 +-
 include/hw/rdma/rdma.h        |  40 +++
 21 files changed, 796 insertions(+), 607 deletions(-)
 create mode 100644 hw/rdma/rdma.c
 create mode 100644 include/hw/rdma/rdma.h

-- 
2.17.2
