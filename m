Received: from eggs.gnu.org ([209.51.188.92]:40413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gldAs-0005SE-N9
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gldAr-0002vH-W0
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gldAr-0002so-QJ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id u4so24304193wrp.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:15:49 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 21 Jan 2019 17:15:43 +0000
Message-Id: <20190121171543.32422-4-alex.bennee@linaro.org>
In-Reply-To: <20190121171543.32422-1-alex.bennee@linaro.org>
References: <20190121171543.32422-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  3/3] tests/vm: expose BUILD_TARGET,
 TARGET_LIST and EXTRA_CONFIGURE_OPTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kamil@netbsd.org, brad@comstyle.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Now the underlying basevm support passes these along we can expose
some additional variables to our Makefile to allow more customised
tweaking of the build. For example:

  make vm-build-freebsd TARGET_LIST=aarch64-softmmu \
    EXTRA_CONFIGURE_OPTS="--disable-tools --disable-docs" \
    BUILD_TARGET=check-softfloat

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a98fb3027f..6be53aa297 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -18,6 +18,11 @@ vm-test:
 	@echo ""
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
+	@echo
+	@echo "Special variables:"
+	@echo "    BUILD_TARGET=foo		 - override the build target"
+	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds."
+	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
@@ -45,6 +50,9 @@ vm-build-%: tests/vm/%.img
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
2.17.1
