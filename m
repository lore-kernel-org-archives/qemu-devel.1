Received: from eggs.gnu.org ([2001:4830:134:3::10]:32837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPnBN-0002KA-72
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPnBM-0005zw-3n
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:30:05 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gPnBL-0004lO-Su
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:30:04 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 11:29:45 +0000
Message-Id: <20181122112947.7586-2-peter.maydell@linaro.org>
In-Reply-To: <20181122112947.7586-1-peter.maydell@linaro.org>
References: <20181122112947.7586-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0 1/3] disas.c: Use address_space_read()
 to read memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Currently disas.c reads physical memory using
cpu_physical_memory_read(). This effectively hard-codes
assuming that all CPUs have the same view of physical
memory. Switch to address_space_read() instead, which
lets us use the AddressSpace for the CPU we're
disassembling for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/disas.c b/disas.c
index 5325b7e6be6..f9c517b3588 100644
--- a/disas.c
+++ b/disas.c
@@ -588,7 +588,10 @@ static int
 physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
                      struct disassemble_info *info)
 {
-    cpu_physical_memory_read(memaddr, myaddr, length);
+    CPUDebug *s = container_of(info, CPUDebug, info);
+
+    address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
+                       myaddr, length);
     return 0;
 }
 
-- 
2.19.1
