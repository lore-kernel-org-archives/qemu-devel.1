Received: from eggs.gnu.org ([2001:4830:134:3::10]:47790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D74-0007FV-OD
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D73-0000Iw-S7
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:52:02 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:47746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5D73-0000I5-Ld
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:52:01 -0400
Received: by mail-pg0-x242.google.com with SMTP id r25so7532975pgn.4
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:52:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Oct 2017 08:51:45 -0700
Message-Id: <20171019155146.30434-9-richard.henderson@linaro.org>
In-Reply-To: <20171019155146.30434-1-richard.henderson@linaro.org>
References: <20171019155146.30434-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 8/9] disas: Remove monitor_disas_is_physical
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

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
