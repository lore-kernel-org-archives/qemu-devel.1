Received: from eggs.gnu.org ([209.51.188.92]:43176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1goa3r-0000DG-0K
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 15:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1goa3q-00041R-5X
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 15:32:46 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1goa3p-0003zP-Qh
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 15:32:46 -0500
Received: by mail-lj1-x244.google.com with SMTP id u89-v6so18762251lje.1
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 12:32:42 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 29 Jan 2019 12:32:19 -0800
Message-Id: <20190129203219.6473-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] gdbstub: allow killing QEMU via vKill command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Luc Michel <luc.michel@greensocs.com>

With multiprocess extensions gdb uses 'vKill' packet instead of 'k' to
kill the inferior. Handle 'vKill' the same way 'k' was handled in the
presence of single process.

Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
(f|s)ThreadInfo and ThreadExtraInfo")

Cc: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 gdbstub.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index bfc7afb50968..1ef31240c055 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1383,6 +1383,28 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
 
             put_packet(s, buf);
             break;
+        } else if (strncmp(p, "Kill;", 5) == 0) {
+            unsigned long pid;
+
+            p += 5;
+
+            if (qemu_strtoul(p, &p, 16, &pid)) {
+                put_packet(s, "E22");
+                break;
+            }
+            process = gdb_get_process(s, pid);
+
+            if (process == NULL) {
+                put_packet(s, "E22");
+                break;
+            }
+            if (s->process_num <= 1) {
+                /* Kill the target */
+                error_report("QEMU: Terminated via GDBstub");
+                exit(0);
+            }
+            /* TODO: handle multiprocess case */
+            goto unknown_command;
         } else {
             goto unknown_command;
         }
-- 
2.11.0
