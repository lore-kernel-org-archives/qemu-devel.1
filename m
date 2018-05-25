Received: from eggs.gnu.org ([2001:4830:134:3::10]:38438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vd-0001kC-9x
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vc-0008JW-4S
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fM7vb-0008Ib-Rx
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:24 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 25 May 2018 10:17:54 +0200
Message-Id: <20180525081754.29506-14-laurent@vivier.eu>
In-Reply-To: <20180525081754.29506-1-laurent@vivier.eu>
References: <20180525081754.29506-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 13/13] gdbstub: Clarify what gdb_handlesig() is
 doing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

gdb_handlesig()'s behaviour is not entirely obvious at first
glance. Add a doc comment for it, and also add a comment
explaining why it's ok for gdb_do_syscallv() to ignore
gdb_handlesig()'s return value. (Coverity complains about
this: CID 1390850.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180515181958.25837-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 gdbstub.c              |  6 ++++++
 include/exec/gdbstub.h | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index e4ece2f5bc..6081e719c5 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1558,6 +1558,12 @@ void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_list va)
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
-- 
2.14.3
