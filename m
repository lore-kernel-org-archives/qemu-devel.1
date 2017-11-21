Received: from eggs.gnu.org ([2001:4830:134:3::10]:39502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EL-0000wv-2L
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EH-0002fs-7w
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:53 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37982)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EG-0002fd-Vt
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:49 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:08:46 +0300
Message-ID: <151127332602.6888.9977201576638308100.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 16/45] windbg: generate ExceptionStateChange
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
index b729cd604e..f35873eca0 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -86,6 +86,8 @@ typedef struct SizedBuf {
 InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
+SizedBuf kd_gen_exception_sc(CPUState *cpu);
+
 bool windbg_on_load(void);
 
 #endif
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index a3c433f756..f0edd94dde 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -70,7 +70,6 @@ bool windbg_on_load(void)
     return true;
 }
 
-__attribute__ ((unused)) /* unused yet */
 static void kd_init_state_change(CPUState *cpu,
                                  DBGKD_ANY_WAIT_STATE_CHANGE *sc)
 {
@@ -115,4 +114,23 @@ static void kd_init_state_change(CPUState *cpu,
     }
 }
 
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
+
 #endif
