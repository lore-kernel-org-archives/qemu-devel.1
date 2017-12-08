Received: from eggs.gnu.org ([2001:4830:134:3::10]:58083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNInQ-0001UK-Jz
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNInP-00024Y-Mu
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:34:32 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  8 Dec 2017 13:34:16 +0000
Message-Id: <20171208133416.28978-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qemu-io: fix EOF Ctrl-D handling in qemu-io
 readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

qemu-io puts the TTY into non-canonical mode, which means no EOF processing is
done and thus getchar() will never return the EOF constant. Instead we have to
query the TTY attributes to determine the configured EOF character (usually
Ctrl-D / 0x4), and then explicitly check for that value. This fixes the
regression that prevented Ctrl-D from triggering an exit of qemu-io that has
existed since readline was first added in

  commit 0cf17e181798063c3824c8200ba46f25f54faa1a
  Author: Stefan Hajnoczi <stefanha@redhat.com>
  Date:   Thu Nov 14 11:54:17 2013 +0100

    qemu-io: use readline.c

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
Changed in v2:

  - Query termios settings for EOF character

 qemu-io.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/qemu-io.c b/qemu-io.c
index c70bde3eb1..fa4972d734 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -10,6 +10,9 @@
 #include "qemu/osdep.h"
 #include <getopt.h>
 #include <libgen.h>
+#ifndef _WIN32
+#include <termios.h>
+#endif
 
 #include "qapi/error.h"
 #include "qemu-io.h"
@@ -41,6 +44,26 @@ static bool imageOpts;
 
 static ReadLineState *readline_state;
 
+static int ttyEOF;
+
+static int get_eof_char(void)
+{
+#ifdef _WIN32
+    return 0x4; /* Ctrl-D */
+#else
+    struct termios tty;
+    if (tcgetattr(STDIN_FILENO, &tty) != 0) {
+        if (errno == ENOTTY) {
+            return 0x0; /* just expect read() == 0 */
+        } else {
+            return 0x4; /* Ctrl-D */
+        }
+    }
+
+    return tty.c_cc[VEOF];
+#endif
+}
+
 static int close_f(BlockBackend *blk, int argc, char **argv)
 {
     blk_unref(qemuio_blk);
@@ -322,7 +345,7 @@ static char *fetchline_readline(void)
     readline_start(readline_state, get_prompt(), 0, readline_func, &line);
     while (!line) {
         int ch = getchar();
-        if (ch == EOF) {
+        if (ttyEOF != 0x0 && ch == ttyEOF) {
             break;
         }
         readline_handle_byte(readline_state, ch);
@@ -592,6 +615,7 @@ int main(int argc, char **argv)
     qemuio_add_command(&close_cmd);
 
     if (isatty(STDIN_FILENO)) {
+        ttyEOF = get_eof_char();
         readline_state = readline_init(readline_printf_func,
                                        readline_flush_func,
                                        NULL,
-- 
2.14.3
