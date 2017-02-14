Received: from eggs.gnu.org ([2001:4830:134:3::10]:55724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cda12-00063w-Tp
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cda0z-0008MP-Qr
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:07:20 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cda0z-0008M4-Kr
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:07:17 -0500
Received: by mail-wr0-x236.google.com with SMTP id i10so166529240wrb.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 02:07:17 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 14 Feb 2017 10:07:33 +0000
Message-Id: <20170214100733.22280-4-alex.bennee@linaro.org>
In-Reply-To: <20170214100733.22280-1-alex.bennee@linaro.org>
References: <20170214100733.22280-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/3] .shippable.yml: new CI provider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Ostensibly Shippable offers a similar set of services as Travis.
However they are focused on Docker container based work-flows so we
can use our existing containers to run a few extra builds - in this
case a bunch of cross-compiled targets on a Debian multiarch system.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - reduce matrix to armhf/arm64 which currently work
  - use the make docker-image-* build stanzas
  - add TARGET_LIST to each build
---
 .shippable.yml | 23 +++++++++++++++++++++++
 MAINTAINERS    |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 .shippable.yml

diff --git a/.shippable.yml b/.shippable.yml
new file mode 100644
index 0000000000..e4fa159481
--- /dev/null
+++ b/.shippable.yml
@@ -0,0 +1,23 @@
+language: c
+env:
+  matrix:
+    - IMAGE=debian-armhf-cross
+      CROSS_PREFIX=arm-linux-gnueabihf-
+      TARGET_LIST=arm-softmmu,arm-linux-user
+    - IMAGE=debian-arm64-cross
+      CROSS_PREFIX=aarch64-linux-gnu-
+      TARGET_LIST=aarch64-softmmu,aarch64-linux-user
+    - IMAGE=centos6
+      TARGET_LIST=i386-softmmu,x86_64-softmmu
+build:
+  pre_ci:
+    - make docker-image-${IMAGE}
+  pre_ci_boot:
+    image_name: qemu
+    image_tag: ${IMAGE}
+    pull: false
+    options: "-e HOME=/root"
+  ci:
+    - unset CC
+    - ./configure --cross-prefix=${CROSS_PREFIX} --target-list=${TARGET_LIST}
+    - make -j2
diff --git a/MAINTAINERS b/MAINTAINERS
index 7afbadaa15..578888d32d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1805,6 +1805,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 L: qemu-devel@nongnu.org
 S: Supported
 F: .travis.yml
+F: .shippable.yml
 
 Documentation
 -------------
-- 
2.11.0
