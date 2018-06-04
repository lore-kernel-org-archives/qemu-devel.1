Received: from eggs.gnu.org ([2001:4830:134:3::10]:52997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPodR-0002OB-TF
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPodM-0007hP-Ti
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:30:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPodM-0007hC-Ow
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:30:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DC8B4022414
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 12:30:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  4 Jun 2018 13:30:43 +0100
Message-Id: <20180604123043.13985-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] chardev: don't splatter terminal settings on
 exit if not previously set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The stdio chardev finalize method calls term_exit() to restore the
original terminal settings that were saved in the "oldtty" global. If
the qemu_chr_open_stdio() method exited with an error, we might not have
any original terminal settings saved in "oldtty" yet.

eg

  $ qemu-system-x86_64 -monitor stdio -daemonize
  qemu-system-x86_64: -monitor stdio: cannot use stdio with -daemonize

will cause QEMU to splatter the terminal settings with an all-zeros
"struct termios", with predictably unpleasant results. Fortunately the
existing "stdio_in_use" flag is suitable witness for whether "oldtty"
contains settings that need restoring.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-stdio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index d83e60e787..8039e85f64 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -46,8 +46,10 @@ static bool stdio_echo_state;
=20
 static void term_exit(void)
 {
-    tcsetattr(0, TCSANOW, &oldtty);
-    fcntl(0, F_SETFL, old_fd0_flags);
+    if (stdio_in_use) {
+        tcsetattr(0, TCSANOW, &oldtty);
+        fcntl(0, F_SETFL, old_fd0_flags);
+    }
 }
=20
 static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
--=20
2.17.0
