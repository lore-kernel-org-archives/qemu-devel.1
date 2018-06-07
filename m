Received: from eggs.gnu.org ([2001:4830:134:3::10]:41375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR29D-0005iB-Qz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR29A-0007vN-Gx
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:08:43 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR29A-0007s5-Aw
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:08:40 -0400
Received: by mail-qt0-x241.google.com with SMTP id q13-v6so11405709qtp.4
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 14:08:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  7 Jun 2018 18:08:18 -0300
Message-Id: <20180607210818.12727-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] chardev: Restore CR,LF on stdio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Patryk Olszewski <patryk@fala.ehost.pl>, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Desnogues <laurent.desnogues@gmail.com>

Remove the 'stair-step output' on stdio.

This partially reverts commit 12fb0ac05, which was correct
on the mailing list but got corrupted by the maintainer :p

Introduced-by: 3b876140-c035-dd39-75d0-d54c48128fac@redhat.com
Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Suggested-by: Thomas Huth <thuth@redhat.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
See:
http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06202.html (bug)
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01309.html (report)

Peter, Can this enters directly as bug-fix?

 chardev/char-stdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index d83e60e787..96375f2ab8 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -59,7 +59,7 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
     if (!echo) {
         tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
                          | INLCR | IGNCR | ICRNL | IXON);
-        tty.c_oflag &= ~OPOST;
+        tty.c_oflag |= OPOST;
         tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN);
         tty.c_cflag &= ~(CSIZE | PARENB);
         tty.c_cflag |= CS8;
-- 
2.17.1
