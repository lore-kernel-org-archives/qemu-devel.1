Received: from eggs.gnu.org ([209.51.188.92]:35618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1goMjP-0003CZ-QW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1goMjO-0006T5-Ee
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:18:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:34449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1goMjO-0006P9-6Z
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:18:46 -0500
From: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Date: Tue, 29 Jan 2019 22:49:18 +0800
Message-Id: <4f91d5a46fc26d5672c91d80b78e986d4267c612.1548771590.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1548771590.git.yi.z.zhang@linux.intel.com>
References: <cover.1548771590.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel]  [PATCH v11 3/3] docs: Added MAP_SYNC documentation
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
 docs/nvdimm.txt | 29 ++++++++++++++++++++++++++++-
 qemu-options.hx |  4 ++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 5f158a6..9da96aa 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -142,11 +142,38 @@ backend of vNVDIMM:
 Guest Data Persistence
 ----------------------
 
+vNVDIMM is designed and implemented to guarantee the guest data
+persistence on the backends in case of host crash or a power failures.
+However, there are still some requirements and limitations
+as explained below.
+
 Though QEMU supports multiple types of vNVDIMM backends on Linux,
-currently the only one that can guarantee the guest write persistence
+if MAP_SYNC is not supported by the host kernel and the backends,
+the only backend that can guarantee the guest write persistence
 is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
 which all guest access do not involve any host-side kernel cache.
 
+mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
+systems, QEMU can mmap(2) the dax backend files with MAP_SYNC, which
+ensures filesystem metadata consistency in case of a host crash or a power
+failure. Enabling MAP_SYNC in QEMU requires below conditions
+
+ - 'pmem' option of memory-backend-file is 'on':
+   The backend is a file supporting DAX, e.g., a file on an ext4 or
+   xfs file system mounted with '-o dax'. if your pmem=on ,but the backend is
+   not a file supporting DAX, mapping with this flag results in an EOPNOTSUPP
+   warning. then MAP_SYNC will be ignored
+
+ - 'share' option of memory-backend-file is 'on':
+   MAP_SYNC flag available only with the MAP_SHARED_VALIDATE mapping type.
+
+ - 'MAP_SYNC' is supported on linux kernel.(default opened since Linux 4.15)
+
+Otherwise, We will ignore the MAP_SYNC flag.
+
+For more details, please reference mmap(2) man page:
+http://man7.org/linux/man-pages/man2/mmap.2.html.
+
 When using other types of backends, it's suggested to set 'unarmed'
 option of '-device nvdimm' to 'on', which sets the unarmed flag of the
 guest NVDIMM region mapping structure.  This unarmed flag indicates
diff --git a/qemu-options.hx b/qemu-options.hx
index 08f8516..0cd41f4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4002,6 +4002,10 @@ using the SNIA NVM programming model (e.g. Intel NVDIMM).
 If @option{pmem} is set to 'on', QEMU will take necessary operations to
 guarantee the persistence of its own writes to @option{mem-path}
 (e.g. in vNVDIMM label emulation and live migration).
+Also, we will map the backend-file with MAP_SYNC flag, which can ensure
+the file metadata is in sync to @option{mem-path} in case of host crash
+or a power failure. MAP_SYNC requires support from both the host kernel
+(since Linux kernel 4.15) and @option{mem-path} (only files supporting DAX).
 
 @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
-- 
2.7.4
