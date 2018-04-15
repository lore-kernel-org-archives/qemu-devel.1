Received: from eggs.gnu.org ([2001:4830:134:3::10]:58213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiL-0007BN-NY
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiK-00034Z-Pa
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:41 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiK-00034J-KQ
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:40 -0400
Received: by mail-qt0-x243.google.com with SMTP id a25so7222703qtm.1
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 16:05:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:05:19 -0300
Message-Id: <20180415230522.24404-2-f4bug@amsat.org>
In-Reply-To: <20180415230522.24404-1-f4bug@amsat.org>
References: <20180415230522.24404-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.12? 1/4] configure: Really use local
 libfdt if the system one is too old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, YunQiang Su <syq@debian.org>

QEMU requires libfdt version >= 1.4.2.
If the host has an older libfdt installed, the configure script will use
a (git cloned) local version.

Example with Debian 8:
    $ dpkg-query --showformat='${Version}\n' --show libfdt-dev
    1.4.0+dfsg-1
    $ ./configure
    [...]
    fdt support       yes          # from git submodule 'dtc'

If this case occurs, the linker will have 2 different libfdt available in
the library search path. The default behavior is to search the system path
first, then the local path.

Even if the configure script noticed the libfdt is too old and clone a more
recent locally, when linking the system library is selected first, and the
link process eventually fails:

      LINK    mips64el-softmmu/qemu-system-mips64el
    ../hw/core/loader-fit.o: In function `load_fit':
    /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:278: undefined reference to `fdt_first_subnode'
    /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:286: undefined reference to `fdt_next_subnode'
    /root/src/github.com/philmd/qemu/hw/core/loader-fit.c:277: undefined reference to `fdt_first_subnode'
    collect2: error: ld returned 1 exit status
    Makefile:201: recipe for target 'qemu-system-mips64el' failed
    make[1]: *** [qemu-system-mips64el] Error 1

QEMU already uses a kludge to enforce local CFLAGS before system ones for
libpixman and libfdt, add a similar kludge for the LDFLAGS to enforce using
the local libfdt.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 6 +++++-
 rules.mak | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 0a19b033bc..162e804b49 100755
--- a/configure
+++ b/configure
@@ -3773,7 +3773,8 @@ EOF
               symlink "$source_path/dtc/scripts" "dtc/scripts"
           fi
           fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
-          fdt_libs="-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
+          fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
+          fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
           error_exit "DTC (libfdt) version >= 1.4.2 not present." \
@@ -5715,6 +5716,7 @@ echo_version() {
 
 # prepend pixman and ftd flags after all config tests are done
 QEMU_CFLAGS="$pixman_cflags $fdt_cflags $QEMU_CFLAGS"
+QEMU_LDFLAGS="$fdt_ldflags $QEMU_LDFLAGS"
 libs_softmmu="$pixman_libs $libs_softmmu"
 
 echo "Install prefix    $prefix"
@@ -5745,6 +5747,7 @@ echo "ARFLAGS           $ARFLAGS"
 echo "CFLAGS            $CFLAGS"
 echo "QEMU_CFLAGS       $QEMU_CFLAGS"
 echo "LDFLAGS           $LDFLAGS"
+echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
 echo "python            $python"
@@ -6679,6 +6682,7 @@ else
 fi
 echo "LDFLAGS=$LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
+echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
 echo "LD_REL_FLAGS=$LD_REL_FLAGS" >> $config_host_mak
 echo "LD_I386_EMULATION=$ld_i386_emulation" >> $config_host_mak
 echo "LIBS+=$LIBS" >> $config_host_mak
diff --git a/rules.mak b/rules.mak
index 93a07027b0..04c7f74d07 100644
--- a/rules.mak
+++ b/rules.mak
@@ -73,7 +73,7 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
 # must link with the C++ compiler, not the plain C compiler.
 LINKPROG = $(or $(CXX),$(CC))
 
-LINK = $(call quiet-command, $(LINKPROG) $(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ \
+LINK = $(call quiet-command, $(LINKPROG) $(QEMU_LDFLAGS) $(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ \
        $(call process-archive-undefs, $1) \
        $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
 
-- 
2.17.0
