Received: from eggs.gnu.org ([209.51.188.92]:46181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gjgGu-0004Pm-Jw
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gjgGt-0005Uj-9Y
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:10:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:6612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gjgGr-0005OD-QW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:09:58 -0500
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Wed, 16 Jan 2019 16:10:06 +0800
Message-Id: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V9 0/6] support MAP_SYNC for memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>

Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
files on ext4/xfs file system mounted with '-o dax').

A description of MAP_SYNC and MAP_SHARED_VALIDATE can be found at
    https://patchwork.kernel.org/patch/10028151/

In order to make sure that the file metadata is in sync after a fault 
while we are writing a shared DAX supporting backend files, this
patch-set enables QEMU to use MAP_SYNC flag for memory-backend-dax-file.

As the DAX vs DMA truncated issue was solved, we refined the code and
send out this feature for the v5 version.

We will pass MAP_SYNC to mmap(2); if MAP_SYNC is supported and
'share=on' & 'pmem=on'. 
Or QEMU will not pass this flag to mmap(2)

Changes in V9:
 * 1/6: Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
 * 2/6: New Added: Micheal: use sparse feature define RAM_FLAG. 
 since I don't have much knowledge about the sparse feature, @Micheal Could you 
 add some documentation/commit message on this patch? Thank you very much.
 * 3/6: from 2/5: Eduardo: updated the commit message. 
 * 4/6: from 3/5: Micheal: don't ignore MAP_SYNC failures silently.
 * 5/6: from 4/5: Eduardo: updated the commit message.
 * 6/6: from 5/5: Micheal: Drop the sync option, document the MAP_SYNC.

Changes in v8:
 * Micheal: 3/5, remove the duplicated define in the os_dep.h
 * Micheal: 2/5, make type define safety.
 * Micheal: 2/5, fixed the incorrect define MAP_SHARE on qemu_anon_ram_alloc.
 * 4/6 removed, we remove the on/off/auto define of sync,  as by now,
   MAP_SYNC only worked with pmem=on.
 * @Micheal, I still reuse the RAM_SYNC flag, it is much straightforward to parse 
   all the flags in one parameter.

Changes in v7:
 * Micheal: [3,4,6]/6 limited the "sync" flag only on a nvdimm backend.(pmem=on)

Changes in v6:
 * Pankaj: 3/7 are squashed with 2/7
 * Pankaj: 7/7 update comments to "consistent filesystem metadata".
 * Pankaj, Igor: 1/7 Added Reviewed-by in patch-1/7
 * Stefan, 4/7 move the include header from "/linux/mman.h" to "osdep.h"
 * Stefan, 5/7 Add missing "munmap"
 * Stefan, 2/7 refine the shared/flag.

Changes in v5:
 * Add patch 1 to fix a memory leak issue.
 * Refine the patch 4-6
 * Remove the patch 3 as we already change the parameter from "shared" to
   "flags"

Changes in v4:
 * Add patch 1-3 to switch some functions to a single 'flags'
   parameters. (Michael S. Tsirkin)
 * v3 patch 1-3 become v4 patch 4-6.
 * Patch 4: move definitions of MAP_SYNC and MAP_SHARED_VALIDATE to a
   new header file under include/standard-headers/linux/. (Michael S. Tsirkin)
 * Patch 6: refine the description of the 'sync' option. (Michael S. Tsirkin)

Changes in v3:
 * Patch 1: add MAP_SHARED_VALIDATE in both sync=on and sync=auto
   cases, and add back the retry mechanism. MAP_SYNC will be ignored
   by Linux kernel 4.15 if MAP_SHARED_VALIDATE is missed.
 * Patch 1: define MAP_SYNC and MAP_SHARED_VALIDATE as 0 on non-Linux
   platforms in order to make qemu_ram_mmap() compile on those platforms.
 * Patch 2&3: include more information in error messages of
   memory-backend in hope to help user to identify the error.
   (Dr. David Alan Gilbert)
 * Patch 3: fix typo in the commit message. (Dr. David Alan Gilbert)

Changes in v2:
 * Add 'sync' option to control the use of MAP_SYNC. (Eduardo Habkost)
 * Remove the unnecessary set of MAP_SHARED_VALIDATE in some cases and
   the retry mechanism in qemu_ram_mmap(). (Michael S. Tsirkin)
 * Move OS dependent definitions of MAP_SYNC and MAP_SHARED_VALIDATE
   to osdep.h. (Michael S. Tsirkin)

Zhang Yi (6):
  numa: Fixed the memory leak of numa error message
  memory: use sparse feature define RAM_FLAG.
  util/mmap-alloc: switch 'shared' to 'flags' parameter
  util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap()
  hostmem: add more information in error messages
  docs: Added MAP_SYNC documentation

 backends/hostmem-file.c   |  6 ++++--
 backends/hostmem.c        |  8 +++++---
 docs/nvdimm.txt           | 21 ++++++++++++++++++++-
 exec.c                    |  7 ++++---
 include/exec/memory.h     | 12 ++++++------
 include/qemu/mmap-alloc.h | 20 +++++++++++++++++++-
 include/qemu/osdep.h      | 25 +++++++++++++++++++++++++
 numa.c                    |  1 +
 qemu-options.hx           |  4 ++++
 util/mmap-alloc.c         | 15 +++++++++++----
 util/oslib-posix.c        |  9 ++++++++-
 11 files changed, 107 insertions(+), 21 deletions(-)

-- 
2.7.4
