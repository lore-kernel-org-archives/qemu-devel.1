Received: from eggs.gnu.org ([209.51.188.92]:51073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gizWZ-0004I9-Bz
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gizWY-0000gB-Ie
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:31:19 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 Jan 2019 11:31:04 +0100
Message-Id: <20190114103110.10909-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] s390x/pci: hotplug handler fixes and
 reworks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

A bunch of fixes and reworks for s390x/pci hotplug infrastructure.

Patch 1,2: Reworks already posted (pre_plug handler)
Patch 3,4: Fixes for memory leaks
Patch 5: Rework unplug handler (introduce unplug_request handler) which
         also fixes some unplug scenarios
Patch 6: Handle leftover unplug requests on reset

We might decide to drop 1. 3 and 4 can be picked up independently.

v1 -> v2:
- Some rewordings in patch descriptions
- "s390x/pci: Introduce unplug requests and split unplug handler"
-- Some simplifications regarding s390_pci_perform_unplug()

David Hildenbrand (6):
  s390x/pci: Use hotplug_dev instead of looking up the host bridge
  s390x/pci: Move some hotplug checks to the pre_plug handler
  s390x/pci: Always delete and free the release_timer
  s390x/pci: Ignore the unplug call if we already have a release_timer
  s390x/pci: Introduce unplug requests and split unplug handler
  s390x/pci: Unplug remaining devices on pcihost reset

 hw/s390x/s390-pci-bus.c | 215 +++++++++++++++++++++++++++-------------
 hw/s390x/s390-pci-bus.h |   1 +
 2 files changed, 148 insertions(+), 68 deletions(-)

-- 
2.17.2
