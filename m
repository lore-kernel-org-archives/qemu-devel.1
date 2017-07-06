Received: from eggs.gnu.org ([2001:4830:134:3::10]:36823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTGa5-0004tV-So
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTGa1-00010j-Ps
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:53:09 -0400
Received: from mail-co1nam03on0053.outbound.protection.outlook.com
	([104.47.40.53]:12512
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dTGa1-0000zU-Aa
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:53:05 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 6 Jul 2017 16:49:47 -0700
Message-ID: <77970edd100d0ddbaeb433d0cb13c96b2be15006.1499381754.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1499381754.git.alistair.francis@xilinx.com>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 4/6] char-socket: Report TCP socket waiting
 as information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com

When QEMU is waiting for a TCP socket connection it reports that message as
an error. This isn't an error it is just information so let's change the
report to use info_report() instead.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---

 chardev/char-socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ccc499cfa1..a050a686ea 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -765,8 +765,8 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
      * in TLS and telnet cases, only wait for an accepted socket */
     while (!s->ioc) {
         if (s->is_listen) {
-            error_report("QEMU waiting for connection on: %s",
-                         chr->filename);
+            info_report("QEMU waiting for connection on: %s",
+                        chr->filename);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
             tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), false, NULL);
-- 
2.11.0
