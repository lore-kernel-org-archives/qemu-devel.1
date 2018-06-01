Received: from eggs.gnu.org ([2001:4830:134:3::10]:40322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOf92-0000NL-B0
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOf8x-0000Aj-Sj
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:10:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:53310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fOf8x-000096-IO
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:10:39 -0400
From: junyan.he@gmx.com
Date: Fri,  1 Jun 2018 16:10:22 +0800
Message-Id: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH V6 0/7] nvdimm: guarantee persistence of QEMU
 writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

From: Junyan He <junyan.he@intel.com>

QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
live migration. If the backend is on the persistent memory, QEMU needs
to take proper operations to ensure its writes persistent on the
persistent memory. Otherwise, a host power failure may result in the
loss the guest data on the persistent memory.

This v3 patch series is based on Marcel's patch "mem: add share
parameter to memory-backend-ram" [1] because of the changes in patch 1.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html

Previous versions can be found at
v5: https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02258.html
V4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06993.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html

Changes in v6:
* (Patch 1) Expose all ram block flags rather than redefine the flags.
* (Patch 4) Use pkg-config rather the hard check when configure. 
* (Patch 7) Sync and flush all the pmem data when migration completes,
rather than sync pages one by one in previous version.

Changes in v5:
* (Patch 9) Add post copy check and output some messages for nvdimm.

Changes in v4:
* (Patch 2) Fix compilation errors found by patchew.

Changes in v3:
* (Patch 5) Add a is_pmem flag to ram_handle_compressed() and handle
PMEM writes in it, so we don't need the _common function.
* (Patch 6) Expose qemu_get_buffer_common so we can remove the
unnecessary qemu_get_buffer_to_pmem wrapper.
* (Patch 8) Add a is_pmem flag to xbzrle_decode_buffer() and handle
PMEM writes in it, so we can remove the unnecessary
xbzrle_decode_buffer_{common, to_pmem}.
* Move libpmem stubs to stubs/pmem.c and fix the compilation failures
of test-{xbzrle,vmstate}.c.

Changes in v2:
* (Patch 1) Use a flags parameter in file ram allocation functions.
* (Patch 2) Add a new option 'pmem' to hostmem-file.
* (Patch 3) Use libpmem to operate on the persistent memory, rather
than re-implementing those operations in QEMU.
* (Patch 5-8) Consider the write persistence in the migration path.


Junyan:
[1/7] memory, exec: Expose all memory block related flags.
[6/7] migration/ram: Add check and info message to nvdimm post copy.
[7/7] migration/ram: ensure write persistence on loading all date to PMEM.

Haozhong:
[5/7] mem/nvdimm: ensure write persistence to PMEM in label emulation

Haozhong & Junyan:
[2/7] memory, exec: switch file ram allocation functions to 'flags' parameters
[3/7] hostmem-file: add the 'pmem' option
[4/7] configure: add libpmem support


Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Junyan He <junyan.he@intel.com>

---
backends/hostmem-file.c | 28 +++++++++++++++++++++++++++-
configure               | 29 +++++++++++++++++++++++++++++
docs/nvdimm.txt         | 14 ++++++++++++++
exec.c                  | 36 ++++++++++++++----------------------
hw/mem/nvdimm.c         |  9 ++++++++-
include/exec/memory.h   | 31 +++++++++++++++++++++++++++++--
include/exec/ram_addr.h | 28 ++++++++++++++++++++++++++--
include/qemu/pmem.h     | 24 ++++++++++++++++++++++++
memory.c                |  8 +++++---
migration/ram.c         | 18 ++++++++++++++++++
numa.c                  |  2 +-
qemu-options.hx         |  7 +++++++
stubs/Makefile.objs     |  1 +
stubs/pmem.c            | 23 +++++++++++++++++++++++
14 files changed, 226 insertions(+), 32 deletions(-)
-- 
2.7.4
