Received: from eggs.gnu.org ([209.51.188.92]:46290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoZ-0004zo-Ce
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoX-000244-UW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoX-0001ud-Mn
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id n190so1470222wmd.0
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:54 +0000
Message-Id: <20190107163117.16269-15-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/37] gdbstub: add support for vAttach packets
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

Add support for the vAttach packets. In multiprocess mode, GDB sends
them to attach to additional processes.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181207090135.7651-13-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 9b6b4d20a02..d80af955cea 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1348,6 +1348,41 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
                 goto unknown_command;
             }
             break;
+        } else if (strncmp(p, "Attach;", 7) == 0) {
+            unsigned long pid;
+
+            p += 7;
+
+            if (qemu_strtoul(p, &p, 16, &pid)) {
+                put_packet(s, "E22");
+                break;
+            }
+
+            process = gdb_get_process(s, pid);
+
+            if (process == NULL) {
+                put_packet(s, "E22");
+                break;
+            }
+
+            cpu = get_first_cpu_in_process(s, process);
+
+            if (cpu == NULL) {
+                /* Refuse to attach an empty process */
+                put_packet(s, "E22");
+                break;
+            }
+
+            process->attached = true;
+
+            s->g_cpu = cpu;
+            s->c_cpu = cpu;
+
+            snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
+                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
+
+            put_packet(s, buf);
+            break;
         } else {
             goto unknown_command;
         }
-- 
2.19.2
