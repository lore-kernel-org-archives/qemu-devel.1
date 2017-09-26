Received: from eggs.gnu.org ([2001:4830:134:3::10]:59443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngT-0004GF-Ji
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngN-0000vn-T1
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:49 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51946)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngN-0000vX-LV
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:43 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:05:41 +0300
Message-ID: <150642394142.3900.12304593439029454545.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 17/43] windbg: generate LoadSymbolsStateChange
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

Added function for generate LoadSymbolsStateChange packet.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    1 +
 windbgstub-utils.c              |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 0b859cd6a8..25e8458b4e 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -103,6 +103,7 @@ typedef struct SizedBuf {
 } while (false)
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
+SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
 
 bool windbg_on_load(void);
 void windbg_on_exit(void);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 48d09ff424..7d93f62d16 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -102,6 +102,22 @@ SizedBuf kd_gen_exception_sc(CPUState *cpu)
     return buf;
 }
 
+SizedBuf kd_gen_load_symbols_sc(CPUState *cpu)
+{
+    SizedBuf buf;
+    SBUF_MALLOC(buf, sizeof(DBGKD_ANY_WAIT_STATE_CHANGE));
+
+    DBGKD_ANY_WAIT_STATE_CHANGE *sc = (DBGKD_ANY_WAIT_STATE_CHANGE *) buf.data;
+    kd_init_state_change(cpu, sc);
+
+    sc->NewState = DbgKdLoadSymbolsStateChange;
+    sc->NewState = ldl_p(&sc->NewState);
+
+    sc->u.LoadSymbols.PathNameLength = 0;
+
+    return buf;
+}
+
 bool windbg_on_load(void)
 {
     CPUState *cpu = qemu_get_cpu(0);
