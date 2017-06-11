Received: from eggs.gnu.org ([2001:4830:134:3::10]:60849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tsn@cs.nctu.edu.tw>) id 1dK8Eb-00057e-BM
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 15:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tsn@cs.nctu.edu.tw>) id 1dK8EW-0003Kz-Be
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 15:09:13 -0400
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:42258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tsn@cs.nctu.edu.tw>) id 1dK8EV-00038h-Pz
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 15:09:08 -0400
Received: from csmailer.cs.nctu.edu.tw (localhost [127.0.0.1])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id DAC7B17646
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 03:08:44 +0800 (CST)
Received: from csmailer.cs.nctu.edu.tw ([127.0.0.1])
	by csmailer.cs.nctu.edu.tw (csmailer.cs.nctu.edu.tw [127.0.0.1])
	(amavisd-new, port 10027)
	with ESMTP id hVKNme0rXzc1 for <qemu-devel@nongnu.org>;
	Mon, 12 Jun 2017 03:08:44 +0800 (CST)
Received: from csmail1.cs.nctu.edu.tw (csmail1.cs.nctu.edu.tw [140.113.235.71])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTPS id B5C0217643
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 03:08:44 +0800 (CST)
Received: from mail-qt0-f182.google.com (mail-qt0-f182.google.com
	[209.85.216.182]) (Authenticated sender: tsn)
	by csmail1.cs.nctu.edu.tw (Postfix) with ESMTPA id 7F335174485
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 03:08:44 +0800 (CST)
Received: by mail-qt0-f182.google.com with SMTP id c10so106803016qtd.1
	for <qemu-devel@nongnu.org>; Sun, 11 Jun 2017 12:08:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPhXLnv2g_80gi1o6p-QUbKJQ5m+6gkLDN8TWtE-B=70uacDEw@mail.gmail.com>
References: <CAPhXLnv2g_80gi1o6p-QUbKJQ5m+6gkLDN8TWtE-B=70uacDEw@mail.gmail.com>
From: Tsung-en Hsiao <tsn@cs.nctu.edu.tw>
Date: Mon, 12 Jun 2017 03:08:22 +0800
Message-ID: <CAPhXLnuNAqwQHdns2Sxv4UuFz9WhGH1ZM4E4TN87e31cDpZ7gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Fwd:  [BUG] Failed to compile using gcc7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,
I encountered the same problem on gcc 7.1.1 and found Qu's mail in
this list from google search.

Temporarily fix it by specifying the string length in snprintf
directive. Hope this is helpful to other people encountered the same
problem.

@@ -1,9 +1,7 @@
---
--- a/block/blkdebug.c
-                 "blkdebug:%s:%s", s->config_file ?: "",
--- a/block/blkverify.c
-                 "blkverify:%s:%s",
--- a/hw/usb/bus.c
-        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
-        snprintf(downstream->path, sizeof(downstream->path), "%d", portnr);
--
+++ b/block/blkdebug.c
+                 "blkdebug:%.2037s:%.2037s", s->config_file ?: "",
+++ b/block/blkverify.c
+                 "blkverify:%.2038s:%.2038s",
+++ b/hw/usb/bus.c
+        snprintf(downstream->path, sizeof(downstream->path), "%.12s.%d",
+        snprintf(downstream->path, sizeof(downstream->path), "%.12d", portnr);

Tsung-en Hsiao

> Qu Wenruo Wrote:
>
> Hi all,
>
> After upgrading gcc from 6.3.1 to 7.1.1, qemu can't be compiled with gcc.
>
> The error is:
>
> ------
>  CC      block/blkdebug.o
> block/blkdebug.c: In function 'blkdebug_refresh_filename':
>
> block/blkdebug.c:693:31: error: '%s' directive output may be truncated writing up to 4095 bytes into a region of size 4086 [-Werror=format-truncation=]
>
>                  "blkdebug:%s:%s", s->config_file ?: "",
>                               ^~
> In file included from /usr/include/stdio.h:939:0,
>                 from /home/adam/qemu/include/qemu/osdep.h:68,
>                 from block/blkdebug.c:25:
>
> /usr/include/bits/stdio2.h:64:10: note: '__builtin___snprintf_chk' output 11 or more bytes (assuming 4106) into a destination of size 4096
>
>   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        __bos (__s), __fmt, __va_arg_pack ());
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/adam/qemu/rules.mak:69: block/blkdebug.o] Error 1
> ------
>
> It seems that gcc 7 is introducing more restrict check for printf.
>
> If using clang, although there are some extra warning, it can at least pass the compile.
>
> Thanks,
> Qu
