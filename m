Received: from eggs.gnu.org ([209.51.188.92]:57533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grxyz-0008Gj-Q9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grxyt-0005Bd-Gp
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:41:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:4391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1grxyl-000582-PE
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 23:41:33 -0500
From: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Date: Fri,  8 Feb 2019 21:12:15 +0800
Message-Id: <04efc939bd294677555deddd1b7ab68ef0fc278b.1549631480.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1549631480.git.yi.z.zhang@linux.intel.com>
References: <cover.1549631480.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel]  [PATCH V13 5/5] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 docs/nvdimm.txt | 22 +++++++++++++++++++---
 qemu-options.hx |  5 +++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 5f158a6..e70f28b 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -143,9 +143,25 @@ Guest Data Persistence
 ----------------------
 
 Though QEMU supports multiple types of vNVDIMM backends on Linux,
-currently the only one that can guarantee the guest write persistence
-is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
-which all guest access do not involve any host-side kernel cache.
+the only backend that can guarantee the guest write persistence is:
+
+A. DAX device (e.g., /dev/dax0.0, ) or
+B. DAX file(mounted with dax option)
+
+When using B (A file supporting direct mapping of persistent memory)
+as a backend, write persistence is guaranteed if the host kernel has
+support for the MAP_SYNC flag in the mmap system call (available
+since Linux 4.15 and on certain distro kernels) and additionally
+both 'pmem' and 'share' flags are set to 'on' on the backend.
+
+If these conditions are not satisfied i.e. if either 'pmem' or 'share'
+are not set, if the backend file does not support DAX or if MAP_SYNC
+is not supported by the host kernel, write persistence is not
+guaranteed after a system crash. For compatibility reasons, these
+conditions are silently ignored if not satisfied. Currently, no way
+is provided to test for them.
+For more details, please reference mmap(2) man page:
+http://man7.org/linux/man-pages/man2/mmap.2.html.
 
 When using other types of backends, it's suggested to set 'unarmed'
 option of '-device nvdimm' to 'on', which sets the unarmed flag of the
diff --git a/qemu-options.hx b/qemu-options.hx
index 08f8516..ef1da8f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4002,6 +4002,11 @@ using the SNIA NVM programming model (e.g. Intel NVDIMM).
 If @option{pmem} is set to 'on', QEMU will take necessary operations to
 guarantee the persistence of its own writes to @option{mem-path}
 (e.g. in vNVDIMM label emulation and live migration).
+Also, we will map the backend-file with MAP_SYNC flag, which ensures the
+file metadata is in sync for @option{mem-path} in case of host crash
+or a power failure. MAP_SYNC requires support from both the host kernel
+(since Linux kernel 4.15) and the filesystem of @option{mem-path} mounted
+with DAX option.
 
 @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
-- 
2.7.4
