Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F140C0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E977D21850
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E977D21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hivqX-0001Of-0V
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 03:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hivnd-0000Pz-FK
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hivnc-0008Nw-D4
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hivnZ-0008Lw-6G
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:04:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED0915946B
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 07:04:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-222.ams2.redhat.com
 [10.36.116.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 687D51001B2C;
 Thu,  4 Jul 2019 07:04:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8719E17474; Thu,  4 Jul 2019 09:04:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 09:04:42 +0200
Message-Id: <20190704070442.2277-2-kraxel@redhat.com>
In-Reply-To: <20190704070442.2277-1-kraxel@redhat.com>
References: <20190704070442.2277-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 04 Jul 2019 07:04:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/1] console: fix cell overflow
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux terminal behavior (coming from vt100 I think) is somewhat strange
when it comes to line wraps:  When a character is printed to the last
char cell of a line the cursor does NOT jump to the next line but stays
where it is.  The line feed happens when the next character is printed.

So the valid range for the cursor position is not 0 .. width-1 but
0 .. width, where x == width represents the state where the line is
full but the cursor didn't jump to the next line yet.

The code for the 'clear from start of line' control sequence (ESC[1K)
fails to handle this corner case correctly and may call
console_clear_xy() with x == width.  That will incorrectly clear the
first char cell of the next line, or in case the cursor happens to be on
the last line overflow the cell buffer by one character (three bytes).

Add a check to the loop to fix that.

Didn't spot any other places with the same problem.  But it's easy to
miss that corner case, so also allocate one extra cell as precaution, so
in case we have simliar issues lurking elsewhere it at least wouldn't be
a buffer overflow.

v2: squashed in additional checks suggested by Christophe de Dinechin.

Reported-by: Alexander Oleinik <alxndr@bu.edu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>
Message-id: 20190701075301.14165-1-kraxel@redhat.com
---
 ui/console.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index eb7e7e0c517a..82d1ddac9cfd 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -484,7 +484,7 @@ static void text_console_resize(QemuConsole *s)
     if (s->width < w1)
         w1 = s->width;
 
-    cells = g_new(TextCell, s->width * s->total_height);
+    cells = g_new(TextCell, s->width * s->total_height + 1);
     for(y = 0; y < s->total_height; y++) {
         c = &cells[y * s->width];
         if (w1 > 0) {
@@ -541,6 +541,9 @@ static void update_xy(QemuConsole *s, int x, int y)
         y2 += s->total_height;
     }
     if (y2 < s->height) {
+        if (x >= s->width) {
+            x = s->width - 1;
+        }
         c = &s->cells[y1 * s->width + x];
         vga_putcharxy(s, x, y2, c->ch,
                       &(c->t_attrib));
@@ -787,6 +790,9 @@ static void console_handle_escape(QemuConsole *s)
 static void console_clear_xy(QemuConsole *s, int x, int y)
 {
     int y1 = (s->y_base + y) % s->total_height;
+    if (x >= s->width) {
+        x = s->width - 1;
+    }
     TextCell *c = &s->cells[y1 * s->width + x];
     c->ch = ' ';
     c->t_attrib = s->t_attrib_default;
@@ -992,7 +998,7 @@ static void console_putchar(QemuConsole *s, int ch)
                     break;
                 case 1:
                     /* clear from beginning of line */
-                    for (x = 0; x <= s->x; x++) {
+                    for (x = 0; x <= s->x && x < s->width; x++) {
                         console_clear_xy(s, x, s->y);
                     }
                     break;
-- 
2.18.1


