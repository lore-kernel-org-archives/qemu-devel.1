Received: from eggs.gnu.org ([2001:4830:134:3::10]:52475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eMYKl-0001PV-2a
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eMYKk-0000tJ-8Y
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:57:51 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  6 Dec 2017 11:57:26 +0000
Message-Id: <20171206115726.5237-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-io: fix EOF Ctrl-D handling in qemu-io
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

qemu-io puts the TTY into non-canonical mode, which means no EOF processing is
done and thus getchar() will never return the EOF constant. Instead we have to
check for an explicit Ctrl-D, aka  0x4, to detect EOF and exit the qemu-io
shell. This fixes the regression that prevented Ctrl-D from triggering an exit
of qemu-io that has existed since readline was first added in

  commit 0cf17e181798063c3824c8200ba46f25f54faa1a
  Author: Stefan Hajnoczi <stefanha@redhat.com>
  Date:   Thu Nov 14 11:54:17 2013 +0100

    qemu-io: use readline.c

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qemu-io.c b/qemu-io.c
index c70bde3eb1..2ea0bfbaf8 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -322,7 +322,9 @@ static char *fetchline_readline(void)
     readline_start(readline_state, get_prompt(), 0, readline_func, &line);
     while (!line) {
         int ch = getchar();
-        if (ch == EOF) {
+        /* In non-canon tty mode we get 0x4 (Ctrl-D), not the stdio "EOF"
+         * constant */
+        if (ch == 0x4) {
             break;
         }
         readline_handle_byte(readline_state, ch);
-- 
2.14.3
