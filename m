Received: from eggs.gnu.org ([209.51.188.92]:50787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUw9-0001W5-Vf
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUuR-0003zg-8C
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:02:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goUuQ-0003q2-Cj
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:02:43 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 16:00:28 +0100
Message-Id: <20190129150029.29829-5-philmd@redhat.com>
In-Reply-To: <20190129150029.29829-1-philmd@redhat.com>
References: <20190129150029.29829-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/5] configure: Let SDL support be optional
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

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
display an informative "none".

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
index c7024d6662..df10601fee 100755
--- a/configure
+++ b/configure
@@ -3380,7 +3380,8 @@ for drv in $audio_drv_list; do
=20
     sdl)
     if test "$sdl" =3D "no"; then
-        error_exit "sdl not found or disabled, can not use sdl audio dri=
ver"
+        echo "WARNING: SDL not found or disabled, can not use sdl audio =
driver"
+        audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/sdl *//g')
     fi
     ;;
=20
@@ -3417,6 +3418,9 @@ for drv in $audio_drv_list; do
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
