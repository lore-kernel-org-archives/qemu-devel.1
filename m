Received: from eggs.gnu.org ([2001:4830:134:3::10]:54362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dJ1Dq-00073H-8j
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dJ1Dn-000638-J4
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:27:50 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu,  8 Jun 2017 19:27:41 +0200
Message-Id: <20170608172743.10132-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] spapr: disable hotplugging without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

If the OS is not started, QEMU sends an event to the OS
that is lost and cannot be recovered. An unplug is not
able to restore QEMU in a coherent state.
So, while the OS is not started, disable CPU and memory hotplug.
We guess the OS is started if the CAS has been negotiated.

This series also revert previous fix which was not really fixing
the hotplug problem when the OS is not running.

v2:
- fix indent
- remove useless local_err
- allow hotplug if the VM is not started (pre-launch or incoming state)
- remove vector 6, instead just mark the end of CAS negotiation

Laurent Vivier (2):
  spapr: disable hotplugging without OS
  Revert "spapr: fix memory hot-unplugging"

 hw/ppc/spapr.c             | 51 +++++++++++++++++++++++++++++++++++++++++++---
 hw/ppc/spapr_drc.c         | 20 +++---------------
 hw/ppc/spapr_hcall.c       |  1 +
 include/hw/ppc/spapr.h     |  2 ++
 include/hw/ppc/spapr_drc.h |  1 -
 5 files changed, 54 insertions(+), 21 deletions(-)

-- 
2.9.4
