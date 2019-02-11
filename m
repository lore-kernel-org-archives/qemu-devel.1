Received: from eggs.gnu.org ([209.51.188.92]:50663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHg-0007Xs-S3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBHf-0004ED-4L
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:04 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBHd-0003pn-8P
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:06:02 -0500
Received: by mail-wm1-x32b.google.com with SMTP id q21so17151771wmc.5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:05:19 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:05:01 +0000
Message-Id: <20190211130507.8710-13-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/18] tests/vm: move images to
 $HOME/.cache/qemu-vm/images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Gerd Hoffmann <kraxel@redhat.com>

It's easier to move around the images then, by replacing the
subdirectory with a symlink.  Allows to share the images between
multiple qemu checkouts for example.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a98fb3027f..a58383d263 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -3,7 +3,8 @@
 .PHONY: vm-build-all vm-clean-all
 
 IMAGES := ubuntu.i386 freebsd netbsd openbsd centos
-IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
+IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
+IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
 .PRECIOUS: $(IMAGE_FILES)
 
@@ -24,9 +25,10 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
 vm-clean-all:
 	rm -f $(IMAGE_FILES)
 
-tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
-		$(SRC_PATH)/tests/vm/basevm.py \
-		$(SRC_PATH)/tests/vm/Makefile.include
+$(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
+			$(SRC_PATH)/tests/vm/basevm.py \
+			$(SRC_PATH)/tests/vm/Makefile.include
+	@mkdir -p $(IMAGES_DIR)
 	$(call quiet-command, \
 		$< \
 		$(if $(V)$(DEBUG), --debug) \
@@ -37,7 +39,7 @@ tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
 
 
 # Build in VM $(IMAGE)
-vm-build-%: tests/vm/%.img
+vm-build-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(SRC_PATH)/tests/vm/$* \
 		$(if $(V)$(DEBUG), --debug) \
-- 
2.20.1
