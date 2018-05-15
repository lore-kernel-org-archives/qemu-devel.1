Received: from eggs.gnu.org ([2001:4830:134:3::10]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIeYh-0001i7-Mv
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIeYg-0007ZN-J2
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:20:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIeYg-0007St-34
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:20:22 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 19:19:58 +0100
Message-Id: <20180515181958.25837-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] gdbstub: Clarify what gdb_handlesig() is doing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

gdb_handlesig()'s behaviour is not entirely obvious at first
glance. Add a doc comment for it, and also add a comment
explaining why it's ok for gdb_do_syscallv() to ignore
gdb_handlesig()'s return value. (Coverity complains about
this: CID 1390850.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This took me a little while to figure out, so we might as
well write it down.

Incidentally, a lot of the code in the per-target main
loops doesn't really use gdb_handlesig() correctly either:
for instance in the arm main loop we (a) forget to tell
gdb about SIGSEGV and (b) assume that if we tell gdb about
a SIGTRAP then the signal we get back on resume is either
0 or SIGTRAP, when it could really be anything.

Ideally we'd push the gdb_handlesig calls into
target-independent code, ie queue_signal(). I'm not
sure what sort of fake siginfo we need to generate
for the "generate a different signal" codepath, though:
probably need to look at eg what the gdb gdbstub does.
---
 include/exec/gdbstub.h | 15 +++++++++++++++
 gdbstub.c              |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 2e8a4b83b9..08363969c1 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -48,6 +48,21 @@ int use_gdb_syscalls(void);
 void gdb_set_stop_cpu(CPUState *cpu);
 void gdb_exit(CPUArchState *, int);
 #ifdef CONFIG_USER_ONLY
+/**
+ * gdb_handlesig: yield control to gdb
+ * @cpu: CPU
+ * @sig: if non-zero, the signal number which caused us to stop
+ *
+ * This function yields control to gdb, when a user-mode-only target
+ * needs to stop execution. If @sig is non-zero, then we will send a
+ * stop packet to tell gdb that we have stopped because of this signal.
+ *
+ * This function will block (handling protocol requests from gdb)
+ * until gdb tells us to continue target execution. When it does
+ * return, the return value is a signal to deliver to the target,
+ * or 0 if no signal should be delivered, ie the signal that caused
+ * us to stop should be ignored.
+ */
 int gdb_handlesig(CPUState *, int);
 void gdb_signalled(CPUArchState *, int);
 void gdbserver_fork(CPUState *);
diff --git a/gdbstub.c b/gdbstub.c
index 3c3807358c..c9a63090ea 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1548,6 +1548,12 @@ void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va)
     *p = 0;
 #ifdef CONFIG_USER_ONLY
     put_packet(s, s->syscall_buf);
+    /* Return control to gdb for it to process the syscall request.
+     * Since the protocol requires that gdb hands control back to us
+     * using a "here are the results" F packet, we don't need to check
+     * gdb_handlesig's return value (which is the signal to deliver if
+     * execution was resumed via a continue packet).
+     */
     gdb_handlesig(s->c_cpu, 0);
 #else
     /* In this case wait to send the syscall packet until notification that
-- 
2.17.0
