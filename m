Received: from eggs.gnu.org ([2001:4830:134:3::10]:51797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7EA-0000sd-N2
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7E9-0001YD-SK
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7E9-0001Xk-MN
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C84DE3D975
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:13:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:13:21 +0200
Message-Id: <20170406131326.2418-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Disable hotplug during migration
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

Hi

This updates patches with all the comments received.
I move qdev_unplug() to make linux-user compile.

Please, review.


[RFC - v1]
This series disable hotplug/unplug during migration.  Thank to Markus
for explaining where I had to put the checks.  Why?  Because during
migration we will fail if there are changes.  For instance, in
postcopy, if we add a memory region, we would failing.  Same for other
devices if they are not setup exactly the same on destination.

Iidea would be to disable it, andthen enable for the thing that we know that work.

This series are on top of my previous RAMState v2 serie.

Commets, please?

Thanks, Juan.


*** BLURB HERE ***

Juan Quintela (5):
  qdev: qdev_hotplug is really a bool
  qdev: Export qdev_hot_removed
  qdev: Move qdev_unplug() to qdev-monitor.c
  migration: Disable hotplug/unplug during migration
  ram: Remove migration_bitmap_extend()

 exec.c                  |  1 -
 hw/core/qdev.c          | 40 +++-------------------------------------
 include/exec/ram_addr.h |  2 --
 include/hw/qdev-core.h  |  3 ++-
 migration/ram.c         | 34 ----------------------------------
 qdev-monitor.c          | 45 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 50 insertions(+), 75 deletions(-)

-- 
2.9.3
