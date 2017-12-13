Received: from eggs.gnu.org ([2001:4830:134:3::10]:49678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePBS8-0000sg-24
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePBS4-00048S-W9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePBS4-00047B-Q4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:16 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 13 Dec 2017 18:08:01 +0000
Message-Id: <20171213180807.7066-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/6] Rework vhost memory region updates
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
 
v4
  Rework based on comments from Paolo; now using add/nop rather
  than doing another flatview walk.
 
Dave

Dr. David Alan Gilbert (6):
  vhost: Move log_dirty check
  vhost: Simplify ring verification checks
  vhost: Add temporary memory structure
  vhost: add regions to temporary list
  vhost: compare and flip in new memory region list
  vhost: Clean out old vhost_set_memory and friends

 hw/virtio/trace-events    |   6 +
 hw/virtio/vhost.c         | 426 +++++++++++++++-------------------------------
 include/hw/virtio/vhost.h |   4 +-
 3 files changed, 146 insertions(+), 290 deletions(-)

-- 
2.14.3
