Received: from eggs.gnu.org ([2001:4830:134:3::10]:42037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc5f-00010t-15
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc5e-0003kZ-7l
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:31:03 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cUc5e-0003kE-1e
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:31:02 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cUc5c-000548-Uq from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:01 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Fri, 20 Jan 2017 08:30:28 -0800
Message-ID: <1ebabcf0e1af7a81774fef22f7e765089fb2685d.1484929304.git.julian@codesourcery.com>
In-Reply-To: <cover.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/7] Move target_memory_rw_debug function.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch moves the target_memory_rw_debug function to
include/exec/cpu-all.h, so that it can be used by the ARM semihosting
code as well as the gdbstub code. (I tried Peter Maydell's suggestion
of include/qom/cpu.h as a location for the function, but that raised
uncomfortably-many dependency problems for my taste).

Signed-off-by: Julian Brown <julian@codesourcery.com>
---
 gdbstub.c              | 11 -----------
 include/exec/cpu-all.h | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 64f2696..cb77e15 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -44,17 +44,6 @@
 #define GDB_ATTACHED "0"
 #endif
 
-static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                                         uint8_t *buf, int len, bool is_write)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->memory_rw_debug) {
-        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
-    }
-    return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
-}
-
 enum {
     GDB_SIGNAL_0 = 0,
     GDB_SIGNAL_INT = 2,
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ffe43d5..700b90d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -347,4 +347,26 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
 
 int cpu_exec(CPUState *cpu);
 
+/**
+  * target_memory_rw_debug:
+  * @cpu: The CPU to use.
+  * @addr: The target address to read or write.
+  * @buf: Host buffer to read or write from or into.
+  * @len: Length of data.
+  * @is_write: True for write, false for read.
+  *
+  * A wrapper for cpu_memory_rw_debug that can be overridden with a
+  * CPUClass-specific version if required.
+  */
+static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
+                                         uint8_t *buf, int len, bool is_write)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->memory_rw_debug) {
+        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
+    }
+    return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
+}
+
 #endif /* CPU_ALL_H */
-- 
2.8.1
