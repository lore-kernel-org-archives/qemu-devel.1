Received: from eggs.gnu.org ([2001:4830:134:3::10]:52127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eR1nM-0005wh-GK
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eR1nI-0003BA-1W
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:13:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eR1nH-0003AH-LQ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:13:47 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 18 Dec 2017 20:13:33 +0000
Message-Id: <20171218201340.27583-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

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

v5
  Solve the unref race found by Igor with a new 1st patch
  Now we've got a temporary section list rework the rest of the set
   around that.

Dr. David Alan Gilbert (7):
  vhost: Build temporary section list and deref after commit
  vhost: Move log_dirty check
  vhost: Simplify ring verification checks
  vhost: Merge sections added to temporary list
  vhost: Regenerate region list from changed sections list
  vhost: Clean out old vhost_set_memory and friends
  vhost: Merge and delete unused callbacks

 hw/virtio/trace-events    |   6 +
 hw/virtio/vhost.c         | 490 ++++++++++++++++------------------------------
 include/hw/virtio/vhost.h |   5 +-
 3 files changed, 174 insertions(+), 327 deletions(-)

-- 
2.14.3
