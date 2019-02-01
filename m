Received: from eggs.gnu.org ([209.51.188.92]:38914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9e-0008OF-0P
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9d-0004DO-5U
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:53 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:52707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpa9c-0004CU-Vt
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:53 -0500
Received: by mail-wm1-x32b.google.com with SMTP id m1so6398611wml.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:50:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 14:50:34 +0000
Message-Id: <20190201145035.22739-11-peter.maydell@linaro.org>
In-Reply-To: <20190201145035.22739-1-peter.maydell@linaro.org>
References: <20190201145035.22739-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] Makefile: Abstract out "identify the
 pkgversion" code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Abstract out the "identify the pkgversion" code from the
rule for creating qemu-version.h, so it sets makefile
variables for QEMU_PKGVERSION and QEMU_FULL_VERSION.
(We will want to use these when building the Sphinx docs.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index d519fadee39..2d19d28a271 100644
--- a/Makefile
+++ b/Makefile
@@ -87,6 +87,20 @@ endif
 
 include $(SRC_PATH)/rules.mak
 
+# Create QEMU_PKGVERSION and FULL_VERSION strings
+# If PKGVERSION is set, use that; otherwise get version and -dirty status from git
+QEMU_PKGVERSION := $(if $(PKGVERSION),$(PKGVERSION),$(shell \
+  cd $(SRC_PATH); \
+  if test -d .git; then \
+    git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
+    if ! git diff-index --quiet HEAD &>/dev/null; then \
+      echo "-dirty"; \
+    fi; \
+  fi))
+
+# Either "version (pkgversion)", or just "version" if pkgversion not set
+FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSION))
+
 GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
 
 #see Makefile.objs for the definition of QAPI_MODULES
@@ -391,23 +405,8 @@ all: $(DOCS) sphinxdocs $(TOOLS) $(HELPERS-y) recurse-all modules
 
 qemu-version.h: FORCE
 	$(call quiet-command, \
-		(cd $(SRC_PATH); \
-		if test -n "$(PKGVERSION)"; then \
-			pkgvers="$(PKGVERSION)"; \
-		else \
-			if test -d .git; then \
-				pkgvers=$$(git describe --match 'v*' 2>/dev/null | tr -d '\n');\
-				if ! git diff-index --quiet HEAD &>/dev/null; then \
-					pkgvers="$${pkgvers}-dirty"; \
-				fi; \
-			fi; \
-		fi; \
-		printf "#define QEMU_PKGVERSION \"$${pkgvers}\"\n"; \
-		if test -n "$${pkgvers}"; then \
-			printf '#define QEMU_FULL_VERSION QEMU_VERSION " (" QEMU_PKGVERSION ")"\n'; \
-		else \
-			printf '#define QEMU_FULL_VERSION QEMU_VERSION\n'; \
-		fi; \
+                (printf '#define QEMU_PKGVERSION "$(QEMU_PKGVERSION)"\n'; \
+		printf '#define QEMU_FULL_VERSION "$(FULL_VERSION)"\n'; \
 		) > $@.tmp)
 	$(call quiet-command, if ! cmp -s $@ $@.tmp; then \
 	  mv $@.tmp $@; \
-- 
2.20.1
