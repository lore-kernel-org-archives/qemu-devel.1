Received: from eggs.gnu.org ([2001:4830:134:3::10]:43546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsSv-00033P-Oj
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsSr-0002sv-76
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsSo-0002rw-Li
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:47:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D815883C5
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:47:05 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:47:00 +0800
Message-Id: <20170907084700.952-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] buildsys: Move brlapi libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

baum.o already receives the sdl cflags in its per object variable, do
the same for brlapi libs to avoid cluttering libs_softmmu.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 chardev/Makefile.objs | 1 +
 configure             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 52a8127606..d68e1347f9 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -20,5 +20,6 @@ chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
 common-obj-y += msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) += baum.o
 baum.o-cflags := $(SDL_CFLAGS)
+baum.o-libs := $(BRLAPI_LIBS)
 
 common-obj-$(CONFIG_SPICE) += spice.o
diff --git a/configure b/configure
index fb7e34a901..d718718cfa 100755
--- a/configure
+++ b/configure
@@ -3106,7 +3106,6 @@ int main( void ) { return brlapi__openConnection (NULL, NULL, NULL); }
 EOF
   if compile_prog "" "$brlapi_libs" ; then
     brlapi=yes
-    libs_softmmu="$brlapi_libs $libs_softmmu"
   else
     if test "$brlapi" = "yes" ; then
       feature_not_found "brlapi" "Install brlapi devel"
@@ -5693,6 +5692,7 @@ if test "$curl" = "yes" ; then
 fi
 if test "$brlapi" = "yes" ; then
   echo "CONFIG_BRLAPI=y" >> $config_host_mak
+  echo "BRLAPI_LIBS=$brlapi_libs" >> $config_host_mak
 fi
 if test "$bluez" = "yes" ; then
   echo "CONFIG_BLUEZ=y" >> $config_host_mak
-- 
2.13.5
