Received: from eggs.gnu.org ([2001:4830:134:3::10]:44231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6vew-00069T-Ry
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6vet-0000hP-VP
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6vet-0000gy-PD
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:35 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 288F583F4C
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 10:42:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 12:42:28 +0200
Message-Id: <20181001104230.17779-2-kraxel@redhat.com>
In-Reply-To: <20181001104230.17779-1-kraxel@redhat.com>
References: <20181001104230.17779-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] sdl2: show console #0 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Otherwise sdl2 will show no window in case no graphical
display device is present.

Reproducer: qemu -nodefaults -display sdl -serial vc

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180912114300.6976-1-kraxel@redhat.com
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
