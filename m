Received: from eggs.gnu.org ([2001:4830:134:3::10]:42369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMR-0001bm-Oj
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMN-0006f4-Qd
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:31 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60528)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMM-0006JS-CP
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:26 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:02:11 +0300
Message-ID: <154409773116.5432.5206301850846591733.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 38/39] windbg: implement kd_api_query_memory
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
 windbgstub-utils.c              |   10 ++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 15 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 8192a7b849..bddb52d3db 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -86,6 +86,7 @@ void kd_api_write_msr(CPUState *cs, PacketData *pd);
 void kd_api_search_memory(CPUState *cs, PacketData *pd);
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
 void kd_api_fill_memory(CPUState *cs, PacketData *pd);
+void kd_api_query_memory(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_unsupported(CPUState *cs, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 9b4f6f00b8..799fd95a7a 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -479,6 +479,16 @@ void kd_api_fill_memory(CPUState *cs, PacketData *pd)
     g_free(mem);
 }
 
+void kd_api_query_memory(CPUState *cs, PacketData *pd)
+{
+    DBGKD_QUERY_MEMORY *mem = &pd->m64.u.QueryMemory;
+
+    /* TODO: Needs test memory. */
+    stl_p(&mem->AddressSpace, DBGKD_QUERY_MEMORY_PROCESS);
+    stl_p(&mem->Flags, DBGKD_QUERY_MEMORY_READ | DBGKD_QUERY_MEMORY_WRITE |
+                       DBGKD_QUERY_MEMORY_EXECUTE);
+}
+
 void kd_api_unsupported(CPUState *cs, PacketData *pd)
 {
     WINDBG_ERROR("Caught unimplemented api %s", kd_api_name(pd->m64.ApiNumber));
diff --git a/windbgstub.c b/windbgstub.c
index daf6d37aa1..23ad05f12b 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -236,6 +236,10 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_fill_memory(cs, data);
         break;
 
+    case DbgKdQueryMemoryApi:
+        kd_api_query_memory(cs, data);
+        break;
+
     case DbgKdGetContextExApi:
         kd_api_get_context_ex(cs, data);
         break;
