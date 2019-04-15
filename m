Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F011C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B3020825
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B3020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG2QD-0005mB-1a
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:17:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG2Ox-00054w-Dc
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG2Ov-0003DY-SF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG2Ov-00035c-Hv
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:16:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C7DF307D941;
	Mon, 15 Apr 2019 14:15:55 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5BD9608C0;
	Mon, 15 Apr 2019 14:15:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 15:15:47 +0100
Message-Id: <20190415141547.15444-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 15 Apr 2019 14:15:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for all
 code
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
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415141547.-ZU9E8hTktQU2kdx3OzKjrLkhMD8AAW3WIJ0On2cvNI@z>

Localization is not a feature whose impact is limited to the UI
frontends. Other parts of QEMU rely in localization. In particular the
USB MTP driver needs to be able to convert filenames from the locale
specified character set into UTF-16 / UCS-2 encoded wide characters.
setlocale() is only set from two of the UI frontends though, and worse,
there is inconsistent behaviour with GTK setting LC_CTYPE to C.UTF-8,
while ncurses honours whatever is set in the user's environment.

This causes the USP MTP driver to behave differently depending on which
UI frontend is activated.

Furthermore, the curses settings are dangerous because LC_CTYPE will affe=
ct
the is{upper,lower,alnum} functions which much QEMU code assumes to have
C locale sorting behaviour. This also breaks QMP if the env requests a
non-UTF-8 locale, since QMP is defined to use UTF-8 encoding for JSON.
This problematic curses code was introduced in:

  commit 2f8b7cd587558944532f587abb5203ce54badba9
  Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
  Date:   Mon Mar 11 14:51:27 2019 +0100

    curses: add option to specify VGA font encoding

This patch moves the GTK frontend setlocale() handling into the main()
method. This ensures QMP and other QEMU code has a predictable C.UTF-8.

Eventually QEMU should set LC_ALL, honouring the full user environment,
but this needs various cleanups in QEMU code first. Hardcoding LC_CTYPE
to C.UTF-8 is a partial regression vs the above curses commit, since it
will break the curses wide character handling for non-UTF-8 locales but
this is unavoidable until QEMU is cleaned up to cope with non-UTF-8
locales fully.

Setting of LC_MESSAGES is left in the GTK code since only the GTK
frontend is using translation of strings. This lets us avoid the
platform portability problem where LC_MESSAGES is not provided by
locale.h on MinGW. GTK pulls it in indirectly from libintl.h via
gi18n.h header, but we don't want to pull that into the global
QEMU namespace.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

Changed in v2:

 - Leave LC_MESSAGES setting in gtk code to avoid platform
   portability problems.

 ui/curses.c |  2 --
 ui/gtk.c    | 32 +++++++++++---------------------
 vl.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index cc6d6da684..403cd57913 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -27,7 +27,6 @@
 #include <sys/ioctl.h>
 #include <termios.h>
 #endif
-#include <locale.h>
 #include <wchar.h>
 #include <langinfo.h>
 #include <iconv.h>
@@ -716,7 +715,6 @@ static void curses_display_init(DisplayState *ds, Dis=
playOptions *opts)
     }
 #endif
=20
-    setlocale(LC_CTYPE, "");
     if (opts->u.curses.charset) {
         font_charset =3D opts->u.curses.charset;
     }
diff --git a/ui/gtk.c b/ui/gtk.c
index e96e15435a..e6a41c79ab 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2208,12 +2208,12 @@ static void gtk_display_init(DisplayState *ds, Di=
splayOptions *opts)
=20
     s->free_scale =3D FALSE;
=20
-    /* Mostly LC_MESSAGES only. See early_gtk_display_init() for details=
. For
-     * LC_CTYPE, we need to make sure that non-ASCII characters are cons=
idered
-     * printable, but without changing any of the character classes to m=
ake
-     * sure that we don't accidentally break implicit assumptions.  */
+    /*
+     * See comment in main() for why it has only setup LC_CTYPE,
+     * as opposed to LC_ALL. Given that we need to enable
+     * LC_MESSAGES too for menu translations.
+     */
     setlocale(LC_MESSAGES, "");
