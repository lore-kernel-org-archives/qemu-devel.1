Received: from eggs.gnu.org ([2001:4830:134:3::10]:33667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uT-0001cf-Lt
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uO-0006oC-EC
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:37 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uO-0005sz-1L
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:32 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:46 -0500
Message-Id: <20181209193749.12277-36-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC v2 35/38] configure: add --enable-plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Add support for both ld (using --dynamic-list) and MacOSX's ld64
(-exported_symbols_list).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure       | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 Makefile        |  1 +
 Makefile.target | 18 ++++++++++-
 .gitignore      |  2 ++
 4 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 1c473ce95b..91f9c08ae2 100755
--- a/configure
+++ b/configure
@@ -30,6 +30,7 @@ TMPO="${TMPDIR1}/${TMPB}.o"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
 TMPMO="${TMPDIR1}/${TMPB}.mo"
+TMPTXT="${TMPDIR1}/${TMPB}.txt"
 
 rm -f config.log
 
@@ -474,6 +475,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
+plugins="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1444,6 +1446,10 @@ for opt do
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
@@ -1634,6 +1640,8 @@ Advanced options (experts only):
                            xen pv domain builder
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-plugins
+                           enable plugins via shared library loading
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -5143,6 +5151,58 @@ if compile_prog "" "" ; then
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
+ld_dynamic_list="no"
+if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
+  ld_dynamic_list="yes"
+fi
+
+#########################################
+# See if -exported_symbols_list is supported by the linker
+
+cat > $TMPTXT <<EOF
+  _foo
+EOF
+
+ld_exported_symbols_list="no"
+if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
+  ld_exported_symbols_list="yes"
+fi
+
+if  test "$plugins" = "yes" &&
+    test "$ld_dynamic_list" = "no" &&
+    test "$ld_exported_symbols_list" = "no" ; then
+  error_exit \
+      "Plugin support requires specifying a set of symbols that " \
+      "are exported to plugins. Unfortunately your linker doesn't " \
+      "support the flag (--dynamic-list or -exported_symbols_list) used " \
+      "for this purpose."
+fi
+
 ########################################
 # See if 16-byte vector operations are supported.
 # Even without a vector unit the compiler may expand these.
@@ -6027,6 +6087,7 @@ echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
+echo "plugin support    $plugins"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6779,6 +6840,27 @@ if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
 fi
 
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGIN=y" >> $config_host_mak
+    LIBS="-ldl $LIBS"
+    # Copy the export object list to the build dir
+    if test "$ld_dynamic_list" = "yes" ; then
+	echo "CONFIG_HAS_LD_DYNAMIC_LIST=yes" >> $config_host_mak
+	ld_symbols=qemu-plugins-ld.symbols
+	cp "$source_path/qemu-plugins.symbols" $ld_symbols
+    elif test "$ld_exported_symbols_list" = "yes" ; then
+	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=yes" >> $config_host_mak
+	ld64_symbols=qemu-plugins-ld64.symbols
+	echo "# Automatically generated by configure - do not modify" > $ld64_symbols
+	grep 'qemu_' "$source_path/qemu-plugins.symbols" | sed 's/;//g' | \
+	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
+    else
+	error_exit \
+	    "If \$plugins=yes, either \$ld_dynamic_list or " \
+	    "\$ld_exported_symbols_list should have been set to 'yes'."
+    fi
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
diff --git a/Makefile b/Makefile
index 9cb3076d84..6fd15b296f 100644
--- a/Makefile
+++ b/Makefile
@@ -778,6 +778,7 @@ distclean: clean
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
 	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
 	rm -f qemu-doc.vr qemu-doc.txt
+	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
diff --git a/Makefile.target b/Makefile.target
index 75637c285c..7dada1f368 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -107,7 +107,23 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 
-obj-$(CONFIG_PLUGINS) += plugin.o
+ifdef CONFIG_PLUGIN
+obj-y += plugin.o
+# Abuse -libs suffix to only link with --dynamic-list/-exported_symbols_list
+# when the final binary includes the plugin object.
+#
+# Note that simply setting LDFLAGS is not enough: we build binaries that
+# never link plugin.o, and the linker might fail (at least ld64 does)
+# if the symbols in the list are not in the output binary.
+ ifdef CONFIG_HAS_LD_DYNAMIC_LIST
+ plugin.o-libs := -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
+ else
+  ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
+  plugin.o-libs := \
+	-Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
+  endif
+ endif
+endif
 
 #########################################################
 # Linux user emulator target
diff --git a/.gitignore b/.gitignore
index 64efdfd929..29f6446508 100644
--- a/.gitignore
+++ b/.gitignore
@@ -213,3 +213,5 @@ trace-dtrace-root.dtrace
 trace-ust-all.h
 trace-ust-all.c
 /target/arm/decode-sve.inc.c
+qemu-plugins-ld.symbols
+qemu-plugins-ld64.symbols
-- 
2.17.1
