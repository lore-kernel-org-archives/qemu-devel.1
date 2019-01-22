Received: from eggs.gnu.org ([209.51.188.92]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gm1N6-0003Vf-Iu
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gm1N3-0006qJ-DE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:06:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gm1Mz-0006gL-OZ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:05:59 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 22 Jan 2019 20:05:03 +0100
Message-Id: <20190122190503.13627-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: Let SDL support be optional on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Currently if we try to build QEMU on OpenBSD with SDL disabled, we get:

  $ ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3Dpyt=
hon2.7 --disable-sdl

  ERROR: sdl not found or disabled, can not use sdl audio driver

Since SDL is not a requirement for OpenBSD, let it be optional (we remove
it from $audio_drv_list but it stays available in $audio_possible_drivers=
).
If no audio backends are available, QEMU falls back to the null driver.

This does not change the default behavior:

  $ ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3Dpyt=
hon2.7
  SDL support       yes (1.2.15)

  WARNING: Use of SDL 1.2 is deprecated and will be removed in
  WARNING: future releases. Please switch to using SDL 2.0

  GEN     config-host.h
  ...

but allows to build without SDL:

  $ ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3Dpyt=
hon2.7 --disable-sdl
  SDL support       no
  GEN     config-host.h
  ...

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
See https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02732.html

 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index de768e2343..98fc4fa84a 100755
--- a/configure
+++ b/configure
@@ -828,7 +828,7 @@ NetBSD)
 OpenBSD)
   bsd=3D"yes"
   make=3D"${MAKE-gmake}"
-  audio_drv_list=3D"sdl"
+  audio_drv_list=3D""
   audio_possible_drivers=3D"sdl"
   HOST_VARIANT_DIR=3D"openbsd"
   supported_os=3D"yes"
--=20
2.20.1
