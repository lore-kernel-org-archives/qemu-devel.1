Received: from eggs.gnu.org ([2001:4830:134:3::10]:42620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fzVoz-00018m-GS
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fzVoy-0003lQ-Ma
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:42:21 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fzVou-0003ak-OT
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:42:17 -0400
Received: by mail-lf1-x141.google.com with SMTP id v77-v6so18865680lfa.6
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 16:42:12 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 10 Sep 2018 16:41:54 -0700
Message-Id: <20180910234154.24393-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2] target/xtensa: support input from chardev
 console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Complete xtensa-semi chardev console implementation: allow reading input
characters from file descriptor 0 and call sys_select_one simcall on it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- put CharBackend and input buffer into the XtensaSimConsole structure

 target/xtensa/xtensa-semi.c | 71 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 7aa1d1357bda..2f762162768c 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -34,8 +34,6 @@
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
 
-static CharBackend *xtensa_sim_console;
-
 enum {
     TARGET_SYS_exit = 1,
     TARGET_SYS_read = 3,
@@ -153,13 +151,48 @@ static uint32_t errno_h2g(int host_errno)
     }
 }
 
-void xtensa_sim_open_console(Chardev *chr)
+typedef struct XtensaSimConsole {
+    CharBackend be;
+    struct {
+        char buffer[16];
+        size_t offset;
+    } input;
+} XtensaSimConsole;
+
+static XtensaSimConsole *sim_console;
+
+static IOCanReadHandler sim_console_can_read;
+static int sim_console_can_read(void *opaque)
 {
-    static CharBackend console;
+    XtensaSimConsole *p = opaque;
 
-    qemu_chr_fe_init(&console, chr, &error_abort);
-    qemu_chr_fe_set_handlers(&console, NULL, NULL, NULL, NULL, NULL, NULL, true);
-    xtensa_sim_console = &console;
+    return sizeof(p->input.buffer) - p->input.offset;
+}
+
+static IOReadHandler sim_console_read;
+static void sim_console_read(void *opaque, const uint8_t *buf, int size)
+{
+    XtensaSimConsole *p = opaque;
+    size_t copy = sizeof(p->input.buffer) - p->input.offset;
+
+    if (size < copy) {
+        copy = size;
+    }
+    memcpy(p->input.buffer + p->input.offset, buf, copy);
+    p->input.offset += copy;
+}
+
+void xtensa_sim_open_console(Chardev *chr)
+{
+    static XtensaSimConsole console;
+
+    qemu_chr_fe_init(&console.be, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&console.be,
+                             sim_console_can_read,
+                             sim_console_read,
+                             NULL, NULL, &console,
+                             NULL, true);
+    sim_console = &console;
 }
 
 void HELPER(simcall)(CPUXtensaState *env)
@@ -195,11 +228,27 @@ void HELPER(simcall)(CPUXtensaState *env)
                 if (buf) {
                     vaddr += io_sz;
                     len -= io_sz;
-                    if (fd < 3 && xtensa_sim_console) {
+                    if (fd < 3 && sim_console) {
                         if (is_write && (fd == 1 || fd == 2)) {
-                            io_done = qemu_chr_fe_write_all(xtensa_sim_console,
+                            io_done = qemu_chr_fe_write_all(&sim_console->be,
                                                             buf, io_sz);
                             regs[3] = errno_h2g(errno);
+                        } else if (!is_write && fd == 0) {
+                            if (sim_console->input.offset) {
+                                io_done = sim_console->input.offset;
+                                if (io_sz < io_done) {
+                                    io_done = io_sz;
+                                }
+                                memcpy(buf, sim_console->input.buffer, io_done);
+                                memmove(sim_console->input.buffer,
+                                        sim_console->input.buffer + io_done,
+                                        sim_console->input.offset - io_done);
+                                sim_console->input.offset -= io_done;
+                                qemu_chr_fe_accept_input(&sim_console->be);
+                            } else {
+                                io_done = -1;
+                                regs[3] = TARGET_EAGAIN;
+                            }
                         } else {
                             qemu_log_mask(LOG_GUEST_ERROR,
                                           "%s fd %d is not supported with chardev console\n",
@@ -292,9 +341,11 @@ void HELPER(simcall)(CPUXtensaState *env)
                 tv.tv_sec = (int32_t)tswap32(target_tvv[0]);
                 tv.tv_usec = (int32_t)tswap32(target_tvv[1]);
             }
-            if (fd < 3 && xtensa_sim_console) {
+            if (fd < 3 && sim_console) {
                 if ((fd == 1 || fd == 2) && rq == SELECT_ONE_WRITE) {
                     regs[2] = 1;
+                } else if (fd == 0 && rq == SELECT_ONE_READ) {
+                    regs[2] = sim_console->input.offset > 0;
                 } else {
                     regs[2] = 0;
                 }
-- 
2.11.0
