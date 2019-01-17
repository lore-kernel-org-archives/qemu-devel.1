Received: from eggs.gnu.org ([209.51.188.92]:36819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkBFA-0001d5-0K
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkBF9-0006nR-5z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gkBF8-0006jn-S7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:15 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Jan 2019 18:14:08 +0100
Message-Id: <1547745248-1750-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Add a proper check for openpty() in
 libutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Linux (and maybe some BSDs), we require libutil for the openpty()
function. However, this library is not available on some other systems, so
we currently use a fragile if-statement in the configure script to check
whether we need the library or not. Unfortunately, we also hard-coded a
"-lutil" in the tests/Makefile.include file, so this breaks the build on
Solaris, for example (see buglink below). To fix the issue, add the "-lutil"
to "libs_tools" in the configure script instead, then this gets properly
propagated to the tests, too.
And while we're at it, also replace the fragile if-statement in the confi-
gure script with a proper link-check for the availablity of this function.

Buglink: https://bugs.launchpad.net/qemu/+bug/1777252
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure              | 12 ++++++++++--
 tests/Makefile.include |  4 ----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 3c28bae..0f4e42a 100755
--- a/configure
+++ b/configure
@@ -4595,9 +4595,17 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
   libs_qga="$libs_qga -lrt"
 fi
 
-if test "$darwin" != "yes" -a "$mingw32" != "yes" -a "$solaris" != yes -a \
-        "$haiku" != "yes" ; then
+# Check whether we need to link libutil for openpty()
+cat > $TMPC << EOF
+extern int openpty(int *am, int *as, char *name, void *termp, void *winp);
+int main(void) { return openpty(0, 0, 0, 0, 0); }
+EOF
+
+if ! compile_prog "" "" ; then
+  if compile_prog "" "-lutil" ; then
     libs_softmmu="-lutil $libs_softmmu"
+    libs_tools="-lutil $libs_tools"
+  fi
 fi
 
 ##########################################
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f403a65..8f8e3b4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -793,10 +793,6 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
 	rm $(INITRD_WORK_DIR)/init
 	rmdir $(INITRD_WORK_DIR)
 
-ifeq ($(CONFIG_POSIX),y)
-LIBS += -lutil
-endif
-
 # QTest rules
 
 TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
-- 
1.8.3.1
