Received: from eggs.gnu.org ([2001:4830:134:3::10]:60375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dmMAo-0002Lq-R0
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dmMAj-0007sf-Vv
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:41:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56268 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dmMAj-0007sQ-Ot
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:41:53 -0400
From: Alexander Graf <agraf@suse.de>
Date: Mon, 28 Aug 2017 17:41:52 +0200
Message-Id: <20170828154152.15778-1-agraf@suse.de>
Subject: [Qemu-devel] [PATCH v3] console: add question-mark escape operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Some termcaps (found using SLES11SP1) use [? sequences. According to man
console_codes (http://linux.die.net/man/4/console_codes) the question mark
is a nop and should simply be ignored.

This patch does exactly that, rendering screen output readable when
outputting guest serial consoles to the graphical console emulator.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - rebase to 2.10

v2 -> v3:

  - fix coding style issues
---
 ui/console.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index d2d3534c49..37fee92001 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -880,8 +880,9 @@ static void console_putchar(QemuConsole *s, int ch)
         } else {
             if (s->nb_esc_params < MAX_ESC_PARAMS)
                 s->nb_esc_params++;
-            if (ch == ';')
+            if (ch == ';' || ch == '?') {
                 break;
+            }
             trace_console_putchar_csi(s->esc_params[0], s->esc_params[1],
                                       ch, s->nb_esc_params);
             s->state = TTY_STATE_NORM;
-- 
2.12.3
