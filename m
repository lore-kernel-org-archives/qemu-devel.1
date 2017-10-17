Received: from eggs.gnu.org ([2001:4830:134:3::10]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rdf-0003oT-U7
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RdZ-0005SA-3Q
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:31 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56790)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RdY-0005R9-0y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:24 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:10:20 +0300
Message-ID: <150824582072.6816.7754220722530913728.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 16/43] windbg: generate ExceptionStateChange
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
 include/exec/windbgstub-utils.h |    2 ++
 target/i386/windbgstub.c        |   20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index f0da3cbd86..fea04cbc89 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -93,6 +93,8 @@ typedef struct SizedBuf {
 InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
+SizedBuf kd_gen_exception_sc(CPUState *cpu);
+
 bool windbg_on_load(void);
 
 #endif
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index da0aeb4f1b..334642b677 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -68,7 +68,6 @@ bool windbg_on_load(void)
     return true;
 }
 
-__attribute__ ((unused)) /* unused yet */
 static void kd_init_state_change(CPUState *cpu,
                                  DBGKD_ANY_WAIT_STATE_CHANGE *sc)
 {
@@ -112,3 +111,22 @@ static void kd_init_state_change(CPUState *cpu,
         stw_p(&cr->InstructionCount, DBGKD_MAXSTREAM);
     }
 }
+
+SizedBuf kd_gen_exception_sc(CPUState *cpu)
+{
+    CPUArchState *env = cpu->env_ptr;
+    DBGKD_ANY_WAIT_STATE_CHANGE *sc;
+    DBGKM_EXCEPTION_RECORD64 *exc;
+    SizedBuf buf;
+
+    SBUF_MALLOC(buf, sizeof(DBGKD_ANY_WAIT_STATE_CHANGE) + sizeof(int));
+    sc = (DBGKD_ANY_WAIT_STATE_CHANGE *) buf.data;
+    exc = &sc->u.Exception.ExceptionRecord;
+    kd_init_state_change(cpu, sc);
+
+    stl_p(&sc->NewState, DbgKdExceptionStateChange);
+    stl_p(&exc->ExceptionCode, 0x80000003);
+    sttul_p(&exc->ExceptionAddress, env->eip);
+
+    return buf;
+}
