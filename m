Received: from eggs.gnu.org ([2001:4830:134:3::10]:50101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNPKW-0002JC-SU
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNPKT-0001Jd-H8
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eNPKT-0001JG-BC
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:05 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Dec 2017 20:32:49 +0000
Message-Id: <20171208203257.13102-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/8] Rework vhost memory region updates
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
  This is an experimental set that reworks the way the vhost
code handles changes in physical address space layout that
came from a discussion with Igor.

It's intention is to simplify a lot of the update code,
and to make it easier for the postcopy+shared code to
do the hugepage alignments that are needed.

Instead of updating and trying to merge sections of address
space on each add/remove callback, we wait until the commit phase
and go through and rebuild a list by walking the Flatview of
memory and end up producing an ordered list.
We compare the list to the old list to trigger updates.

This is pretty lightly tested (not least because I can't
get vhost-user+hot-add memory to survive even upstream).

v2
  Incorporate changes and code from Igor, in particular the simpler
  ring verification checks and thus the removal of the complex
  comparison code.

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
 hw/virtio/vhost.c         | 504 ++++++++++++++++------------------------------
 include/exec/memory.h     |  23 +++
 include/hw/virtio/vhost.h |   3 -
 memory.c                  |  22 ++
 5 files changed, 229 insertions(+), 330 deletions(-)

-- 
2.14.3
