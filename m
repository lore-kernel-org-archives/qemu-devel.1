Received: from eggs.gnu.org ([2001:4830:134:3::10]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtT-00067d-KZ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtO-00071L-Vl
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtO-000709-Ny
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF50015561
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FB0617BBD
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:25 +0100
Message-Id: <1489645685-4750-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 09/49] qapi: Clean up build of generated
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rename intermediate qemu-qapi.texi to qemu-qmp-qapi.texi to match its
user qemu-qmp-ref.texi, just like qemu-ga-qapi.texi matches
qemu-ga-ref.texi.

Build the intermediate .texi next to the sources and the final output
in docs/ instead of dumping them into the build root.

Fix version.texi dependencies so that only the targets that actually
need it depend on it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-8-git-send-email-armbru@redhat.com>
---
 .gitignore             | 10 +++++-----
 Makefile               | 27 +++++++++++++++------------
 docs/qemu-qmp-ref.texi |  2 +-
 rules.mak              |  2 +-
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2849d75..55a001e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -99,15 +99,15 @@
 /pc-bios/optionrom/kvmvapic.img
 /pc-bios/s390-ccw/s390-ccw.elf
 /pc-bios/s390-ccw/s390-ccw.img
+/docs/qemu-ga-qapi.texi
 /docs/qemu-ga-ref.html
+/docs/qemu-ga-ref.info*
 /docs/qemu-ga-ref.txt
+/docs/qemu-qmp-qapi.texi
 /docs/qemu-qmp-ref.html
+/docs/qemu-qmp-ref.info*
 /docs/qemu-qmp-ref.txt
-docs/qemu-ga-ref.info*
-docs/qemu-qmp-ref.info*
-/qemu-ga-qapi.texi
-/qemu-qapi.texi
-/version.texi
+/docs/version.texi
 *.tps
 .stgit-*
 cscope.*
diff --git a/Makefile b/Makefile
index 1c4c04f..35d32ee 100644
--- a/Makefile
+++ b/Makefile
@@ -516,7 +516,7 @@ distclean: clean
 	rm -f qemu-doc.vr qemu-doc.txt
 	rm -f config.log
 	rm -f linux-headers/asm
-	rm -f qemu-ga-qapi.texi qemu-qapi.texi version.texi
+	rm -f docs/qemu-ga-qapi.texi docs/qemu-qmp-qapi.texi docs/version.texi
 	rm -f docs/qemu-qmp-ref.7 docs/qemu-ga-ref.7
 	rm -f docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
 	rm -f docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
@@ -663,25 +663,28 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
 
 # documentation
 MAKEINFO=makeinfo
-MAKEINFOFLAGS=--no-split --number-sections
+MAKEINFOFLAGS=--no-split --number-sections -I docs
 TEXIFLAG=$(if $(V),,--quiet)
 
-version.texi: $(SRC_PATH)/VERSION
+docs/version.texi: $(SRC_PATH)/VERSION
 	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
 
-%.html: %.texi version.texi
+%.html: %.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
 	--html $< -o $@,"GEN","$@")
 
-%.info: %.texi version.texi
+%.info: %.texi
 	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
 
-%.txt: %.texi version.texi
+%.txt: %.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
 	--plaintext $< -o $@,"GEN","$@")
 
-%.pdf: %.texi version.texi
-	$(call quiet-command,texi2pdf $(TEXIFLAG) -I $(SRC_PATH) -I . $< -o $@,"GEN","$@")
+%.pdf: %.texi
+	$(call quiet-command,texi2pdf $(TEXIFLAG) -I $(SRC_PATH) -I docs $< -o $@,"GEN","$@")
+
+docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/qemu-ga-ref.txt docs/qemu-ga-ref.pdf docs/qemu-ga-ref.7.pod: docs/version.texi
+docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.pdf docs/qemu-qmp-ref.pod: docs/version.texi
 
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
@@ -695,10 +698,10 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-qemu-qapi.texi: $(qapi-modules) $(qapi-py)
+docs/qemu-qmp-qapi.texi: $(qapi-modules) $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
-qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
+docs/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
@@ -719,10 +722,10 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-monitor-info.texi
 
 docs/qemu-ga-ref.dvi docs/qemu-ga-ref.html docs/qemu-ga-ref.info docs/qemu-ga-ref.pdf docs/qemu-ga-ref.txt docs/qemu-ga-ref.7: \
-docs/qemu-ga-ref.texi qemu-ga-qapi.texi
+docs/qemu-ga-ref.texi docs/qemu-ga-qapi.texi
 
 docs/qemu-qmp-ref.dvi docs/qemu-qmp-ref.html docs/qemu-qmp-ref.info docs/qemu-qmp-ref.pdf docs/qemu-qmp-ref.txt docs/qemu-qmp-ref.7: \
-docs/qemu-qmp-ref.texi qemu-qapi.texi
+docs/qemu-qmp-ref.texi docs/qemu-qmp-qapi.texi
 
 
 ifdef CONFIG_WIN32
diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
index 0a00569..bb25758 100644
--- a/docs/qemu-qmp-ref.texi
+++ b/docs/qemu-qmp-ref.texi
@@ -65,7 +65,7 @@ along with this manual.  If not, see http://www.gnu.org/licenses/.
 @c for texi2pod:
 @c man begin DESCRIPTION
 
-@include qemu-qapi.texi
+@include qemu-qmp-qapi.texi
 
 @c man end
 
diff --git a/rules.mak b/rules.mak
index 83d6dd1..1c0eabb 100644
--- a/rules.mak
+++ b/rules.mak
@@ -380,7 +380,7 @@ define unnest-vars
 endef
 
 TEXI2MAN = $(call quiet-command, \
-	perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl $< $@.pod && \
+	perl -Ww -- $(SRC_PATH)/scripts/texi2pod.pl -I docs $< $@.pod && \
 	$(POD2MAN) --section=$(subst .,,$(suffix $@)) --center=" " --release=" " $@.pod > $@, \
 	"GEN","$@")
 
-- 
2.7.4
