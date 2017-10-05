Received: from eggs.gnu.org ([2001:4830:134:3::10]:38687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e02xx-00054u-CR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e02xt-0005Pj-4i
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:01:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e02xs-0005O9-T9
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:01:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5CC37F402
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 10:01:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  5 Oct 2017 12:01:03 +0200
Message-Id: <20171005100106.30118-4-kraxel@redhat.com>
In-Reply-To: <20171005100106.30118-1-kraxel@redhat.com>
References: <20171005100106.30118-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] ui: add keycodemapdb repository as a GIT
 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

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
Message-id: 20170929101201.21039-4-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure                 |  8 +++++++-
 Makefile                  | 18 ++++++++++++++++++
 .gitignore                |  1 +
 .gitmodules               |  3 +++
 scripts/archive-source.sh |  2 +-
 ui/keycodemapdb           |  1 +
 6 files changed, 31 insertions(+), 2 deletions(-)
 create mode 160000 ui/keycodemapdb

diff --git a/configure b/configure
index 38f1710c80..06f18ea9af 100755
--- a/configure
+++ b/configure
@@ -264,7 +264,13 @@ cc_i386=i386-pc-linux-gnu-gcc
 libs_qga=""
 debug_info="yes"
 stack_protector=""
-git_submodules=""
+
+if test -e "$source_path/.git"
+then
+    git_submodules="ui/keycodemapdb"
+else
+    git_submodules=""
+fi
 
 # Don't accept a target_list environment variable.
 unset target_list
diff --git a/Makefile b/Makefile
index cec0f44374..d2bada4d8b 100644
--- a/Makefile
+++ b/Makefile
@@ -214,6 +214,24 @@ trace-dtrace-root.h: trace-dtrace-root.dtrace
 
 trace-dtrace-root.o: trace-dtrace-root.dtrace
 
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
+
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
diff --git a/.gitignore b/.gitignore
index b5e115d96b..620eec6b47 100644
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
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 4029de7b20..4e63774f9a 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ vroot_dir="${tar_file}.vroot"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="dtc"
+submodules="dtc ui/keycodemapdb"
 
 trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
 
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
new file mode 160000
index 0000000000..56ce5650d2
--- /dev/null
+++ b/ui/keycodemapdb
@@ -0,0 +1 @@
+Subproject commit 56ce5650d2c6ea216b4580df44b9a6dd3bc92c3b
-- 
2.9.3
