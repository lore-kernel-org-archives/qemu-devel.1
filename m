Received: from eggs.gnu.org ([2001:4830:134:3::10]:44290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QP-0008GU-Hq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QO-0000FQ-Pm
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ch9QO-0000FE-KX
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:16 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Feb 2017 14:32:03 +0800
Message-Id: <20170224063205.2537-4-famz@redhat.com>
In-Reply-To: <20170224063205.2537-1-famz@redhat.com>
References: <20170224063205.2537-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] .shippable.yml: new CI provider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Ostensibly Shippable offers a similar set of services as Travis.
However they are focused on Docker container based work-flows so we
can use our existing containers to run a few extra builds - in this
case a bunch of cross-compiled targets on a Debian multiarch system.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170220105139.21581-4-alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 .shippable.yml | 19 +++++++++++++++++++
 MAINTAINERS    |  1 +
 2 files changed, 20 insertions(+)
 create mode 100644 .shippable.yml

diff --git a/.shippable.yml b/.shippable.yml
new file mode 100644
index 0000000..1a1fd7a
--- /dev/null
+++ b/.shippable.yml
@@ -0,0 +1,19 @@
+language: c
+env:
+  matrix:
+    - IMAGE=3Ddebian-armhf-cross
+      TARGET_LIST=3Darm-softmmu,arm-linux-user
+    - IMAGE=3Ddebian-arm64-cross
+      TARGET_LIST=3Daarch64-softmmu,aarch64-linux-user
+build:
+  pre_ci:
+    - make docker-image-${IMAGE}
+  pre_ci_boot:
+    image_name: qemu
+    image_tag: ${IMAGE}
+    pull: false
+    options: "-e HOME=3D/root"
+  ci:
+    - unset CC
+    - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=3D${TARGET_LIST}
+    - make -j2
diff --git a/MAINTAINERS b/MAINTAINERS
index 4714df8..6740467 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1803,6 +1803,7 @@ M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 L: qemu-devel@nongnu.org
 S: Supported
 F: .travis.yml
+F: .shippable.yml
=20
 Documentation
 -------------
--=20
2.9.3
