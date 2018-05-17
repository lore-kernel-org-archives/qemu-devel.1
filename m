Received: from eggs.gnu.org ([2001:4830:134:3::10]:34455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJLhX-0006aX-Is
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJLhU-0007KR-VV
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:23 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com
	([40.107.5.97]:20608
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fJLhU-0007FD-Og
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:20 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Thu, 17 May 2018 19:23:42 +0300
Message-Id: <20180517162342.4330-5-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
References: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] dump: add Windows live system dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, armbru@redhat.com, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

Unlike dying Windows, live system memory doesn't contain
correct register contexts. But they can be populated with QEMU register
values.
After this patch, QEMU will be able to produce guest Windows live system
dump.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 win_dump.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 win_dump.h |  95 +++++++++++++++++++++++++++++++++++--
 2 files changed, 246 insertions(+), 5 deletions(-)

diff --git a/win_dump.c b/win_dump.c
index 2d9afb514e..b15c191ad7 100644
--- a/win_dump.c
+++ b/win_dump.c
@@ -97,6 +97,14 @@ static void patch_bugcheck_data(WinDumpHeader64 *h, Error **errp)
         error_setg(errp, "win-dump: failed to read bugcheck data");
         return;
     }
+
+    /*
+     * If BugcheckCode wasn't saved, we consider guest OS as alive.
+     */
+
+    if (!h->BugcheckCode) {
+        h->BugcheckCode = LIVE_SYSTEM_DUMP;
+    }
 }
 
 /*
@@ -177,12 +185,139 @@ try_again:
     h->KdDebuggerDataBlock = KdDebuggerDataBlock;
 }
 
+struct saved_context {
+    WinContext ctx;
+    uint64_t addr;
+};
+
+static void patch_and_save_context(WinDumpHeader64 *h,
+                                   struct saved_context *saved_ctx,
+                                   Error **errp)
+{
+    uint64_t KiProcessorBlock;
+    uint16_t OffsetPrcbContext;
+    CPUState *cpu;
+    int i = 0;
+
+    if (cpu_memory_rw_debug(first_cpu,
+            h->KdDebuggerDataBlock + KDBG_KI_PROCESSOR_BLOCK_OFFSET64,
+            (uint8_t *)&KiProcessorBlock, sizeof(KiProcessorBlock), 0)) {
+        error_setg(errp, "win-dump: failed to read KiProcessorBlock");
+        return;
+    }
+
+    if (cpu_memory_rw_debug(first_cpu,
+            h->KdDebuggerDataBlock + KDBG_OFFSET_PRCB_CONTEXT_OFFSET64,
+            (uint8_t *)&OffsetPrcbContext, sizeof(OffsetPrcbContext), 0)) {
+        error_setg(errp, "win-dump: failed to read OffsetPrcbContext");
+        return;
+    }
+
+    CPU_FOREACH(cpu) {
+        X86CPU *x86_cpu = X86_CPU(cpu);
+        CPUX86State *env = &x86_cpu->env;
+        uint64_t Prcb;
+        uint64_t Context;
+        WinContext ctx;
+
+        if (cpu_memory_rw_debug(first_cpu,
+                KiProcessorBlock + i * sizeof(uint64_t),
+                (uint8_t *)&Prcb, sizeof(Prcb), 0)) {
+            error_setg(errp, "win-dump: failed to read"
+                             " CPU #%d PRCB location", i);
+            return;
+        }
+
+        if (cpu_memory_rw_debug(first_cpu,
+                Prcb + OffsetPrcbContext,
+                (uint8_t *)&Context, sizeof(Context), 0)) {
+            error_setg(errp, "win-dump: failed to read"
+                             " CPU #%d ContextFrame location", i);
+            return;
+        }
+
+        saved_ctx[i].addr = Context;
+
+        ctx = (WinContext){
+            .ContextFlags = WIN_CTX_ALL,
+            .MxCsr = env->mxcsr,
+
+            .SegEs = env->segs[0].selector,
+            .SegCs = env->segs[1].selector,
+            .SegSs = env->segs[2].selector,
+            .SegDs = env->segs[3].selector,
+            .SegFs = env->segs[4].selector,
+            .SegGs = env->segs[5].selector,
+            .EFlags = cpu_compute_eflags(env),
+
+            .Dr0 = env->dr[0],
+            .Dr1 = env->dr[1],
+            .Dr2 = env->dr[2],
+            .Dr3 = env->dr[3],
+            .Dr6 = env->dr[6],
+            .Dr7 = env->dr[7],
+
+            .Rax = env->regs[R_EAX],
+            .Rbx = env->regs[R_EBX],
+            .Rcx = env->regs[R_ECX],
+            .Rdx = env->regs[R_EDX],
+            .Rsp = env->regs[R_ESP],
+            .Rbp = env->regs[R_EBP],
+            .Rsi = env->regs[R_ESI],
+            .Rdi = env->regs[R_EDI],
+            .R8  = env->regs[8],
+            .R9  = env->regs[9],
+            .R10 = env->regs[10],
+            .R11 = env->regs[11],
+            .R12 = env->regs[12],
+            .R13 = env->regs[13],
+            .R14 = env->regs[14],
+            .R15 = env->regs[15],
+
+            .Rip = env->eip,
+            .FltSave = {
+                .MxCsr = env->mxcsr,
+            },
+        };
+
+        if (cpu_memory_rw_debug(first_cpu, Context,
+                (uint8_t *)&saved_ctx[i].ctx, sizeof(WinContext), 0)) {
+            error_setg(errp, "win-dump: failed to save CPU #%d context", i);
+            return;
+        }
+
+        if (cpu_memory_rw_debug(first_cpu, Context,
+                (uint8_t *)&ctx, sizeof(WinContext), 1)) {
+            error_setg(errp, "win-dump: failed to write CPU #%d context", i);
+            return;
+        }
+
+        i++;
+    }
+}
+
+static void restore_context(WinDumpHeader64 *h,
+                            struct saved_context *saved_ctx)
+{
+    int i;
+    Error *err = NULL;
+
+    for (i = 0; i < h->NumberProcessors; i++) {
+        if (cpu_memory_rw_debug(first_cpu, saved_ctx[i].addr,
+                (uint8_t *)&saved_ctx[i].ctx, sizeof(WinContext), 1)) {
+            error_setg(&err, "win-dump: failed to restore CPU #%d context", i);
+            warn_report_err(err);
+        }
+    }
+}
+
 void create_win_dump(DumpState *s, Error **errp)
 {
     WinDumpHeader64 *h = (WinDumpHeader64 *)(s->guest_note +
             VMCOREINFO_ELF_NOTE_HDR_SIZE);
     X86CPU *first_x86_cpu = X86_CPU(first_cpu);
     uint64_t saved_cr3 = first_x86_cpu->env.cr[3];
+    struct saved_context *saved_ctx = NULL;
     Error *local_err = NULL;
 
     if (s->guest_note_size != sizeof(WinDumpHeader64) +
@@ -212,20 +347,37 @@ void create_win_dump(DumpState *s, Error **errp)
 
     patch_header(h);
 
+    saved_ctx = g_new(struct saved_context, h->NumberProcessors);
+
+    /*
+     * Always patch context because there is no way
+     * to determine if the system-saved context is valid
+     */
+
+    patch_and_save_context(h, saved_ctx, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out_free;
+    }
+
     s->total_size = h->RequiredDumpSpace;
 
     s->written_size = qemu_write_full(s->fd, h, sizeof(*h));
     if (s->written_size != sizeof(*h)) {
         error_setg(errp, QERR_IO_ERROR);
-        goto out_cr3;
+        goto out_restore;
     }
 
     write_runs(s, h, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out_cr3;
+        goto out_restore;
     }
 
