Received: from eggs.gnu.org ([2001:4830:134:3::10]:33910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO33-0001jc-Vn
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO2y-0002Tb-C0
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43600)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO2y-0002Sy-4V
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:04 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:22:49 +0300
Message-ID: <151299856873.4808.2984243428725634756.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 16/46] windbg: generate
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
 target/i386/windbgstub.c        |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index d9dae4e902..a7ec53555b 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -75,6 +75,7 @@ InitedAddr *windbg_get_KPCR(void);
 InitedAddr *windbg_get_version(void);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
+SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
 
 bool windbg_on_load(void);
 
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 5db6a5e3bc..28d4f5bb10 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -134,4 +134,20 @@ SizedBuf kd_gen_exception_sc(CPUState *cpu)
     return buf;
 }
 
+SizedBuf kd_gen_load_symbols_sc(CPUState *cpu)
+{
+    DBGKD_ANY_WAIT_STATE_CHANGE *sc;
+    SizedBuf buf;
+
+    buf.size = sizeof(DBGKD_ANY_WAIT_STATE_CHANGE);
+    buf.data = g_malloc0(buf.size);
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
