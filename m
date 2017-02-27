Received: from eggs.gnu.org ([2001:4830:134:3::10]:38058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ciMJw-000156-3h
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ciMJs-0007Zi-5Q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:36 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ciMJr-0007Yd-Uw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:32 -0500
Received: by mail-wr0-x232.google.com with SMTP id g10so53383021wrg.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 06:30:31 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 27 Feb 2017 14:30:27 +0000
Message-Id: <20170227143028.16428-2-alex.bennee@linaro.org>
In-Reply-To: <20170227143028.16428-1-alex.bennee@linaro.org>
References: <20170227143028.16428-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/2] new: dockerfiles/debian-s390-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>

This adds an s390 cross build target to our library of docker setups.
There is an issue with the xfslibs-dev:s390x package having a clash so
we do a || apt-get -f install to fixup the rest of the dependencies.

This doesn't build on the debian.docker file as we are using the
multilib compiler which is only available in stretch (the current
testing repo).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tests/docker/dockerfiles/debian-s390x-cross.docker | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-s390x-cross.docker

diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
new file mode 100644
index 0000000000..bbb21ed088
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -0,0 +1,22 @@
+#
+# Docker s390 cross-compiler target
+#
+# This docker target is based on stretch (testing) as the stable build
+# doesn't have the cross compiler available.
+#
+FROM debian:testing-slim
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
+
+# Add the s390x architecture
+RUN dpkg --add-architecture s390x
+
+# Grab the updated list of packages
+RUN apt update
+RUN apt dist-upgrade -yy
+RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
+RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
-- 
2.11.0
