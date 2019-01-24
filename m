Received: from eggs.gnu.org ([209.51.188.92]:43751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gmeQJ-0008Or-Bc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gmeQI-0008Bj-I8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:47:59 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:34206
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1gmeQI-00088w-CC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:47:58 -0500
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu, 24 Jan 2019 13:47:49 +0100
Message-Id: <1548334069-9158-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH] gdbstub: shutdown guest when the target is
 killed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@redhat.com, edgar.iglesias@xilinx.com, alistair.francis@wdc.com, luc.michel@greensocs.com, frederic.konrad@adacore.com

Under MinGW when the target is killed no "W00" packet are received by GDB
because gdbstub takes the "exit(0)" path. So replace the "exit(0)" call by
a normal guest shutdown so the "W00" packet has a chance to be sent in
"gdb_cleanup".

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 gdbstub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index bfc7afb..c91a909 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1389,7 +1389,12 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     case 'k':
         /* Kill the target */
         error_report("QEMU: Terminated via GDBstub");
+#ifdef CONFIG_USER_ONLY
         exit(0);
+#else
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+#endif
+        break;
     case 'D':
         /* Detach packet */
         pid = 1;
-- 
1.8.3.1
