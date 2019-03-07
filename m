Received: from eggs.gnu.org ([209.51.188.92]:34014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utN-0002h5-Co
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utM-0004uV-7q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:05 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1utL-0004sZ-S7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id f3so9726724wmj.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:25:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id d1sm5338345wrs.13.2019.03.07.07.25.01
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 07:25:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Mar 2019 15:24:47 +0000
Message-Id: <20190307152450.20340-10-peter.maydell@linaro.org>
In-Reply-To: <20190307152450.20340-1-peter.maydell@linaro.org>
References: <20190307152450.20340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/12] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add support to our configure and makefile machinery for building
our rST docs into HTML files.

Building the documentation now requires that sphinx-build is
available; this seems better than allowing half the docs to
be built if it is not present but having half of them missing.
(In particular it means that assuming that distros configured with
--enable-docs they'll get a helpful error from configure telling
them the new build dependency.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190305172139.32662-10-peter.maydell@linaro.org
Message-id: 20190228145624.24885-10-peter.maydell@linaro.org
---
 configure  | 15 +++++++++++++--
 Makefile   | 45 ++++++++++++++++++++++++++++++++++++++++++---
 .gitignore |  1 +
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index cefeb8fcce4..47bf617fcc5 100755
--- a/configure
+++ b/configure
@@ -4589,13 +4589,24 @@ if compile_prog "" "" ; then
   syncfs=yes
 fi
 
+# Check we have a new enough version of sphinx-build
+has_sphinx_build() {
+    # This is a bit awkward but works: create a trivial document and
+    # try to run it with our configuration file (which enforces a
+    # version requirement). This will fail if either
+    # sphinx-build doesn't exist at all or if it is too old.
+    mkdir -p "$TMPDIR1/sphinx"
+    touch "$TMPDIR1/sphinx/index.rst"
+    sphinx-build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
+}
+
 # Check if tools are available to build documentation.
 if test "$docs" != "no" ; then
-  if has makeinfo && has pod2man; then
+  if has makeinfo && has pod2man && has_sphinx_build; then
     docs=yes
   else
     if test "$docs" = "yes" ; then
-      feature_not_found "docs" "Install texinfo and Perl/perl-podlators"
+      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and python-sphinx"
     fi
     docs=no
   fi
diff --git a/Makefile b/Makefile
index 2208bde4196..add22cf2947 100644
--- a/Makefile
+++ b/Makefile
@@ -388,7 +388,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
 qemu-version.h: FORCE
 	$(call quiet-command, \
@@ -637,6 +637,14 @@ dist: qemu-$(VERSION).tar.bz2
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
+# Note that these commands assume that there are no HTML files in
+# the docs subdir in the source tree! If there are then this will
+# blow them away for an in-source-tree 'make clean'.
+define clean-manual =
+rm -rf docs/$1/_static
+rm -f docs/$1/objects.inv docs/$1/searchindex.js docs/$1/*.html
+endef
+
 distclean: clean
 	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f config-all-devices.mak config-all-disas.mak config.status
@@ -657,6 +665,9 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	rm -f docs/qemu-block-drivers.7
 	rm -f docs/qemu-cpu-models.7
+	rm -f .doctrees
+	$(call clean-manual,devel)
+	$(call clean-manual,interop)
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -690,7 +701,18 @@ else
 BLOBS=
 endif
 
-install-doc: $(DOCS)
+define install-manual =
+for d in $$(cd docs && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
+for f in $$(cd docs && find $1 -type f); do $(INSTALL_DATA) "docs/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
+endef
+
+# Note that we deliberately do not install the "devel" manual: it is
+# for QEMU developers, and not interesting to our users.
+.PHONY: install-sphinxdocs
+install-sphinxdocs: sphinxdocs
+	$(call install-manual,interop)
+
+install-doc: $(DOCS) install-sphinxdocs
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
@@ -841,6 +863,23 @@ docs/version.texi: $(SRC_PATH)/VERSION
 %.pdf: %.texi docs/version.texi
 	$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
 
+# Sphinx builds all its documentation at once in one invocation
+# and handles "don't rebuild things unless necessary" itself.
+# The '.doctrees' files are cached information to speed this up.
+.PHONY: sphinxdocs
+sphinxdocs: docs/devel/index.html docs/interop/index.html
+
+# Canned command to build a single manual
+build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -b html -d .doctrees/$1 $(SRC_PATH)/docs/$1 docs/$1 ,"SPHINX","docs/$1")
+# We assume all RST files in the manual's directory are used in it
+manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
+
+docs/devel/index.html: $(call manual-deps,devel)
+	$(call build-manual,devel)
+
+docs/interop/index.html: $(call manual-deps,interop)
+	$(call build-manual,interop)
+
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
@@ -869,7 +908,7 @@ docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
 scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
 
-html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
+html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
 info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
 pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
diff --git a/.gitignore b/.gitignore
index b66b7725512..77522561b8e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+/.doctrees
 /config-devices.*
 /config-all-devices.*
 /config-all-disas.*
-- 
2.20.1
