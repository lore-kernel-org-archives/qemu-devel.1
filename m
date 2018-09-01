Received: from eggs.gnu.org ([2001:4830:134:3::10]:35462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JD-0004pE-J0
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JC-0007o6-GA
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:23 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:35 +0200
Message-Id: <20180901124639.19735-12-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 11/15] gdbstub: add support for vAttach packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, mark.burton@greensocs.com

Add support for the vAttach packets. In multiprocess mode, GDB sends
them to attach to additional processes.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 4bed0a85f3..4874d65a30 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1327,10 +1327,42 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
                     break;
                 }
                 goto unknown_command;
             }
             break;
+        } else if (strncmp(p, "Attach", 6) == 0) {
+            unsigned long pid;
+
+            p += 7;
+
+            qemu_strtoul(p, &p, 16, &pid);
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
+                     get_thread_id(s, cpu, thread_id, sizeof(thread_id)));
+
+            put_packet(s, buf);
+            break;
         } else {
             goto unknown_command;
         }
     case 'k':
         /* Kill the target */
-- 
2.18.0
