Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E3C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E742085A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E742085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgRS9-0007o8-Mm
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cdupontd@redhat.com>) id 1hgRQw-0007F6-9J
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cdupontd@redhat.com>) id 1hgRQr-0006Op-7y
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:15:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cdupontd@redhat.com>) id 1hgRQr-0006O5-1U
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:15:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so5141077wme.4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 03:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=J/9DlseNGPZvGO/oMpYQCy9sX4DFzapfgPoBJ1IagJ4=;
 b=N9IRrzO8kU/wjrSbryiFx2Zu623QGnEXWBbcEgF1dhfhi0yLxRxbTVv7CF8swsMfb5
 QFQr1/QGc4ftwZTj3GkaEL5uEmz1JpIWtxW+5qr6sEBPAQHAfRON7n915SlD7kD+WiWI
 Qnt/UwsvJsSbqzsdF2SB3D9kut7rlaFrEE44JatYFt0q6Q4tc7/Gpm1lZWOKVKAm6nEV
 2IE0xjF5lf8up8hQrhLwxALjgU5w66eqX4Kb7yb+Yb59YU4aJVRqGxpNzRvIorpcWFJ7
 uarCbDGKBWUEneWQz8lXKQ5Kdjnpb/oCkOif3pexNnOQeIulsysWC5WJDZO3lPMfvzHd
 KZAA==
X-Gm-Message-State: APjAAAVh1i6sKi0EjpJhnx6SftCrSziSfw+ynPiZ2/5lsx+PKm8c5PV4
 xATO89CfoT7vrs41aF+rW/ttVg==
X-Google-Smtp-Source: APXvYqynR/PZ1lSqdQcqMmjJ8Q/mhYwokx9/58uAo7owQsXoPC8waRB2VWhcYBVGMiCUxMYMIGbLaw==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr2566346wmg.69.1561630507778; 
 Thu, 27 Jun 2019 03:15:07 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b6a:1220:b9aa:75f2:4e31:7532?
 ([2a01:e35:8b6a:1220:b9aa:75f2:4e31:7532])
 by smtp.gmail.com with ESMTPSA id q10sm1795260wrf.32.2019.06.27.03.15.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 03:15:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20190627053523.25541-1-kraxel@redhat.com>
Date: Thu, 27 Jun 2019 12:14:10 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <7621E57A-E22F-43F4-A96A-5C3982059107@redhat.com>
References: <20190627053523.25541-1-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] console: fix cell overflow
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
Cc: alxndr@bu.edu, qemu-devel@nongnu.org, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 27 Jun 2019, at 07:35, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> Linux terminal behavior (coming from vt100 I think) is somewhat =
strange
> when it comes to line wraps:  When a character is printed to the last
> char cell of a line the cursor does NOT jump to the next line but =
stays
> where it is.  The line feed happens when the next character is =
printed.
>=20
> So the valid range for the cursor position is not 0 .. width-1 but
> 0 .. width, where x =3D=3D width represents the state where the line =
is
> full but the cursor didn't jump to the next line yet.
>=20
> The code for the 'clear from start of line' control sequence (ESC[1K)
> fails to handle this corner case correctly and may call
> console_clear_xy() with x =3D=3D width.  That will incorrectly clear =
the
> first char cell of the next line, or in case the cursor happens to be =
on
> the last line overflow the cell buffer by one character (three bytes).
>=20
> Add a check to the loop to fix that.
>=20
> Didn't spot any other places with the same problem.  But it's easy to
> miss that corner case, so also allocate one extra cell as precaution, =
so
> in case we have simliar issues lurking elsewhere it at least wouldn't =
be
> a buffer overflow.
>=20
> Reported-by: Alexander Oleinik <alxndr@bu.edu>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> ui/console.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/ui/console.c b/ui/console.c
> index eb7e7e0c517a..13d933510cdb 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -484,7 +484,7 @@ static void text_console_resize(QemuConsole *s)
>     if (s->width < w1)
>         w1 =3D s->width;
>=20
> -    cells =3D g_new(TextCell, s->width * s->total_height);
> +    cells =3D g_new(TextCell, s->width * s->total_height + 1);

I don=E2=80=99t like allocating just in case. At least put a comment =
explaining why ;-)
This extra byte only catches a single case (arguably an existing one).

What about adding a couple of extra tests where cell[=E2=80=A6 + x] is =
used?
(there is a third location I did not protect, because it already had
exactly that test)

diff --git a/ui/console.c b/ui/console.c
index eb7e7e0c51..00d27f6384 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -541,6 +541,9 @@ static void update_xy(QemuConsole *s, int x, int y)
         y2 +=3D s->total_height;
     }
     if (y2 < s->height) {
+        if (x >=3D s->width) {
+            x =3D s->width - 1;
+        }
         c =3D &s->cells[y1 * s->width + x];
         vga_putcharxy(s, x, y2, c->ch,
                       &(c->t_attrib));
@@ -787,6 +790,9 @@ static void console_handle_escape(QemuConsole *s)
 static void console_clear_xy(QemuConsole *s, int x, int y)
 {
     int y1 =3D (s->y_base + y) % s->total_height;
+    if (x >=3D s->width) {
+        x =3D s->width - 1;
+    }
     TextCell *c =3D &s->cells[y1 * s->width + x];
     c->ch =3D ' ';
     c->t_attrib =3D s->t_attrib_default;


Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>

>     for(y =3D 0; y < s->total_height; y++) {
>         c =3D &cells[y * s->width];
>         if (w1 > 0) {
> @@ -992,7 +992,7 @@ static void console_putchar(QemuConsole *s, int =
ch)
>                     break;
>                 case 1:
>                     /* clear from beginning of line */
> -                    for (x =3D 0; x <=3D s->x; x++) {
> +                    for (x =3D 0; x <=3D s->x && x < s->width; x++) {
>                         console_clear_xy(s, x, s->y);
>                     }
>                     break;
> --=20
> 2.18.1
>=20
>=20


