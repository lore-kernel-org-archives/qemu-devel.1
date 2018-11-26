Received: from eggs.gnu.org ([208.118.235.92]:50684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gREUb-0005IY-DK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gREUV-0000hR-Im
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:51:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gREUR-0000cO-PP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:51:45 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Nov 2018 14:51:25 +0400
Message-Id: <20181126105125.30973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] doc: fix the configuration path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Use a CONFDIR variable to show the configured sysconf path in the
generated documentations (html, man pages etc).

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1644985

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile     | 9 ++++++---
 qemu-ga.texi | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 9cc4dae1a6..a39c231d1c 100644
--- a/Makefile
+++ b/Makefile
@@ -932,11 +932,14 @@ ui/shader.o: $(SRC_PATH)/ui/shader.c \
 MAKEINFO=3Dmakeinfo
 MAKEINFOINCLUDES=3D -I docs -I $(<D) -I $(@D)
 MAKEINFOFLAGS=3D--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=3D$(MAKEINFOINCLUDES) "-DVERSION=3D$(VERSION)"
+TEXI2PODFLAGS=3D$(MAKEINFOINCLUDES) -DVERSION=3D"$(VERSION)" -DCONFDIR=3D=
"$(qemu_confdir)"
 TEXI2PDFFLAGS=3D$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
=20
-docs/version.texi: $(SRC_PATH)/VERSION
-	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
+docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
+	$(call quiet-command,(\
+		echo "@set VERSION $(VERSION)" && \
+		echo "@set CONFDIR $(qemu_confdir)" \
+	)> $@,"GEN","$@")
=20
 %.html: %.texi docs/version.texi
 	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
diff --git a/qemu-ga.texi b/qemu-ga.texi
index 4c7a8fd163..f00ad830f2 100644
--- a/qemu-ga.texi
+++ b/qemu-ga.texi
@@ -30,7 +30,7 @@ set user's password
 @end itemize
=20
 qemu-ga will read a system configuration file on startup (located at
-@file{/etc/qemu/qemu-ga.conf} by default), then parse remaining
+@file{@value{CONFDIR}/qemu-ga.conf} by default), then parse remaining
 configuration options on the command line. For the same key, the last
 option wins, but the lists accumulate (see below for configuration
 file format).
@@ -58,7 +58,7 @@ file format).
   Enable fsfreeze hook. Accepts an optional argument that specifies
   script to run on freeze/thaw. Script will be called with
   'freeze'/'thaw' arguments accordingly (default is
-  @samp{/etc/qemu/fsfreeze-hook}). If using -F with an argument, do
+  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, d=
o
   not follow -F with a space (for example:
   @samp{-F/var/run/fsfreezehook.sh}).
=20
--=20
2.20.0.rc1
