Received: from eggs.gnu.org ([2001:4830:134:3::10]:48099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIGFE-0005Wb-J8
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIGF8-00044p-5t
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIGF7-00044l-Sz
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:18:02 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 17:17:57 +0200
Message-Id: <20170606151757.32473-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] docs: create interop/ subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armbru@redhat.com, peter.maydell@linaro.org, berrange@redhat.com, thuth@redhat.com

This is for the future interoperability & management guide.  It includes
the QAPI docs, including the automatically generated ones, other socket
protocols (vhost-user, VNC), and the qcow2 file format.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                                         | 16 +++---
 Makefile                                           | 61 +++++++++++++---------
 configure                                          |  2 +-
 docs/{specs => interop}/qcow2.txt                  |  0
 docs/{ => interop}/qemu-ga-ref.texi                |  0
 docs/{ => interop}/qemu-qmp-ref.texi               |  0
 docs/{ => interop}/qmp-intro.txt                   |  0
 docs/{ => interop}/qmp-spec.txt                    |  0
 docs/{specs => interop}/vhost-user.txt             |  0
 .../{ => interop}/vnc-ledstate-Pseudo-encoding.txt |  0
 10 files changed, 44 insertions(+), 35 deletions(-)
 rename docs/{specs => interop}/qcow2.txt (100%)
 rename docs/{ => interop}/qemu-ga-ref.texi (100%)
 rename docs/{ => interop}/qemu-qmp-ref.texi (100%)
 rename docs/{ => interop}/qmp-intro.txt (100%)
 rename docs/{ => interop}/qmp-spec.txt (100%)
 rename docs/{specs => interop}/vhost-user.txt (100%)
 rename docs/{ => interop}/vnc-ledstate-Pseudo-encoding.txt (100%)

diff --git a/.gitignore b/.gitignore
index fa96bd29bb..09c2363acf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,14 +100,14 @@
 /pc-bios/optionrom/kvmvapic.img
 /pc-bios/s390-ccw/s390-ccw.elf
 /pc-bios/s390-ccw/s390-ccw.img
-/docs/qemu-ga-qapi.texi
-/docs/qemu-ga-ref.html
-/docs/qemu-ga-ref.info*
-/docs/qemu-ga-ref.txt
-/docs/qemu-qmp-qapi.texi
-/docs/qemu-qmp-ref.html
-/docs/qemu-qmp-ref.info*
-/docs/qemu-qmp-ref.txt
+/docs/interop/qemu-ga-qapi.texi
+/docs/interop/qemu-ga-ref.html
+/docs/interop/qemu-ga-ref.info*
+/docs/interop/qemu-ga-ref.txt
+/docs/interop/qemu-qmp-qapi.texi
+/docs/interop/qemu-qmp-ref.html
+/docs/interop/qemu-qmp-ref.info*
+/docs/interop/qemu-qmp-ref.txt
 /docs/version.texi
 *.tps
 .stgit-*
diff --git a/Makefile b/Makefile
index e14988d9d6..a7e64adac5 100644
--- a/Makefile
+++ b/Makefile
@@ -207,8 +207,8 @@ HELPERS-$(CONFIG_LINUX) = qemu-bridge-helper$(EXESUF)
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
-DOCS+=docs/qemu-qmp-ref.html docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.7
-DOCS+=docs/qemu-ga-ref.html docs/qemu-ga-ref.txt docs/qemu-ga-ref.7
+DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
+DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
 ifdef CONFIG_VIRTFS
 DOCS+=fsdev/virtfs-proxy-helper.1
 endif
@@ -522,11 +522,12 @@ distclean: clean
 	rm -f qemu-doc.vr qemu-doc.txt
 	rm -f config.log
 	rm -f linux-headers/asm
-	rm -f docs/qemu-ga-qapi.texi docs/qemu-qmp-qapi.texi docs/version.texi
-	rm -f docs/qemu-qmp-ref.7 docs/qemu-ga-ref.7
-	rm -f docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
-	rm -f docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
-	rm -f docs/qemu-qmp-ref.html docs/qemu-ga-ref.html
+	rm -f docs/version.texi
+	rm -f docs/interop/qemu-ga-qapi.texi docs/interop/qemu-qmp-qapi.texi
+	rm -f docs/interop/qemu-qmp-ref.7 docs/interop/qemu-ga-ref.7
+	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
+	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
+	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -565,13 +566,13 @@ install-doc: $(DOCS)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
-	$(INSTALL_DATA) docs/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 ifneq ($(TOOLS),)
 	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
