Received: from eggs.gnu.org ([2001:4830:134:3::10]:41604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtG-0003H4-5c
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtE-0001bM-LT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:22 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAtE-0001ad-Fh
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:20 -0400
Received: by mail-wm0-x244.google.com with SMTP id a67so21143935wmf.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:42 +0200
Message-Id: <1525817687-34620-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/30] configure: Really use local libfdt if the
 system one is too old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Message-Id: <20180415230522.24404-2-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 configure | 6 +++++-
 rules.mak | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 3ff4d77..43756dc 100755
--- a/configure
+++ b/configure
@@ -3800,7 +3800,8 @@ EOF
               symlink "$source_path/dtc/scripts" "dtc/scripts"
           fi
           fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
-          fdt_libs="-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
+          fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
+          fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
           error_exit "DTC (libfdt) version >= 1.4.2 not present." \
@@ -5742,6 +5743,7 @@ echo_version() {
 
 # prepend pixman and ftd flags after all config tests are done
 QEMU_CFLAGS="$pixman_cflags $fdt_cflags $QEMU_CFLAGS"
+QEMU_LDFLAGS="$fdt_ldflags $QEMU_LDFLAGS"
 libs_softmmu="$pixman_libs $libs_softmmu"
 
 echo "Install prefix    $prefix"
@@ -5772,6 +5774,7 @@ echo "ARFLAGS           $ARFLAGS"
 echo "CFLAGS            $CFLAGS"
 echo "QEMU_CFLAGS       $QEMU_CFLAGS"
 echo "LDFLAGS           $LDFLAGS"
+echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
 echo "python            $python"
@@ -6706,6 +6709,7 @@ else
 fi
 echo "LDFLAGS=$LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
+echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
 echo "LD_REL_FLAGS=$LD_REL_FLAGS" >> $config_host_mak
 echo "LD_I386_EMULATION=$ld_i386_emulation" >> $config_host_mak
 echo "LIBS+=$LIBS" >> $config_host_mak
diff --git a/rules.mak b/rules.mak
index 93a0702..04c7f74 100644
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
1.8.3.1
