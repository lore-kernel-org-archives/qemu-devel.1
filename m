Received: from eggs.gnu.org ([2001:4830:134:3::10]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyU-0004mU-6a
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyT-0007JO-BX
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:10 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyT-0007J3-4e
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:09 -0500
Received: by mail-wm0-x244.google.com with SMTP id i11so11095992wmf.4
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:43 +0100
Message-Id: <1513790098-9815-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/46] hw/i386/vmport: replace fprintf() by
 trace events or LOG_UNIMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20171215034356.4449-2-f4bug@amsat.org>
[Replace unknown command tracepoint with LOG_UNIMP, add
 generic tracepoint for vmport commands. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/trace-events |  4 ++++
 hw/i386/vmport.c     | 14 +++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index d43b4b6..22d4464 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -113,3 +113,7 @@ amdvi_mode_invalid(uint8_t level, uint64_t addr)"error: translation level 0x%"PR
 amdvi_page_fault(uint64_t addr) "error: page fault accessing guest physical address 0x%"PRIx64
 amdvi_iotlb_hit(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "hit iotlb devid %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
 amdvi_translation_result(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
+
+# hw/i386/vmport.c
+vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
+vmport_command(unsigned char command) "command: 0x%02x"
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index eb880c6..9b8c688 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -27,8 +27,7 @@
 #include "hw/i386/pc.h"
 #include "sysemu/hw_accel.h"
 #include "hw/qdev.h"
-
-/* #define VMPORT_DEBUG */
+#include "trace.h"
 
 #define VMPORT_CMD_GETVERSION 0x0a
 #define VMPORT_CMD_GETRAMSIZE 0x14
@@ -54,6 +53,7 @@ void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque)
         return;
     }
 
+    trace_vmport_register(command, func, opaque);
     port_state->func[command] = func;
     port_state->opaque[command] = opaque;
 }
@@ -76,13 +76,9 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
     }
 
     command = env->regs[R_ECX];
-    if (command >= VMPORT_ENTRIES) {
-        return eax;
-    }
-    if (!s->func[command]) {
-#ifdef VMPORT_DEBUG
-        fprintf(stderr, "vmport: unknown command %x\n", command);
-#endif
+    trace_vmport_command(command);
+    if (command >= VMPORT_ENTRIES || !s->func[command]) {
+        qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
         return eax;
     }
 
-- 
1.8.3.1
