Received: from eggs.gnu.org ([2001:4830:134:3::10]:56315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGFHr-0007Gg-DA
	for qemu-devel@nongnu.org; Wed, 31 May 2017 21:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGFHp-0005uA-QN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 21:52:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  1 Jun 2017 11:52:14 +1000
Message-Id: <20170601015218.9299-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The code managing DRCs[0] has quite a few things that are more
complicated than they need to be.  In particular the object
representing a DRC has a bunch of method pointers, despite the fact
that there are currently no subclasses, and even if there were the
method implementations would be unlikely to differ.

This appears to be a misguided attempt to "abstract" or hide things in
a way which is bureaucraticl, rather than meaningful.  We may have an
object model, but we don't have to adopt Java's kingdom-of-nouns
nonsense[1].

This series makes a start on simplifying things.  There's still plenty
more, but you have to start somewhere.

[0] "Dynamic Reconfiguration Connectors" a firmware abstraction used
    in hotplug operations
[1] https://steve-yegge.blogspot.com.au/2006/03/execution-in-kingdom-of-nouns.html

David Gibson (4):
  spapr: Move DRC RTAS calls into spapr_drc.c
  spapr: Abolish DRC get_fdt method
  spapr: Abolish DRC set_configured method
  spapr: Make DRC get_index and get_type methods into plain functions

 hw/ppc/spapr.c             |  13 +-
 hw/ppc/spapr_drc.c         | 404 ++++++++++++++++++++++++++++++++++++++-------
 hw/ppc/spapr_events.c      |  10 +-
 hw/ppc/spapr_pci.c         |   4 +-
 hw/ppc/spapr_rtas.c        | 304 ----------------------------------
 hw/ppc/trace-events        |   2 -
 include/hw/ppc/spapr_drc.h |   9 +-
 7 files changed, 355 insertions(+), 391 deletions(-)

-- 
2.9.4
