Received: from eggs.gnu.org ([2001:4830:134:3::10]:34942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5M-0004XX-4B
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5J-0003ze-0z
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:32 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44208)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5I-0003yz-Ib
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:28 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:25:13 +0300
Message-ID: <151299871311.4808.11276175738665754697.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 41/46] windbg: implemented kd_api_fill_memory
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

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    1 +
 windbgstub-utils.c              |   39 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 44 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index a58c47d359..f4adfe44dd 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -91,6 +91,7 @@ void kd_api_get_version(CPUState *cpu, PacketData *pd);
 void kd_api_read_msr(CPUState *cpu, PacketData *pd);
 void kd_api_write_msr(CPUState *cpu, PacketData *pd);
 void kd_api_search_memory(CPUState *cpu, PacketData *pd);
+void kd_api_fill_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 79899d3295..a34f5ae8bd 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -294,6 +294,45 @@ void kd_api_search_memory(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_fill_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_FILL_MEMORY *m64c = &pd->m64.u.FillMemory;
+    uint32_t len = ldl_p(&m64c->Length);
+    target_ulong addr = ldq_p(&m64c->Address);
+    uint16_t pattern = ldl_p(&m64c->PatternLength);
+    uint16_t flags = ldl_p(&m64c->Flags);
+    int err, offset = 0;
+
+    uint8_t mem[pattern];
+    memcpy(mem, pd->extra, pattern);
+
+    pd->extra_size = 0;
+
+    switch (flags) {
+    case DBGKD_FILL_MEMORY_VIRTUAL:
+        while (offset < len) {
+            err = cpu_memory_rw_debug(cpu, addr + offset, mem,
+                                      MIN(pattern, len - offset), 1);
+            offset += pattern;
+            if (err) {
+                WINDBG_DEBUG("fill_memory: No physical page mapped: " FMT_ADDR,
+                             addr);
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
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 3dcac03be1..f0b3ca3390 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -216,6 +216,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_search_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdFillMemoryApi:
+        kd_api_fill_memory(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
