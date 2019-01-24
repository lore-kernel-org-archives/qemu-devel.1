Received: from eggs.gnu.org ([209.51.188.92]:36977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTcr-00049Y-FO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmTcq-0000ac-NY
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:16:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmTcq-0000YF-I6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:16:12 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 24 Jan 2019 02:15:53 +0100
Message-Id: <20190124011554.25418-4-philmd@redhat.com>
In-Reply-To: <20190124011554.25418-1-philmd@redhat.com>
References: <20190124011554.25418-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/4] configure: Let SDL support be optional
 on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Currently if we try to build QEMU on OpenBSD with SDL disabled, we get:

  $ ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3Dpyt=
hon2.7 --disable-sdl

  ERROR: sdl not found or disabled, can not use sdl audio driver

Since SDL is not a requirement for OpenBSD, let it be optional.
If it is not found, or the user explicitly disable it, remove it
from the audio_drv_list.
If no audio backends are available, QEMU will fall back to the
null driver.
Instead of displaying nothing when audio_drv_list ends up empty,
display "none".

This does not change the default behavior:

  $ ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3Dpyt=
hon2.7
  SDL support       yes (1.2.15)
  Audio drivers     sdl

  WARNING: Use of SDL 1.2 is deprecated and will be removed in
  WARNING: future releases. Please switch to using SDL 2.0

  GEN     config-host.h
  ...

but allows to build without SDL:

  $ ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3Dpyt=
hon2.7 --disable-sdl
  WARN: sdl not found or disabled, can not use sdl audio driver
  SDL support       no
  Audio drivers     none
  GEN     config-host.h
  ...

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index d50defceb7..fa444e9921 100755
--- a/configure
+++ b/configure
@@ -3379,7 +3379,8 @@ for drv in $audio_drv_list; do
=20
     sdl)
     if test "$sdl" =3D "no"; then
-        error_exit "sdl not found or disabled, can not use sdl audio dri=
ver"
+        echo "WARN: sdl not found or disabled, can not use sdl audio dri=
ver"
+        audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/sdl *//g')
     fi
     ;;
=20
@@ -3408,6 +3409,9 @@ for drv in $audio_drv_list; do
     ;;
     esac
 done
+if test -z "$audio_drv_list"; then
+    audio_drv_list=3D"none"
+fi
=20
 ##########################################
 # BrlAPI probe
--=20
2.20.1
