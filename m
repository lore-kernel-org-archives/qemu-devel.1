Received: from eggs.gnu.org ([209.51.188.92]:34017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOi-0004mk-R3
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOg-0008VC-Qh
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOg-0007Y0-JQ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:38 -0500
Received: by mail-wr1-x444.google.com with SMTP id v13so12370346wrw.5
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:20 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:44:59 +0000
Message-Id: <20190110174516.21586-3-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 02/19] tests: run ldconfig after installing
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
Cc: ymankad@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

The docker file builds and installs software into /usr/local but does
not run ldconfig. As a result QEMU links to libvirglrenderer.so, but
then crashes in "make check" unable to find the library.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 47a30adbdb..954fcf9606 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -36,5 +36,7 @@ RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
 RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install
 ENV QEMU_CONFIGURE_OPTS --enable-netmap
 
+RUN ldconfig
+
 # gcrypt
 ENV QEMU_CONFIGURE_OPTS $QEMU_CONFIGURE_OPTS --enable-gcrypt
-- 
2.17.1
