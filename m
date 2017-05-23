Received: from eggs.gnu.org ([2001:4830:134:3::10]:45270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dD7pW-0003lY-5T
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dD7pR-00069S-8K
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:18:22 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 23 May 2017 13:18:08 +0200
Message-Id: <20170523111812.13469-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] spapr: disable hotplugging without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

If the OS is not started, QEMU sends an event to the OS
that is lost and cannot be recovered. An unplug is not
able to restore QEMU in a coherent state.
So, while the OS is not started, disable CPU and memory hotplug.
We use option vector 6 to know if the OS is started

This series moves error checking for memory hotplug
in a pre_plug function, and introduces the option
vector 6 management. It also revert previous
fix which was not really fixing the hotplug problem
when the OS is not running.

Laurent Vivier (4):
  spapr: add pre_plug function for memory
  spapr: add option vector 6
  spapr: disable hotplugging without OS
  Revert "spapr: fix memory hot-unplugging"

 hw/ppc/spapr.c              | 103 ++++++++++++++++++++++++++++++++++++--------
 hw/ppc/spapr_drc.c          |  20 ++-------
 hw/ppc/spapr_hcall.c        |   5 ++-
 hw/ppc/spapr_ovec.c         |   8 ++++
 include/hw/ppc/spapr.h      |   2 +
 include/hw/ppc/spapr_drc.h  |   1 -
 include/hw/ppc/spapr_ovec.h |   7 +++
 7 files changed, 109 insertions(+), 37 deletions(-)

-- 
2.9.4
