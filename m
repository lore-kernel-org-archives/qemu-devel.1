Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DDFC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9AC2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9AC2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRfVP-0005TC-Cg
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 12:14:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hRfTs-0004GT-NA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hRfTn-00088z-1c
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hRfTl-0007zT-6X
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F8C230832F4;
	Fri, 17 May 2019 16:12:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B326F5DC19;
	Fri, 17 May 2019 16:12:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AADC51752B; Fri, 17 May 2019 18:12:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:12:38 +0200
Message-Id: <20190517161241.11813-2-kraxel@redhat.com>
In-Reply-To: <20190517161241.11813-1-kraxel@redhat.com>
References: <20190517161241.11813-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 17 May 2019 16:12:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/4] ui/curses: do not assume wchar_t contains
 unicode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

E.g. BSD and Solaris even use locale-specific encoding there.

We thus have to go through the native multibyte representation and use
mbrtowc/wcrtomb to make a proper conversion.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Kamil Rytarowski <n54@gmx.com>
Message-Id: <20190427183307.12796-2-samuel.thibault@ens-lyon.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/curses.c | 149 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 53 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index fb63945188b2..81d419879ede 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -400,65 +400,108 @@ static void curses_atexit(void)
     endwin();
 }
 
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
+    char *puch, *pmbch;
+    size_t such, smbch;
+    mbstate_t ps;
 
-    pch = (char *) &ch;
-    pwch = (char *) &wch;
-    sch = sizeof(ch);
-    swch = sizeof(wch);
+    puch = (char *) &uch;
+    pmbch = (char *) mbch;
+    such = sizeof(uch);
+    smbch = sizeof(mbch);
 
-    if (iconv(conv, &pch, &sch, &pwch, &swch) == (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%04x from UCS-2 to WCHAR_T: %s\n",
-                        ch, strerror(errno));
-    } else {
-        vga_to_curses[glyph].chars[0] = wch;
+    if (iconv(conv, &puch, &such, &pmbch, &smbch) == (size_t) -1) {
+        fprintf(stderr, "Could not convert 0x%04x "
+                        "from UCS-2 to a multibyte character: %s\n",
+                        uch, strerror(errno));
+        return;
     }
+
+    memset(&ps, 0, sizeof(ps));
+    if (mbrtowc(&wch, mbch, sizeof(mbch) - smbch, &ps) == -1) {
+        fprintf(stderr, "Could not convert 0x%04x "
+                        "from a multibyte character to wchar_t: %s\n",
+                        uch, strerror(errno));
+        return;
+    }
+    vga_to_curses[fch].chars[0] = wch;
 }
 
 /* Setup wchar glyph for one font character */
