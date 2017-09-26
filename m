Received: from eggs.gnu.org ([2001:4830:134:3::10]:59334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwng9-0003zt-3p
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwng7-0000of-JU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:29 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51876)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwng6-0000oI-VR
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:27 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:05:24 +0300
Message-ID: <150642392471.3900.18243723823459989509.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 14/43] windbg: init DBGKD_ANY_WAIT_STATE_CHANGE
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
 include/exec/windbgstub-utils.h |    8 +++++
 windbgstub-utils.c              |   57 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 63df5e339c..cf2996d8cb 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -62,6 +62,14 @@
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
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 662096647e..60f6705f7c 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -14,9 +14,13 @@
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
 
 typedef struct KDData {
@@ -26,6 +30,59 @@ typedef struct KDData {
 
 static KDData *kd;
 
+static void kd_breakpoint_remove_range(CPUState *cpu, target_ulong base,
+                                       target_ulong limit)
+{}
+
+__attribute__ ((unused)) /* unused yet */
+static void kd_init_state_change(CPUState *cpu,
+                                 DBGKD_ANY_WAIT_STATE_CHANGE *sc)
+{
+    CPUArchState *env = cpu->env_ptr;
+    DBGKD_CONTROL_REPORT *cr = &sc->ControlReport;
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
+    sc->NumberProcessors = ldl_p(&sc->NumberProcessors);
+
+    target_ulong KPRCB = READ_VMEM(cpu, kd->KPCR.addr +
+                                   OFFSET_KPRCB, target_ulong);
+    sc->Thread = READ_VMEM(cpu, KPRCB + OFFSET_KPRCB_CURRTHREAD,
+                           target_ulong);
+    sc->Thread = ldtul_p(&sc->Thread);
+    sc->ProgramCounter = ldtul_p(&env->eip);
+
+    /* T0D0: CONTROL REPORT */
+
+    cr->Dr6 = ldtul_p(&env->dr[6]);
+    cr->Dr7 = ldtul_p(&env->dr[7]);
+    cr->ReportFlags = REPORT_INCLUDES_SEGS | REPORT_STANDARD_CS;
+    cr->ReportFlags = lduw_p(&cr->ReportFlags);
+    cr->SegCs = lduw_p(&env->segs[R_CS].selector);
+    cr->SegDs = lduw_p(&env->segs[R_DS].selector);
+    cr->SegEs = lduw_p(&env->segs[R_ES].selector);
+    cr->SegFs = lduw_p(&env->segs[R_FS].selector);
+    cr->EFlags = ldl_p(&env->eflags);
+
+    err = cpu_memory_rw_debug(cpu, sc->ProgramCounter,
+                              PTR(cr->InstructionStream[0]),
+                              DBGKD_MAXSTREAM, 0);
+    if (!err) {
+        cr->InstructionCount = DBGKD_MAXSTREAM;
+        cr->InstructionCount = lduw_p(&cr->InstructionCount);
+        kd_breakpoint_remove_range(cpu, sc->ProgramCounter,
+                                   sc->ProgramCounter + DBGKD_MAXSTREAM);
+    }
+}
+
 bool windbg_on_load(void)
 {
     CPUState *cpu = qemu_get_cpu(0);
