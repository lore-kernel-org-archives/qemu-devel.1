Received: from eggs.gnu.org ([2001:4830:134:3::10]:41992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZC-0007sF-DW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZB-0005tf-IO
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:10 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZB-0005sq-CD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:09 -0500
Received: by mail-wr0-x241.google.com with SMTP id w50so5008340wrc.11
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:06 +0100
Message-Id: <1515756676-3860-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/52] chardev: Use goto/label instead of
 do/break/while(0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Use of a do/while(0) control flow in order to permit an early break
is an unusual paradigm, and triggers a false positive with a planned
future syntax check against 'while (0);'.  Rewrite the code to use a
goto instead.  This patch temporarily keeps an extra level of
indentation to highlight the change; the next patch cleans it up.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171201232433.25193-4-eblake@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-serial.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 2f8f838..10162f9 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -64,9 +64,14 @@ static void tty_serial_init(int fd, int speed,
 #endif
     tcgetattr(fd, &tty);
 
-#define check_speed(val) if (speed <= val) { spd = B##val; break; }
+#define check_speed(val) \
+    if (speed <= val) {  \
+        spd = B##val;    \
+        goto done;       \
+    }
+
     speed = speed * 10 / 11;
-    do {
+    {
         check_speed(50);
         check_speed(75);
         check_speed(110);
@@ -125,8 +130,10 @@ static void tty_serial_init(int fd, int speed,
         check_speed(4000000);
 #endif
         spd = B115200;
-    } while (0);
+    }
 
+#undef check_speed
+ done:
     cfsetispeed(&tty, spd);
     cfsetospeed(&tty, spd);
 
-- 
1.8.3.1
