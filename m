Received: from eggs.gnu.org ([2001:4830:134:3::10]:44499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXaS-0000Dc-To
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXaQ-0007mR-Jy
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxXaQ-0007lo-BS
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:38 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 28 Sep 2017 13:06:18 +0100
Message-Id: <20170928120621.30288-4-berrange@redhat.com>
In-Reply-To: <20170928120621.30288-1-berrange@redhat.com>
References: <20170928120621.30288-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 3/6] ui: add keycodemapdb repository as a
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
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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
 .gitignore                |  1 +
 .gitmodules               |  3 +++
 configure                 |  8 +++++++-
 scripts/archive-source.sh |  2 +-
 ui/Makefile.objs          | 18 ++++++++++++++++++
 ui/keycodemapdb           |  1 +
 6 files changed, 31 insertions(+), 2 deletions(-)
 create mode 160000 ui/keycodemapdb

diff --git a/.gitignore b/.gitignore
index 06bf972fc3..1eada71afd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -14,6 +14,7 @@
 /trace/generated-tcg-tracers.h
 /ui/shader/texture-blit-frag.h
 /ui/shader/texture-blit-vert.h
+/ui/input-keymap-*.c
 *-timestamp
 /*-softmmu
 /*-darwin-user
diff --git a/.gitmodules b/.gitmodules
index 84c54cdc49..f3bbc01f82 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -34,3 +34,6 @@
 [submodule "roms/QemuMacDrivers"]
 	path = roms/QemuMacDrivers
 	url = git://git.qemu.org/QemuMacDrivers.git
+[submodule "ui/keycodemapdb"]
+	path = ui/keycodemapdb
+	url = https://gitlab.com/keycodemap/keycodemapdb.git
diff --git a/configure b/configure
index ed4048f8b2..1aeb09f83f 100755
--- a/configure
+++ b/configure
@@ -264,7 +264,13 @@ cc_i386=i386-pc-linux-gnu-gcc
 libs_qga=""
 debug_info="yes"
 stack_protector=""
-git_submodules=""
+
+if test -d "$source_path/.git"
+then
+    git_submodules="ui/keycodemapdb"
+else
+    git_submodules=""
+fi
 
 # Don't accept a target_list environment variable.
 unset target_list
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 0c06af0d00..9c789c5d9c 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ vroot_dir="${tar_file}.vroot"
 # independant of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="dtc"
+submodules="dtc ui/keycodemapdb"
 
 if test $? -ne 0; then
     error "git submodule command failed"
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index ec8533d6d9..a930afafe5 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -50,3 +50,21 @@ gtk-egl.o-libs += $(OPENGL_LIBS)
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
+ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs .git-submodule-status
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
2.13.5
