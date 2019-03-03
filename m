Received: from eggs.gnu.org ([209.51.188.92]:47282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0Ln4-000070-PK
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 02:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0LfJ-0001N7-Jd
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 02:36:07 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h0LfJ-0001Ic-Aq
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 02:36:05 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat,  2 Mar 2019 22:14:06 -0800
Message-Id: <20190303061406.7631-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Reduce curses escdelay from 1s to 0.2s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

By default, curses will only report single ESC key event after 1s delay,
since ESC is also used for keypad escape sequences. This however makes us=
ers
believe that ESC is not working. Reducing to 0.2s provides good enough us=
er
experience, while still allowing 200ms for keypad sequences to get in, wh=
ich
should be more than enough.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 ui/curses.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/curses.c b/ui/curses.c
index 6e0091c3b2..700315bc09 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -231,7 +231,7 @@ static void curses_refresh(DisplayChangeListener *dcl=
)
         keycode =3D curses2keycode[chr];
         keycode_alt =3D 0;
=20
-        /* alt key */
+        /* alt or esc key */
         if (keycode =3D=3D 1) {
             int nextchr =3D getch();
=20
@@ -361,6 +361,7 @@ static void curses_setup(void)
     initscr(); noecho(); intrflush(stdscr, FALSE);
     nodelay(stdscr, TRUE); nonl(); keypad(stdscr, TRUE);
     start_color(); raw(); scrollok(stdscr, FALSE);
+    set_escdelay(200);
=20
     /* Make color pair to match color format (3bits bg:3bits fg) */
     for (i =3D 0; i < 64; i++) {
--=20
2.20.1
