Received: from eggs.gnu.org ([2001:4830:134:3::10]:39547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EQ-00012B-Sv
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EM-0002i3-US
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:58 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38012)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EM-0002ht-Lp
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:54 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:08:51 +0300
Message-ID: <151127333169.6888.10315185193447806092.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 17/45] windbg: generate
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
index f35873eca0..8558bc6c8a 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -87,6 +87,7 @@ InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
+SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
 
 bool windbg_on_load(void);
 
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index f0edd94dde..261e441db1 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -133,4 +133,19 @@ SizedBuf kd_gen_exception_sc(CPUState *cpu)
     return buf;
 }
 
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
+
 #endif
