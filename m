Received: from eggs.gnu.org ([2001:4830:134:3::10]:37733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DD-0007OQ-GS
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D9-00078k-VO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5D9-00078Z-Ms
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DED506826
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:43 +0100
Message-Id: <20161222152300.32395-9-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/25] build-sys: remove libtool left-over
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Libtool support was removed in commit e999ee44349, there is a few
left-over.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20161108070513.30274-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore    | 4 ----
 Makefile      | 9 +++------
 Makefile.objs | 1 -
 configure     | 2 --
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3d7848c..e43c304 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,10 +82,6 @@
 *.d
 !/scripts/qemu-guest-agent/fsfreeze-hook.d
 *.o
-*.lo
-*.la
-*.pc
-.libs
 .sdk
 *.gcda
 *.gcno
diff --git a/Makefile b/Makefile
index 474cc5e..214cbad 100644
--- a/Makefile
+++ b/Makefile
@@ -231,12 +231,10 @@ ALL_SUBDIRS=3D$(TARGET_DIRS) $(patsubst %,pc-bios/%=
, $(ROMS))
=20
 recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
=20
-$(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h | $(BUILD_D=
IR)/version.lo
+$(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o=
")
-$(BUILD_DIR)/version.lo: $(SRC_PATH)/version.rc config-host.h
-	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.l=
o")
=20
-Makefile: $(version-obj-y) $(version-lobj-y)
+Makefile: $(version-obj-y)
=20
 ######################################################################
 # Build libraries
@@ -358,10 +356,9 @@ clean:
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h =
gen-op-arm.h
 	rm -f qemu-options.def
 	rm -f *.msi
-	find . \( -name '*.l[oa]' -o -name '*.so' -o -name '*.dll' -o -name '*.=
mo' -o -name '*.[oda]' \) -type f -exec rm {} +
+	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[od=
a]' \) -type f -exec rm {} +
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *=
.pod *~ */*~
 	rm -f fsdev/*.pod
-	rm -rf .libs */.libs
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	@# May not be present in GENERATED_HEADERS
diff --git a/Makefile.objs b/Makefile.objs
index e59b979..51c36a4 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -97,7 +97,6 @@ common-obj-y +=3D disas/
 ######################################################################
 # Resource file for Windows executables
 version-obj-$(CONFIG_WIN32) +=3D $(BUILD_DIR)/version.o
-version-lobj-$(CONFIG_WIN32) +=3D $(BUILD_DIR)/version.lo
=20
 ######################################################################
 # tracing
diff --git a/configure b/configure
index 3770d7c..7dec6cd 100755
--- a/configure
+++ b/configure
@@ -28,8 +28,6 @@ TMPB=3D"qemu-conf"
 TMPC=3D"${TMPDIR1}/${TMPB}.c"
 TMPO=3D"${TMPDIR1}/${TMPB}.o"
 TMPCXX=3D"${TMPDIR1}/${TMPB}.cxx"
-TMPL=3D"${TMPDIR1}/${TMPB}.lo"
-TMPA=3D"${TMPDIR1}/lib${TMPB}.la"
 TMPE=3D"${TMPDIR1}/${TMPB}.exe"
 TMPMO=3D"${TMPDIR1}/${TMPB}.mo"
=20
--=20
2.9.3
