Received: from eggs.gnu.org ([2001:4830:134:3::10]:46564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds3EF-0006Cb-22
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds3E6-0000sp-AR
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:40:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds3E6-0000s1-4q
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:40:54 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 10:40:51 +0200
Message-Id: <20170913084051.21378-5-kraxel@redhat.com>
In-Reply-To: <20170913084051.21378-1-kraxel@redhat.com>
References: <20170913084051.21378-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] console: add question-mark escape operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Alexander Graf <agraf@suse.de>

Some termcaps (found using SLES11SP1) use [? sequences. According to man
console_codes (http://linux.die.net/man/4/console_codes) the question mark
is a nop and should simply be ignored.

This patch does exactly that, rendering screen output readable when
outputting guest serial consoles to the graphical console emulator.

Signed-off-by: Alexander Graf <agraf@suse.de>
Message-id: 20170829113818.42482-1-agraf@suse.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index f0292d7820..b82c27960a 100644
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
2.9.3
