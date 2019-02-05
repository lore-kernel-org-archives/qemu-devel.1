Received: from eggs.gnu.org ([209.51.188.92]:35909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GJ-0002Lk-Mq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GG-0003ks-Jz
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:59 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GG-0003X1-2V
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:56 -0500
Received: by mail-wr1-x436.google.com with SMTP id v16so2844396wrn.11
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:15:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:19 +0100
Message-Id: <1549390526-24246-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/76] configure: Add a proper check for
 openpty() in libutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

On Linux (and maybe some BSDs), we require libutil for the openpty()
function. However, this library is not available on some other systems, so
we currently use a fragile if-statement in the configure script to check
whether we need the library or not. Unfortunately, we also hard-coded a
"-lutil" in the tests/Makefile.include file, so this breaks the build on
Solaris, for example (see buglink below). To fix the issue, add the "-lutil"
to "libs_tools" in the configure script instead, then this gets properly
propagated to the tests, too.
And while we're at it, also replace the fragile if-statement in the confi-
gure script with a proper link-check for the availability of this function.

Buglink: https://bugs.launchpad.net/qemu/+bug/1777252
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              | 12 ++++++++++--
 tests/Makefile.include |  4 ----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 3d89870..f6a51e0 100755
--- a/configure
+++ b/configure
@@ -4612,9 +4612,17 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
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
index 75ad9c0..b39e989 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -798,10 +798,6 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
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
