Received: from eggs.gnu.org ([209.51.188.92]:36111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AX-0001xZ-2y
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AS-0000bm-TD
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:56 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AS-0000Rl-Ie
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:52 -0500
Received: by mail-wr1-x430.google.com with SMTP id z18so3711701wrh.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.35
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:04 +0000
Message-Id: <20190205170510.21984-17-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/22] gdbstub: allow killing QEMU via vKill
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

From: Max Filippov <jcmvbkbc@gmail.com>

With multiprocess extensions gdb uses 'vKill' packet instead of 'k' to
kill the inferior. Handle 'vKill' the same way 'k' was handled in the
presence of single process.

Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
(f|s)ThreadInfo and ThreadExtraInfo")

Cc: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-id: 20190130192403.13754-1-jcmvbkbc@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 3129b5c2842..a4be63f6eb4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1359,6 +1359,10 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
 
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
2.20.1
