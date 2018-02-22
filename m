Received: from eggs.gnu.org ([2001:4830:134:3::10]:39498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1eopDt-0005Ut-G2
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1eopDq-0007cD-E6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:39:37 -0500
Received: from forward103o.mail.yandex.net ([37.140.190.177]:40067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rndfax@yandex.ru>) id 1eopDq-00079Y-1N
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:39:34 -0500
From: Aleksey Kuleshov <rndfax@yandex.ru>
MIME-Version: 1.0
Message-Id: <52841519299484@web28j.yandex.ru>
Date: Thu, 22 Feb 2018 14:38:04 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Qemu-devel] Patch 9894dc0cdcc broke something
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hello!

I hit unexpected disconnections because of this patch:

commit 9894dc0cdcc397ee5b26370bc53da6d360a363c2
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Tue Jan 19 11:14:29 2016 +0000

    char: convert from GIOChannel to QIOChannel
    
    In preparation for introducing TLS support to the TCP chardev
    backend, convert existing chardev code from using GIOChannel
    to QIOChannel. This simplifies the chardev code by removing
    most of the OS platform conditional code for dealing with
    file descriptor passing.
    
    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Message-Id: <1453202071-10289-3-git-send-email-berrange@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

breaks tcp_chr_read:

-static gboolean tcp_chr_read(GIOChannel *chan, GIOCondition cond, void *opaque)
+static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     CharDriverState *chr = opaque;
     TCPCharDriver *s = chr->opaque;
@@ -2938,9 +2801,7 @@ static gboolean tcp_chr_read(GIOChannel *chan, GIOCondition cond, void *opaque)
     if (len > s->max_size)
         len = s->max_size;
     size = tcp_chr_recv(chr, (void *)buf, len);
-    if (size == 0 ||
-        (size < 0 &&
-         socket_error() != EAGAIN && socket_error() != EWOULDBLOCK)) {
+    if (size == 0 || size == -1) {
         /* connection closed */
         tcp_chr_disconnect(chr);
     } else if (size > 0) {

since tcp_chr_recv returns -1 on blocking:

static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
{
...
    if (ret == QIO_CHANNEL_ERR_BLOCK) {
        errno = EAGAIN;
        ret = -1;
    } else if (ret == -1) {
        errno = EIO;
    }

This patch not just converts GIOChannel to QIOChannel
it also changes the logic which is not mentioned in the commit message.

Fix please :)
