Received: from eggs.gnu.org ([2001:4830:134:3::10]:41945)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1drSWA-00075t-QJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1drSW9-000625-NV
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:29:06 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Mon, 11 Sep 2017 19:16:39 +0200
Message-Id: <20170911171639.22005-1-n54@gmx.com>
In-Reply-To: <20170903164952.26760-1-n54@gmx.com>
References: <20170903164952.26760-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH v2] Discover openpty(3) dynamically in configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, jperkin@joyent.com, peter.maydell@linaro.org, Kamil Rytarowski <n54@gmx.com>

openpty(3) might:
 - exists in libc (OSX)
 - exists in libutil (GNU, BSD)
 - does not exist (SmartOS)

Add a function to discover this function in the ./configure script.
Add new config types: CONFIG_OPENPTY_LIBC and CONFIG_OPENPTY_LIBUTIL,
respectively defined when openpts(3) links with -lc or -lutil.

Replace the condition adding -lutil in tests (for openpty(3)) from
CONFIG_POSIX to CONFIG_OPENPTY_LIBUTIL.

Replace the fallback openpty(3) impelementation comment from Solaris
to SmartOS. Solaris is EOL'ed and it's confirmed that it does not work
on Oracle Solaris.
---
 configure              | 25 +++++++++++++++++++++++++
 tests/Makefile.include |  2 +-
 util/qemu-openpty.c    |  4 ++--
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index fd7e3a5e81..a614adcd29 100755
--- a/configure
+++ b/configure
@@ -3819,6 +3819,25 @@ EOF
   fi
 fi
 
+##########################################
+# openpty probe
+openpty_libc=no
+openpty_libutil=no
+cat > $TMPC << EOF
+extern int openpty(int *amaster, int *aslave, char *name, void *termp, void *winp);
+
+int main(void)
+{
+    int master_fd, slave_fd;
+    return openpty(&master_fd, &slave_fd, 0, 0, 0) == 0;
+}
+EOF
+if compile_prog "" "" ; then
+  openpty_libc=yes
+elif compile_prog "" "-lutil" ; then
+  openpty_libutil=yes
+fi
+
 ##########################################
 # signalfd probe
 signalfd="no"
@@ -5788,6 +5807,12 @@ fi
 if test "$fdt" = "yes" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
 fi
+if test "$openpty_libc" = "yes" ; then
+  echo "CONFIG_OPENPTY_LIBC=y" >> $config_host_mak
+fi
+if test "$openpty_libutil" = "yes" ; then
+  echo "CONFIG_OPENPTY_LIBUTIL=y" >> $config_host_mak
+fi
 if test "$signalfd" = "yes" ; then
   echo "CONFIG_SIGNALFD=y" >> $config_host_mak
 fi
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715e9c..e7e0bc2724 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -814,7 +814,7 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
 	rm $(INITRD_WORK_DIR)/init
 	rmdir $(INITRD_WORK_DIR)
 
-ifeq ($(CONFIG_POSIX),y)
+ifeq ($(CONFIG_OPENPTY_LIBUTIL),y)
 LIBS += -lutil
 endif
 
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index 2e8b43bdf5..62c87e5563 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -51,8 +51,8 @@
 # include <termios.h>
 #endif
 
-#ifdef __sun__
-/* Once Solaris has openpty(), this is going to be removed. */
+/* The fallback implementation is needed at least on SmartOS. */
+#if !defined(CONFIG_OPENPTY_LIBC) && !defined(CONFIG_OPENPTY_LIBUTIL)
 static int openpty(int *amaster, int *aslave, char *name,
                    struct termios *termp, struct winsize *winp)
 {
-- 
2.14.1
