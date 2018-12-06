Received: from eggs.gnu.org ([2001:4830:134:3::10]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMF-0001Si-Ni
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMB-0006UU-Pt
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:19 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60528)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMB-0006JS-Gr
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:15 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:02:00 +0300
Message-ID: <154409772001.5432.4223343818401602178.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 36/39] windbg: implement kd_api_search_memory
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
 windbgstub-utils.c              |   17 +++++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 22 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 74e3b9a0da..4eb976260b 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -83,6 +83,7 @@ void kd_api_write_physical_memory(CPUState *cs, PacketData *pd);
 void kd_api_get_version(CPUState *cs, PacketData *pd);
 void kd_api_read_msr(CPUState *cs, PacketData *pd);
 void kd_api_write_msr(CPUState *cs, PacketData *pd);
+void kd_api_search_memory(CPUState *cs, PacketData *pd);
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 4289e537a9..3664a0d681 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -417,6 +417,23 @@ void kd_api_write_physical_memory(CPUState *cs, PacketData *pd)
     stl_p(&mem->ActualBytesWritten, len);
 }
 
+void kd_api_search_memory(CPUState *cs, PacketData *pd)
+{
+    DBGKD_SEARCH_MEMORY *m64c = &pd->m64.u.SearchMemory;
+    int s_len = MAX(ldq_p(&m64c->SearchLength), 1);
+    int p_len = MIN(ldl_p(&m64c->PatternLength), pd->extra_size);
+    target_ulong addr = ldq_p(&m64c->SearchAddress);
+    InitedAddr find =
+        windbg_search_vmaddr(cs, addr, addr + s_len, pd->extra, p_len);
+    pd->extra_size = 0;
+    if (find.is_init) {
+        stl_p(&m64c->FoundAddress, find.addr);
+        pd->m64.ReturnStatus = STATUS_SUCCESS;
+    } else {
+        pd->m64.ReturnStatus = STATUS_NO_MORE_ENTRIES;
+    }
+}
+
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd)
 {
 }
diff --git a/windbgstub.c b/windbgstub.c
index 109a52b663..a50de68db5 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -224,6 +224,10 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_write_msr(cs, data);
         break;
 
+    case DbgKdSearchMemoryApi:
+        kd_api_search_memory(cs, data);
+        break;
+
     case DbgKdClearAllInternalBreakpointsApi:
         kd_api_clear_all_internal_breakpoints(cs, data);
         return;
