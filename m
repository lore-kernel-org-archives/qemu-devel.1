Received: from eggs.gnu.org ([2001:4830:134:3::10]:46556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb2U-0002GF-OO
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb2T-0003NS-1Q
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:35:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cQb2S-0003N0-Pw
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:35:08 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0239681226
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 14:35:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  9 Jan 2017 15:34:37 +0100
Message-Id: <20170109143437.30554-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170109143437.30554-1-marcandre.lureau@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 21/21] build-sys: add qapi doc generation
 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Generate and install the man, txt and html versions of QAPI
documentation (generate and install qemu-doc.txt too).

Add it also to optional pdf/info targets.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 .gitignore         |  9 +++++++++
 Makefile           | 43 ++++++++++++++++++++++++++++++++++++-------
 configure          |  2 +-
 docs/qmp-intro.txt |  3 +--
 rules.mak          |  2 ++
 5 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index e16bddc070..511527bd8a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -109,6 +109,15 @@
 /pc-bios/optionrom/kvmvapic.img
 /pc-bios/s390-ccw/s390-ccw.elf
 /pc-bios/s390-ccw/s390-ccw.img
+/docs/qemu-ga-ref.html
+/docs/qemu-ga-ref.txt
+/docs/qemu-qmp-ref.html
+/docs/qemu-qmp-ref.txt
+docs/qemu-ga-ref.info*
+docs/qemu-qmp-ref.info*
+/qemu-ga-qapi.texi
+/qemu-qapi.texi
+*.tps
 .stgit-*
 cscope.*
 tags
diff --git a/Makefile b/Makefile
index 37d45ee21b..3597e95d28 100644
--- a/Makefile
+++ b/Makefile
@@ -91,6 +91,8 @@ HELPERS-$(CONFIG_LINUX) =3D qemu-bridge-helper$(EXESUF)
=20
 ifdef BUILD_DOCS
 DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
+DOCS+=3Ddocs/qemu-qmp-ref.html docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.7
+DOCS+=3Ddocs/qemu-ga-ref.html docs/qemu-ga-ref.txt docs/qemu-ga-ref.7
 ifdef CONFIG_VIRTFS
 DOCS+=3Dfsdev/virtfs-proxy-helper.1
 endif
@@ -266,6 +268,7 @@ qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-genera=
ted
 gen-out-type =3D $(subst .,-,$(suffix $@))
=20
 qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
+qapi-py +=3D $(SRC_PATH)/scripts/qapi2texi.py
=20
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
:\
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qap=
i-py)
@@ -395,6 +398,11 @@ distclean: clean
 	rm -f qemu-doc.vr
 	rm -f config.log
 	rm -f linux-headers/asm
+	rm -f qemu-ga-qapi.texi qemu-qapi.texi
+	rm -f docs/qemu-qmp-ref.7 docs/qemu-ga-ref.7
+	rm -f docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
+	rm -f docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
+	rm -f docs/qemu-qmp-ref.html docs/qemu-ga-ref.html
 	for d in $(TARGET_DIRS); do \
 	rm -rf $$d || exit 1 ; \
         done
@@ -432,9 +440,13 @@ install-doc: $(DOCS)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
+	$(INSTALL_DATA) docs/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 ifneq ($(TOOLS),)
 	$(INSTALL_DATA) qemu-img.1 "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
@@ -442,6 +454,9 @@ ifneq ($(TOOLS),)
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 	$(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
+	$(INSTALL_DATA) docs/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) docs/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
 endif
 endif
 ifdef CONFIG_VIRTFS
@@ -529,9 +544,10 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
 	ui/shader/texture-blit-vert.h ui/shader/texture-blit-frag.h
=20
 # documentation
-MAKEINFO=3Dmakeinfo
+MAKEINFO=3Dmakeinfo -D 'VERSION $(VERSION)'
 MAKEINFOFLAGS=3D--no-split --number-sections
