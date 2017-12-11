Received: from eggs.gnu.org ([2001:4830:134:3::10]:34910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5J-0004V8-C3
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5D-0003vU-7r
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:29 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44186)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5C-0003vC-Tc
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:23 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:25:07 +0300
Message-ID: <151299870749.4808.15323057710642491224.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 40/46] windbg: implemented
 kd_api_search_memory
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
 windbgstub-utils.c              |   33 +++++++++++++++++++++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 38 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 6e73ef973c..a58c47d359 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -90,6 +90,7 @@ void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_get_version(CPUState *cpu, PacketData *pd);
 void kd_api_read_msr(CPUState *cpu, PacketData *pd);
 void kd_api_write_msr(CPUState *cpu, PacketData *pd);
+void kd_api_search_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 7ef301bac7..79899d3295 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -261,6 +261,39 @@ void kd_api_get_version(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_search_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_SEARCH_MEMORY *m64c = &pd->m64.u.SearchMemory;
+    int s_len = MAX(ldq_p(&m64c->SearchLength), 1);
+    int p_len = MIN(ldl_p(&m64c->PatternLength), pd->extra_size);
+    target_ulong addr = ldq_p(&m64c->SearchAddress);
+    int size = MIN(s_len, 1024);
+    uint8_t mem[size + p_len];
+    int i, err;
+
+    pd->extra_size = 0;
+    pd->m64.ReturnStatus = STATUS_NO_MORE_ENTRIES;
+
+    while (s_len) {
+        err = cpu_memory_rw_debug(cpu, addr, mem, size + p_len, 0);
+        if (!err) {
+            for (i = 0; i < size; ++i) {
+                if (memcmp(mem + i, pd->extra, p_len) == 0) {
+                    stl_p(&m64c->FoundAddress, addr + i);
+                    pd->m64.ReturnStatus = STATUS_SUCCESS;
+                    return;
+                }
+            }
+        } else {
+            WINDBG_DEBUG("search_memory: No physical page mapped: " FMT_ADDR,
+                         addr);
+        }
+        s_len -= size;
+        addr += size;
+        size = MIN(s_len, 1024);
+    }
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 45f61917d9..3dcac03be1 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -212,6 +212,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
     case DbgKdClearAllInternalBreakpointsApi:
         return;
 
+    case DbgKdSearchMemoryApi:
+        kd_api_search_memory(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
