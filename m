Received: from eggs.gnu.org ([2001:4830:134:3::10]:40063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1clb2d-00048h-9Z
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 07:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1clb2X-0002xe-EW
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 07:50:07 -0500
Received: from ozlabs.ru ([107.173.13.209]:49878)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1clb2X-0002xT-95
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 07:50:01 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed,  8 Mar 2017 23:49:55 +1100
Message-Id: <20170308124955.35623-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu] dtc: Allow compiling with old gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

After 6e85fce0225f "dtc: Update requirement to v1.4.2" QEMU stopped
compiling in CentOS7:

In file included from /home/aik/p/qemu/dtc/libfdt/libfdt.h:54:0,
                 from /home/aik/p/qemu/device_tree.c:30:
/home/aik/p/qemu/dtc/libfdt/libfdt_env.h:64:0: error: "__bitwise" redefined [-Werror]
 #define __bitwise
 ^
In file included from /usr/include/asm/ptrace.h:27:0,
                 from /usr/include/asm/sigcontext.h:11,
                 from /usr/include/bits/sigcontext.h:27,
                 from /usr/include/signal.h:340,
                 from /home/aik/p/qemu/include/qemu/osdep.h:86,
                 from /home/aik/p/qemu/device_tree.c:14:
/usr/include/linux/types.h:21:0: note: this is the location of the previous definition
 #define __bitwise __bitwise__
 ^
cc1: all warnings being treated as errors
make: *** [device_tree.o] Error 1
make: *** Waiting for unfinished jobs....

The reason is that CentOS7 comes with libfdt 1.4.0 so QEMU tries using
the internal one which does not compile as CentOS7 comes with gcc v4.8.5
which reports warnings which it would not if the OS's libfdt was used
(libfdt_env.h has not changed between 1.4.0 and 1.4.2).

gcc 6.2.0 from Ubuntu v16.10 handles this fine.

This replaces -I with -isystem to suppress the warning (which turns
to an error because of -Werror).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 6c21975f02..2c2a5df14a 100755
--- a/configure
+++ b/configure
@@ -3414,7 +3414,7 @@ EOF
        symlink "$source_path/dtc/Makefile" "dtc/Makefile"
        symlink "$source_path/dtc/scripts" "dtc/scripts"
     fi
-    fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
+    fdt_cflags="-isystem\$(SRC_PATH)/dtc/libfdt"
     fdt_libs="-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
   elif test "$fdt" = "yes" ; then
     # have neither and want - prompt for system/submodule install
-- 
2.11.0