@@ -579,9 +580,9 @@ ifneq ($(TOOLS),)
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 	$(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
-	$(INSTALL_DATA) docs/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
-	$(INSTALL_DATA) docs/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
 endif
 endif
 ifdef CONFIG_VIRTFS
@@ -689,8 +690,12 @@ docs/version.texi: $(SRC_PATH)/VERSION
 %.pdf: %.texi
 	$(call quiet-command,texi2pdf $(TEXIFLAG) -I $(SRC_PATH) -I docs $< -o $@,"GEN","$@")
 
-docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/qemu-ga-ref.txt docs/qemu-ga-ref.pdf docs/qemu-ga-ref.7.pod: docs/version.texi
-docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.pdf docs/qemu-qmp-ref.pod: docs/version.texi
+docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.info \
+    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.pdf \
+    docs/interop/qemu-ga-ref.7.pod: docs/version.texi
+docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.info \
+    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.pdf \
+    docs/interop/qemu-qmp-ref.pod: docs/version.texi
 
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
@@ -704,12 +709,12 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-docs/qemu-qmp-qapi.texi docs/qemu-ga-qapi.texi: $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
+docs/interop/qemu-qmp-qapi.texi docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
 
-docs/qemu-qmp-qapi.texi: $(qapi-modules)
+docs/interop/qemu-qmp-qapi.texi: $(qapi-modules)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
-docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
+docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
@@ -719,21 +724,25 @@ fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 qemu-ga.8: qemu-ga.texi
 
-html: qemu-doc.html docs/qemu-qmp-ref.html docs/qemu-ga-ref.html
-info: qemu-doc.info docs/qemu-qmp-ref.info docs/qemu-ga-ref.info
-pdf: qemu-doc.pdf docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
-txt: qemu-doc.txt docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
+html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
+info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
+pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
+txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
 	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
 	qemu-monitor-info.texi
 
-docs/qemu-ga-ref.dvi docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/qemu-ga-ref.pdf docs/qemu-ga-ref.txt docs/qemu-ga-ref.7: \
-docs/qemu-ga-ref.texi docs/qemu-ga-qapi.texi
+docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
+    docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
+    docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7: \
+	docs/interop/qemu-ga-ref.texi docs/interop/qemu-ga-qapi.texi
 
-docs/qemu-qmp-ref.dvi docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info docs/qemu-qmp-ref.pdf docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.7: \
-docs/qemu-qmp-ref.texi docs/qemu-qmp-qapi.texi
+docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
+    docs/interop/qemu-qmp-ref.info docs/interop/qemu-qmp-ref.pdf \
+    docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
+	docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi
 
 
 ifdef CONFIG_WIN32
diff --git a/configure b/configure
index 71f5612a65..3b574e8ed9 100755
--- a/configure
+++ b/configure
@@ -6364,7 +6364,7 @@ fi
 
 # build tree in object directory in case the source is not in the current directory
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
-DIRS="$DIRS docs fsdev"
+DIRS="$DIRS docs docs/interop fsdev"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
 DIRS="$DIRS qapi-generated"
diff --git a/docs/specs/qcow2.txt b/docs/interop/qcow2.txt
similarity index 100%
rename from docs/specs/qcow2.txt
rename to docs/interop/qcow2.txt
diff --git a/docs/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
similarity index 100%
rename from docs/qemu-ga-ref.texi
rename to docs/interop/qemu-ga-ref.texi
diff --git a/docs/qemu-qmp-ref.texi b/docs/interop/qemu-qmp-ref.texi
similarity index 100%
rename from docs/qemu-qmp-ref.texi
rename to docs/interop/qemu-qmp-ref.texi
diff --git a/docs/qmp-intro.txt b/docs/interop/qmp-intro.txt
similarity index 100%
rename from docs/qmp-intro.txt
rename to docs/interop/qmp-intro.txt
diff --git a/docs/qmp-spec.txt b/docs/interop/qmp-spec.txt
similarity index 100%
rename from docs/qmp-spec.txt
rename to docs/interop/qmp-spec.txt
diff --git a/docs/specs/vhost-user.txt b/docs/interop/vhost-user.txt
similarity index 100%
rename from docs/specs/vhost-user.txt
rename to docs/interop/vhost-user.txt
diff --git a/docs/vnc-ledstate-Pseudo-encoding.txt b/docs/interop/vnc-ledstate-Pseudo-encoding.txt
similarity index 100%
rename from docs/vnc-ledstate-Pseudo-encoding.txt
rename to docs/interop/vnc-ledstate-Pseudo-encoding.txt
-- 
2.13.0
