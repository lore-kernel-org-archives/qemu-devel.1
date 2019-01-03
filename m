Received: from eggs.gnu.org ([208.118.235.92]:42805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf6hR-0003mw-0t
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf6hQ-0004ok-3v
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:22:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf6hP-0004U6-Tm
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:22:28 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 18:21:51 +0100
Message-Id: <20190103172151.24706-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docker: Use stable git tag for virglrenderer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Use a stable tag instead of some random commit from mainstream
development, to avoid unexpected build failures.

This fixes:

    CC       virglrenderer.lo
  virglrenderer.c: In function 'virgl_has_gl_colorspace':
  virglrenderer.c:208:11: error: implicit declaration of function 'virgl_=
has_egl_khr_gl_colorspace' [-Werror=3Dimplicit-function-declaration]
             virgl_has_egl_khr_gl_colorspace(egl_info));
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  virglrenderer.c:208:43: error: 'egl_info' undeclared (first use in this=
 function)
             virgl_has_egl_khr_gl_colorspace(egl_info));
                                             ^~~~~~~~
  virglrenderer.c:208:43: note: each undeclared identifier is reported on=
ly once for each function it appears in
  cc1: some warnings being treated as errors

As of this commit 'git virglrenderer-0.7.0' is the last stable tag.
(virglrenderer commit breaking: fb4f7577f7ef)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
index 24b113b76f..47a30adbdb 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -24,7 +24,8 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
-RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr=
/src/virglrenderer
+RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr=
/src/virglrenderer && \
+    cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx =
--disable-tests && make install
=20
 # netmap
--=20
2.17.2
