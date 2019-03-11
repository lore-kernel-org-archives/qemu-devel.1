Received: from eggs.gnu.org ([209.51.188.92]:36314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h3IBQ-0007Xj-DS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h3IBO-0000tm-TN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h3IBO-0000sS-Gy
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:22 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 11 Mar 2019 03:29:04 -0700
Message-Id: <1552300155-25216-1-git-send-email-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v6 00/11] Misc fixes to pvrdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com

Hi,
Please review the following patch-set which consist of cosmetics fixes to
device's user interface (traces, error_report and monitor) and some bug
fixes.

Thanks Markus, Eric, Marcel and David for your review.

Review is needed for patches 4 and 11 (new)

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

v5 -> v6:
    * Add some more error reports in patch #1
    * New patch to fix an issue with call to object_get_typename

Yuval Shaia (11):
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
  hw/pvrdma: Provide correct value to object_get_typename

 hmp-commands-info.hx          |  14 ++
 hmp.c                         |  27 +++
 hmp.h                         |   1 +
 hw/rdma/Makefile.objs         |   2 +-
 hw/rdma/rdma.c                |  30 +++
 hw/rdma/rdma_backend.c        | 501 +++++++++++++++++++++---------------------
 hw/rdma/rdma_backend.h        |   7 +-
 hw/rdma/rdma_backend_defs.h   |  10 +-
 hw/rdma/rdma_rm.c             | 196 ++++++++++-------
 hw/rdma/rdma_rm.h             |  11 +-
 hw/rdma/rdma_rm_defs.h        |  28 ++-
 hw/rdma/rdma_utils.c          |  83 ++++++-
 hw/rdma/rdma_utils.h          |  61 +++--
 hw/rdma/trace-events          |  32 ++-
 hw/rdma/vmw/pvrdma.h          |  12 +-
 hw/rdma/vmw/pvrdma_cmd.c      | 115 +++-------
 hw/rdma/vmw/pvrdma_dev_ring.c |  26 +--
 hw/rdma/vmw/pvrdma_main.c     | 182 ++++++++-------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  52 ++---
 hw/rdma/vmw/trace-events      |  16 +-
 include/hw/rdma/rdma.h        |  40 ++++
 21 files changed, 817 insertions(+), 629 deletions(-)
 create mode 100644 hw/rdma/rdma.c
 create mode 100644 include/hw/rdma/rdma.h

-- 
1.8.3.1
