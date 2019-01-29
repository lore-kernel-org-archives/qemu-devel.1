Received: from eggs.gnu.org ([209.51.188.92]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk5-0001z4-2f
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk4-0001ip-9Q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goRk2-0001bf-8I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:48 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 29 Jan 2019 11:39:19 +0000
Message-Id: <20190129113921.21599-4-berrange@redhat.com>
In-Reply-To: <20190129113921.21599-1-berrange@redhat.com>
References: <20190129113921.21599-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/5] nsis: ensure we always pass -W64 flag to
 nsis installer script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The code to set the -W64 flag is inside a conditional block that only
executes when we are bundling DLLs with the installer. This results in
QEMU being installed in the wrong location on 64-bit hosts when DLLs
are not bundled.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 14a463564e..97a6727358 100644
--- a/Makefile
+++ b/Makefile
@@ -893,11 +893,14 @@ INSTALLER =3D qemu-setup-$(VERSION)$(EXESUF)
=20
 nsisflags =3D -V2 -NOCD
=20
+ifeq ($(ARCH),x86_64)
+nsisflags +=3D -DW64
+endif
+
 ifneq ($(wildcard $(SRC_PATH)/dll),)
 ifeq ($(ARCH),x86_64)
 # 64 bit executables
 DLL_PATH =3D $(SRC_PATH)/dll/w64
-nsisflags +=3D -DW64
 else
 # 32 bit executables
 DLL_PATH =3D $(SRC_PATH)/dll/w32
--=20
2.20.1
