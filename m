Received: from eggs.gnu.org ([2001:4830:134:3::10]:43265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e34ZV-0005LV-NZ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e34ZQ-0007ro-PL
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:20:33 -0400
Received: from mail-bl2nam02on0115.outbound.protection.outlook.com
	([104.47.38.115]:62752
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1e34ZQ-0007rB-Hj
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:20:28 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Fri, 13 Oct 2017 11:19:13 -0700
Message-Id: <20171013181913.7556-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] notdirty_mem_write: implement 8-byte accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>

Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
always turn into atomic 8-byte writes on the host, however if we missed
in the softmmu, and the TLB line was marked as not dirty, then we
would end up tearing the 8-byte write into two 4-byte writes in
access_with_adjusted_size().

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
---
This manifested as a race in lock-free synchronisation with an aarch64
Windows guest on an x86-64 host (with multithreaded TCG).

 exec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/exec.c b/exec.c
index 6378714a2b..7c591a9b75 100644
--- a/exec.c
+++ b/exec.c
@@ -2348,6 +2348,9 @@ static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
     case 4:
         stl_p(qemu_map_ram_ptr(NULL, ram_addr), val);
         break;
+    case 8:
+        stq_p(qemu_map_ram_ptr(NULL, ram_addr), val);
+        break;
     default:
         abort();
     }
@@ -2378,6 +2381,16 @@ static const MemoryRegionOps notdirty_mem_ops = {
     .write = notdirty_mem_write,
     .valid.accepts = notdirty_mem_accepts,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
 };
 
 /* Generate a debug exception if a watchpoint has been hit.  */
-- 
2.14.2
