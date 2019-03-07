Received: from eggs.gnu.org ([209.51.188.92]:58049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugW-0007at-ST
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1ugV-0002zh-PY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1ugV-0002zF-Ie
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:47 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 16:11:35 +0100
Message-Id: <20190307151141.6483-2-kraxel@redhat.com>
In-Reply-To: <20190307151141.6483-1-kraxel@redhat.com>
References: <20190307151141.6483-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] Reduce curses escdelay from 1s to 25ms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

By default, curses will only report single ESC key event after 1s delay,
since ESC is also used for keypad escape sequences. This however makes
users believe that ESC is not working. Reducing to 25ms provides good user
experience, while still allowing 25ms for keypad sequences to get in, which
should be enough.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-Id: <20190303172557.17139-1-samuel.thibault@ens-lyon.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/curses.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/curses.c b/ui/curses.c
index 6e0091c3b286..870273de51a9 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -231,7 +231,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
         keycode = curses2keycode[chr];
         keycode_alt = 0;
 
-        /* alt key */
+        /* alt or esc key */
         if (keycode == 1) {
             int nextchr = getch();
 
@@ -361,6 +361,7 @@ static void curses_setup(void)
     initscr(); noecho(); intrflush(stdscr, FALSE);
     nodelay(stdscr, TRUE); nonl(); keypad(stdscr, TRUE);
     start_color(); raw(); scrollok(stdscr, FALSE);
+    set_escdelay(25);
 
     /* Make color pair to match color format (3bits bg:3bits fg) */
     for (i = 0; i < 64; i++) {
-- 
2.18.1
