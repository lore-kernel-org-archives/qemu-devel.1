Received: from eggs.gnu.org ([2001:4830:134:3::10]:35477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JD-0004rK-W6
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JC-0007oI-M4
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:23 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:29 +0200
Message-Id: <20180901124639.19735-6-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 05/15] gdbstub: add multiprocess support to
 'sC' packets
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

Change the sC packet handling to support the multiprocess extension.
Instead of returning the first thread, we return the first thread of the
current process.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 2cb9cb6d97..c15250ce65 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1531,13 +1531,18 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             type = strtoul(p, (char **)&p, 16);
             sstep_flags = type;
             put_packet(s, "OK");
             break;
         } else if (strcmp(p,"C") == 0) {
-            /* "Current thread" remains vague in the spec, so always return
-             *  the first CPU (gdb returns the first thread). */
-            put_packet(s, "QC1");
+            /* "Current thread" remains vague in the spec, so always return the
+             * first thread of the current process (gdb returns the first
+             * thread).
+             */
+            cpu = get_first_cpu_in_process(s, gdb_get_cpu_process(s, s->g_cpu));
+            snprintf(buf, sizeof(buf), "QC%s",
+                     get_thread_id(s, cpu, thread_id, sizeof(thread_id)));
+            put_packet(s, buf);
             break;
         } else if (strcmp(p,"fThreadInfo") == 0) {
             s->query_cpu = first_cpu;
             goto report_cpuinfo;
         } else if (strcmp(p,"sThreadInfo") == 0) {
-- 
2.18.0
