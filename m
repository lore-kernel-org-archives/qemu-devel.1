Received: from eggs.gnu.org ([209.51.188.92]:47778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G0X-0004PW-Ag
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G0V-0002e9-Ac
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:53 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2G0V-0002TG-2q
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:51 -0500
Received: by mail-wm1-x342.google.com with SMTP id g20so12381199wmh.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 05:57:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Mar 2019 13:57:42 +0000
Message-Id: <20190308135744.6480-2-peter.maydell@linaro.org>
In-Reply-To: <20190308135744.6480-1-peter.maydell@linaro.org>
References: <20190308135744.6480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] Makefile: Fix Sphinx documentation builds
 for in-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The Sphinx build-sphinx tool does not permit building a manual
into the same directory as its source files. This meant that
commit 5f71eac06e15b9a3fa1134d446f broke QEMU in-source-tree
builds, which would fail with:
  Error: source directory and destination directory are same.

Fix this by making in-tree builds build the Sphinx manuals
into a subdirectory of docs/.

Fixes: 5f71eac06e15b9a3fa1134d446f ("Makefile, configure: Support building rST documentation")
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index d2463c92371..0194ef7fa55 100644
--- a/Makefile
+++ b/Makefile
@@ -655,12 +655,20 @@ dist: qemu-$(VERSION).tar.bz2
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
-# Note that these commands assume that there are no HTML files in
-# the docs subdir in the source tree! If there are then this will
-# blow them away for an in-source-tree 'make clean'.
+# Sphinx does not allow building manuals into the same directory as
+# the source files, so if we're doing an in-tree QEMU build we must
+# build the manuals into a subdirectory (and then install them from
+# there for 'make install'). For an out-of-tree build we can just
+# use the docs/ subdirectory in the build tree as normal.
+ifeq ($(realpath $(SRC_PATH)),$(realpath .))
+MANUAL_BUILDDIR := docs/built
+else
+MANUAL_BUILDDIR := docs
+endif
+
 define clean-manual =
-rm -rf docs/$1/_static
-rm -f docs/$1/objects.inv docs/$1/searchindex.js docs/$1/*.html
+rm -rf $(MANUAL_BUILDDIR)/$1/_static
+rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(MANUAL_BUILDDIR)/$1/*.html
 endef
 
 distclean: clean
@@ -720,8 +728,8 @@ BLOBS=
 endif
 
 define install-manual =
-for d in $$(cd docs && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd docs && find $1 -type f); do $(INSTALL_DATA) "docs/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
+for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
+for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
 endef
 
 # Note that we deliberately do not install the "devel" manual: it is
@@ -885,17 +893,17 @@ docs/version.texi: $(SRC_PATH)/VERSION
 # and handles "don't rebuild things unless necessary" itself.
 # The '.doctrees' files are cached information to speed this up.
 .PHONY: sphinxdocs
-sphinxdocs: docs/devel/index.html docs/interop/index.html
+sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index.html
 
 # Canned command to build a single manual
-build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -b html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 docs/$1 ,"SPHINX","docs/$1")
+build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -b html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 
-docs/devel/index.html: $(call manual-deps,devel)
+$(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
 	$(call build-manual,devel)
 
-docs/interop/index.html: $(call manual-deps,interop)
+$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
 	$(call build-manual,interop)
 
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-- 
2.20.1
