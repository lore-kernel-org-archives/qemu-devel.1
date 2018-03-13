Received: from eggs.gnu.org ([2001:4830:134:3::10]:57856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshm-0005SX-1K
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshk-0002to-6Q
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:38 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshj-0002sj-V0
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:36 -0400
Received: by mail-wm0-x242.google.com with SMTP id t3so867637wmc.2
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:21 +0100
Message-Id: <20180313224719.4954-12-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/69] chardev: fix handling of EAGAIN for TCP
 chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

When this commit was applied

  commit 9894dc0cdcc397ee5b26370bc53da6d360a363c2
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Tue Jan 19 11:14:29 2016 +0000

    char: convert from GIOChannel to QIOChannel

The tcp_chr_recv() function was changed to return QIO_CHANNEL_ERR_BLOCK
which corresonds to -2. As such the handling for EAGAIN was able to be
removed from tcp_chr_read(). Unfortunately in a later commit:

  commit b6572b4f97a7b126c7b24e165893ed9fe3d72e1f
  Author: Marc-André Lureau <marcandre.lureau@redhat.com>
  Date:   Fri Mar 11 18:55:24 2016 +0100

    char: translate from QIOChannel error to errno

The tcp_chr_recv() function was changed back to return -1, with errno
set to EAGAIN, without also re-addding support for this to tcp_chr_read()

Reported-by: Aleksey Kuleshov <rndfax@yandex.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20180222121351.26191-1-berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a220803c01..541fcf487d 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -450,7 +450,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
         len = s->max_size;
     }
     size = tcp_chr_recv(chr, (void *)buf, len);
-    if (size == 0 || size == -1) {
+    if (size == 0 || (size == -1 && errno != EAGAIN)) {
         /* connection closed */
         tcp_chr_disconnect(chr);
     } else if (size > 0) {
-- 
2.14.3
