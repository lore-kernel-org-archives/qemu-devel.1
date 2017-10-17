Received: from eggs.gnu.org ([2001:4830:134:3::10]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rg8-0005z1-Gz
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rg2-0007iS-RK
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:13:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57496)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rg2-0007i7-KC
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:12:58 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:12:54 +0300
Message-ID: <150824597393.6816.9995893839577495938.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 43/43] windbg: implemented
 kd_api_query_memory
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
index 0438ea44b6..190fdab6b2 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -112,6 +112,7 @@ void kd_api_write_msr(CPUState *cpu, PacketData *pd);
 void kd_api_search_memory(CPUState *cpu, PacketData *pd);
 void kd_api_fill_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
+void kd_api_query_memory(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
 SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 444bb0474d..7de2fd6ade 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -333,6 +333,20 @@ void kd_api_fill_memory(CPUState *cpu, PacketData *pd)
     }
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
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index b348028dfd..36372c0ea5 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -220,6 +220,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_fill_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdQueryMemoryApi:
+        kd_api_query_memory(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
