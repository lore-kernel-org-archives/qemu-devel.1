Received: from eggs.gnu.org ([2001:4830:134:3::10]:55388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ecU59-0007Rb-4V
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ecU56-0002gT-38
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:39:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ecU55-0002en-TO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:39:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4CFCCDB
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:39:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 19 Jan 2018 10:39:17 +0000
Message-Id: <20180119103924.332-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v7 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This patch set reworks the way the vhost code handles changes in
physical address space layout that came from a discussion with Igor.

Its intention is to simplify a lot of the update code,
and to make it easier for the postcopy+shared code to
do the hugepage alignments that are needed.

Instead of inserting/removing each section during the add/del
callbacks of the listener, we start afresh and build a list
from the add and nop callbacks, then at the end compare the list
we've built with the exisiting list.

v7
  Avoid calling memcmp(NULL,NULL,0) in region list compare

v6
  Tidy ups from Igor
  The biggest change is moving the 'Move log_dirty check' to be
  the last patch in the set.

Dr. David Alan Gilbert (7):
  vhost: Build temporary section list and deref after commit
  vhost: Simplify ring verification checks
  vhost: Merge sections added to temporary list
  vhost: Regenerate region list from changed sections list
  vhost: Clean out old vhost_set_memory and friends
  vhost: Merge and delete unused callbacks
  vhost: Move log_dirty check

 hw/virtio/trace-events    |   6 +
 hw/virtio/vhost.c         | 497 ++++++++++++++++------------------------------
 include/hw/virtio/vhost.h |   5 +-
 3 files changed, 180 insertions(+), 328 deletions(-)

-- 
2.14.3
