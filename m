Received: from eggs.gnu.org ([2001:4830:134:3::10]:56804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dHwsN-0003a1-8I
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dHwsI-0000MJ-AM
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:37:15 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com
	([104.47.38.87]:61945
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dHwsI-0000Lf-24
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:37:10 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 5 Jun 2017 11:34:11 -0700
Message-ID: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] char-socket: Don't report TCP socket
 waiting as an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

When QEMU is waiting for a TCP socket connection it reports that message as
an error. This isn't an error though, so let's change the report to just
use qemu_log().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 chardev/char-socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ccc499cfa1..a9884fa85b 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -27,6 +27,7 @@
 #include "io/channel-tls.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qapi/clone-visitor.h"
 
 #include "chardev/char-io.h"
@@ -765,7 +766,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
      * in TLS and telnet cases, only wait for an accepted socket */
     while (!s->ioc) {
         if (s->is_listen) {
-            error_report("QEMU waiting for connection on: %s",
+            qemu_log("QEMU waiting for connection on: %s",
                          chr->filename);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
             tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
-- 
2.11.0
