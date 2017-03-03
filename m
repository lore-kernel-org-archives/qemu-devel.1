Received: from eggs.gnu.org ([2001:4830:134:3::10]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqY-00087W-Tx
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqX-0001Od-AH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:25:02 +1100
Message-Id: <20170303032507.16142-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/17] target/ppc: Add execute permission
 checking to access authority check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Basic storage protection defines various access authority permissions
based on a slb storage key and pte pp value pair. This access authority
defines read, write and execute permissions however currently we only
use this to control read and write permissions and ignore the execute
control.

Fix the code to allow execute permissions based on the key-pp value pair.
Execute is allowed under the same conditions which enable reads.
(i.e. read permission -> execute permission)

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index ee94f13..99f936d 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -308,28 +308,27 @@ static int ppc_hash64_pte_prot(PowerPCCPU *cpu,
         case 0x0:
         case 0x1:
         case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
+            prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             break;
 
         case 0x3:
         case 0x6:
-            prot = PAGE_READ;
+            prot = PAGE_READ | PAGE_EXEC;
             break;
         }
     } else {
         switch (pp) {
         case 0x0:
         case 0x6:
-            prot = 0;
             break;
 
         case 0x1:
         case 0x3:
-            prot = PAGE_READ;
+            prot = PAGE_READ | PAGE_EXEC;
             break;
 
         case 0x2:
-            prot = PAGE_READ | PAGE_WRITE;
+            prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             break;
         }
     }
-- 
2.9.3
