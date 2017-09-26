Received: from eggs.gnu.org ([2001:4830:134:3::10]:59395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngJ-00049T-46
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngI-0000t3-9J
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:39 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51926)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwngI-0000sk-2K
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:38 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:05:36 +0300
Message-ID: <150642393586.3900.6729085808427726742.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 16/43] windbg: generate ExceptionStateChange
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

Added function for generate ExceptionStateChange packet.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    3 +++
 windbgstub-utils.c              |   21 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 791721d472..0b859cd6a8 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -101,6 +101,9 @@ typedef struct SizedBuf {
     buf.data = NULL;        \
     buf.size = 0;           \
 } while (false)
+
+SizedBuf kd_gen_exception_sc(CPUState *cpu);
+
 bool windbg_on_load(void);
 void windbg_on_exit(void);
 
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 60f6705f7c..48d09ff424 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -34,7 +34,6 @@ static void kd_breakpoint_remove_range(CPUState *cpu, target_ulong base,
                                        target_ulong limit)
 {}
 
-__attribute__ ((unused)) /* unused yet */
 static void kd_init_state_change(CPUState *cpu,
                                  DBGKD_ANY_WAIT_STATE_CHANGE *sc)
 {
@@ -83,6 +82,26 @@ static void kd_init_state_change(CPUState *cpu,
     }
 }
 
+SizedBuf kd_gen_exception_sc(CPUState *cpu)
+{
+    CPUArchState *env = cpu->env_ptr;
+    SizedBuf buf;
+    SBUF_MALLOC(buf, sizeof(DBGKD_ANY_WAIT_STATE_CHANGE) + sizeof(int));
+
+    DBGKD_ANY_WAIT_STATE_CHANGE *sc = (DBGKD_ANY_WAIT_STATE_CHANGE *) buf.data;
+    kd_init_state_change(cpu, sc);
+
+    sc->NewState = DbgKdExceptionStateChange;
+    sc->NewState = ldl_p(&sc->NewState);
+
+    DBGKM_EXCEPTION_RECORD64 *exc = &sc->u.Exception.ExceptionRecord;
+    exc->ExceptionCode = 0x80000003;
+    exc->ExceptionCode = ldl_p(&exc->ExceptionCode);
+    exc->ExceptionAddress = ldtul_p(&env->eip);
+
+    return buf;
+}
+
 bool windbg_on_load(void)
 {
     CPUState *cpu = qemu_get_cpu(0);
