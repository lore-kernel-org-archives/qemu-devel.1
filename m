Received: from eggs.gnu.org ([209.51.188.92]:46350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoa-00050L-8a
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoY-00024s-BB
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:48 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:56147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoX-0001w9-V9
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:46 -0500
Received: by mail-wm1-x331.google.com with SMTP id y139so1436454wmc.5
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:55 +0000
Message-Id: <20190107163117.16269-16-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/37] gdbstub: processes initialization on new
 peer connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

When a new connection is established, we set the first process to be
attached, and the others detached. The first CPU of the first process
is selected as the current CPU.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181207090135.7651-14-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index d80af955cea..432e7d2f7da 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2267,9 +2267,10 @@ static bool gdb_accept(void)
     }
 
     s = g_malloc0(sizeof(GDBState));
-    s->c_cpu = first_cpu;
-    s->g_cpu = first_cpu;
     create_default_process(s);
+    s->processes[0].attached = true;
+    s->c_cpu = gdb_first_attached_cpu(s);
+    s->g_cpu = s->c_cpu;
     s->fd = fd;
     gdb_has_xml = false;
 
@@ -2355,8 +2356,19 @@ static void gdb_chr_receive(void *opaque, const uint8_t *buf, int size)
 
 static void gdb_chr_event(void *opaque, int event)
 {
+    int i;
+    GDBState *s = (GDBState *) opaque;
+
     switch (event) {
     case CHR_EVENT_OPENED:
+        /* Start with first process attached, others detached */
+        for (i = 0; i < s->process_num; i++) {
+            s->processes[i].attached = !i;
+        }
+
+        s->c_cpu = gdb_first_attached_cpu(s);
+        s->g_cpu = s->c_cpu;
+
         vm_stop(RUN_STATE_PAUSED);
         gdb_has_xml = false;
         break;
@@ -2546,15 +2558,13 @@ int gdbserver_start(const char *device)
         memset(s, 0, sizeof(GDBState));
         s->mon_chr = mon_chr;
     }
-    s->c_cpu = first_cpu;
-    s->g_cpu = first_cpu;
 
     create_processes(s);
 
     if (chr) {
         qemu_chr_fe_init(&s->chr, chr, &error_abort);
         qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_receive,
-                                 gdb_chr_event, NULL, NULL, NULL, true);
+                                 gdb_chr_event, NULL, s, NULL, true);
     }
     s->state = chr ? RS_IDLE : RS_INACTIVE;
     s->mon_chr = mon_chr;
-- 
2.19.2
