Received: from eggs.gnu.org ([2001:4830:134:3::10]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iB-0001mp-Hc
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5i8-0008SU-Fb
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:35 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:06 -0500
Message-Id: <20180619014319.28272-41-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 040/113] multiboot: Reject kernels exceeding
 the address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

The code path where mh_load_end_addr is non-zero in the Multiboot
header checks that mh_load_end_addr >= mh_load_addr and so
mb_load_size is checked.  However, mb_load_size is not checked when
calculated from the file size, when mh_load_end_addr is 0.

If the kernel binary size is larger than can fit in the address space
after load_addr, we ended up with a kernel_size that is smaller than
load_size, which means that we read the file into a too small buffer.

Add a check to reject kernel files with such Multiboot headers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>
(cherry picked from commit b17a9054a0652a1481be48a6729e972abf02412f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/multiboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index d9a0a95a2f..775aa5bfd0 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -247,6 +247,10 @@ int load_multiboot(FWCfgState *fw_cfg,
             }
             mb_load_size = kernel_file_size - mb_kernel_text_offset;
         }
+        if (mb_load_size > UINT32_MAX - mh_load_addr) {
+            error_report("kernel does not fit in address space");
+            exit(1);
+        }
         if (mh_bss_end_addr) {
             if (mh_bss_end_addr < (mh_load_addr + mb_load_size)) {
                 error_report("invalid bss_end_addr address");
-- 
2.11.0
