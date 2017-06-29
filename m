Received: from eggs.gnu.org ([2001:4830:134:3::10]:58907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQfO3-0005QY-Nc
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQfO0-0007Wm-HK
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:45:59 -0400
Received: from mail-by2nam03on0043.outbound.protection.outlook.com
	([104.47.42.43]:24064
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dQfNz-0007WH-Kt
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:45:56 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 12:42:41 -0700
Message-ID: <453bac0f21aa525d7c9de38d4c8c509b44c4ecda.1498761179.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498761179.git.alistair.francis@xilinx.com>
References: <cover.1498761179.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 3/3] char-socket: Report TCP socket waiting as
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com

When QEMU is waiting for a TCP socket connection it reports that message as
an error. This isn't an error it is just informaiton so let's change the
report to use report() instead.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ccc499cfa1..ad1b3d6e93 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -765,7 +765,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
      * in TLS and telnet cases, only wait for an accepted socket */
     while (!s->ioc) {
         if (s->is_listen) {
-            error_report("QEMU waiting for connection on: %s",
+            report(INFO, "QEMU waiting for connection on: %s",
                          chr->filename);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
             tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
-- 
2.11.0
