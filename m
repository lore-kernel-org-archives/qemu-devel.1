Received: from eggs.gnu.org ([2001:4830:134:3::10]:50903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2x-0000BS-7u
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2w-0001xt-Fs
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:51 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf2w-0001xd-8z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:50 -0400
Received: by mail-wm0-x243.google.com with SMTP id j85so5436907wmj.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:24:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:00 +0200
Message-Id: <1499955874-10954-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/41] chardev: block during sync read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

A sync read should block until all requested data is
available (instead of retrying in qemu_chr_fe_read_all). Change the
channel to blocking during sync_read.

Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170706170353.32601-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ccc499c..7e6648b 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -454,7 +454,9 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
         return 0;
     }
 
+    qio_channel_set_blocking(s->ioc, true, NULL);
     size = tcp_chr_recv(chr, (void *) buf, len);
+    qio_channel_set_blocking(s->ioc, false, NULL);
     if (size == 0) {
         /* connection closed */
         tcp_chr_disconnect(chr);
-- 
1.8.3.1
