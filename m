Received: from eggs.gnu.org ([209.51.188.92]:34011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOi-0004mO-Gd
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOg-0008Ua-Lm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:40 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOg-0007Xl-Bq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:38 -0500
Received: by mail-wr1-x441.google.com with SMTP id q18so12341745wrx.9
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:19 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:44:58 +0000
Message-Id: <20190110174516.21586-2-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 01/19] docker: Use stable git tag for
 virglrenderer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use a stable tag instead of some random commit from mainstream
development, to avoid unexpected build failures.

This fixes:

    CC       virglrenderer.lo
  virglrenderer.c: In function 'virgl_has_gl_colorspace':
  virglrenderer.c:208:11: error: implicit declaration of function 'virgl_has_egl_khr_gl_colorspace' [-Werror=implicit-function-declaration]
             virgl_has_egl_khr_gl_colorspace(egl_info));
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  virglrenderer.c:208:43: error: 'egl_info' undeclared (first use in this function)
             virgl_has_egl_khr_gl_colorspace(egl_info));
                                             ^~~~~~~~
  virglrenderer.c:208:43: note: each undeclared identifier is reported only once for each function it appears in
  cc1: some warnings being treated as errors

As of this commit 'git virglrenderer-0.7.0' is the last stable tag.
(virglrenderer commit breaking: fb4f7577f7ef)

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-amd64.docker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 24b113b76f..47a30adbdb 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -24,7 +24,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
-RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/src/virglrenderer
+RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/src/virglrenderer && \
+    cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
 
 # netmap
-- 
2.17.1
