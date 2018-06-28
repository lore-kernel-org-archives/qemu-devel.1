Received: from eggs.gnu.org ([2001:4830:134:3::10]:37782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAN-00072v-8i
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAL-0008Qk-VB
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:19 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAL-0008Ou-NS
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:17 -0400
Received: by mail-wr0-x229.google.com with SMTP id h10-v6so6671295wrq.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:13 +0200
Message-Id: <1530216310-52873-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/60] chardev: don't splatter terminal settings
 on exit if not previously set
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20180604123043.13985-1-berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-stdio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 96375f2..9624220 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -46,8 +46,10 @@ static bool stdio_echo_state;
 
 static void term_exit(void)
 {
-    tcsetattr(0, TCSANOW, &oldtty);
-    fcntl(0, F_SETFL, old_fd0_flags);
+    if (stdio_in_use) {
+        tcsetattr(0, TCSANOW, &oldtty);
+        fcntl(0, F_SETFL, old_fd0_flags);
+    }
 }
 
 static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
-- 
1.8.3.1
