Received: from eggs.gnu.org ([2001:4830:134:3::10]:40675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMJ-00074Y-NM
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMI-00043w-Aw
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Mar 2018 15:18:59 +1100
Message-Id: <20180315041903.10046-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180315041903.10046-1-david@gibson.dropbear.id.au>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 5/9] PPC e500: Fix gap between u-boot and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Engraf <david.engraf@sysgo.com>, David Gibson <david@gibson.dropbear.id.au>

From: David Engraf <david.engraf@sysgo.com>

This patch moves the gap between u-boot and kernel at the correct location.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 43c15d18c4..bdef2bddc6 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1009,6 +1009,10 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     }
 
     cur_base = loadaddr + payload_size;
+    if (cur_base < (32 * 1024 * 1024)) {
+        /* u-boot occupies memory up to 32MB, so load blobs above */
+        cur_base = (32 * 1024 * 1024);
+    }
 
     /* Load bare kernel only if no bios/u-boot has been provided */
     if (machine->kernel_filename && !kernel_as_payload) {
@@ -1025,11 +1029,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         cur_base += kernel_size;
     }
 
-    if (cur_base < (32 * 1024 * 1024)) {
-        /* u-boot occupies memory up to 32MB, so load blobs above */
-        cur_base = (32 * 1024 * 1024);
-    }
-
     /* Load initrd. */
     if (machine->initrd_filename) {
         initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
-- 
2.14.3
