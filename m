Received: from eggs.gnu.org ([2001:4830:134:3::10]:59526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fKbMm-0004P6-BB
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fKbMi-0000jZ-8J
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:20:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:57533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fKbMh-0000iD-VU
	for qemu-devel@nongnu.org; Sun, 20 May 2018 23:20:04 -0400
Message-ID: <trinity-ed52b923-8346-4deb-9ec8-d425e2c2d8ba-1526872788874@3c-app-mailcom-bs01>
From: "Junyan He" <junyan.he@gmx.com>
Date: Mon, 21 May 2018 05:19:48 +0200
In-Reply-To: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V5 0/9] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net

   Ping for review, thanks

   Sent: Thursday, May 10, 2018 at 10:08 AM
   From: junyan.he@gmx.com
   To: qemu-devel@nongnu.org
   Cc: "Haozhong Zhang" <haozhong.zhang@intel.com>,
   xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com,
   mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com,
   quintela@redhat.com, "Junyan He" <junyan.he@intel.com>,
   stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
   rth@twiddle.net
   Subject: [Qemu-devel] [PATCH V5 0/9] nvdimm: guarantee persistence of
   QEMU writes to persistent memory
   From: Junyan He <junyan.he@intel.com>
   QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
   live migration. If the backend is on the persistent memory, QEMU needs
   to take proper operations to ensure its writes persistent on the
   persistent memory. Otherwise, a host power failure may result in the
   loss the guest data on the persistent memory.
   This v3 patch series is based on Marcel's patch "mem: add share
   parameter to memory-backend-ram" [1] because of the changes in patch 1.
   [1]
   [1]https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html
   Previous versions can be found at
   V4:
   [2]https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06993.html
   v3:
   [3]https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
   v2:
   [4]https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
   v1:
   [5]https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html
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
   Haozhong Zhang (8):
   [1/9] memory, exec: switch file ram allocation functions to 'flags'
   parameters
   [2/9] hostmem-file: add the 'pmem' option
   [3/9] configure: add libpmem support
   [4/9] mem/nvdimm: ensure write persistence to PMEM in label emulation
   [5/9] migration/ram: ensure write persistence on loading zero pages to
   PMEM
   [6/9] migration/ram: ensure write persistence on loading normal pages
   to PMEM
   [7/9] migration/ram: ensure write persistence on loading compressed
   pages to PMEM
   [8/9] migration/ram: ensure write persistence on loading xbzrle pages
   to PMEM
   Junyan He (1):
   [9/9] migration/ram: Add check and info message to nvdimm post copy.
   Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
   Signed-off-by: Junyan He <junyan.he@intel.com>
   ---
   backends/hostmem-file.c | 27 ++++++++++++++++++++++++++-
   configure | 35 +++++++++++++++++++++++++++++++++++
   docs/nvdimm.txt | 14 ++++++++++++++
   exec.c | 20 ++++++++++++++++----
   hw/mem/nvdimm.c | 9 ++++++++-
   include/exec/memory.h | 12 ++++++++++--
   include/exec/ram_addr.h | 28 ++++++++++++++++++++++++++--
   include/migration/qemu-file-types.h | 2 ++
   include/qemu/pmem.h | 27 +++++++++++++++++++++++++++
   memory.c | 8 +++++---
   migration/qemu-file.c | 29 +++++++++++++++++++----------
   migration/ram.c | 52
   ++++++++++++++++++++++++++++++++++++++++++----------
   migration/ram.h | 2 +-
   migration/rdma.c | 2 +-
   migration/xbzrle.c | 8 ++++++--
   migration/xbzrle.h | 3 ++-
   numa.c | 2 +-
   qemu-options.hx | 7 +++++++
   stubs/Makefile.objs | 1 +
   stubs/pmem.c | 37 +++++++++++++++++++++++++++++++++++++
   tests/Makefile.include | 4 ++--
   tests/test-xbzrle.c | 4 ++--
   22 files changed, 290 insertions(+), 43 deletions(-)
   --
   2.7.4

References

   1. https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html
   2. https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06993.html
   3. https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
   4. https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
   5. https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html
