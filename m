Received: from eggs.gnu.org ([209.51.188.92]:53175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKS8e-0000H0-K9
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKS8d-0005AA-2h
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:28 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:40806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKS8c-00059W-PC
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:33:27 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 27 Apr 2019 20:33:06 +0200
Message-Id: <20190427183307.12796-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190427183307.12796-1-samuel.thibault@ens-lyon.org>
References: <20190427183307.12796-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCHv4 1/2] ui/curses: do not assume wchar_t
 contains unicode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, kraxel@redhat.com, kamil@netbsd.org, Kamil Rytarowski <n54@gmx.com>

E.g. BSD and Solaris even use locale-specific encoding there.

We thus have to go through the native multibyte representation and use
mbrtowc/wcrtomb to make a proper conversion.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Kamil Rytarowski <n54@gmx.com>
---
 ui/curses.c | 157 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 100 insertions(+), 57 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index fb63945188..81d419879e 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -400,65 +400,108 @@ static void curses_atexit(void)
     endwin();
 }
=20
+/*
+ * In the following:
+ * - fch is the font glyph number
+ * - uch is the unicode value
+ * - wch is the wchar_t value (may not be unicode, e.g. on BSD/solaris)
+ * - mbch is the native local-dependent multibyte representation
+ */
+
 /* Setup wchar glyph for one UCS-2 char */
