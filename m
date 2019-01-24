Received: from eggs.gnu.org ([209.51.188.92]:58957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmdb2-0006bJ-7q
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmdb1-0007Nq-9e
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:55:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmdb1-0007Mm-4I
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:54:59 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 12:54:48 +0100
Message-Id: <20190124115448.30487-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] tests/vm: move images to
 $HOME/.cache/qemu-vm/images
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

Notes:
    v2: use $HOME/.cache/qemu-vm/images as location

 tests/vm/Makefile.include | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

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
2.9.3
