Received: from eggs.gnu.org ([2001:4830:134:3::10]:43672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d9K6n-0006LV-S6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d9K6m-0007tl-GW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:29 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1d9K6l-0007sQ-U4
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:36:28 -0400
Received: by mail-lf0-x243.google.com with SMTP id 99so1192952lfu.2
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:36:27 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 12 May 2017 16:36:04 -0700
Message-Id: <1494632164-23799-4-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1494632164-23799-1-git-send-email-jcmvbkbc@gmail.com>
References: <1494632164-23799-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] target/xtensa: support output to chardev
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

In semihosting mode QEMU allows guest to read and write host file
descriptors directly, including descriptors 0..2, a.k.a. stdin, stdout
and stderr. Sometimes it's desirable to have semihosting console
controlled by -serial option, e.g. to connect it to network.

Add semihosting console to xtensa-semi.c, open it in the 'sim' machine
in the presence of -serial option and direct stdout and stderr to it
when it's present.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/sim.c             |  4 +++
 target/xtensa/cpu.h         |  1 +
 target/xtensa/xtensa-semi.c | 66 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index b27e28d..5521e91 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -114,6 +114,9 @@ static void xtensa_sim_init(MachineState *machine)
         xtensa_create_memory_regions(&sysram, "xtensa.sysram");
     }
 
+    if (serial_hds[0]) {
+        xtensa_sim_open_console(serial_hds[0]);
+    }
     if (kernel_filename) {
         uint64_t elf_entry;
         uint64_t elf_lowaddr;
@@ -136,6 +139,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->is_default = true;
     mc->init = xtensa_sim_init;
     mc->max_cpus = 4;
+    mc->no_serial = 1;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index ecca17d..ee29fb1 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -483,6 +483,7 @@ void xtensa_translate_init(void);
 void xtensa_breakpoint_handler(CPUState *cs);
 void xtensa_finalize_config(XtensaConfig *config);
 void xtensa_register_core(XtensaConfigList *node);
+void xtensa_sim_open_console(Chardev *chr);
 void check_interrupts(CPUXtensaState *s);
 void xtensa_irq_init(CPUXtensaState *env);
 void *xtensa_get_extint(CPUXtensaState *env, unsigned extint);
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index ffcaf8d..01c622e 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -29,7 +29,12 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/semihost.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
+#include "sysemu/char.h"
+#include "sysemu/sysemu.h"
+
+static CharBackend *xtensa_sim_console;
 
 enum {
     TARGET_SYS_exit = 1,
@@ -148,6 +153,15 @@ static uint32_t errno_h2g(int host_errno)
     }
 }
 
+void xtensa_sim_open_console(Chardev *chr)
+{
+    static CharBackend console;
+
+    qemu_chr_fe_init(&console, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&console, NULL, NULL, NULL, NULL, NULL, true);
+    xtensa_sim_console = &console;
+}
+
 void HELPER(simcall)(CPUXtensaState *env)
 {
     CPUState *cs = CPU(xtensa_env_get_cpu(env));
@@ -181,10 +195,25 @@ void HELPER(simcall)(CPUXtensaState *env)
                 if (buf) {
                     vaddr += io_sz;
                     len -= io_sz;
-                    io_done = is_write ?
-                        write(fd, buf, io_sz) :
-                        read(fd, buf, io_sz);
-                    regs[3] = errno_h2g(errno);
+                    if (fd < 3 && xtensa_sim_console) {
+                        if (is_write && (fd == 1 || fd == 2)) {
+                            io_done = qemu_chr_fe_write_all(xtensa_sim_console,
+                                                            buf, io_sz);
+                            regs[3] = errno_h2g(errno);
+                        } else {
+                            qemu_log_mask(LOG_GUEST_ERROR,
+                                          "%s fd %d is not supported with chardev console\n",
+                                          is_write ?
+                                          "writing to" : "reading from", fd);
+                            io_done = -1;
+                            regs[3] = TARGET_EBADF;
+                        }
+                    } else {
+                        io_done = is_write ?
+                            write(fd, buf, io_sz) :
+                            read(fd, buf, io_sz);
+                        regs[3] = errno_h2g(errno);
+                    }
                     if (io_done == -1) {
                         error = true;
                         io_done = 0;
@@ -256,10 +285,6 @@ void HELPER(simcall)(CPUXtensaState *env)
             uint32_t target_tvv[2];
 
             struct timeval tv = {0};
-            fd_set fdset;
-
-            FD_ZERO(&fdset);
-            FD_SET(fd, &fdset);
 
             if (target_tv) {
                 cpu_memory_rw_debug(cs, target_tv,
@@ -267,12 +292,25 @@ void HELPER(simcall)(CPUXtensaState *env)
                 tv.tv_sec = (int32_t)tswap32(target_tvv[0]);
                 tv.tv_usec = (int32_t)tswap32(target_tvv[1]);
             }
-            regs[2] = select(fd + 1,
-                    rq == SELECT_ONE_READ   ? &fdset : NULL,
-                    rq == SELECT_ONE_WRITE  ? &fdset : NULL,
-                    rq == SELECT_ONE_EXCEPT ? &fdset : NULL,
-                    target_tv ? &tv : NULL);
-            regs[3] = errno_h2g(errno);
+            if (fd < 3 && xtensa_sim_console) {
+                if ((fd == 1 || fd == 2) && rq == SELECT_ONE_WRITE) {
+                    regs[2] = 1;
+                } else {
+                    regs[2] = 0;
+                }
+                regs[3] = 0;
+            } else {
+                fd_set fdset;
+
+                FD_ZERO(&fdset);
+                FD_SET(fd, &fdset);
+                regs[2] = select(fd + 1,
+                                 rq == SELECT_ONE_READ   ? &fdset : NULL,
+                                 rq == SELECT_ONE_WRITE  ? &fdset : NULL,
+                                 rq == SELECT_ONE_EXCEPT ? &fdset : NULL,
+                                 target_tv ? &tv : NULL);
+                regs[3] = errno_h2g(errno);
+            }
         }
         break;
 
-- 
2.1.4
