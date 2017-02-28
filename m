Received: from eggs.gnu.org ([2001:4830:134:3::10]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cih9N-0003Xu-DU
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cih9L-0001Cf-VW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cih9L-0001CX-PG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:45:03 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 28 Feb 2017 20:44:57 +0800
Message-Id: <20170228124458.31307-2-famz@redhat.com>
In-Reply-To: <20170228124458.31307-1-famz@redhat.com>
References: <20170228124458.31307-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] new: dockerfiles/debian-s390-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This adds an s390 cross build target to our library of docker setups.
There is an issue with the xfslibs-dev:s390x package having a clash so
we do a || apt-get -f install to fixup the rest of the dependencies.

This doesn't build on the debian.docker file as we are using the
multilib compiler which is only available in stretch (the current
testing repo).

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20170227143028.16428-2-alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/debian-s390x-cross.docker | 22 ++++++++++++++++=
++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-s390x-cross.docker

diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/d=
ocker/dockerfiles/debian-s390x-cross.docker
new file mode 100644
index 0000000..bbb21ed
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
+RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources=
.list
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
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Ds390x-linux-gnu-
--=20
2.9.3
