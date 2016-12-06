Received: from eggs.gnu.org ([2001:4830:134:3::10]:58416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEHFB-0000Eq-W5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEHF7-0005H5-Fh
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:01:22 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cEHF7-0005Gk-05
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:01:17 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so128836068wmt.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 07:01:16 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  6 Dec 2016 15:00:04 +0000
Message-Id: <20161206150004.19758-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.9] gdbstub: remove spurious
 tb_flush() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, rth@twiddle.net, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

These are (now) mostly harmless but not needed. The correct place to
flush if you want to is in the TCG aware code and not in gdbstub.
Currently flushes are triggered for cpu_single_step() and breakpoint
manipulation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index de62d26..ea48415 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1274,7 +1274,6 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
             cpu->watchpoint_hit = NULL;
             goto send_packet;
         }
-        tb_flush(cpu);
         ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
@@ -1513,7 +1512,6 @@ gdb_handlesig(CPUState *cpu, int sig)
 
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
-    tb_flush(cpu);
 
     if (sig != 0) {
         snprintf(buf, sizeof(buf), "S%02x", target_signal_to_gdb(sig));
-- 
2.10.2
