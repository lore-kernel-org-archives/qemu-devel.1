Received: from eggs.gnu.org ([2001:4830:134:3::10]:50085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffJX6-0002y6-UE
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffJX2-0007Vb-Gc
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:18700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1ffJX2-0007Ug-7C
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:20 -0400
From: junyan.he@gmx.com
Date: Tue, 17 Jul 2018 14:32:03 +0800
Message-Id: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 0/7 V10] nvdimm: guarantee persistence of QEMU
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
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and live migration.
If the backend is on the persistent memory, QEMU needs to take proper operations to
ensure its writes persistent on the persistent memory. Otherwise, a host power failure
may result in the loss the guest data on the persistent memory.

This patch series is based on Marcel's patch "mem: add share parameter to memory-backend-ram" [1]
because of the changes in patch 1.
[1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html

Previous versions of this patch series can be found at: 
v9: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02361.html
v8: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg02279.html
v7: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02997.html
v6: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00061.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02258.html
V4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06993.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html

Changes in v10:
* (Patch 4) Fix a nit in nvdimm docs about pmem option usage in command line 
The v10 patch set is all reviewed by Igor Mammedov <imammedo@redhat.com>

Changes in v9:
* (Patch 3 and Patch 4) Reorder these two patches to make logic right.
Firstly add libpmem support, and then we can use libpmem's configure
check result. Also fix some typo and grammar issues in these two patches.

Changs in v8: 
* (Patch 3) Report a error when user set 'pmem' to file-backend, while
the qemu is lack of libpmem support. In this case, we can not ensure
the persistence of the file-backend, so we choose to fail the build
rather than contine and make the thing more confused.

Changes in v7: 
The v6 patch set has already reviewed by Stefan Hajnoczi <stefanha@redhat.com>
No logic change in this v7 version, just:
* Spelling check and some document words refined.
* Rebase to "ram is migratable" patch set.

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
[3/7] configure: add libpmem support [4/7] hostmem-file: add the 'pmem' option
[4/7] hostmem-file: add the 'pmem' option

--
 backends/hostmem-file.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 configure               | 29 +++++++++++++++++++++++++++++
 docs/nvdimm.txt         | 22 ++++++++++++++++++++++
 exec.c                  | 38 +++++++++++++-------------------------
 hw/mem/nvdimm.c         |  9 ++++++++-
 include/exec/memory.h   | 31 +++++++++++++++++++++++++++++--
 include/exec/ram_addr.h | 28 ++++++++++++++++++++++++++--
 include/qemu/pmem.h     | 24 ++++++++++++++++++++++++
 memory.c                |  8 +++++---
 migration/ram.c         | 17 +++++++++++++++++
 numa.c                  |  2 +-
 qemu-options.hx         |  7 +++++++
 stubs/Makefile.objs     |  1 +
 stubs/pmem.c            | 23 +++++++++++++++++++++++
 14 files changed, 246 insertions(+), 35 deletions(-)
 create mode 100644 include/qemu/pmem.h
 create mode 100644 stubs/pmem.c

-- 
2.7.4
