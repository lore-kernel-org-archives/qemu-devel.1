Received: from eggs.gnu.org ([2001:4830:134:3::10]:54802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patryk@fala.ehost.pl>) id 1fLZmc-0004pl-Sx
	for qemu-devel@nongnu.org; Wed, 23 May 2018 15:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patryk@fala.ehost.pl>) id 1fLZmZ-0005ve-Rj
	for qemu-devel@nongnu.org; Wed, 23 May 2018 15:50:50 -0400
Received: from s16.ehost.pl ([193.143.77.16]:39396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <patryk@fala.ehost.pl>)
	id 1fLZmZ-0005uc-H1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 15:50:47 -0400
From: Patryk Olszewski <patryk@fala.ehost.pl>
Date: Wed, 23 May 2018 21:50:41 +0200
Message-Id: <1527105041-21013-1-git-send-email-patryk@fala.ehost.pl>
Subject: [Qemu-devel] [PATCH v2] Remove unwanted crlf conversion in serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, thuth@redhat.com, Patryk Olszewski <patryk@fala.ehost.pl>

This patch fixes bug in serial that made it almost impossible for guest
to communicate with devices through host's serial.

OPOST flag in c_oflag enables output processing letting other flags in
c_oflag take effect. Usually in c_oflag ONLCR flag is also set, which
causes crlf to be sent in place of lf. This breaks binary transmissions.
Unsetting OPOST flag turns off any output processing which fixes the bug.

Bug reports related:
https://bugs.launchpad.net/qemu/+bug/1772086
https://bugs.launchpad.net/qemu/+bug/1407813
https://bugs.launchpad.net/qemu/+bug/1715296
also
https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html

Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
---
 chardev/char-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index feb52e5..ae548d2 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
 
     tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
                      | INLCR | IGNCR | ICRNL | IXON);
-    tty.c_oflag |= OPOST;
+    tty.c_oflag &= ~OPOST;
     tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
     tty.c_cflag &= ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
     switch (data_bits) {
-- 
2.7.4
