Received: from eggs.gnu.org ([2001:4830:134:3::10]:47975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyfZI-0000Kd-5r
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyfZE-00040B-6K
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:22:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyfZE-0003zn-14
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:22:20 -0400
Date: Wed, 21 Mar 2018 17:22:07 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521645545-247351-2-git-send-email-mst@redhat.com>
References: <1521645545-247351-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521645545-247351-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 2/2] make: switch from -I to -iquote
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=83=C2=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>

Our rule right now is to use <> for external headers,
"" for internal ones. The idea was to avoid conflicts
between e.g. a system file named <trace.h> and an
internal one by the same name.

Unfortunately we use -I compiler flag so it does not
help: a system file doing #include <trace.h> will
still pick up ours first.

To fix, switch to -iquote which is supported by both
gcc and clang and only affects #include "" directives.

As a side effect, this catches any future uses of
 #include <> for internal headers.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I still think we want to switch to a more formal rule such as qemu/
prefix for all includes down the road, but this will at least catch any
scheme violations from creeping in meanwhile.


 configure       | 16 ++++++++--------
 rules.mak       |  2 +-
 Makefile.target |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index af72fc8..23a4f3b 100755
--- a/configure
+++ b/configure
@@ -534,7 +534,7 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-QEMU_INCLUDES="-I. -I\$(SRC_PATH) -I\$(SRC_PATH)/accel/tcg -I\$(SRC_PATH)/include"
+QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)/accel/tcg -iquote \$(SRC_PATH)/include"
 if test "$debug_info" = "yes"; then
     CFLAGS="-g $CFLAGS"
     LDFLAGS="-g $LDFLAGS"
@@ -6560,19 +6560,19 @@ if test "$vxhs" = "yes" ; then
 fi
 
 if test "$tcg_interpreter" = "yes"; then
-  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
 elif test "$ARCH" = "s390x" ; then
-  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
 elif test "$ARCH" = "x86_64" -o "$ARCH" = "x32" ; then
-  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" = "ppc64" ; then
-  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
 else
-  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
+  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
-QEMU_INCLUDES="-I\$(SRC_PATH)/tcg $QEMU_INCLUDES"
+QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg $QEMU_INCLUDES"
 
 echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
diff --git a/rules.mak b/rules.mak
index 6e94333..93a0702 100644
--- a/rules.mak
+++ b/rules.mak
@@ -29,7 +29,7 @@ QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 # dir, one absolute and the other relative to the compiler working
 # directory. These are the same for target-independent files, but
 # different for target-dependent ones.
-QEMU_LOCAL_INCLUDES = -I$(BUILD_DIR)/$(@D) -I$(@D)
+QEMU_LOCAL_INCLUDES = -iquote $(BUILD_DIR)/$(@D) -iquote $(@D)
 
 WL_U := -Wl,-u,
 find-symbols = $(if $1, $(sort $(shell $(NM) -P -g $1 | $2)))
diff --git a/Makefile.target b/Makefile.target
index 6549481..d0ec77a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -11,9 +11,9 @@ $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
 ifdef CONFIG_LINUX
 QEMU_CFLAGS += -I../linux-headers
 endif
-QEMU_CFLAGS += -I.. -I$(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
+QEMU_CFLAGS += -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
 
-QEMU_CFLAGS+=-I$(SRC_PATH)/include
+QEMU_CFLAGS+=-iquote $(SRC_PATH)/include
 
 ifdef CONFIG_USER_ONLY
 # user emulator name
-- 
MST
