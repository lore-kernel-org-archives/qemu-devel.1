Received: from eggs.gnu.org ([2001:4830:134:3::10]:53501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gZAYj-0001WP-0i
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gZAYf-0001Ky-QI
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:16:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:47266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gZAYf-0001IF-GI
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:16:53 -0500
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Tue, 18 Dec 2018 16:16:44 +0800
Message-Id: <cover.1545120100.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V7 0/6] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peter.maydell@linaro.org, yu.c.zhang@linux.intel.com, ehabkost@redhat.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, crosthwaite.peter@gmail.com, richard.henderson@linaro.org, xiaoguangrong.eric@gmail.com, Zhang Yi <yi.z.zhang@linux.intel.com>

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

A new auto on/off option 'sync' is added to memory-backend-file:
 - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
        'share=off' or 'pmem=off', QEMU will abort
 - off: never pass MAP_SYNC to mmap(2)
 - auto (default): if MAP_SYNC is supported and 'share=on' 'pmem=on', work as if
        'sync=on'; otherwise, work as if 'sync=off'

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
  util/mmap-alloc: switch qemu_ram_mmap() to 'flags' parameter
  util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap()
  util/mmap-alloc: Switch the RAM_SYNC flags to OnOffAuto
  hostmem: add more information in error messages
  hostmem-file: add 'sync' option

 backends/hostmem-file.c   | 45 +++++++++++++++++++++++++++++++++++++++++++--
 backends/hostmem.c        |  8 +++++---
 docs/nvdimm.txt           | 22 +++++++++++++++++++++-
 exec.c                    |  9 +++++----
 include/exec/memory.h     | 18 ++++++++++++++++++
 include/exec/ram_addr.h   |  1 +
 include/qemu/mmap-alloc.h | 20 +++++++++++++++++++-
 include/qemu/osdep.h      | 29 +++++++++++++++++++++++++++++
 numa.c                    |  1 +
 qemu-options.hx           | 22 +++++++++++++++++++++-
 util/mmap-alloc.c         | 27 ++++++++++++++++++++++-----
 util/oslib-posix.c        |  8 +++++++-
 12 files changed, 192 insertions(+), 18 deletions(-)

-- 
2.7.4
