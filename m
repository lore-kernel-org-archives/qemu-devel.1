Received: from eggs.gnu.org ([2001:4830:134:3::10]:34423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhG-0002u6-3Q
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhD-0006nF-Nv
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:34 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50608)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhD-0006n1-E9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:31 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:54:29 +0300
Message-ID: <154401446884.8440.14559945425266957490.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 26/39] windbg: implement kd_api_get_context
 and kd_api_set_context
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
 include/exec/windbgstub-utils.h |    2 ++
 target/i386/windbgstub.c        |   27 +++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 638b2b9a6f..a88e013de9 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -69,6 +69,8 @@ const char *kd_pkt_type_name(int id);
 
 void kd_api_read_virtual_memory(CPUState *cs, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cs, PacketData *pd);
+void kd_api_get_context(CPUState *cs, PacketData *pd);
+void kd_api_set_context(CPUState *cs, PacketData *pd);
 void kd_api_unsupported(CPUState *cs, PacketData *pd);
 
 DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_exc(CPUState *cs);
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index a1d27b8aca..900950495f 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -896,6 +896,33 @@ GEN_WINDBG_KSPEC_REGS_RW(windbg_read_ks_regs, false)
 __attribute__ ((unused)) /* unused yet */
 GEN_WINDBG_KSPEC_REGS_RW(windbg_write_ks_regs, true)
 
+void kd_api_get_context(CPUState *cs, PacketData *pd)
+{
+    int err;
+
+    pd->extra_size = sizeof(CPU_CONTEXT);
+    err = windbg_read_context(cs, pd->extra, pd->extra_size,
+                              0, sizeof(CPU_CONTEXT));
+
+    if (err) {
+        pd->extra_size = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
+void kd_api_set_context(CPUState *cs, PacketData *pd)
+{
+    int err;
+
+    err = windbg_write_context(cs, pd->extra, pd->extra_size,
+                               0, sizeof(CPU_CONTEXT));
+    pd->extra_size = 0;
+
+    if (err) {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
 static bool find_KPCR(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/windbgstub.c b/windbgstub.c
index 46400d9bad..70ebf3c0ad 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -157,6 +157,14 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_write_virtual_memory(cs, data);
         break;
 
+    case DbgKdGetContextApi:
+        kd_api_get_context(cs, data);
+        break;
+
+    case DbgKdSetContextApi:
+        kd_api_set_context(cs, data);
+        break;
+
     default:
         kd_api_unsupported(cs, data);
         break;
