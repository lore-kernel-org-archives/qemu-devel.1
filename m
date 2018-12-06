Received: from eggs.gnu.org ([2001:4830:134:3::10]:42336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMM-0001Wl-C3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMH-0006Wg-MH
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:26 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60512)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMG-0006FU-Pa
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:20 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:02:05 +0300
Message-ID: <154409772559.5432.3961809771008633191.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 37/39] windbg: implement kd_api_fill_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    1 +
 windbgstub-utils.c              |   41 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 46 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 4eb976260b..8192a7b849 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -85,6 +85,7 @@ void kd_api_read_msr(CPUState *cs, PacketData *pd);
 void kd_api_write_msr(CPUState *cs, PacketData *pd);
 void kd_api_search_memory(CPUState *cs, PacketData *pd);
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
+void kd_api_fill_memory(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_unsupported(CPUState *cs, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 3664a0d681..9b4f6f00b8 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -438,6 +438,47 @@ void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd)
 {
 }
 
+void kd_api_fill_memory(CPUState *cs, PacketData *pd)
+{
+    DBGKD_FILL_MEMORY *m64c = &pd->m64.u.FillMemory;
+    uint32_t len = ldl_p(&m64c->Length);
+    target_ulong addr = ldq_p(&m64c->Address);
+    uint16_t pattern = MIN(ldl_p(&m64c->PatternLength), pd->extra_size);
+    uint16_t flags = ldl_p(&m64c->Flags);
+    int err, offset = 0;
+
+    uint8_t *mem = g_new(uint8_t, pattern);
+    memcpy(mem, pd->extra, pattern);
+
+    pd->extra_size = 0;
+
+    switch (flags) {
+    case DBGKD_FILL_MEMORY_VIRTUAL:
+        while (offset < len) {
+            err = cpu_memory_rw_debug(cs, addr + offset, mem,
+                                      MIN(pattern, len - offset), 1);
+            offset += pattern;
+            if (err) {
+                DPRINTF("fill_memory: No physical page mapped: " FMT_ADDR "\n",
+                        addr);
+            }
+        }
+        break;
+
+    case DBGKD_FILL_MEMORY_PHYSICAL:
+        while (offset < len) {
+            cpu_physical_memory_rw(addr, mem, MIN(pattern, len - offset), 1);
+            offset += pattern;
+        }
+        break;
+
+    default:
+        break;
+    }
+
+    g_free(mem);
+}
+
 void kd_api_unsupported(CPUState *cs, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s", kd_api_name(pd->m64.ApiNumber));
diff --git a/windbgstub.c b/windbgstub.c
index a50de68db5..daf6d37aa1 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -232,6 +232,10 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_clear_all_internal_breakpoints(cs, data);
         return;
 
+    case DbgKdFillMemoryApi:
+        kd_api_fill_memory(cs, data);
+        break;
+
     case DbgKdGetContextExApi:
         kd_api_get_context_ex(cs, data);
         break;
