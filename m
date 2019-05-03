Received: from eggs.gnu.org ([209.51.188.92]:59534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWE7-0008Ew-1W
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWE5-0001Mi-Qq
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:39 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  3 May 2019 13:18:24 +0200
Message-Id: <20190503111832.30316-5-laurent@vivier.eu>
In-Reply-To: <20190503111832.30316-1-laurent@vivier.eu>
References: <20190503111832.30316-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 04/12] doc: fix the configuration path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use a CONFDIR variable to show the configured sysconf path in the
generated documentations (html, man pages etc).

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=1644985

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181126105125.30973-1-marcandre.lureau@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-ga.texi | 4 ++--
 Makefile     | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/qemu-ga.texi b/qemu-ga.texi
index 4c7a8fd16329..f00ad830f283 100644
--- a/qemu-ga.texi
+++ b/qemu-ga.texi
@@ -30,7 +30,7 @@ set user's password
 @end itemize
 
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
+  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, do
   not follow -F with a space (for example:
   @samp{-F/var/run/fsfreezehook.sh}).
 
diff --git a/Makefile b/Makefile
index 1211e78c91ed..43a7a047b452 100644
--- a/Makefile
+++ b/Makefile
@@ -899,11 +899,14 @@ ui/shader.o: $(SRC_PATH)/ui/shader.c \
 MAKEINFO=makeinfo
 MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
 MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
-TEXI2PODFLAGS=$(MAKEINFOINCLUDES) "-DVERSION=$(VERSION)"
+TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
 TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
 
-docs/version.texi: $(SRC_PATH)/VERSION
-	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
+docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
+	$(call quiet-command,(\
+		echo "@set VERSION $(VERSION)" && \
+		echo "@set CONFDIR $(qemu_confdir)" \
+	)> $@,"GEN","$@")
 
 %.html: %.texi docs/version.texi
 	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
-- 
2.20.1
