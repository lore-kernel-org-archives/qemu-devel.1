Received: from eggs.gnu.org ([2001:4830:134:3::10]:41660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKU-000089-5C
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKO-0005JX-HE
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:30 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60086)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKM-00059T-Bu
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:24 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:00:14 +0300
Message-ID: <154409761380.5432.1067124865535256250.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 17/39] windbg: generate ExceptionStateChange
 and LoadSymbolsStateChange
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
 include/exec/windbgstub-utils.h |    3 +++
 target/i386/windbgstub.c        |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index a28068eecd..794cb387b0 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -67,6 +67,9 @@ typedef struct PacketData {
 const char *kd_api_name(int id);
 const char *kd_pkt_type_name(int id);
 
+DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_exc(CPUState *cs);
+DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_ls(CPUState *cs);
+
 bool windbg_on_load(void);
 void windbg_on_reset(void);
 
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index b2ac7a6d5f..37c5805818 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -161,7 +161,6 @@ void windbg_on_reset(void)
 #endif
 }
 
-__attribute__ ((unused)) /* unused yet */
 static void kd_init_state_change(CPUState *cs, DBGKD_ANY_WAIT_STATE_CHANGE *sc)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -201,3 +200,35 @@ static void kd_init_state_change(CPUState *cs, DBGKD_ANY_WAIT_STATE_CHANGE *sc)
     memset(cr->InstructionStream, 0, DBGKD_MAXSTREAM);
     stw_p(&cr->InstructionCount, 0);
 }
+
+DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_exc(CPUState *cs)
+{
+    DBGKD_ANY_WAIT_STATE_CHANGE *sc = g_new0(DBGKD_ANY_WAIT_STATE_CHANGE, 1);
+    DBGKM_EXCEPTION_RECORD64 *exc = &sc->u.Exception.ExceptionRecord;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    kd_init_state_change(cs, sc);
+
+    stl_p(&sc->NewState, DbgKdExceptionStateChange);
+    sttul_p(&exc->ExceptionAddress, env->eip);
+
+    /* TODO: Fix this hardcoded value. */
+    stl_p(&exc->ExceptionCode, 0x80000003);
+
+    return sc;
+}
+
+DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_ls(CPUState *cs)
+{
+    DBGKD_ANY_WAIT_STATE_CHANGE *sc = g_new0(DBGKD_ANY_WAIT_STATE_CHANGE, 1);
+
+    kd_init_state_change(cs, sc);
+
+    stl_p(&sc->NewState, DbgKdLoadSymbolsStateChange);
+
+    /* TODO: Path to load symbold (with extra array). */
+    stl_p(&sc->u.LoadSymbols.PathNameLength, 0);
+
+    return sc;
+}
