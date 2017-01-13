Received: from eggs.gnu.org ([2001:4830:134:3::10]:59971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33c-0003kP-7Q
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33X-0006ia-CG
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33X-0006i7-6K
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:15 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EA144A543
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:42:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:34 +0100
Message-Id: <20170113144135.5150-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 20/21] build-sys: add txt documentation rules
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

Build plain text documentation, and install it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore |  1 +
 Makefile   | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3338bdc876..568c4bf9d3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,6 +40,7 @@
 /qmp-marshal.c
 /qemu-doc.html
 /qemu-doc.info
+/qemu-doc.txt
 /qemu-img
 /qemu-nbd
 /qemu-options.def
diff --git a/Makefile b/Makefile
index 4a4a34ed8b..3280da201b 100644
--- a/Makefile
+++ b/Makefile
@@ -81,7 +81,7 @@ Makefile: ;
 configure: ;
=20
 .PHONY: all clean cscope distclean html info install install-doc \
-	pdf recurse-all speed test dist msi FORCE
+	pdf txt recurse-all speed test dist msi FORCE
=20
 $(call set-vpath, $(SRC_PATH))
=20
@@ -90,7 +90,7 @@ LIBS+=3D-lz $(LIBS_TOOLS)
 HELPERS-$(CONFIG_LINUX) =3D qemu-bridge-helper$(EXESUF)
=20
 ifdef BUILD_DOCS
-DOCS=3Dqemu-doc.html qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
+DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
 ifdef CONFIG_VIRTFS
 DOCS+=3Dfsdev/virtfs-proxy-helper.1
 endif
@@ -429,6 +429,7 @@ endif
 install-doc: $(DOCS)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
+	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
 ifdef CONFIG_POSIX
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) qemu.1 "$(DESTDIR)$(mandir)/man1"
@@ -536,6 +537,10 @@ TEXIFLAG=3D$(if $(V),,--quiet)
 %.info: %.texi
 	$(call quiet-command,$(MAKEINFO) $(MAKEINFOFLAGS) $< -o $@,"GEN","$@")
=20
+%.txt: %.texi
+	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
+	--plaintext $< -o $@,"GEN","$@")
+
 %.pdf: %.texi
 	$(call quiet-command,texi2pdf $(TEXIFLAG) -I . $<,"GEN","$@")
=20
@@ -561,6 +566,7 @@ qemu-ga.8: qemu-ga.texi
 html: qemu-doc.html
 info: qemu-doc.info
 pdf: qemu-doc.pdf
+txt: qemu-doc.txt
=20
 qemu-doc.html qemu-doc.info qemu-doc.pdf: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
@@ -659,7 +665,7 @@ help:
 	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
 	@echo  ''
 	@echo  'Documentation targets:'
-	@echo  '  html info pdf'
+	@echo  '  html info pdf txt'
 	@echo  '                  - Build documentation in specified format'
 	@echo  ''
 ifdef CONFIG_WIN32
--=20
2.11.0
