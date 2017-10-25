Received: from eggs.gnu.org ([2001:4830:134:3::10]:43006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7KqB-0007eM-Ho
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kq5-000857-M9
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:23 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:48214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7Kq5-00084T-Fa
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:17 -0400
Received: by mail-wm0-x243.google.com with SMTP id p75so1567064wmg.3
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:31:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 14:30:55 +0200
Message-Id: <20171025123056.3165-11-richard.henderson@linaro.org>
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/11] disas: Remove monitor_disas_is_physical
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Even though there is only one monitor, and thus no race on this
global data object, there is also no point in having it.  We can
just as well record the decision in the read_memory_function that
we select.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/disas.c b/disas.c
index e52e776a60..92b389d25f 100644
--- a/disas.c
+++ b/disas.c
@@ -512,19 +512,11 @@ const char *lookup_symbol(target_ulong orig_addr)
 
 #include "monitor/monitor.h"
 
-static int monitor_disas_is_physical;
-
 static int
-monitor_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
+physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
                      struct disassemble_info *info)
 {
-    CPUDebug *s = container_of(info, CPUDebug, info);
-
-    if (monitor_disas_is_physical) {
-        cpu_physical_memory_read(memaddr, myaddr, length);
-    } else {
-        cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
-    }
+    cpu_physical_memory_read(memaddr, myaddr, length);
     return 0;
 }
 
@@ -539,8 +531,8 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
     INIT_DISASSEMBLE_INFO(s.info, (FILE *)mon, monitor_fprintf);
 
     s.cpu = cpu;
-    monitor_disas_is_physical = is_physical;
-    s.info.read_memory_func = monitor_read_memory;
+    s.info.read_memory_func
+        = (is_physical ? physical_read_memory : target_read_memory);
     s.info.print_address_func = generic_print_address;
     s.info.buffer_vma = pc;
     s.info.cap_arch = -1;
-- 
2.13.6
