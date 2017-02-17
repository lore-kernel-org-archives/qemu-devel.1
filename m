Received: from eggs.gnu.org ([2001:4830:134:3::10]:33363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cekCw-0003Bb-5f
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cekCv-0005Vg-2u
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:12:26 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cekCu-0005Ug-SG
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:12:25 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 15:12:20 +0000
Message-Id: <1487344340-30471-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] Makefile: Put VERSION info into version.texi
 rather than using -D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <mlureau@redhat.com>

Unfortunately some older versions of makeinfo don't correctly
handle the -D command line option and fail to set the variable.
This then causes them to complain
 docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSION

Work around this by doing as the autotools do, and writing
the information into a version.texi file which we then
include from the .texi files that need it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile               | 17 ++++++++++-------
 docs/qemu-ga-ref.texi  |  2 ++
 docs/qemu-qmp-ref.texi |  2 ++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 830fa5a..1c4c04f 100644
--- a/Makefile
+++ b/Makefile
@@ -516,7 +516,7 @@ distclean: clean
 	rm -f qemu-doc.vr qemu-doc.txt
 	rm -f config.log
 	rm -f linux-headers/asm
-	rm -f qemu-ga-qapi.texi qemu-qapi.texi
+	rm -f qemu-ga-qapi.texi qemu-qapi.texi version.texi
 	rm -f docs/qemu-qmp-ref.7 docs/qemu-ga-ref.7
 	rm -f docs/qemu-qmp-ref.txt docs/qemu-ga-ref.txt
 	rm -f docs/qemu-qmp-ref.pdf docs/qemu-ga-ref.pdf
@@ -663,21 +663,24 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
 
 # documentation
 MAKEINFO=makeinfo
-MAKEINFOFLAGS=--no-split --number-sections -D 'VERSION $(VERSION)'
-TEXIFLAG=$(if $(V),,--quiet) --command='@set VERSION $(VERSION)'
+MAKEINFOFLAGS=--no-split --number-sections
+TEXIFLAG=$(if $(V),,--quiet)
 
-%.html: %.texi
+version.texi: $(SRC_PATH)/VERSION
+	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
+
+%.html: %.texi version.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
 	--html $< -o $@,"GEN","$@")
 
-%.info: %.texi
+%.info: %.texi version.texi
 	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
 
-%.txt: %.texi
+%.txt: %.texi version.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
 	--plaintext $< -o $@,"GEN","$@")
 
-%.pdf: %.texi
+%.pdf: %.texi version.texi
 	$(call quiet-command,texi2pdf $(TEXIFLAG) -I $(SRC_PATH) -I . $< -o $@,"GEN","$@")
 
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
diff --git a/docs/qemu-ga-ref.texi b/docs/qemu-ga-ref.texi
index 87cc8d0..ddb76ce 100644
--- a/docs/qemu-ga-ref.texi
+++ b/docs/qemu-ga-ref.texi
@@ -1,6 +1,8 @@
 \input texinfo
 @setfilename qemu-ga-ref.info
 
+@include version.texi
+
 @exampleindent 0
 @paragraphindent 0
 
diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
index 818e525..0a00569 100644
--- a/docs/qemu-qmp-ref.texi
+++ b/docs/qemu-qmp-ref.texi
@@ -1,6 +1,8 @@
 \input texinfo
 @setfilename qemu-qmp-ref.info
 
+@include version.texi
+
 @exampleindent 0
 @paragraphindent 0
 
-- 
2.7.4
