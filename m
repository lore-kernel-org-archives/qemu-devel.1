Received: from eggs.gnu.org ([2001:4830:134:3::10]:43720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g03kx-0004Qm-3b
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 07:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g03Y7-0003nc-T4
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 07:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g03Y5-0003YO-A5
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 07:43:10 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9597730842AE
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 11:43:08 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 12 Sep 2018 13:43:00 +0200
Message-Id: <20180912114300.6976-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] sdl2: show console #0 unconditionally
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

Otherwise sdl2 will show no window in case no graphical
display device is present.

Reproducer: qemu -nodefaults -display sdl -serial vc

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 0a9a18a964..2696b95c79 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -806,7 +806,8 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     for (i = 0; i < sdl2_num_outputs; i++) {
         QemuConsole *con = qemu_console_lookup_by_index(i);
         assert(con != NULL);
-        if (!qemu_console_is_graphic(con)) {
+        if (!qemu_console_is_graphic(con) &&
+            qemu_console_get_index(con) != 0) {
             sdl2_console[i].hidden = true;
         }
         sdl2_console[i].idx = i;
-- 
2.9.3