-TEXIFLAG=3D$(if $(V),,--quiet)
+TEXIFLAG=3D$(if $(V),,--quiet) --command=3D'@set VERSION $(VERSION)'
+
 %.html: %.texi
 	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
 	--html $< -o $@,"GEN","$@")
@@ -544,7 +560,7 @@ TEXIFLAG=3D$(if $(V),,--quiet)
 	--plaintext $< -o $@,"GEN   $@")
=20
 %.pdf: %.texi
-	$(call quiet-command,texi2pdf $(TEXIFLAG) -I . $<,"GEN","$@")
+	$(call quiet-command,texi2pdf $(TEXIFLAG) -I $(SRC_PATH) -I . $< -o $@,=
"GEN","$@")
=20
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtoo=
l
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")
@@ -558,6 +574,12 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-inf=
o.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxt=
ool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")
=20
+qemu-qapi.texi: $(qapi-modules) $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN" "$@")
+
+qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
+
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
 qemu.1: qemu-option-trace.texi
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
@@ -565,16 +587,23 @@ fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-hel=
per.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 qemu-ga.8: qemu-ga.texi
=20
-html: qemu-doc.html
-info: qemu-doc.info
-pdf: qemu-doc.pdf
-txt: qemu-doc.txt
+html: qemu-doc.html docs/qemu-qmp-ref.html docs/qemu-ga-ref.html
+info: qemu-doc.info docs/qemu-qmp-ref.info docs/qemu-ga-ref.info
+pdf: qemu-doc.pdf docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
+txt: qemu-doc.txt docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
=20
 qemu-doc.html qemu-doc.info qemu-doc.pdf: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
 	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
 	qemu-monitor-info.texi
=20
+docs/qemu-ga-ref.dvi docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/qe=
mu-ga-ref.pdf docs/qemu-ga-ref.txt docs/qemu-ga-ref.7: \
+docs/qemu-ga-ref.texi qemu-ga-qapi.texi
+
+docs/qemu-qmp-ref.dvi docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info docs=
/qemu-qmp-ref.pdf docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.7: \
+docs/qemu-qmp-ref.texi qemu-qapi.texi
+
+
 ifdef CONFIG_WIN32
=20
 INSTALLER =3D qemu-setup-$(VERSION)$(EXESUF)
diff --git a/configure b/configure
index 3770d7c263..b2ae46e464 100755
--- a/configure
+++ b/configure
@@ -6183,7 +6183,7 @@ fi
=20
 # build tree in object directory in case the source is not in the curren=
t directory
 DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests=
/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
-DIRS=3D"$DIRS fsdev"
+DIRS=3D"$DIRS docs fsdev"
 DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS=3D"$DIRS roms/seabios roms/vgabios"
 DIRS=3D"$DIRS qapi-generated"
diff --git a/docs/qmp-intro.txt b/docs/qmp-intro.txt
index f6a3a031e9..60deafbae6 100644
--- a/docs/qmp-intro.txt
+++ b/docs/qmp-intro.txt
@@ -16,8 +16,7 @@ QMP is JSON[1] based and features the following:
 For detailed information on QMP's usage, please, refer to the following =
files:
=20
 o qmp-spec.txt      QEMU Machine Protocol current specification
-o qmp-commands.txt  QMP supported commands (auto-generated at build-time=
)
-o qmp-events.txt    List of available asynchronous events
+o qemu-qmp-ref.html QEMU QMP commands and events (auto-generated at buil=
d-time)
=20
 [1] http://www.json.org
=20
diff --git a/rules.mak b/rules.mak
index c9739961a7..73de30c7b3 100644
--- a/rules.mak
+++ b/rules.mak
@@ -369,5 +369,7 @@ TEXI2MAN =3D $(call quiet-command, \
=20
 %.1:
 	$(call TEXI2MAN)
+%.7:
+	$(call TEXI2MAN)
 %.8:
 	$(call TEXI2MAN)
--=20
2.11.0
