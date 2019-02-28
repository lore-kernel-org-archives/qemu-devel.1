Received: from eggs.gnu.org ([209.51.188.92]:42480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFR-0000QH-Ux
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFR-00077u-49
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:41 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFQ-000753-T6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id r5so23418855wrg.9
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:40 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:22 +0000
Message-Id: <20190228202537.4638-2-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/16] tests/tcg: add softmmu awareness to
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/Makefile         | 17 ++++++++++++++++-
 tests/tcg/Makefile.include |  2 +-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index bf06415390..55feab0f67 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -26,7 +26,7 @@
 #
 # We also accept SPEED=slow to enable slower running tests
 #
-# We also expect to be in the tests build dir for the FOO-linux-user.
+# We also expect to be in the tests build dir for the FOO-(linux-user|softmmu).
 #
 
 -include ../../config-host.mak
@@ -52,7 +52,11 @@ QEMU_CFLAGS=
 LDFLAGS=
 
 # The QEMU for this TARGET
+ifdef CONFIG_USER_ONLY
 QEMU=../qemu-$(TARGET_NAME)
+else
+QEMU=../qemu-system-$(TARGET_NAME)
+endif
 
 # If TCG debugging is enabled things are a lot slower
 ifeq ($(CONFIG_DEBUG_TCG),y)
@@ -61,6 +65,7 @@ else
 TIMEOUT=15
 endif
 
+ifdef CONFIG_USER_ONLY
 # The order we include is important. We include multiarch, base arch
 # and finally arch if it's not the same as base arch.
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
@@ -77,6 +82,16 @@ endif
 
 %: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+else
+# For softmmu targets we include a different Makefile fragement as the
+# build options for bare programs are usually pretty different. They
+# are expected to provide their own build recipes.
+-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.softmmu-target
+ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
+-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
+endif
+
+endif
 
 all: $(TESTS)
 
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
index c581bd6ffc..73b5626fc5 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.include
@@ -67,7 +67,7 @@ endif
 ifneq ($(GUEST_BUILD),)
 guest-tests: $(GUEST_BUILD)
 
-run-guest-tests: guest-tests qemu-$(TARGET_NAME)
+run-guest-tests: guest-tests qemu-$(subst y,system-,$(CONFIG_SOFTMMU))$(TARGET_NAME)
 	$(call quiet-command, \
 	(cd tests && $(MAKE) -f $(TCG_MAKE) SPEED=$(SPEED) run), \
 	"RUN", "tests for $(TARGET_NAME)")
-- 
2.20.1
