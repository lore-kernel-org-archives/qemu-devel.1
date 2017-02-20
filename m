Received: from eggs.gnu.org ([2001:4830:134:3::10]:53402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cflZE-0006iF-AX
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cflZD-0006Mj-IQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:40 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cflZD-0006MB-C3
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:39 -0500
Received: by mail-wr0-x232.google.com with SMTP id 35so21321389wrw.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 02:51:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 20 Feb 2017 10:51:38 +0000
Message-Id: <20170220105139.21581-4-alex.bennee@linaro.org>
In-Reply-To: <20170220105139.21581-1-alex.bennee@linaro.org>
References: <20170220105139.21581-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 3/4] .shippable.yml: new CI provider
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
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v3
  - reduce matrix to armhf/arm64 which currently work
  - use the make docker-image-* build stanzas
  - add TARGET_LIST to each build
v5
  - add .shippable to MAINTAINER
  - drop centos6 build, shippable guests still need to be apt based
---
 .shippable.yml | 19 +++++++++++++++++++
 MAINTAINERS    |  1 +
 2 files changed, 20 insertions(+)
 create mode 100644 .shippable.yml

diff --git a/.shippable.yml b/.shippable.yml
new file mode 100644
index 0000000000..1a1fd7a91d
--- /dev/null
+++ b/.shippable.yml
@@ -0,0 +1,19 @@
+language: c
+env:
+  matrix:
+    - IMAGE=debian-armhf-cross
+      TARGET_LIST=arm-softmmu,arm-linux-user
+    - IMAGE=debian-arm64-cross
+      TARGET_LIST=aarch64-softmmu,aarch64-linux-user
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
+    - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
+    - make -j2
diff --git a/MAINTAINERS b/MAINTAINERS
index fb57d8eb45..6dcbebf072 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1804,6 +1804,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 L: qemu-devel@nongnu.org
 S: Supported
 F: .travis.yml
+F: .shippable.yml
 
 Documentation
 -------------
-- 
2.11.0
