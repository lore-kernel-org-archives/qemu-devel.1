Received: from eggs.gnu.org ([2001:4830:134:3::10]:34973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5P-0004Xj-Bo
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5O-00043N-Cp
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:35 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44228)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5O-000437-4W
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:34 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:25:18 +0300
Message-ID: <151299871875.4808.12329119791884227277.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 42/46] windbg: implemented
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
 windbgstub-utils.c              |    9 +++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 14 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index f4adfe44dd..8d36354b7c 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -93,6 +93,7 @@ void kd_api_write_msr(CPUState *cpu, PacketData *pd);
 void kd_api_search_memory(CPUState *cpu, PacketData *pd);
 void kd_api_fill_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
+void kd_api_query_memory(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
 SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index a34f5ae8bd..e3b1276dab 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -333,6 +333,15 @@ void kd_api_fill_memory(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_query_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_QUERY_MEMORY *mem = &pd->m64.u.QueryMemory;
+
+    stl_p(&mem->AddressSpace, DBGKD_QUERY_MEMORY_PROCESS);
+    stl_p(&mem->Flags, DBGKD_QUERY_MEMORY_READ |
+           DBGKD_QUERY_MEMORY_WRITE | DBGKD_QUERY_MEMORY_EXECUTE);
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index f0b3ca3390..f0930f20a8 100755
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
