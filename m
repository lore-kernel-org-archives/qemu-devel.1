Received: from eggs.gnu.org ([2001:4830:134:3::10]:39384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9EB-0000pt-K0
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9E5-0002aI-St
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37942)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9E5-0002aC-LH
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:37 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:08:35 +0300
Message-ID: <151127331479.6888.2059069002163826691.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 14/45] windbg: init
 DBGKD_ANY_WAIT_STATE_CHANGE
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

Added function for init DBGKD_ANY_WAIT_STATE_CHANGE. It is a header of 'state change' packets.


Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    8 ++++++
 target/i386/windbgstub.c        |   49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 2d74fb847a..6ce870beb1 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -43,6 +43,14 @@
     _t;                                                       \
 })
 
+#if TARGET_LONG_BITS == 64
+# define sttul_p(p, v) stq_p(p, v)
+# define ldtul_p(p) ldq_p(p)
+#else
+# define sttul_p(p, v) stl_p(p, v)
+# define ldtul_p(p) ldl_p(p)
+#endif
+
 typedef struct InitedAddr {
     target_ulong addr;
     bool is_init;
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 47ee5840ef..a3c433f756 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -17,9 +17,13 @@
 #ifdef TARGET_X86_64
 # define OFFSET_SELF_PCR         0x18
 # define OFFSET_VERS             0x108
+# define OFFSET_KPRCB            0x20
+# define OFFSET_KPRCB_CURRTHREAD 0x8
 #else
 # define OFFSET_SELF_PCR         0x1C
 # define OFFSET_VERS             0x34
+# define OFFSET_KPRCB            0x20
+# define OFFSET_KPRCB_CURRTHREAD 0x4
 #endif
 
 bool windbg_on_load(void)
@@ -66,4 +70,49 @@ bool windbg_on_load(void)
     return true;
 }
 
+__attribute__ ((unused)) /* unused yet */
+static void kd_init_state_change(CPUState *cpu,
+                                 DBGKD_ANY_WAIT_STATE_CHANGE *sc)
+{
+    CPUArchState *env = cpu->env_ptr;
+    DBGKD_CONTROL_REPORT *cr = &sc->ControlReport;
+    InitedAddr *KPCR = windbg_get_KPCR();
+    target_ulong KPRCB;
+    int err = 0;
+
+    /* T0D0: HEADER */
+
+    sc->Processor = 0;
+
+    sc->NumberProcessors = 0;
+    CPUState *cpu_tmp;
+    CPU_FOREACH(cpu_tmp) {
+        sc->NumberProcessors++;
+    }
+    stl_p(&sc->NumberProcessors, sc->NumberProcessors);
+
+    KPRCB = READ_VMEM(cpu, KPCR->addr + OFFSET_KPRCB, target_ulong);
+    sc->Thread = READ_VMEM(cpu, KPRCB + OFFSET_KPRCB_CURRTHREAD, target_ulong);
+    sttul_p(&sc->Thread, sc->Thread);
+    sttul_p(&sc->ProgramCounter, env->eip);
+
+    /* T0D0: CONTROL REPORT */
+
+    sttul_p(&cr->Dr6, env->dr[6]);
+    sttul_p(&cr->Dr7, env->dr[7]);
+    stw_p(&cr->ReportFlags, REPORT_INCLUDES_SEGS | REPORT_STANDARD_CS);
+    stw_p(&cr->SegCs, env->segs[R_CS].selector);
+    stw_p(&cr->SegDs, env->segs[R_DS].selector);
+    stw_p(&cr->SegEs, env->segs[R_ES].selector);
+    stw_p(&cr->SegFs, env->segs[R_FS].selector);
+    stl_p(&cr->EFlags, env->eflags);
+
+    err = cpu_memory_rw_debug(cpu, sc->ProgramCounter,
+                              PTR(cr->InstructionStream[0]),
+                              DBGKD_MAXSTREAM, 0);
+    if (!err) {
+        stw_p(&cr->InstructionCount, DBGKD_MAXSTREAM);
+    }
+}
+
 #endif
