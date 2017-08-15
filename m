Received: from eggs.gnu.org ([2001:4830:134:3::10]:43949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYGv-0002N9-QN
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYGu-0000o4-69
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhYGt-0000nZ-Sr
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D92A0EC53E
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:36:22 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 15 Aug 2017 10:36:04 +0100
Message-Id: <20170815093615.16453-2-berrange@redhat.com>
In-Reply-To: <20170815093615.16453-1-berrange@redhat.com>
References: <20170815093615.16453-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/12] ui: add keycodemapdb repository as a
 GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The https://gitlab.com/keycodemap/keycodemapdb/ repo contains a
data file mapping between all the different scancode/keycode/keysym
sets that are known, and a tool to auto-generate lookup tables for
different combinations.

It is used by GTK-VNC, SPICE-GTK and libvirt for mapping keys.
Using it in QEMU will let us replace many hand written lookup
tables with auto-generated tables from a master data source,
reducing bugs. Adding new QKeyCodes will now only require the
master table to be updated, all ~20 other tables will be
automatically updated to follow.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .gitignore                    |  2 ++
 .gitmodules                   |  3 +++
 configure                     |  2 ++
 tests/docker/Makefile.include | 11 +++++++----
 tests/docker/run              |  4 +++-
 ui/Makefile.objs              | 18 ++++++++++++++++++
 ui/keycodemapdb               |  1 +
 7 files changed, 36 insertions(+), 5 deletions(-)
 create mode 160000 ui/keycodemapdb

diff --git a/.gitignore b/.gitignore
index cf65316863..6e5a1202c8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -14,6 +14,8 @@
 /trace/generated-tcg-tracers.h
 /ui/shader/texture-blit-frag.h
 /ui/shader/texture-blit-vert.h
+/ui/keycodemap_*.c
+/ui/input-keymap-*.c
 *-timestamp
 /*-softmmu
 /*-darwin-user
diff --git a/.gitmodules b/.gitmodules
index 5b0c212622..369989f19e 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -37,3 +37,6 @@
 [submodule "roms/QemuMacDrivers"]
 	path = roms/QemuMacDrivers
 	url = git://git.qemu.org/QemuMacDrivers.git
+[submodule "ui/keycodemapdb"]
+	path = ui/keycodemapdb
+	url = https://gitlab.com/keycodemap/keycodemapdb.git
diff --git a/configure b/configure
index dd73cce62f..bd373ec2b4 100755
--- a/configure
+++ b/configure
@@ -5258,6 +5258,8 @@ echo_version() {
     fi
 }
 
+(cd $source_path && git submodule update --init ui/keycodemapdb)
+
 # prepend pixman and ftd flags after all config tests are done
 QEMU_CFLAGS="$pixman_cflags $fdt_cflags $QEMU_CFLAGS"
 libs_softmmu="$pixman_libs $libs_softmmu"
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index aaab1a4208..2920edb79a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -18,21 +18,24 @@ TESTS ?= %
 IMAGES ?= %
 
 # Make archive from git repo $1 to tar.gz $2
-make-archive-maybe = $(if $(wildcard $1/*), \
-	$(call quiet-command, \
+make-archive = $(call quiet-command, \
 		(cd $1; if git diff-index --quiet HEAD -- &>/dev/null; then \
 			git archive -1 HEAD --format=tar.gz; \
 		else \
 			git archive -1 $$(git stash create) --format=tar.gz; \
 		fi) > $2, \
-		"ARCHIVE","$(notdir $2)"))
+		"ARCHIVE","$(notdir $2)")
+make-archive-maybe = $(if $(wildcard $1/*), \
+	$(call make-archive, $1, $2))
 
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := docker-src.$(CUR_TIME)
 
 $(DOCKER_SRC_COPY):
 	@mkdir $@
-	$(call make-archive-maybe, $(SRC_PATH), $@/qemu.tgz)
+	$(call quiet-command, git submodule update --init $(SRC_PATH)/ui/keycodemapdb, "GIT", "ui/keycodemapdb")
+	$(call make-archive, $(SRC_PATH), $@/qemu.tgz)
+	$(call make-archive, $(SRC_PATH)/ui/keycodemapdb, $@/keycodemapdb.tgz)
 	$(call make-archive-maybe, $(SRC_PATH)/dtc, $@/dtc.tgz)
 	$(call make-archive-maybe, $(SRC_PATH)/pixman, $@/pixman.tgz)
 	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
diff --git a/tests/docker/run b/tests/docker/run
index c1e4513bce..c30352df4a 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -33,13 +33,15 @@ mkdir -p $TEST_DIR/{src,build,install}
 
 # Extract the source tarballs
 tar -C $TEST_DIR/src -xzf $BASE/qemu.tgz
-for p in dtc pixman; do
+for p in dtc pixman ; do
     if test -f $BASE/$p.tgz; then
         tar -C $TEST_DIR/src/$p -xzf $BASE/$p.tgz
         export FEATURES="$FEATURES $p"
     fi
 done
 
+tar -C $TEST_DIR/src/ui/keycodemapdb -xzf $BASE/keycodemapdb.tgz
+
 if test -n "$SHOW_ENV"; then
     if test -f /packages.txt; then
         echo "Packages installed:"
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 3369451285..6796a9f98b 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -49,3 +49,21 @@ gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
+
+KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
+KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
+
+KEYCODEMAP_FILES = \
+		 $(NULL)
+
+GENERATED_FILES += $(KEYCODEMAP_FILES)
+
+ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
+	$(call quiet-command,\
+	    src=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\1,") && \
+	    dst=$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.c$$,\2,") && \
+	    $(PYTHON) $(KEYCODEMAP_GEN) \
+	          --lang glib2 \
+	          --varname qemu_input_map_$${src}_to_$${dst} \
+	          code-map $(KEYCODEMAP_CSV) $${src} $${dst} \
+	        > $@ || rm $@, "GEN", "$@")
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
new file mode 160000
index 0000000000..56ce5650d2
--- /dev/null
+++ b/ui/keycodemapdb
@@ -0,0 +1 @@
+Subproject commit 56ce5650d2c6ea216b4580df44b9a6dd3bc92c3b
-- 
2.13.3
