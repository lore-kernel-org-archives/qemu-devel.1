Received: from eggs.gnu.org ([2001:4830:134:3::10]:39965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkw-0001zL-Ny
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkv-0006Gz-RC
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:06 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkv-0006GQ-Lm
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:05 -0400
Received: by mail-oi0-x241.google.com with SMTP id h4so13124135oib.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:57:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:12 -0300
Message-Id: <20170602185630.5059-7-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 06/24] docker: create deb-src entry and
 setup Emdebian in the same layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian.docker | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index d08def6a8d..33ba686892 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -13,13 +13,11 @@ FROM debian:stable-slim
 RUN apt update
 RUN apt install -yy aptitude ca-certificates curl
 
-# Setup Emdebian
-RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
-RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
-
 # Install common build utilities
 RUN apt update
 RUN apt install -yy build-essential clang
+
+# Duplicate deb line as deb-src, setup Emdebian
+RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list && \
+    echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
+    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
-- 
2.11.0