-static void convert_ucs(int glyph, uint16_t ch, iconv_t conv)
+static void convert_ucs(unsigned char fch, uint16_t uch, iconv_t conv)
 {
+    char mbch[MB_LEN_MAX];
     wchar_t wch;
-    char *pch, *pwch;
-    size_t sch, swch;
-
-    pch =3D (char *) &ch;
-    pwch =3D (char *) &wch;
-    sch =3D sizeof(ch);
-    swch =3D sizeof(wch);
+    char *puch, *pmbch;
+    size_t such, smbch;
+    mbstate_t ps;
+
+    puch =3D (char *) &uch;
+    pmbch =3D (char *) mbch;
+    such =3D sizeof(uch);
+    smbch =3D sizeof(mbch);
+
+    if (iconv(conv, &puch, &such, &pmbch, &smbch) =3D=3D (size_t) -1) {
+        fprintf(stderr, "Could not convert 0x%04x "
+                        "from UCS-2 to a multibyte character: %s\n",
+                        uch, strerror(errno));
+        return;
+    }
=20
-    if (iconv(conv, &pch, &sch, &pwch, &swch) =3D=3D (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%04x from UCS-2 to WCHAR_T:=
 %s\n",
-                        ch, strerror(errno));
-    } else {
-        vga_to_curses[glyph].chars[0] =3D wch;
+    memset(&ps, 0, sizeof(ps));
+    if (mbrtowc(&wch, mbch, sizeof(mbch) - smbch, &ps) =3D=3D -1) {
+        fprintf(stderr, "Could not convert 0x%04x "
+                        "from a multibyte character to wchar_t: %s\n",
+                        uch, strerror(errno));
+        return;
     }
+    vga_to_curses[fch].chars[0] =3D wch;
 }
=20
 /* Setup wchar glyph for one font character */
-static void convert_font(unsigned char ch, iconv_t conv)
+static void convert_font(unsigned char fch, iconv_t conv)
 {
+    char mbch[MB_LEN_MAX];
     wchar_t wch;
-    char *pch, *pwch;
-    size_t sch, swch;
-
-    pch =3D (char *) &ch;
-    pwch =3D (char *) &wch;
-    sch =3D sizeof(ch);
-    swch =3D sizeof(wch);
+    char *pfch, *pmbch;
+    size_t sfch, smbch;
+    mbstate_t ps;
+
+    pfch =3D (char *) &fch;
+    pmbch =3D (char *) &mbch;
+    sfch =3D sizeof(fch);
+    smbch =3D sizeof(mbch);
+
+    if (iconv(conv, &pfch, &sfch, &pmbch, &smbch) =3D=3D (size_t) -1) {
+        fprintf(stderr, "Could not convert font glyph 0x%02x "
+                        "from %s to a multibyte character: %s\n",
+                        fch, font_charset, strerror(errno));
+        return;
+    }
=20
-    if (iconv(conv, &pch, &sch, &pwch, &swch) =3D=3D (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%02x from %s to WCHAR_T: %s=
\n",
-                        ch, font_charset, strerror(errno));
-    } else {
-        vga_to_curses[ch].chars[0] =3D wch;
+    memset(&ps, 0, sizeof(ps));
+    if (mbrtowc(&wch, mbch, sizeof(mbch) - smbch, &ps) =3D=3D -1) {
+        fprintf(stderr, "Could not convert font glyph 0x%02x "
+                        "from a multibyte character to wchar_t: %s\n",
+                        fch, strerror(errno));
+        return;
     }
+    vga_to_curses[fch].chars[0] =3D wch;
 }
=20
 /* Convert one wchar to UCS-2 */
 static uint16_t get_ucs(wchar_t wch, iconv_t conv)
 {
-    uint16_t ch;
-    char *pch, *pwch;
-    size_t sch, swch;
-
-    pch =3D (char *) &ch;
-    pwch =3D (char *) &wch;
-    sch =3D sizeof(ch);
-    swch =3D sizeof(wch);
-
-    if (iconv(conv, &pwch, &swch, &pch, &sch) =3D=3D (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS-2=
: %s\n",
-                (unsigned long)wch, strerror(errno));
+    char mbch[MB_LEN_MAX];
+    uint16_t uch;
+    char *pmbch, *puch;
+    size_t smbch, such;
+    mbstate_t ps;
+    int ret;
+
+    memset(&ps, 0, sizeof(ps));
+    ret =3D wcrtomb(mbch, wch, &ps);
+    if (ret =3D=3D -1) {
+        fprintf(stderr, "Could not convert 0x%04x "
+                        "from wchar_t to a multibyte character: %s\n",
+                        wch, strerror(errno));
+        return 0xFFFD;
+    }
+
+    pmbch =3D (char *) mbch;
+    puch =3D (char *) &uch;
+    smbch =3D ret;
+    such =3D sizeof(uch);
+
+    if (iconv(conv, &pmbch, &smbch, &puch, &such) =3D=3D (size_t) -1) {
+        fprintf(stderr, "Could not convert 0x%04x "
+                        "from a multibyte character to UCS-2 : %s\n",
+                        wch, strerror(errno));
         return 0xFFFD;
     }
=20
-    return ch;
+    return uch;
 }
=20
 /*
@@ -466,6 +509,11 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
  */
 static void font_setup(void)
 {
+    iconv_t ucs2_to_nativecharset;
+    iconv_t nativecharset_to_ucs2;
+    iconv_t font_conv;
+    int i;
+
     /*
      * Control characters are normally non-printable, but VGA does have
      * well-known glyphs for them.
@@ -505,30 +553,25 @@ static void font_setup(void)
       0x25bc
     };
=20
-    iconv_t ucs_to_wchar_conv;
-    iconv_t wchar_to_ucs_conv;
-    iconv_t font_conv;
-    int i;
-
-    ucs_to_wchar_conv =3D iconv_open("WCHAR_T", "UCS-2");
-    if (ucs_to_wchar_conv =3D=3D (iconv_t) -1) {
+    ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESET), "UCS-2");
+    if (ucs2_to_nativecharset =3D=3D (iconv_t) -1) {
         fprintf(stderr, "Could not convert font glyphs from UCS-2: '%s'\=
n",
                         strerror(errno));
         exit(1);
     }
=20
-    wchar_to_ucs_conv =3D iconv_open("UCS-2", "WCHAR_T");
-    if (wchar_to_ucs_conv =3D=3D (iconv_t) -1) {
-        iconv_close(ucs_to_wchar_conv);
+    nativecharset_to_ucs2 =3D iconv_open("UCS-2", nl_langinfo(CODESET));
+    if (nativecharset_to_ucs2 =3D=3D (iconv_t) -1) {
+        iconv_close(ucs2_to_nativecharset);
         fprintf(stderr, "Could not convert font glyphs to UCS-2: '%s'\n"=
,
                         strerror(errno));
         exit(1);
     }
=20
-    font_conv =3D iconv_open("WCHAR_T", font_charset);
+    font_conv =3D iconv_open(nl_langinfo(CODESET), font_charset);
     if (font_conv =3D=3D (iconv_t) -1) {
-        iconv_close(ucs_to_wchar_conv);
-        iconv_close(wchar_to_ucs_conv);
+        iconv_close(ucs2_to_nativecharset);
+        iconv_close(nativecharset_to_ucs2);
         fprintf(stderr, "Could not convert font glyphs from %s: '%s'\n",
                         font_charset, strerror(errno));
         exit(1);
@@ -536,7 +579,7 @@ static void font_setup(void)
=20
     /* Control characters */
     for (i =3D 0; i <=3D 0x1F; i++) {
-        convert_ucs(i, control_characters[i], ucs_to_wchar_conv);
+        convert_ucs(i, control_characters[i], ucs2_to_nativecharset);
     }
=20
     for (i =3D 0x20; i <=3D 0xFF; i++) {
@@ -544,12 +587,12 @@ static void font_setup(void)
     }
=20
     /* DEL */
-    convert_ucs(0x7F, 0x2302, ucs_to_wchar_conv);
+    convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
=20
     if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
         /* Non-Unicode capable, use termcap equivalents for those availa=
ble */
         for (i =3D 0; i <=3D 0xFF; i++) {
-            switch (get_ucs(vga_to_curses[i].chars[0], wchar_to_ucs_conv=
)) {
+            switch (get_ucs(vga_to_curses[i].chars[0], nativecharset_to_=
ucs2)) {
             case 0x00a3:
                 vga_to_curses[i] =3D *WACS_STERLING;
                 break;
@@ -649,8 +692,8 @@ static void font_setup(void)
             }
         }
     }
-    iconv_close(ucs_to_wchar_conv);
-    iconv_close(wchar_to_ucs_conv);
+    iconv_close(ucs2_to_nativecharset);
+    iconv_close(nativecharset_to_ucs2);
     iconv_close(font_conv);
 }
=20
--=20
2.20.1
