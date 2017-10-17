Received: from eggs.gnu.org ([2001:4830:134:3::10]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rdi-0003qq-HR
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rdd-0005Ub-Sg
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:34 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56816)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rdd-0005U9-Lk
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:29 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:10:26 +0300
Message-ID: <150824582633.6816.5852422519729126672.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 17/43] windbg: generate
 LoadSymbolsStateChange
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
 target/i386/windbgstub.c        |   15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index fea04cbc89..1c43be7c41 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -94,6 +94,7 @@ InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
+SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
 
 bool windbg_on_load(void);
 
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 334642b677..314301545b 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -130,3 +130,18 @@ SizedBuf kd_gen_exception_sc(CPUState *cpu)
 
     return buf;
 }
+
+SizedBuf kd_gen_load_symbols_sc(CPUState *cpu)
+{
+    DBGKD_ANY_WAIT_STATE_CHANGE *sc;
+    SizedBuf buf;
+
+    SBUF_MALLOC(buf, sizeof(DBGKD_ANY_WAIT_STATE_CHANGE));
+    sc = (DBGKD_ANY_WAIT_STATE_CHANGE *) buf.data;
+    kd_init_state_change(cpu, sc);
+
+    stl_p(&sc->NewState, DbgKdLoadSymbolsStateChange);
+    stl_p(&sc->u.LoadSymbols.PathNameLength, 0);
+
+    return buf;
+}
