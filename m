Received: from eggs.gnu.org ([2001:4830:134:3::10]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5i0-0001cQ-Vp
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hz-0008P3-F3
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:25 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:02 -0500
Message-Id: <20180619014319.28272-37-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 036/113] multiboot: bss_end_addr can be zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jack Schwartz <jack.schwartz@oracle.com>, Kevin Wolf <kwolf@redhat.com>

From: Jack Schwartz <jack.schwartz@oracle.com>

The multiboot spec (https://www.gnu.org/software/grub/manual/multiboot/),
section 3.1.3, allows for bss_end_addr to be zero.

A zero bss_end_addr signifies there is no .bss section.

Suggested-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 2a8fcd119eb7c6bb3837fc3669eb1b2dfb31daf8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/multiboot.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index c7b70c91d5..ff2733d12e 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -233,12 +233,6 @@ int load_multiboot(FWCfgState *fw_cfg,
         mh_entry_addr = ldl_p(header+i+28);
 
         if (mh_load_end_addr) {
-            if (mh_bss_end_addr < mh_load_addr) {
-                fprintf(stderr, "invalid mh_bss_end_addr address\n");
-                exit(1);
-            }
-            mb_kernel_size = mh_bss_end_addr - mh_load_addr;
-
             if (mh_load_end_addr < mh_load_addr) {
                 fprintf(stderr, "invalid mh_load_end_addr address\n");
                 exit(1);
@@ -249,8 +243,16 @@ int load_multiboot(FWCfgState *fw_cfg,
                 fprintf(stderr, "invalid kernel_file_size\n");
                 exit(1);
             }
-            mb_kernel_size = kernel_file_size - mb_kernel_text_offset;
-            mb_load_size = mb_kernel_size;
+            mb_load_size = kernel_file_size - mb_kernel_text_offset;
+        }
+        if (mh_bss_end_addr) {
+            if (mh_bss_end_addr < (mh_load_addr + mb_load_size)) {
+                fprintf(stderr, "invalid mh_bss_end_addr address\n");
+                exit(1);
+            }
+            mb_kernel_size = mh_bss_end_addr - mh_load_addr;
+        } else {
+            mb_kernel_size = mb_load_size;
         }
 
         /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_VBE.
-- 
2.11.0
