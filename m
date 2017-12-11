Received: from eggs.gnu.org ([2001:4830:134:3::10]:33808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOU1t-00084O-AP
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOU1q-0006RA-7s
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOU1q-0006Pq-1h
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 14:46:18 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 11 Dec 2017 19:46:02 +0000
Message-Id: <20171211194610.3962-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/8] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This patch set reworks the way the vhost code handles changes in
physical address space layout that came from a discussion with Igor.

Its intention is to simplify a lot of the update code,
and to make it easier for the postcopy+shared code to
do the hugepage alignments that are needed.

Instead of updating and trying to merge sections of address
space on each add/remove callback, we wait until the commit phase
and go through and rebuild a list by walking the Flatview of
memory and end up producing an ordered list.
We compare the list to the old list to trigger updates.

v3
  Fix misordered comparison (that is removed later in the series)
  A few spelling fixes
  Now bisect builds, make checks and passes a test with hotlug
  memory on real vhost.

Dave


Dr. David Alan Gilbert (8):
  memory: address_space_iterate
  vhost: Move log_dirty check
  vhost: Simplify ring verification checks
  vhost: New memory update functions
  vhost: update_mem_cb implementation
  vhost: Compare and copy updated region data into device state
  vhost: Remove old vhost_set_memory etc
  vhost: Move mem_sections maintenance into commit/update routines

 hw/virtio/trace-events    |   7 +
 hw/virtio/vhost.c         | 498 ++++++++++++++++------------------------------
 include/exec/memory.h     |  23 +++
 include/hw/virtio/vhost.h |   3 -
 memory.c                  |  22 ++
 5 files changed, 226 insertions(+), 327 deletions(-)

-- 
2.14.3
