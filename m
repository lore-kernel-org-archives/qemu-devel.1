Received: from eggs.gnu.org ([2001:4830:134:3::10]:60544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnir-0006TT-R6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnim-0001wx-0n
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:17 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52500)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnil-0001wo-Pg
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:11 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:08:09 +0300
Message-ID: <150642408958.3900.8830840266347440753.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 43/43] windbg: implemented kd_api_query_memory
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
 windbgstub-utils.c              |   14 ++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 19 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index d1a10c862e..d44ae1918b 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -121,6 +121,7 @@ void kd_api_write_msr(CPUState *cpu, PacketData *pd);
 void kd_api_search_memory(CPUState *cpu, PacketData *pd);
 void kd_api_fill_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
+void kd_api_query_memory(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
 SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 3832e0b116..3f5299c3f4 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -1606,6 +1606,20 @@ void kd_api_fill_memory(CPUState *cpu, PacketData *pd)
     pd->extra_size = 0;
 }
 
+void kd_api_query_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_QUERY_MEMORY *mem = &pd->m64.u.QueryMemory;
+
+    if (ldl_p(&mem->AddressSpace) == DBGKD_QUERY_MEMORY_VIRTUAL) {
+        mem->AddressSpace = DBGKD_QUERY_MEMORY_PROCESS;
+        mem->Flags = DBGKD_QUERY_MEMORY_READ |
+                     DBGKD_QUERY_MEMORY_WRITE |
+                     DBGKD_QUERY_MEMORY_EXECUTE;
+        mem->AddressSpace = ldl_p(&mem->AddressSpace);
+        mem->Flags = ldl_p(&mem->Flags);
+    }
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index b01ddcf009..338bc00859 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -213,6 +213,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_fill_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdQueryMemoryApi:
+        kd_api_query_memory(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
