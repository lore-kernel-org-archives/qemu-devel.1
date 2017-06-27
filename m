Received: from eggs.gnu.org ([2001:4830:134:3::10]:34605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dPxQ2-0002Hx-SW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dPxPz-0003AQ-Ql
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:49:06 -0400
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com
	([104.47.38.42]:37288
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dPxPz-0003A2-Jt
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:49:03 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 13:45:48 -0700
Message-ID: <55b6931c368b67ece2f0bd7d8e83092727df1e3c.1498596157.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498596157.git.alistair.francis@xilinx.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 3/3] char-socket: Report TCP socket waiting as
 a warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

When QEMU is waiting for a TCP socket connection it reports that message as
an error. This isn't an error it is a warnign so let's change the report to
use warning_report() instead.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ccc499cfa1..5a56628e74 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -765,7 +765,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
      * in TLS and telnet cases, only wait for an accepted socket */
     while (!s->ioc) {
         if (s->is_listen) {
-            error_report("QEMU waiting for connection on: %s",
+            warning_report("QEMU waiting for connection on: %s",
                          chr->filename);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
             tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
-- 
2.11.0
