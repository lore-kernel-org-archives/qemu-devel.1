Received: from eggs.gnu.org ([2001:4830:134:3::10]:44545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKufr-0007OD-0F
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKufq-0004Gt-4d
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:24:50 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Dec 2017 17:24:29 -0600
Message-Id: <20171201232433.25193-4-eblake@redhat.com>
In-Reply-To: <20171201232433.25193-1-eblake@redhat.com>
References: <20171201232433.25193-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/7] chardev: Use goto/label instead of
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
Cc: armbru@redhat.com, qemu-trivial@nongnu.org, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use of a do/while(0) control flow in order to permit an early break
is an unusual paradigm, and triggers a false positive with a planned
future syntax check against 'while (0);'.  Rewrite the code to use a
goto instead.  This patch temporarily keeps an extra level of
indentation to highlight the change; the next patch cleans it up.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-serial.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 2f8f83821d..10162f9fa3 100644
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
2.14.3
