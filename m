Received: from eggs.gnu.org ([2001:4830:134:3::10]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKg-0006hn-24
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKb-0000MJ-TH
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKb-0000C4-IX
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:50 -0400
Message-Id: <20181025172057.20414-42-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 41/48] configure: add --enable-plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

For now only add it for ELF platforms, since we rely on the linker's
--dynamic-list flag to pass a list of symbols to be exported to the
executable. An alternative would be to use -rdynamic, but that would
expose all of QEMU's objects to plugins.

I have no experience with non-ELF systems but I suspect adding support
for those should be pretty easy.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/configure b/configure
index 03bf719ca7..78e86098e5 100755
--- a/configure
+++ b/configure
@@ -30,6 +30,7 @@ TMPO="${TMPDIR1}/${TMPB}.o"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
 TMPMO="${TMPDIR1}/${TMPB}.mo"
+TMPTXT="${TMPDIR1}/${TMPB}.txt"
 
 rm -f config.log
 
@@ -477,6 +478,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
+plugins="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1443,6 +1445,10 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
+  --enable-plugins) plugins="yes"
+  ;;
+  --disable-plugins) plugins="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1633,6 +1639,8 @@ Advanced options (experts only):
                            xen pv domain builder
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-plugins
+                           enable plugins via shared library loading
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -5204,6 +5212,42 @@ if compile_prog "" "" ; then
   atomic64=yes
 fi
 
+#########################################
+# See if --dynamic-list is supported by the linker
+
+cat > $TMPTXT <<EOF
+{
+  foo;
+};
+EOF
+
+cat > $TMPC <<EOF
+#include <stdio.h>
+void foo(void);
+
+void foo(void)
+{
+  printf("foo\n");
+}
+
+int main(void)
+{
+  foo();
+  return 0;
+}
+EOF
+
+if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
+  ld_dynamic_list="yes"
+else
+  if test "$plugins" = "yes" ; then
+    error_exit \
+        "Plugin support requires specifying a set of symbols that " \
+        "are exported to plugins. Unfortunately your linker doesn't " \
+        "support the flag (--dynamic-list) used for this purpose."
+  fi
+fi
+
 ########################################
 # See if 16-byte vector operations are supported.
 # Even without a vector unit the compiler may expand these.
@@ -6091,6 +6135,7 @@ echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
+echo "plugin support    $plugins"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6849,6 +6894,12 @@ if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
 fi
 
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGINS=y" >> $config_host_mak
+    LIBS="-ldl $LIBS"
+    LDFLAGS="-Wl,--dynamic-list=\$(SRC_PATH)/qemu-plugins.symbols $LDFLAGS"
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.17.1
