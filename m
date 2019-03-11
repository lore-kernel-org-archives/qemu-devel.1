Received: from eggs.gnu.org ([209.51.188.92]:48177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38r4-0007la-43
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38r3-0003eu-BF
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38r3-0003eS-2J
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:45 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:30:52 +0100
Message-Id: <20190311003052.13778-6-philmd@redhat.com>
In-Reply-To: <20190311003052.13778-1-philmd@redhat.com>
References: <20190311003052.13778-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/5] .travis.yml: Build and install EDK2 roms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Michal=20Pr=C3=ADvozn=C3=ADk?= <mprivozn@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Add a job to build and install the EDK2 platform firmware binaries.

This job is only triggered if the last commit matches the EDK2
name (case insensitive), or when tag are created (such releases
or release candidates).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index e942175dd3..628cc52c99 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -258,3 +258,24 @@ matrix:
     - env:
         - CONFIG=3D"--disable-system"
         - TEST_CMD=3D"make -j3 check-tcg V=3D1"
+
+
+    # EDK2 roms builds
+    - if: tag IS present OR commit_message =3D~ /(edk2|EDK2)/
+      env:
+        - CONFIG=3D"--disable-system --disable-user --prefix=3D$PWD/dist=
"
+        - EDK2_BUILD_OPTIONS=3D"--quiet --silent"
+      script:
+        - git submodule update --init roms/edk2
+        - make -j3
+        - make -C roms efi -j2
+        - make install
+      addons:
+        apt:
+          packages:
+            - dos2unix
+            - gcc-aarch64-linux-gnu
+            - gcc-arm-linux-gnueabihf
+            - iasl
+            - nasm
+            - uuid-dev
--=20
2.20.1
