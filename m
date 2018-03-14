Received: from eggs.gnu.org ([2001:4830:134:3::10]:34744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGH-00038j-SI
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGG-0004C4-2S
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 14 Mar 2018 18:32:09 +0100
Message-Id: <20180314173213.18563-2-kwolf@redhat.com>
In-Reply-To: <20180314173213.18563-1-kwolf@redhat.com>
References: <20180314173213.18563-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] multiboot: Reject kernels exceeding the
 address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, jack.schwartz@oracle.com, anatol.pomozov@gmail.com, ppandit@redhat.com

The code path with a manually set mh_load_addr in the Multiboot header
checks that load_end_addr <= load_addr, but the path where load_end_addr
is automatically detected if 0 is given in the header misses the
corresponding check. If the kernel binary size is larger than can fit in
the address space after load_addr, we ended up with a kernel_size that
is smaller than load_size, which means that we read the file into a too
small buffer.

Add a check to reject kernel files with such Multiboot headers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/i386/multiboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index b9064264d8..1e215bf8d3 100644
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
2.13.6
