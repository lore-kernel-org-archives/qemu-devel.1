Received: from eggs.gnu.org ([209.51.188.92]:52107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn224-0003VL-4z
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn222-0000gz-5a
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:31 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn221-0000eg-SB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:30 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so10359570wrt.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:13 +0000
Message-Id: <20190125140017.6092-11-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 10/14] tests/vm: move images to
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

It's easier to move around the images then, by replacing the
subdirectory with a symlink.  Allows to share the images between
multiple qemu checkouts for example.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
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
2.17.1
