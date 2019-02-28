Received: from eggs.gnu.org ([209.51.188.92]:42725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFa-0000UN-FG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFZ-0007Or-O5
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:50 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFZ-0007OB-Gm
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id e74so10415498wmg.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:49 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:36 +0000
Message-Id: <20190228202537.4638-16-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 15/16] .travis.yml: separate softfloat from
 check-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

While used by TCG it is not explicitly part of TCG and the tests can
be run standalone in a minimal build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml            | 6 ++++++
 tests/Makefile.include | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index cca57f4314..71b3c4a7a3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -85,6 +85,12 @@ matrix:
         - CONFIG="--disable-user"
 
 
+    # Just build tools and run minimal unit and softfloat checks
+    - env:
+        - BASE_CONFIG="--enable-tools"
+        - CONFIG="--disable-user --disable-system"
+        - TEST_CMD="make check-unit check-softfloat -j3"
+
     - env:
         - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f39b96e250..fb31cc5edf 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1059,7 +1059,7 @@ clean-tcg-tests-%:
 build-tcg: $(BUILD_TCG_TARGET_RULES)
 
 .PHONY: check-tcg
-check-tcg: check-softfloat $(RUN_TCG_TARGET_RULES)
+check-tcg: $(RUN_TCG_TARGET_RULES)
 
 .PHONY: clean-tcg
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
-- 
2.20.1
