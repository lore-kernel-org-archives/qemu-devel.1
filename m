Received: from eggs.gnu.org ([2001:4830:134:3::10]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eZdkX-0001uP-D4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eZdkR-0004F9-FD
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:22:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:53608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eZdkR-0004Bw-4d
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:22:27 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu, 11 Jan 2018 22:22:06 +0800
Message-Id: <20180111142208.17617-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/2] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

v2 is based on Eduardo's machine-next tree. Changes of
memory-backend-file are based on my previous patches in that tree.


Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
files on ext4/xfs file system mounted with '-o dax').

This patchset enables QEMU to use MAP_SYNC flag for memory-backend-file,
in order to guarantee the guest write persistence to backend files
supporting DAX.

A new auto on/off option 'sync' is added to memory-backend-file:
 - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
        'share=off', QEMU will abort
 - off: never pass MAP_SYNC to mmap(2)
 - auto (default): if MAP_SYNC is supported and 'share=on', work as if
        'sync=on'; otherwise, work as if 'sync=off'

Changes in v2:
 * Add 'sync' option to control the use of MAP_SYNC. (Eduardo Habkost)
 * Remove the unnecessary set of MAP_SHARED_VALIDATE in some cases and
   the retry mechanism in qemu_ram_mmap(). (Michael S. Tsirkin)
 * Move OS dependent definitions of MAP_SYNC and MAP_SHARED_VALIDATE
   to osdep.h. (Michael S. Tsirkin)

Haozhong Zhang (2):
  util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap()
  hostmem-file: add 'sync' option

 backends/hostmem-file.c   | 39 ++++++++++++++++++++++++++++++++++++++-
 docs/nvdimm.txt           | 15 ++++++++++++++-
 exec.c                    | 13 ++++++++-----
 include/exec/memory.h     |  4 ++++
 include/exec/ram_addr.h   |  6 +++---
 include/qemu/mmap-alloc.h |  3 ++-
 include/qemu/osdep.h      | 16 ++++++++++++++++
 memory.c                  |  6 ++++--
 numa.c                    |  2 +-
 qemu-options.hx           | 21 ++++++++++++++++++++-
 util/mmap-alloc.c         | 24 ++++++++++++++++++++++--
 util/oslib-posix.c        |  2 +-
 12 files changed, 133 insertions(+), 18 deletions(-)

-- 
2.15.1
