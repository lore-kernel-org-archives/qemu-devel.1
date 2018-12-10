Received: from eggs.gnu.org ([2001:4830:134:3::10]:43240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU3-000858-Q9
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU2-0000UL-Ct
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:35 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU2-0000UB-6J
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:34 -0500
Received: by mail-wm1-x341.google.com with SMTP id s14so11410756wmh.1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:34 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:17 +0000
Message-Id: <20181210152829.29271-2-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 01/13] tests/tcg: add softmmu awareness to
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
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile         | 17 ++++++++++++++++-
 tests/tcg/Makefile.include |  2 +-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index bf06415390..d6a7fee2e7 100644
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
+# For softmmu targets we inculde a different Makefile fragement as the
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
2.17.1
