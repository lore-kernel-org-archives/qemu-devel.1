Received: from eggs.gnu.org ([2001:4830:134:3::10]:59880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33V-0003de-2m
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33U-0006gN-6F
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33U-0006fs-0U
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:42:12 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C2F43D945
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:42:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:32 +0100
Message-Id: <20170113144135.5150-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 18/21] build-sys: remove dvi doc generation
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

There is no clear reason to have rules to generate dvi format
documentation, pdf is generally better supported nowadays.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 .gitignore |  1 -
 Makefile   | 12 ++++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/.gitignore b/.gitignore
index e43c3044dc..3338bdc876 100644
--- a/.gitignore
+++ b/.gitignore
@@ -60,7 +60,6 @@
 *.a
 *.aux
 *.cp
-*.dvi
 *.exe
 *.msi
 *.dll
diff --git a/Makefile b/Makefile
index 82ee20150a..1d6a31deb3 100644
--- a/Makefile
+++ b/Makefile
@@ -80,7 +80,7 @@ GENERATED_HEADERS +=3D module_block.h
 Makefile: ;
 configure: ;
=20
-.PHONY: all clean cscope distclean dvi html info install install-doc \
+.PHONY: all clean cscope distclean html info install install-doc \
 	pdf recurse-all speed test dist msi FORCE
=20
 $(call set-vpath, $(SRC_PATH))
@@ -387,7 +387,7 @@ distclean: clean
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
-	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps qemu-doc.dvi
+	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
 	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
 	rm -f qemu-doc.vr
@@ -529,9 +529,6 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
 MAKEINFO=3Dmakeinfo
 MAKEINFOFLAGS=3D--no-split --number-sections
 TEXIFLAG=3D$(if $(V),,--quiet)
-%.dvi: %.texi
-	$(call quiet-command,texi2dvi $(TEXIFLAG) -I . $<,"GEN","$@")
-
 %.html: %.texi
 	$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
 	--html $< -o $@,"GEN","$@")
@@ -585,12 +582,11 @@ qemu-ga.8: qemu-ga.texi
 	  $(POD2MAN) --section=3D8 --center=3D" " --release=3D" " qemu-ga.pod >=
 $@, \
 	  "GEN","$@")
=20
-dvi: qemu-doc.dvi
 html: qemu-doc.html
 info: qemu-doc.info
 pdf: qemu-doc.pdf
=20
-qemu-doc.dvi qemu-doc.html qemu-doc.info qemu-doc.pdf: \
+qemu-doc.html qemu-doc.info qemu-doc.pdf: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
 	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
 	qemu-monitor-info.texi
@@ -687,7 +683,7 @@ help:
 	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
 	@echo  ''
 	@echo  'Documentation targets:'
-	@echo  '  dvi html info pdf'
+	@echo  '  html info pdf'
 	@echo  '                  - Build documentation in specified format'
 	@echo  ''
 ifdef CONFIG_WIN32
--=20
2.11.0
