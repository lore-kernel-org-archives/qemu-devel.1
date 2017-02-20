Received: from eggs.gnu.org ([2001:4830:134:3::10]:38259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfo6R-0007ku-Ub
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfo6O-00031v-4y
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cfo6N-0002zK-S4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:04 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Feb 2017 14:33:58 +0100
Message-Id: <1487597638-28323-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487597638-28323-1-git-send-email-armbru@redhat.com>
References: <1487597638-28323-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] Makefile: Put VERSION info into
 version.texi rather than using -D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Unfortunately some older versions of makeinfo don't correctly
handle the -D command line option and fail to set the variable.
This then causes them to complain
 docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSION

Work around this by doing as the autotools do, and writing
the information into a version.texi file which we then
include from the .texi files that need it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1487357968-31000-1-git-send-email-peter.maydell@linaro.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore             |  1 +
 Makefile               | 17 ++++++++++-------
 docs/qemu-ga-ref.texi  |  2 ++
 docs/qemu-qmp-ref.texi |  2 ++
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index c563dc1..2849d75 100644
--- a/.gitignore
+++ b/.gitignore
@@ -107,6 +107,7 @@ docs/qemu-ga-ref.info*
 docs/qemu-qmp-ref.info*
 /qemu-ga-qapi.texi
 /qemu-qapi.texi
+/version.texi
 *.tps
 .stgit-*
 cscope.*
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
=20
 # documentation
 MAKEINFO=3Dmakeinfo
-MAKEINFOFLAGS=3D--no-split --number-sections -D 'VERSION $(VERSION)'
-TEXIFLAG=3D$(if $(V),,--quiet) --command=3D'@set VERSION $(VERSION)'
+MAKEINFOFLAGS=3D--no-split --number-sections
+TEXIFLAG=3D$(if $(V),,--quiet)
=20
-%.html: %.texi
+version.texi: $(SRC_PATH)/VERSION
+	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
+
+%.html: %.texi version.texi
 	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
 	--html $< -o $@,"GEN","$@")
=20
-%.info: %.texi
+%.info: %.texi version.texi
 	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
=20
-%.txt: %.texi
+%.txt: %.texi version.texi
 	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
 	--plaintext $< -o $@,"GEN","$@")
=20
-%.pdf: %.texi
+%.pdf: %.texi version.texi
 	$(call quiet-command,texi2pdf $(TEXIFLAG) -I $(SRC_PATH) -I . $< -o $@,=
"GEN","$@")
=20
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtoo=
l
diff --git a/docs/qemu-ga-ref.texi b/docs/qemu-ga-ref.texi
index 87cc8d0..ddb76ce 100644
--- a/docs/qemu-ga-ref.texi
+++ b/docs/qemu-ga-ref.texi
@@ -1,6 +1,8 @@
 \input texinfo
 @setfilename qemu-ga-ref.info
=20
+@include version.texi
+
 @exampleindent 0
 @paragraphindent 0
=20
diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
index 818e525..0a00569 100644
--- a/docs/qemu-qmp-ref.texi
+++ b/docs/qemu-qmp-ref.texi
@@ -1,6 +1,8 @@
 \input texinfo
 @setfilename qemu-qmp-ref.info
=20
+@include version.texi
+
 @exampleindent 0
 @paragraphindent 0
=20
--=20
2.7.4
