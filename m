Received: from eggs.gnu.org ([2001:4830:134:3::10]:41591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoC-0003kK-BF
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpoA-0005i2-83
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfpo9-0005hj-OX
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8019E77935
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 15:55:36 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 16:55:08 +0100
Message-Id: <20170810155522.31099-2-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-1-berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 01/15] ui: add keycodemapdb repository as a GIT
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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
 .gitignore       |  2 ++
 .gitmodules      |  3 +++
 ui/Makefile.objs | 18 ++++++++++++++++++
 ui/keycodemapdb  |  1 +
 4 files changed, 24 insertions(+)
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
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 3369451285..d94d1ca183 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -49,3 +49,21 @@ gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
+
+KEYCODEMAP_GEN = ui/keycodemapdb/tools/keymap-gen
+KEYCODEMAP_CSV = ui/keycodemapdb/data/keymaps.csv
+
+KEYCODEMAP_FILES = \
+		 $(NULL)
+
+GENERATED_FILES += $(KEYCODEMAP_FILES)
+
+ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) ui/Makefile.objs
+	$(call quiet-command,\
+	    $(PYTHON) $(KEYCODEMAP_GEN) \
+	          --lang glib2 \
+	          --varname qemu_input_map_$$(echo $@ | sed -e "s,^ui/input-keymap-,," -e "s,\.c$$,,") \
+	          code-map $(KEYCODEMAP_CSV) \
+	          $$(echo $@ | sed -E -e "s,^ui/input-keymap-([a-zA-Z0-9]+)2([a-zA-Z0-9]+)\.c$$,\1,") \
+	          $$(echo $@ | sed -E -e "s,^ui/input-keymap-([a-zA-Z0-9]+)2([a-zA-Z0-9]+)\.c$$,\2,") \
+	        > $@ || rm $@, "GEN", "$@")
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
new file mode 160000
index 0000000000..aed87bb2aa
--- /dev/null
+++ b/ui/keycodemapdb
@@ -0,0 +1 @@
+Subproject commit aed87bb2aa6ed83b49574eb982e3bdd4c36acf17
-- 
2.13.3
