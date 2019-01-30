Received: from eggs.gnu.org ([209.51.188.92]:33551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1govTY-0007sT-Te
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 14:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1govTX-0005x9-Ng
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 14:24:44 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1govTX-0005nq-Fs
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 14:24:43 -0500
Received: by mail-lj1-x244.google.com with SMTP id v1-v6so626982ljd.0
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 11:24:26 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 30 Jan 2019 11:24:03 -0800
Message-Id: <20190130192403.13754-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2] gdbstub: allow killing QEMU via vKill
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>, Luc Michel <luc.michel@greensocs.com>

With multiprocess extensions gdb uses 'vKill' packet instead of 'k' to
kill the inferior. Handle 'vKill' the same way 'k' was handled in the
presence of single process.

Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
(f|s)ThreadInfo and ThreadExtraInfo")

Cc: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- terminate QEMU in the vKill packet handler regardless of whatever the
  PID is or how many processes are attached [Luc Michel]

 gdbstub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index bfc7afb50968..96ffcd9d9d1d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1383,6 +1383,10 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
 
             put_packet(s, buf);
             break;
+        } else if (strncmp(p, "Kill;", 5) == 0) {
+            /* Kill the target */
+            error_report("QEMU: Terminated via GDBstub");
+            exit(0);
         } else {
             goto unknown_command;
         }
-- 
2.11.0
