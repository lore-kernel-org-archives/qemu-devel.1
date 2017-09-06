Received: from eggs.gnu.org ([2001:4830:134:3::10]:53488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxU-0002Zm-AS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxR-00013l-5n
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpgxR-00012D-07
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:29:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  6 Sep 2017 16:28:45 -0400
Message-Id: <1504729728-23279-4-git-send-email-cota@braap.org>
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 3/6] configure: add --enable-plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

For now only add it for ELF platforms, since we rely on the linker's
--dynamic-list flag to pass a list of symbols to be exported to the
executable. An alternative would be to use -rdynamic, but that would
expose all of QEMU's objects to plugins.

I have no experience with non-ELF systems but I suspect adding support
for those should be pretty easy.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/configure b/configure
index 987f59b..45f7af5 100755
--- a/configure
+++ b/configure
@@ -30,6 +30,7 @@ TMPO="${TMPDIR1}/${TMPB}.o"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
 TMPMO="${TMPDIR1}/${TMPB}.mo"
+TMPTXT="${TMPDIR1}/${TMPB}.txt"
 
 rm -f config.log
 
@@ -404,6 +405,8 @@ tcmalloc="no"
 jemalloc="no"
 replication="yes"
 vxhs=""
+plugins="no"
+ld_dynamic_list="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -1282,6 +1285,10 @@ for opt do
   ;;
   --enable-vxhs) vxhs="yes"
   ;;
+  --enable-plugins) plugins="yes"
+  ;;
+  --disable-plugins) plugins="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1442,6 +1449,8 @@ Advanced options (experts only):
                            xen pv domain builder
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-plugins
+                           enable plugins via shared library loading
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -4745,6 +4754,42 @@ if compile_prog "" "" ; then
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
 # check if getauxval is available.
 
@@ -5388,6 +5433,7 @@ echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
+echo "plugin support    $plugins"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6053,6 +6099,12 @@ if test "$vxhs" = "yes" ; then
   echo "VXHS_LIBS=$vxhs_libs" >> $config_host_mak
 fi
 
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGINS=y" >> $config_host_mak
+    LIBS="-ldl $LIBS"
+    LDFLAGS="-Wl,--dynamic-list=\$(SRC_PATH)/qemu-plugins.symbols $LDFLAGS"
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.7.4
