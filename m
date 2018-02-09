Received: from eggs.gnu.org ([2001:4830:134:3::10]:35637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Br-0006Sw-VS
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006Hz-SE
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006HW-Nu
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C35784256
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 10:45:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Feb 2018 11:45:42 +0100
Message-Id: <20180209104546.29401-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] tcg: fix dirty bitmap race with MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This is a race that can happen when migrating TCG guests under load.
It was introduced by the change to run vCPUs outside the big QEMU lock.

Paolo Bonzini (4):
  memory: remove memory_region_test_and_clear_dirty
  memory: hide memory_region_sync_dirty_bitmap behind
    DirtyBitmapSnapshot
  memory: introduce memory_global_after_dirty_log_sync
  memory: unify loops to sync dirty log bitmap

 exec.c                       | 31 ++++++++++++++++++
 hw/display/cg3.c             |  1 -
 hw/display/exynos4210_fimd.c |  1 -
 hw/display/framebuffer.c     |  1 -
 hw/display/g364fb.c          |  1 -
 hw/display/sm501.c           |  1 -
 hw/display/tcx.c             |  2 --
 hw/display/vga.c             |  6 ----
 include/exec/memory.h        | 47 +++++++++------------------
 memory.c                     | 76 +++++++++++++++++---------------------------
 migration/ram.c              |  1 +
 11 files changed, 76 insertions(+), 92 deletions(-)

-- 
2.14.3
