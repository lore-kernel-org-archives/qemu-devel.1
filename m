Received: from eggs.gnu.org ([2001:4830:134:3::10]:33401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RdW-0003gX-PX
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RdP-0005Hm-TI
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:20 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56744)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RdP-0005Eu-0E
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:15 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:10:09 +0300
Message-ID: <150824580953.6816.17308668705388913065.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 14/43] windbg: init
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
index d6abb82dfa..5aa54550cd 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -50,6 +50,14 @@
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
index 83e80bdfc8..da0aeb4f1b 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -15,9 +15,13 @@
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
@@ -63,3 +67,48 @@ bool windbg_on_load(void)
 
     return true;
 }
+
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
