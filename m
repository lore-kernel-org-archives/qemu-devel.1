Received: from eggs.gnu.org ([2001:4830:134:3::10]:56601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3512ce2cb=igor.druzhinin@citrix.com>)
	id 1dSQ3j-0006oV-0E
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3512ce2cb=igor.druzhinin@citrix.com>)
	id 1dSQ3f-0007zl-QM
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:48:15 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:31685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3512ce2cb=igor.druzhinin@citrix.com>)
	id 1dSQ3f-0007yI-F6
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:48:11 -0400
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Tue, 4 Jul 2017 16:47:43 +0100
Message-ID: <1499183267-28623-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] xen: don't save/restore the physmap on
 VM save/restore
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

---
Changed in v2:
* Patch 2: set dummy flag in a new flags field in struct MapCacheEntry
* Patch 3: change xen_remap_cache_entry name and signature
* Patch 3: gate ram_block_notify_* functions in xen_remap_bucket
* Patch 3: rewrite the logic of xen_replace_cache_entry_unlocked to
           reuse the existing entry instead of allocating a new one
* Patch 4: don't use xen_phys_offset_to_gaddr in non-compat mode

---
Igor Druzhinin (4):
  xen: move physmap saving into a separate function
  xen/mapcache: add an ability to create dummy mappings
  xen/mapcache: introduce xen_replace_cache_entry()
  xen: don't use xenstore to save/restore physmap anymore

 configure                     |  18 +++++++
 hw/i386/xen/xen-hvm.c         | 105 ++++++++++++++++++++++++++---------------
 hw/i386/xen/xen-mapcache.c    | 107 ++++++++++++++++++++++++++++++++++++++----
 include/hw/xen/xen_common.h   |   8 ++++
 include/sysemu/xen-mapcache.h |  11 ++++-
 5 files changed, 201 insertions(+), 48 deletions(-)

-- 
2.7.4
