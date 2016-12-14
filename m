Received: from eggs.gnu.org ([2001:4830:134:3::10]:35157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7v-00067X-MN
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7r-0001zL-KR
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:59 -0500
Received: from mail-wj0-f175.google.com ([209.85.210.175]:33549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHD7r-0001zC-EE
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:55 -0500
Received: by mail-wj0-f175.google.com with SMTP id xy5so42546706wjc.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:13:55 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Dec 2016 17:12:44 +0000
Message-Id: <20161214171244.26813-5-alex.bennee@linaro.org>
In-Reply-To: <20161214171244.26813-1-alex.bennee@linaro.org>
References: <20161214171244.26813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC/POC PATCH 4/4] tests/tcg/Makefile: use docker
 target for arm-tcg-tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com, marcandre.lureau@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This means we can type:

  make arm-tcg-tests

And through the power of docker and Debian's emdebian cross tools we
build the misc and arm TCG targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.include | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index 3eff12527c..6d8d666203 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -8,6 +8,7 @@ BUILD_DIR?=$(CURDIR)
 include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
 
 UNAME_M := $(shell uname -m)
+BUILD_UID = $(shell id -u)
 
 tests-tcg: prepare $(UNAME_M)
 
@@ -22,9 +23,22 @@ i386:
 	cd $(BUILD_DIR)/i386-linux-user/tests/ && \
 	make -f $(SRC_PATH)/tests/tcg/i386/Makefile
 
-arm:
-	cd $(BUILD_DIR)/arm-linux-user/tests/ && \
-	make -f $(SRC_PATH)/tests/tcg/arm/Makefile
+arm-tcg-tests: docker-image-debian-multiarch-cross
+	mkdir -p $(BUILD_DIR)/arm-linux-user/tests
+	docker run --rm -it -v $(SRC_PATH):$(SRC_PATH) \
+		-v $(BUILD_DIR):$(BUILD_DIR) \
+		--user $(BUILD_ID):$(BUILD_ID) \
+		-w $(BUILD_DIR)/arm-linux-user/tests \
+		-e CROSS_CC="arm-linux-gnueabihf-gcc" \
+		qemu:debian-multiarch-cross \
+		make -f ../../tests/tcg/misc/Makefile
+	docker run --rm -it -v $(SRC_PATH):$(SRC_PATH) \
+		-v $(BUILD_DIR):$(BUILD_DIR) \
+		--user $(BUILD_ID):$(BUILD_ID) \
+		-w $(BUILD_DIR)/arm-linux-user/tests \
+		-e CROSS_CC="arm-linux-gnueabihf-gcc" \
+		qemu:debian-multiarch-cross \
+		make -f ../../tests/tcg/arm/Makefile
 
 aarch64:
 	cd $(BUILD_DIR)/aarch64-linux-user/tests/ && \
-- 
2.11.0
