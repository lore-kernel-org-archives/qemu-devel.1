Received: from eggs.gnu.org ([2001:4830:134:3::10]:58742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3478c7289=igor.druzhinin@citrix.com>)
	id 1dQySQ-0007Mf-KM
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3478c7289=igor.druzhinin@citrix.com>)
	id 1dQySH-0006tq-5p
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:07:42 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:4938
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3478c7289=igor.druzhinin@citrix.com>)
	id 1dQySG-0006tJ-QL
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:07:37 -0400
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Fri, 30 Jun 2017 17:07:01 +0100
Message-ID: <1498838825-23701-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] xen: don't save/restore the physmap on VM
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: Igor Druzhinin <igor.druzhinin@citrix.com>, sstabellini@kernel.org, anthony.perard@citrix.com, paul.durrant@citrix.com, pbonzini@redhat.com

Saving/restoring the physmap to/from xenstore was introduced to
QEMU majorly in order to cover up the VRAM region restore issue.
The sequence of restore operations implies that we should know
the effective guest VRAM address *before* we have the VRAM region
restored (which happens later). Unfortunately, in Xen environment
VRAM memory does actually belong to a guest - not QEMU itself -
which means the position of this region is unknown beforehand and
can't be mapped into QEMU address space immediately.

Previously, recreating xenstore keys, holding the physmap, by the
toolstack helped to get this information in place at the right
moment ready to be consumed by QEMU to map the region properly.
But using xenstore for it has certain disadvantages: toolstack
needs to be aware of these keys and save/restore them accordingly;
accessing xenstore requires extra privileges which hinders QEMU
sandboxing.

The previous attempt to get rid of that was to remember all the
VRAM pointers during QEMU initialization phase and then update
them all at once when an actual foreign mapping is established.
Unfortunately, this approach worked only for VRAM and only for
a predefined set of devices - stdvga and cirrus. QXL and other
possible future devices using a moving emulated MMIO region
would be equally broken.

The new approach leverages xenforeignmemory_map2() call recently
introduced in libxenforeignmemory. It allows to create a dummy
anonymous mapping for QEMU during its initialization and change
it to a real one later during machine state restore.

Igor Druzhinin (4):
  xen: move physmap saving into a separate function
  xen/mapcache: add an ability to create dummy mappings
  xen/mapcache: introduce xen_remap_cache_entry()
  xen: don't use xenstore to save/restore physmap anymore

 configure                     |  18 ++++++
 hw/i386/xen/xen-hvm.c         | 100 ++++++++++++++++++++------------
 hw/i386/xen/xen-mapcache.c    | 129 +++++++++++++++++++++++++++++++++++++++---
 include/hw/xen/xen_common.h   |   8 +++
 include/sysemu/xen-mapcache.h |   6 ++
 5 files changed, 217 insertions(+), 44 deletions(-)

-- 
2.7.4
