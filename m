Received: from eggs.gnu.org ([209.51.188.92]:46149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoR-0004ue-Cm
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoO-0001rx-P6
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoM-0001iy-Ai
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:35 -0500
Received: by mail-wm1-x32f.google.com with SMTP id n190so1469885wmd.0
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:48 +0000
Message-Id: <20190107163117.16269-9-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/37] gdbstub: add multiprocess support to 'sC'
 packets
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

Change the sC packet handling to support the multiprocess extension.
Instead of returning the first thread, we return the first thread of the
current process.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181207090135.7651-7-luc.michel@greensocs.com
[PMM: corrected checkpatch comment style nit]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 09114ea7769..1ba7aa6a28a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1554,9 +1554,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
             put_packet(s, "OK");
             break;
         } else if (strcmp(p,"C") == 0) {
-            /* "Current thread" remains vague in the spec, so always return
-             *  the first CPU (gdb returns the first thread). */
-            put_packet(s, "QC1");
+            /*
+             * "Current thread" remains vague in the spec, so always return
+             * the first thread of the current process (gdb returns the
+             * first thread).
+             */
+            cpu = get_first_cpu_in_process(s, gdb_get_cpu_process(s, s->g_cpu));
+            snprintf(buf, sizeof(buf), "QC%s",
+                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_id)));
+            put_packet(s, buf);
             break;
         } else if (strcmp(p,"fThreadInfo") == 0) {
             s->query_cpu = first_cpu;
-- 
2.19.2
