Received: from eggs.gnu.org ([2001:4830:134:3::10]:41638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKQ-0008Vk-IP
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKM-0005EE-D7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:26 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60060)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsKM-00051F-1z
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:22 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:00:08 +0300
Message-ID: <154409760821.5432.8492771845358817756.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 16/39] windbg: init
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

Add function for init DBGKD_ANY_WAIT_STATE_CHANGE. It is a header of
'state change' packets.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 target/i386/windbgstub.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index f1bab10b10..b2ac7a6d5f 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -15,9 +15,13 @@
 #ifdef TARGET_X86_64
 #define OFFSET_KPCR_SELF 0x18
 #define OFFSET_KPCR_LOCK_ARRAY 0x28
+#define OFFSET_KPRCB 0x20
+#define OFFSET_KPRCB_CURRTHREAD 0x8
 #else  /* TARGET_I386 */
 #define OFFSET_KPCR_SELF 0x1C
 #define OFFSET_KPCR_VERSION 0x34
+#define OFFSET_KPRCB 0x20
+#define OFFSET_KPRCB_CURRTHREAD 0x4
 #endif /* TARGET_I386 */
 
 #ifdef TARGET_X86_64
@@ -156,3 +160,44 @@ void windbg_on_reset(void)
     kdVersion.is_init = false;
 #endif
 }
+
+__attribute__ ((unused)) /* unused yet */
+static void kd_init_state_change(CPUState *cs, DBGKD_ANY_WAIT_STATE_CHANGE *sc)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    DBGKD_CONTROL_REPORT *cr = &sc->ControlReport;
+    target_ulong KPRCB = VMEM_ADDR(cs, KPCR.addr + OFFSET_KPRCB);
+    target_ulong thread = VMEM_ADDR(cs, KPRCB + OFFSET_KPRCB_CURRTHREAD);
+    int number_processors = 0;
+
+    CPUState *cpu_tmp;
+    CPU_FOREACH(cpu_tmp) {
+        ++number_processors;
+    }
+
+    /* HEADER */
+
+    /* TODO: Fix this hardcoded value. */
+    stw_p(&sc->ProcessorLevel, 0);
+    /* TODO: Fix this hardcoded value. */
+    stw_p(&sc->Processor, 0);
+    stl_p(&sc->NumberProcessors, number_processors);
+    sttul_p(&sc->Thread, thread);
+    sttul_p(&sc->ProgramCounter, env->eip);
+
+    /* CONTROL REPORT */
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
+    /* This is a feature */
+    memset(cr->InstructionStream, 0, DBGKD_MAXSTREAM);
+    stw_p(&cr->InstructionCount, 0);
+}
