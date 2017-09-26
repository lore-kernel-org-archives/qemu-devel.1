Received: from eggs.gnu.org ([2001:4830:134:3::10]:60446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnie-0006Go-9F
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnia-0001rX-AH
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52456)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnia-0001rI-2U
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:00 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:07:58 +0300
Message-ID: <150642407781.3900.3667954520393080307.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 41/43] windbg: implemented kd_api_search_memory
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
 windbgstub-utils.c              |   30 ++++++++++++++++++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 35 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 23cafb1a89..ba001ddb42 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -118,6 +118,7 @@ void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
 void kd_api_get_version(CPUState *cpu, PacketData *pd);
 void kd_api_read_msr(CPUState *cpu, PacketData *pd);
 void kd_api_write_msr(CPUState *cpu, PacketData *pd);
+void kd_api_search_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 26bdb1f6ea..2d3fbcc41c 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -1540,6 +1540,36 @@ void kd_api_write_msr(CPUState *cpu, PacketData *pd)
     pd->m64.ReturnStatus = STATUS_SUCCESS;
 }
 
+void kd_api_search_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_SEARCH_MEMORY *m64c = &pd->m64.u.SearchMemory;
+    int s_len = MAX(1, ldq_p(&m64c->SearchLength));
+    int p_len = MIN(ldl_p(&m64c->PatternLength), pd->extra_size);
+    target_ulong addr = ldq_p(&m64c->SearchAddress);
+
+    uint8_t mem[s_len - 1 + p_len];
+
+    int err = cpu_memory_rw_debug(cpu, addr, mem, sizeof(mem), 0);
+    if (!err) {
+        int i;
+        pd->m64.ReturnStatus = STATUS_NO_MORE_ENTRIES;
+        for (i = 0; i < s_len; ++i) {
+            if (memcmp(mem + i, pd->extra, p_len) == 0) {
+                m64c->FoundAddress = addr + i;
+                m64c->FoundAddress = ldq_p(&m64c->FoundAddress);
+                pd->m64.ReturnStatus = STATUS_SUCCESS;
+                break;
+            }
+        }
+    } else {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+        WINDBG_DEBUG("search_memory: No physical page mapped: " FMT_ADDR,
+                     addr);
+    }
+
+    pd->extra_size = 0;
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 1ec4932ddc..7cff6bc514 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -205,6 +205,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
     case DbgKdClearAllInternalBreakpointsApi:
         return;
 
+    case DbgKdSearchMemoryApi:
+        kd_api_search_memory(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
