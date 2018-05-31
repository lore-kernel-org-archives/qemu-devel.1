Received: from eggs.gnu.org ([2001:4830:134:3::10]:59478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBZ-0006QT-5t
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBX-0004Co-HP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41376 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBX-0004CI-DH
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 197D6818BAED
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:23 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97F5339D63
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:16:05 +0200
Message-Id: <20180531171606.21604-14-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 52/53] char: Remove unwanted crlf conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Patryk Olszewski <patryk@fala.ehost.pl>

This patch fixes a bug in serial that made it almost impossible for guest
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
Message-Id: <1527105041-21013-1-git-send-email-patryk@fala.ehost.pl>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-serial.c | 2 +-
 chardev/char-stdio.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index feb52e559d..ae548d28da 100644
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
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 96375f2ab8..d83e60e787 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -59,7 +59,7 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
     if (!echo) {
         tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
                          | INLCR | IGNCR | ICRNL | IXON);
-        tty.c_oflag |= OPOST;
+        tty.c_oflag &= ~OPOST;
         tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN);
         tty.c_cflag &= ~(CSIZE | PARENB);
         tty.c_cflag |= CS8;
-- 
2.17.0