+out_restore:
+    restore_context(h, saved_ctx);
+out_free:
+    g_free(saved_ctx);
 out_cr3:
     first_x86_cpu->env.cr[3] = saved_cr3;
 
diff --git a/win_dump.h b/win_dump.h
index 281241881e..f9e1faf8eb 100644
--- a/win_dump.h
+++ b/win_dump.h
@@ -80,8 +80,97 @@ typedef struct WinDumpHeader64 {
 
 void create_win_dump(DumpState *s, Error **errp);
 
-#define KDBG_OWNER_TAG_OFFSET64         0x10
-#define KDBG_KI_BUGCHECK_DATA_OFFSET64  0x88
-#define KDBG_MM_PFN_DATABASE_OFFSET64   0xC0
+#define KDBG_OWNER_TAG_OFFSET64             0x10
+#define KDBG_MM_PFN_DATABASE_OFFSET64       0xC0
+#define KDBG_KI_BUGCHECK_DATA_OFFSET64      0x88
+#define KDBG_KI_PROCESSOR_BLOCK_OFFSET64    0x218
+#define KDBG_OFFSET_PRCB_CONTEXT_OFFSET64   0x338
 
 #define VMCOREINFO_ELF_NOTE_HDR_SIZE    24
+
+#define WIN_CTX_X64 0x00100000L
+
+#define WIN_CTX_CTL 0x00000001L
+#define WIN_CTX_INT 0x00000002L
+#define WIN_CTX_SEG 0x00000004L
+#define WIN_CTX_FP  0x00000008L
+#define WIN_CTX_DBG 0x00000010L
+
+#define WIN_CTX_FULL    (WIN_CTX_X64 | WIN_CTX_CTL | WIN_CTX_INT | WIN_CTX_FP)
+#define WIN_CTX_ALL     (WIN_CTX_FULL | WIN_CTX_SEG | WIN_CTX_DBG)
+
+#define LIVE_SYSTEM_DUMP    0x00000161
+
+typedef struct WinM128A {
+    uint64_t low;
+    int64_t high;
+} QEMU_ALIGNED(16) WinM128A;
+
+typedef struct WinContext {
+    uint64_t PHome[6];
+
+    uint32_t ContextFlags;
+    uint32_t MxCsr;
+
+    uint16_t SegCs;
+    uint16_t SegDs;
+    uint16_t SegEs;
+    uint16_t SegFs;
+    uint16_t SegGs;
+    uint16_t SegSs;
+    uint32_t EFlags;
+
+    uint64_t Dr0;
+    uint64_t Dr1;
+    uint64_t Dr2;
+    uint64_t Dr3;
+    uint64_t Dr6;
+    uint64_t Dr7;
+
+    uint64_t Rax;
+    uint64_t Rcx;
+    uint64_t Rdx;
+    uint64_t Rbx;
+    uint64_t Rsp;
+    uint64_t Rbp;
+    uint64_t Rsi;
+    uint64_t Rdi;
+    uint64_t R8;
+    uint64_t R9;
+    uint64_t R10;
+    uint64_t R11;
+    uint64_t R12;
+    uint64_t R13;
+    uint64_t R14;
+    uint64_t R15;
+
+    uint64_t Rip;
+
+    struct {
+        uint16_t ControlWord;
+        uint16_t StatusWord;
+        uint8_t TagWord;
+        uint8_t Reserved1;
+        uint16_t ErrorOpcode;
+        uint32_t ErrorOffset;
+        uint16_t ErrorSelector;
+        uint16_t Reserved2;
+        uint32_t DataOffset;
+        uint16_t DataSelector;
+        uint16_t Reserved3;
+        uint32_t MxCsr;
+        uint32_t MxCsr_Mask;
+        WinM128A FloatRegisters[8];
+        WinM128A XmmRegisters[16];
+        uint8_t Reserved4[96];
+    } FltSave;
+
+    WinM128A VectorRegister[26];
+    uint64_t VectorControl;
+
+    uint64_t DebugControl;
+    uint64_t LastBranchToRip;
+    uint64_t LastBranchFromRip;
+    uint64_t LastExceptionToRip;
+    uint64_t LastExceptionFromRip;
+} QEMU_ALIGNED(16) WinContext;
-- 
2.14.3