-static void convert_font(unsigned char ch, iconv_t conv)
+static void convert_font(unsigned char fch, iconv_t conv)
 {
+    char mbch[MB_LEN_MAX];
     wchar_t wch;
-    char *pch, *pwch;
-    size_t sch, swch;
+    char *pfch, *pmbch;
+    size_t sfch, smbch;
+    mbstate_t ps;
 
-    pch = (char *) &ch;
-    pwch = (char *) &wch;
-    sch = sizeof(ch);
-    swch = sizeof(wch);
+    pfch = (char *) &fch;
+    pmbch = (char *) &mbch;
+    sfch = sizeof(fch);
+    smbch = sizeof(mbch);
 
-    if (iconv(conv, &pch, &sch, &pwch, &swch) == (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%02x from %s to WCHAR_T: %s\n",
-                        ch, font_charset, strerror(errno));
-    } else {
-        vga_to_curses[ch].chars[0] = wch;
+    if (iconv(conv, &pfch, &sfch, &pmbch, &smbch) == (size_t) -1) {
+        fprintf(stderr, "Could not convert font glyph 0x%02x "
+                        "from %s to a multibyte character: %s\n",
+                        fch, font_charset, strerror(errno));
+        return;
     }
+
+    memset(&ps, 0, sizeof(ps));
+    if (mbrtowc(&wch, mbch, sizeof(mbch) - smbch, &ps) == -1) {
+        fprintf(stderr, "Could not convert font glyph 0x%02x "
+                        "from a multibyte character to wchar_t: %s\n",
+                        fch, strerror(errno));
+        return;
+    }
+    vga_to_curses[fch].chars[0] = wch;
 }
 
 /* Convert one wchar to UCS-2 */
 static uint16_t get_ucs(wchar_t wch, iconv_t conv)
 {
-    uint16_t ch;
-    char *pch, *pwch;
-    size_t sch, swch;
+    char mbch[MB_LEN_MAX];
+    uint16_t uch;
+    char *pmbch, *puch;
+    size_t smbch, such;
+    mbstate_t ps;
+    int ret;
 
-    pch = (char *) &ch;
-    pwch = (char *) &wch;
-    sch = sizeof(ch);
-    swch = sizeof(wch);
+    memset(&ps, 0, sizeof(ps));
+    ret = wcrtomb(mbch, wch, &ps);
+    if (ret == -1) {
+        fprintf(stderr, "Could not convert 0x%04x "
+                        "from wchar_t to a multibyte character: %s\n",
+                        wch, strerror(errno));
+        return 0xFFFD;
+    }
+
+    pmbch = (char *) mbch;
+    puch = (char *) &uch;
+    smbch = ret;
+    such = sizeof(uch);
 
-    if (iconv(conv, &pwch, &swch, &pch, &sch) == (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%02lx from WCHAR_T to UCS-2: %s\n",
-                (unsigned long)wch, strerror(errno));
+    if (iconv(conv, &pmbch, &smbch, &puch, &such) == (size_t) -1) {
+        fprintf(stderr, "Could not convert 0x%04x "
+                        "from a multibyte character to UCS-2 : %s\n",
+                        wch, strerror(errno));
         return 0xFFFD;
     }
 
-    return ch;
+    return uch;
 }
 
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
 
-    iconv_t ucs_to_wchar_conv;
-    iconv_t wchar_to_ucs_conv;
-    iconv_t font_conv;
-    int i;
-
-    ucs_to_wchar_conv = iconv_open("WCHAR_T", "UCS-2");
-    if (ucs_to_wchar_conv == (iconv_t) -1) {
+    ucs2_to_nativecharset = iconv_open(nl_langinfo(CODESET), "UCS-2");
+    if (ucs2_to_nativecharset == (iconv_t) -1) {
         fprintf(stderr, "Could not convert font glyphs from UCS-2: '%s'\n",
                         strerror(errno));
         exit(1);
     }
 
-    wchar_to_ucs_conv = iconv_open("UCS-2", "WCHAR_T");
-    if (wchar_to_ucs_conv == (iconv_t) -1) {
-        iconv_close(ucs_to_wchar_conv);
+    nativecharset_to_ucs2 = iconv_open("UCS-2", nl_langinfo(CODESET));
+    if (nativecharset_to_ucs2 == (iconv_t) -1) {
+        iconv_close(ucs2_to_nativecharset);
         fprintf(stderr, "Could not convert font glyphs to UCS-2: '%s'\n",
                         strerror(errno));
         exit(1);
     }
 
-    font_conv = iconv_open("WCHAR_T", font_charset);
+    font_conv = iconv_open(nl_langinfo(CODESET), font_charset);
     if (font_conv == (iconv_t) -1) {
-        iconv_close(ucs_to_wchar_conv);
-        iconv_close(wchar_to_ucs_conv);
+        iconv_close(ucs2_to_nativecharset);
+        iconv_close(nativecharset_to_ucs2);
         fprintf(stderr, "Could not convert font glyphs from %s: '%s'\n",
                         font_charset, strerror(errno));
         exit(1);
@@ -536,7 +579,7 @@ static void font_setup(void)
 
     /* Control characters */
     for (i = 0; i <= 0x1F; i++) {
-        convert_ucs(i, control_characters[i], ucs_to_wchar_conv);
+        convert_ucs(i, control_characters[i], ucs2_to_nativecharset);
     }
 
     for (i = 0x20; i <= 0xFF; i++) {
@@ -544,12 +587,12 @@ static void font_setup(void)
     }
 
     /* DEL */
-    convert_ucs(0x7F, 0x2302, ucs_to_wchar_conv);
+    convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
 
     if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
         /* Non-Unicode capable, use termcap equivalents for those available */
         for (i = 0; i <= 0xFF; i++) {
-            switch (get_ucs(vga_to_curses[i].chars[0], wchar_to_ucs_conv)) {
+            switch (get_ucs(vga_to_curses[i].chars[0], nativecharset_to_ucs2)) {
             case 0x00a3:
                 vga_to_curses[i] = *WACS_STERLING;
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
 
-- 
2.18.1


