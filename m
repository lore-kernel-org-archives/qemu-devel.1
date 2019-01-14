Received: from eggs.gnu.org ([209.51.188.92]:35448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kE-0006Iu-NX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3k9-0005IV-41
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3k8-0005GA-S4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so23320190wrr.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:34 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:10 +0000
Message-Id: <20190114150129.1013-3-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/21] tests: run ldconfig after installing
 extra software
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

The docker file builds and installs software into /usr/local but does
not run ldconfig. As a result QEMU links to libvirglrenderer.so, but
then crashes in "make check" unable to find the library.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
