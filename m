Received: from eggs.gnu.org ([209.51.188.92]:45672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlV-00024C-DS
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlO-00016R-Eh
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlO-00012o-8y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:30 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:02 +0000
Message-Id: <20190109163114.17010-2-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/13] tests: run ldconfig after installing
 extra software
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The docker file builds and installs software into /usr/local but does
not run ldconfig. As a result QEMU links to libvirglrenderer.so, but
then crashes in "make check" unable to find the library.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
index 24b113b76f..1f597121dc 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -35,5 +35,7 @@ RUN git clone https://github.com/luigirizzo/netmap.git =
/usr/src/netmap
 RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --ker=
nel-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make install
 ENV QEMU_CONFIGURE_OPTS --enable-netmap
=20
+RUN ldconfig
+
 # gcrypt
 ENV QEMU_CONFIGURE_OPTS $QEMU_CONFIGURE_OPTS --enable-gcrypt
--=20
2.19.2
