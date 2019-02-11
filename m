Received: from eggs.gnu.org ([209.51.188.92]:52666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBOZ-0004Zs-Ta
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBOW-00009d-1N
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:11 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBOV-00008R-Hx
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:07 -0500
Received: by mail-wr1-x429.google.com with SMTP id f14so300332wrg.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:13:06 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:05:04 +0000
Message-Id: <20190211130507.8710-16-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/18] tests/vm: expose BUILD_TARGET,
 TARGET_LIST and EXTRA_CONFIGURE_OPTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Now the underlying basevm support passes these along we can expose
some additional variables to our Makefile to allow more customised
tweaking of the build. For example:

  make vm-build-freebsd TARGET_LIST=aarch64-softmmu \
    EXTRA_CONFIGURE_OPTS="--disable-tools --disable-docs" \
    BUILD_TARGET=check-softfloat

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a58383d263..992d823f6b 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -19,6 +19,11 @@ vm-test:
 	@echo ""
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
+	@echo
+	@echo "Special variables:"
+	@echo "    BUILD_TARGET=foo		 - override the build target"
+	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds."
+	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
@@ -47,6 +52,9 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
 		--image "$<" \
-		--build-qemu $(SRC_PATH), \
+		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
+		--build-qemu $(SRC_PATH) -- \
+		$(if $(TARGET_LIST),--target-list=$(TARGET_LIST)) \
+		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
 		"  VM-BUILD $*")
 
-- 
2.20.1
