Received: from eggs.gnu.org ([2001:4830:134:3::10]:32811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPnBL-0002JD-SJ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPnBL-0005sC-5C
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:30:03 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gPnBK-0004lO-TV
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:30:03 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 11:29:46 +0000
Message-Id: <20181122112947.7586-3-peter.maydell@linaro.org>
In-Reply-To: <20181122112947.7586-1-peter.maydell@linaro.org>
References: <20181122112947.7586-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0 2/3] monitor: Use address_space_read()
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

Currently monitor.c reads physical memory using
cpu_physical_memory_read(). This effectively hard-codes
assuming that all CPUs have the same view of physical
memory. Switch to address_space_read() instead, which
lets us use the AddressSpace for the CPU we're
reading memory for (falling back to address_space_memory
if there is no CPU, as happens with the "none" board).
As a bonus, this allows us to detect failures to read memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 monitor.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index d39390c2f2f..b0e8f2c490a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1604,7 +1604,13 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
         if (l > line_size)
             l = line_size;
         if (is_physical) {
-            cpu_physical_memory_read(addr, buf, l);
+            AddressSpace *as = cs ? cs->as : &address_space_memory;
+            MemTxResult r = address_space_read(as, addr,
+                                               MEMTXATTRS_UNSPECIFIED, buf, l);
+            if (r != MEMTX_OK) {
+                monitor_printf(mon, " Cannot access memory\n");
+                break;
+            }
         } else {
             if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
                 monitor_printf(mon, " Cannot access memory\n");
-- 
2.19.1
