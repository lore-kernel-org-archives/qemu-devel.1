Received: from eggs.gnu.org ([2001:4830:134:3::10]:37040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAken-0002F3-0K
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAkej-0006oE-Oy
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:09:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:53978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1dAkej-0006ni-HB
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:09:25 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Tue, 16 May 2017 15:15:23 -0700
Message-Id: <1494972923-31756-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH] Memory: use memory address space for cpu-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Anthony Xu <anthony.xu@intel.com>

If cpu-memory address space is same as memory address space,
use memory address space for cpu-memory address space.

any memory region change causeaddress space to rebuild PhysPageMap,
rebuilding PhysPageMap is very expensive.

removing cpu-memory address space reduces the guest boot time and
memory usage.

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
---
 cpus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 740b8dc..15c7a6a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1748,8 +1748,13 @@ void qemu_init_vcpu(CPUState *cpu)
         /* If the target cpu hasn't set up any address spaces itself,
          * give it the default one.
          */
-        AddressSpace *as = address_space_init_shareable(cpu->memory,
-                                                        "cpu-memory");
+        AddressSpace *as;
+        if (cpu->memory == address_space_memory.root) {
+            address_space_memory.ref_count++;
+            as = &address_space_memory;
+        } else {
+            as = address_space_init_shareable(cpu->memory, "cpu-memory");
+        }
         cpu->num_ases = 1;
         cpu_address_space_init(cpu, as, 0);
     }
-- 
1.8.3.1
