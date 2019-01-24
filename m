Received: from eggs.gnu.org ([209.51.188.92]:36766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmcCe-00070m-10
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmcCc-0001RL-QO
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:25:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmcCc-0000YR-HO
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:25:42 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 11:25:04 +0100
Message-Id: <20190124102504.24192-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/vm: move images to subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, Gerd Hoffmann <kraxel@redhat.com>

It's easier to move around the images then, by replacing the
subdirectory with a symlink.  Allows to share the images between
multiple qemu checkouts for example.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/.gitignore       |  1 +
 tests/vm/Makefile.include | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 tests/vm/.gitignore

diff --git a/tests/vm/.gitignore b/tests/vm/.gitignore
new file mode 100644
index 0000000000..c291c09129
--- /dev/null
+++ b/tests/vm/.gitignore
@@ -0,0 +1 @@
+images
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a98fb3027f..f9f0417447 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -3,7 +3,7 @@
 .PHONY: vm-build-all vm-clean-all
 
 IMAGES := ubuntu.i386 freebsd netbsd openbsd centos
-IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
+IMAGE_FILES := $(patsubst %, tests/vm/images/%.img, $(IMAGES))
 
 .PRECIOUS: $(IMAGE_FILES)
 
@@ -24,9 +24,10 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
 vm-clean-all:
 	rm -f $(IMAGE_FILES)
 
-tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
-		$(SRC_PATH)/tests/vm/basevm.py \
-		$(SRC_PATH)/tests/vm/Makefile.include
+tests/vm/images/%.img:	$(SRC_PATH)/tests/vm/% \
+			$(SRC_PATH)/tests/vm/basevm.py \
+			$(SRC_PATH)/tests/vm/Makefile.include
+	@mkdir -p tests/vm/images
 	$(call quiet-command, \
 		$< \
 		$(if $(V)$(DEBUG), --debug) \
@@ -37,7 +38,7 @@ tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
 
 
 # Build in VM $(IMAGE)
-vm-build-%: tests/vm/%.img
+vm-build-%: tests/vm/images/%.img
 	$(call quiet-command, \
 		$(SRC_PATH)/tests/vm/$* \
 		$(if $(V)$(DEBUG), --debug) \
-- 
2.9.3
