Received: from eggs.gnu.org ([2001:4830:134:3::10]:49030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eK7RR-00010d-O6
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eK7RO-0001QS-Na
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:50:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eK7RO-0001QD-Ga
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:50:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82430DF08
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 18:50:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 29 Nov 2017 18:50:19 +0000
Message-Id: <20171129185026.23632-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is an experimental set that reworks the way the vhost
code handles changes in physical address space layout that
came from a discussion with Igor.

Instead of updating and trying to merge sections of address
space on each add/remove callback, we wait until the commit phase
and go through and rebuild a list by walking the Flatview of
memory and end up producing an ordered list.
We compare the list to the old list to trigger updates.

Note, only very lightly tested so far, I'm just trying to see if it's
the right shape.

Igor, is this what you were intending?

Dave

Dr. David Alan Gilbert (7):
  memory: address_space_iterate
  vhost: Move log_dirty check
  vhost: New memory update functions
  vhost: update_mem_cb implementation
  vhost: Compare new and old memory lists
  vhost: Copy updated region data into device state
  vhost: Remove vhost_set_memory and children

 hw/virtio/trace-events |   8 +
 hw/virtio/vhost.c      | 424 ++++++++++++++++++++++---------------------------
 include/exec/memory.h  |  23 +++
 memory.c               |  22 +++
 4 files changed, 241 insertions(+), 236 deletions(-)

-- 
2.14.3
