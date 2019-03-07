Received: from eggs.gnu.org ([209.51.188.92]:34017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utN-0002hS-N1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utM-0004v4-T3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1utM-0004uJ-Mm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id r5so17898443wrg.9
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:25:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id d1sm5338345wrs.13.2019.03.07.07.25.02
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 07:25:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Mar 2019 15:24:48 +0000
Message-Id: <20190307152450.20340-11-peter.maydell@linaro.org>
In-Reply-To: <20190307152450.20340-1-peter.maydell@linaro.org>
References: <20190307152450.20340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/12] Makefile: Abstract out "identify the
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

Abstract out the "identify the pkgversion" code from the
rule for creating qemu-version.h, so it sets makefile
variables for QEMU_PKGVERSION and QEMU_FULL_VERSION.
(We will want to use these when building the Sphinx docs.)

NB: As we abstract this out, we use -e to check for .git
rather than -d, since in some situations .git may be a file
rather than a directory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190305172139.32662-11-peter.maydell@linaro.org
Message-id: 20190228145624.24885-11-peter.maydell@linaro.org
---
 Makefile | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index add22cf2947..b746d112a7f 100644
--- a/Makefile
+++ b/Makefile
@@ -87,6 +87,20 @@ endif
 
 include $(SRC_PATH)/rules.mak
 
+# Create QEMU_PKGVERSION and FULL_VERSION strings
+# If PKGVERSION is set, use that; otherwise get version and -dirty status from git
+QEMU_PKGVERSION := $(if $(PKGVERSION),$(PKGVERSION),$(shell \
+  cd $(SRC_PATH); \
+  if test -e .git; then \
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
 
 GENERATED_QAPI_FILES = qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
@@ -392,23 +406,8 @@ all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all mo
 
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
