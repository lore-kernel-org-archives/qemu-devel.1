Received: from eggs.gnu.org ([209.51.188.92]:33736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKQKi-00017g-56
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKQDZ-0004zV-8k
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:30:27 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:47166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKQDT-0004U7-IV
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 12:30:23 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 27 Apr 2019 18:30:07 +0200
Message-Id: <20190427163007.5113-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv3 2/2] ui/curses: manipulate cchar_t with
 standard curses functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kraxel@redhat.com, kamil@netbsd.org

The chars/attr fields are curses internals, setcchar and getcchar have
to be used instead.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 ui/curses.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 395f9545e9..bc0d77a2a8 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -66,20 +66,22 @@ static void curses_update(DisplayChangeListener *dcl,
 {
     console_ch_t *line;
     cchar_t curses_line[width];
+    wchar_t wch[CCHARW_MAX];
+    attr_t attrs;
+    short colors;
+    int ret;
=20
     line =3D screen + y * width;
     for (h +=3D y; y < h; y ++, line +=3D width) {
         for (x =3D 0; x < width; x++) {
             chtype ch =3D line[x] & 0xff;
             chtype at =3D line[x] & ~0xff;
-            if (vga_to_curses[ch].chars[0]) {
-                curses_line[x] =3D vga_to_curses[ch];
-            } else {
-                curses_line[x] =3D (cchar_t) {
-                    .chars[0] =3D ch,
-                };
+            ret =3D getcchar(&vga_to_curses[ch], wch, &attrs, &colors, N=
ULL);
+            if (ret =3D=3D ERR || wch[0] =3D=3D 0) {
+                wch[0] =3D ch;
+                wch[1] =3D 0;
             }
-            curses_line[x].attr |=3D at;
+            setcchar(&curses_line[x], wch, at, 0, NULL);
         }
         mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
     }
@@ -412,7 +414,7 @@ static void curses_atexit(void)
 static void convert_ucs(unsigned char fch, uint16_t uch, iconv_t conv)
 {
     char mbch[MB_CUR_MAX];
-    wchar_t wch;
+    wchar_t wch[2];
     char *puch, *pmbch;
     size_t such, smbch;
=20
@@ -428,20 +430,22 @@ static void convert_ucs(unsigned char fch, uint16_t=
 uch, iconv_t conv)
         return;
     }
=20
-    if (mbtowc(&wch, mbch, sizeof(mbch) - smbch) =3D=3D -1) {
+    if (mbtowc(&wch[0], mbch, sizeof(mbch) - smbch) =3D=3D -1) {
         fprintf(stderr, "Could not convert 0x%04x "
                         "from a multibyte character to wchar_t: %s\n",
                         uch, strerror(errno));
         return;
     }
-    vga_to_curses[fch].chars[0] =3D wch;
+
+    wch[1] =3D 0;
+    setcchar(&vga_to_curses[fch], wch, 0, 0, NULL);
 }
=20
 /* Setup wchar glyph for one font character */
 static void convert_font(unsigned char fch, iconv_t conv)
 {
     char mbch[MB_CUR_MAX];
-    wchar_t wch;
+    wchar_t wch[2];
     char *pfch, *pmbch;
     size_t sfch, smbch;
=20
@@ -457,13 +461,15 @@ static void convert_font(unsigned char fch, iconv_t=
 conv)
         return;
     }
=20
-    if (mbtowc(&wch, mbch, sizeof(mbch) - smbch) =3D=3D -1) {
+    if (mbtowc(&wch[0], mbch, sizeof(mbch) - smbch) =3D=3D -1) {
         fprintf(stderr, "Could not convert font glyph 0x%02x "
                         "from a multibyte character to wchar_t: %s\n",
                         fch, strerror(errno));
         return;
     }
-    vga_to_curses[fch].chars[0] =3D wch;
+
+    wch[1] =3D 0;
+    setcchar(&vga_to_curses[fch], wch, 0, 0, NULL);
 }
=20
 /* Convert one wchar to UCS-2 */
@@ -586,7 +592,16 @@ static void font_setup(void)
     if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
         /* Non-Unicode capable, use termcap equivalents for those availa=
ble */
         for (i =3D 0; i <=3D 0xFF; i++) {
-            switch (get_ucs(vga_to_curses[i].chars[0], nativecharset_to_=
ucs2)) {
+            wchar_t wch[CCHARW_MAX];
+            attr_t attr;
+            short color;
+            int ret;
+
+            ret =3D getcchar(&vga_to_curses[i], wch, &attr, &color, NULL=
);
+            if (ret =3D=3D ERR)
+                continue;
+
+            switch (get_ucs(wch[0], nativecharset_to_ucs2)) {
             case 0x00a3:
                 vga_to_curses[i] =3D *WACS_STERLING;
                 break;
--=20
2.20.1