-    setlocale(LC_CTYPE, "C.UTF-8");
     bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
     textdomain("qemu");
=20
@@ -2262,22 +2262,12 @@ static void gtk_display_init(DisplayState *ds, Di=
splayOptions *opts)
=20
 static void early_gtk_display_init(DisplayOptions *opts)
 {
-    /* The QEMU code relies on the assumption that it's always run in
-     * the C locale. Therefore it is not prepared to deal with
-     * operations that produce different results depending on the
-     * locale, such as printf's formatting of decimal numbers, and
-     * possibly others.
-     *
-     * Since GTK+ calls setlocale() by default -importing the locale
-     * settings from the environment- we must prevent it from doing so
-     * using gtk_disable_setlocale().
-     *
-     * QEMU's GTK+ UI, however, _does_ have translations for some of
-     * the menu items. As a trade-off between a functionally correct
-     * QEMU and a fully internationalized UI we support importing
-     * LC_MESSAGES from the environment (see the setlocale() call
-     * earlier in this file). This allows us to display translated
-     * messages leaving everything else untouched.
+    /*
+     * GTK calls setlocale() by default, importing the locale
+     * settings from the environment. QEMU's main() method will
+     * have set LC_MESSAGES and LC_CTYPE to allow GTK to display
+     * translated messages, including use of wide characters. We
+     * must not allow GTK to change other aspects of the locale.
      */
     gtk_disable_setlocale();
     gtkinit =3D gtk_init_check(NULL, NULL);
diff --git a/vl.c b/vl.c
index c696ad2a13..87a55cddb3 100644
--- a/vl.c
+++ b/vl.c
@@ -49,6 +49,7 @@ int main(int argc, char **argv)
 #define main qemu_main
 #endif /* CONFIG_COCOA */
=20
+#include <locale.h>
=20
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -3022,6 +3023,45 @@ int main(int argc, char **argv, char **envp)
     char *dir, **dirs;
     BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_que=
ue);
=20
+    /*
+     * Ideally we would set LC_ALL, but QEMU currently isn't able to cop=
e
+     * with arbitrary localization settings. In particular there are two
+     * known problems
+     *
+     *   - The QMP monitor needs to use the C locale rules for numeric
+     *     formatting. This would need a double/int -> string formatter
+     *     that is locale independant.
+     *
+     *   - The QMP monitor needs to encode all data as UTF-8. This needs
+     *     to be updated to use iconv(3) to explicitly convert the curre=
nt
+     *     locale's charset into utf-8
+     *
+     *   - Lots of codes uses is{upper,lower,alnum,...} functions, expec=
ting
+     *     C locale sorting behaviour. Most QEMU usage should likely be
+     *     changed to g_ascii_is{upper,lower,alnum...} to match code
+     *     assumptions, without being broken by locale settnigs.
+     *
+     * We do still have two requirements
+     *
+     *   - Ability to correct display translated text according to the
+     *     user's locale
+     *
+     *   - Ability to handle multibyte characters, ideally according to
+     *     user's locale specified character set. This affects ability
+     *     of usb-mtp to correctly convert filenames to UCS16 and curses
+     *     & GTK frontends wide character display.
+     *
+     * The second requirement would need LC_CTYPE to be honoured, but
+     * this conflicts with the 2nd & 3rd problems listed earlier. For
+     * now we make a tradeoff, trying to set an explicit UTF-8 localee
+     *
+     * Note we can't set LC_MESSAGES here, since mingw doesn't define
+     * this constant in locale.h Fortunately we only need it for the
+     * GTK frontend and that uses gi18n.h which pulls in a definition
+     * of LC_MESSAGES.
+     */
+    setlocale(LC_CTYPE, "C.UTF-8");
+
     module_call_init(MODULE_INIT_TRACE);
=20
     qemu_init_cpu_list();
--=20
2.20.1


