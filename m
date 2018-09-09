Received: from eggs.gnu.org ([2001:4830:134:3::10]:46780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fypM4-0005go-Pt
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 22:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fypM3-0005cb-KI
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 22:21:40 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fypM3-0005aP-B8
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 22:21:39 -0400
Received: by mail-lj1-x243.google.com with SMTP id s12-v6so15133500ljj.0
	for <qemu-devel@nongnu.org>; Sat, 08 Sep 2018 19:21:39 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat,  8 Sep 2018 19:21:04 -0700
Message-Id: <20180909022104.5939-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: support input from chardev
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
 target/xtensa/xtensa-semi.c | 55 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 7aa1d1357bda..f3c23f8625c2 100644
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
@@ -153,12 +151,45 @@ static uint32_t errno_h2g(int host_errno)
     }
 }
 
+typedef struct SimInputBuffer {
+    char buffer[16];
+    size_t offset;
+} SimInputBuffer;
+
+static CharBackend *xtensa_sim_console;
+static SimInputBuffer sim_input_buffer;
+
+static IOCanReadHandler xtensa_sim_console_can_read;
+static int xtensa_sim_console_can_read(void *opaque)
+{
+    SimInputBuffer *p = opaque;
+
+    return sizeof(p->buffer) - p->offset;
+}
+
+static IOReadHandler xtensa_sim_console_read;
+static void xtensa_sim_console_read(void *opaque, const uint8_t *buf, int size)
+{
+    SimInputBuffer *p = opaque;
+    size_t copy = sizeof(p->buffer) - p->offset;
+
+    if (size < copy) {
+        copy = size;
+    }
+    memcpy(p->buffer + p->offset, buf, copy);
+    p->offset += copy;
+}
+
 void xtensa_sim_open_console(Chardev *chr)
 {
     static CharBackend console;
 
     qemu_chr_fe_init(&console, chr, &error_abort);
-    qemu_chr_fe_set_handlers(&console, NULL, NULL, NULL, NULL, NULL, NULL, true);
+    qemu_chr_fe_set_handlers(&console,
+                             xtensa_sim_console_can_read,
+                             xtensa_sim_console_read,
+                             NULL, NULL, &sim_input_buffer,
+                             NULL, true);
     xtensa_sim_console = &console;
 }
 
@@ -200,6 +231,22 @@ void HELPER(simcall)(CPUXtensaState *env)
                             io_done = qemu_chr_fe_write_all(xtensa_sim_console,
                                                             buf, io_sz);
                             regs[3] = errno_h2g(errno);
+                        } else if (!is_write && fd == 0) {
+                            if (sim_input_buffer.offset) {
+                                io_done = sim_input_buffer.offset;
+                                if (io_sz < io_done) {
+                                    io_done = io_sz;
+                                }
+                                memcpy(buf, sim_input_buffer.buffer, io_done);
+                                memmove(sim_input_buffer.buffer,
+                                        sim_input_buffer.buffer + io_done,
+                                        sim_input_buffer.offset - io_done);
+                                sim_input_buffer.offset -= io_done;
+                                qemu_chr_fe_accept_input(xtensa_sim_console);
+                            } else {
+                                io_done = -1;
+                                regs[3] = TARGET_EAGAIN;
+                            }
                         } else {
                             qemu_log_mask(LOG_GUEST_ERROR,
                                           "%s fd %d is not supported with chardev console\n",
@@ -295,6 +342,8 @@ void HELPER(simcall)(CPUXtensaState *env)
             if (fd < 3 && xtensa_sim_console) {
                 if ((fd == 1 || fd == 2) && rq == SELECT_ONE_WRITE) {
                     regs[2] = 1;
+                } else if (fd == 0 && rq == SELECT_ONE_READ) {
+                    regs[2] = sim_input_buffer.offset > 0;
                 } else {
                     regs[2] = 0;
                 }
-- 
2.11.0
