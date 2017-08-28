Received: from eggs.gnu.org ([2001:4830:134:3::10]:57827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dmM0d-00065N-Ku
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dmM0Y-0004kb-Kb
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:31:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54801 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dmM0Y-0004kK-ED
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:31:22 -0400
From: Alexander Graf <agraf@suse.de>
Date: Mon, 28 Aug 2017 17:31:18 +0200
Message-Id: <20170828153118.13500-1-agraf@suse.de>
Subject: [Qemu-devel] [PATCH v2] console: add question-mark escape operator
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
---
 ui/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index d2d3534c49..c28e19c375 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -880,7 +880,7 @@ static void console_putchar(QemuConsole *s, int ch)
         } else {
             if (s->nb_esc_params < MAX_ESC_PARAMS)
                 s->nb_esc_params++;
-            if (ch == ';')
+            if (ch == ';' || ch == '?')
                 break;
             trace_console_putchar_csi(s->esc_params[0], s->esc_params[1],
                                       ch, s->nb_esc_params);
-- 
2.12.3
