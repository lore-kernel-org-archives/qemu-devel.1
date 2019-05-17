Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12CEC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53CB2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53CB2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRfVN-0005RP-0I
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 12:14:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hRfTs-0004GY-Of
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hRfTo-0008AL-UZ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hRfTl-0007zU-6V
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 662E3317916C;
	Fri, 17 May 2019 16:12:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B2F8E5D71B;
	Fri, 17 May 2019 16:12:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id B335317532; Fri, 17 May 2019 18:12:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:12:39 +0200
Message-Id: <20190517161241.11813-3-kraxel@redhat.com>
In-Reply-To: <20190517161241.11813-1-kraxel@redhat.com>
References: <20190517161241.11813-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 17 May 2019 16:12:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/4] ui/curses: manipulate cchar_t with standard
 curses functions
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

The chars/attr fields are curses internals, setcchar and getcchar have
to be used instead.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Kamil Rytarowski <n54@gmx.com>
Message-Id: <20190427183307.12796-3-samuel.thibault@ens-lyon.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/curses.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 81d419879ede..1f3fcabb004b 100644
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
 
     line = screen + y * width;
     for (h += y; y < h; y ++, line += width) {
         for (x = 0; x < width; x++) {
             chtype ch = line[x] & 0xff;
             chtype at = line[x] & ~0xff;
-            if (vga_to_curses[ch].chars[0]) {
-                curses_line[x] = vga_to_curses[ch];
-            } else {
-                curses_line[x] = (cchar_t) {
-                    .chars[0] = ch,
-                };
+            ret = getcchar(&vga_to_curses[ch], wch, &attrs, &colors, NULL);
+            if (ret == ERR || wch[0] == 0) {
+                wch[0] = ch;
+                wch[1] = 0;
             }
-            curses_line[x].attr |= at;
+            setcchar(&curses_line[x], wch, at, 0, NULL);
         }
         mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
     }
@@ -412,7 +414,7 @@ static void curses_atexit(void)
 static void convert_ucs(unsigned char fch, uint16_t uch, iconv_t conv)
 {
     char mbch[MB_LEN_MAX];
-    wchar_t wch;
+    wchar_t wch[2];
     char *puch, *pmbch;
     size_t such, smbch;
     mbstate_t ps;
@@ -430,20 +432,22 @@ static void convert_ucs(unsigned char fch, uint16_t uch, iconv_t conv)
     }
 
     memset(&ps, 0, sizeof(ps));
-    if (mbrtowc(&wch, mbch, sizeof(mbch) - smbch, &ps) == -1) {
+    if (mbrtowc(&wch[0], mbch, sizeof(mbch) - smbch, &ps) == -1) {
         fprintf(stderr, "Could not convert 0x%04x "
                         "from a multibyte character to wchar_t: %s\n",
                         uch, strerror(errno));
         return;
     }
-    vga_to_curses[fch].chars[0] = wch;
+
+    wch[1] = 0;
+    setcchar(&vga_to_curses[fch], wch, 0, 0, NULL);
 }
 
 /* Setup wchar glyph for one font character */
 static void convert_font(unsigned char fch, iconv_t conv)
 {
     char mbch[MB_LEN_MAX];
-    wchar_t wch;
+    wchar_t wch[2];
     char *pfch, *pmbch;
     size_t sfch, smbch;
     mbstate_t ps;
@@ -461,13 +465,15 @@ static void convert_font(unsigned char fch, iconv_t conv)
     }
 
     memset(&ps, 0, sizeof(ps));
-    if (mbrtowc(&wch, mbch, sizeof(mbch) - smbch, &ps) == -1) {
+    if (mbrtowc(&wch[0], mbch, sizeof(mbch) - smbch, &ps) == -1) {
         fprintf(stderr, "Could not convert font glyph 0x%02x "
                         "from a multibyte character to wchar_t: %s\n",
                         fch, strerror(errno));
         return;
     }
-    vga_to_curses[fch].chars[0] = wch;
+
+    wch[1] = 0;
+    setcchar(&vga_to_curses[fch], wch, 0, 0, NULL);
 }
 
 /* Convert one wchar to UCS-2 */
@@ -592,7 +598,16 @@ static void font_setup(void)
     if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
         /* Non-Unicode capable, use termcap equivalents for those available */
         for (i = 0; i <= 0xFF; i++) {
-            switch (get_ucs(vga_to_curses[i].chars[0], nativecharset_to_ucs2)) {
+            wchar_t wch[CCHARW_MAX];
+            attr_t attr;
+            short color;
+            int ret;
+
+            ret = getcchar(&vga_to_curses[i], wch, &attr, &color, NULL);
+            if (ret == ERR)
+                continue;
+
+            switch (get_ucs(wch[0], nativecharset_to_ucs2)) {
             case 0x00a3:
                 vga_to_curses[i] = *WACS_STERLING;
                 break;
-- 
2.18.1


