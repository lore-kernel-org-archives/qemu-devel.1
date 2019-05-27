Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919FCC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B84F2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B84F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46633 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVGaG-0003rJ-FH
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 10:26:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVGZV-0003Uf-61
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVGZU-0005f7-7M
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1hVGZT-0005dR-Va
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:25:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 412FE307D860
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 14:25:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 99DB010027B6;
	Mon, 27 May 2019 14:25:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 16:25:40 +0200
Message-Id: <20190527142540.23255-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 27 May 2019 14:25:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] ui/curses: Fix build with -m32
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

wchar_t may resolve to be an unsigned long on 32-bit architectures.
Using the %x conversion specifier will then give a compiler warning:

ui/curses.c: In function =E2=80=98get_ucs=E2=80=99:
ui/curses.c:492:49: error: format =E2=80=98%x=E2=80=99 expects argument o=
f type =E2=80=98unsigned int=E2=80=99, but argument 3 has type =E2=80=98w=
char_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=3D]
  492 |         fprintf(stderr, "Could not convert 0x%04x "
      |                                              ~~~^
      |                                                 |
      |                                                 unsigned int
      |                                              %04lx
  493 |                         "from wchar_t to a multibyte character: %=
s\n",
  494 |                         wch, strerror(errno));
      |                         ~~~
      |                         |
      |                         wchar_t {aka long int}
ui/curses.c:504:49: error: format =E2=80=98%x=E2=80=99 expects argument o=
f type =E2=80=98unsigned int=E2=80=99, but argument 3 has type =E2=80=98w=
char_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=3D]
  504 |         fprintf(stderr, "Could not convert 0x%04x "
      |                                              ~~~^
      |                                                 |
      |                                                 unsigned int
      |                                              %04lx
  505 |                         "from a multibyte character to UCS-2 : %s=
\n",
  506 |                         wch, strerror(errno));
      |                         ~~~
      |                         |
      |                         wchar_t {aka long int}

Fix this by casting the wchar_t value to an unsigned long and using %lx
as the conversion specifier.

Fixes: b7b664a4fe9a955338f2e11a0f7433b29c8cbad0
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 ui/curses.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index 1f3fcabb00..e9319eb8ae 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -489,9 +489,9 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
     memset(&ps, 0, sizeof(ps));
     ret =3D wcrtomb(mbch, wch, &ps);
     if (ret =3D=3D -1) {
-        fprintf(stderr, "Could not convert 0x%04x "
+        fprintf(stderr, "Could not convert 0x%04lx "
                         "from wchar_t to a multibyte character: %s\n",
-                        wch, strerror(errno));
+                        (unsigned long)wch, strerror(errno));
         return 0xFFFD;
     }
=20
@@ -501,9 +501,9 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
     such =3D sizeof(uch);
=20
     if (iconv(conv, &pmbch, &smbch, &puch, &such) =3D=3D (size_t) -1) {
-        fprintf(stderr, "Could not convert 0x%04x "
+        fprintf(stderr, "Could not convert 0x%04lx "
                         "from a multibyte character to UCS-2 : %s\n",
-                        wch, strerror(errno));
+                        (unsigned long)wch, strerror(errno));
         return 0xFFFD;
     }
=20
--=20
2.21.0


