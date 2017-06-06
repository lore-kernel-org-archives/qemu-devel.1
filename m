Received: from eggs.gnu.org ([2001:4830:134:3::10]:42712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bru.dominguez@gmail.com>) id 1dIEEv-0000SO-Gt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bru.dominguez@gmail.com>) id 1dIEEq-0002ZO-HK
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:09:41 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bru.dominguez@gmail.com>)
	id 1dIEEq-0002Z0-7l
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:09:36 -0400
Received: by mail-wm0-x242.google.com with SMTP id k15so34851885wmh.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 06:09:36 -0700 (PDT)
From: Bruno Dominguez <bru.dominguez@gmail.com>
Date: Tue,  6 Jun 2017 14:07:47 +0100
Message-Id: <1496754467-20893-1-git-send-email-bru.dominguez@gmail.com>
Subject: [Qemu-devel] [PATCH v2] configure: split c and cxx extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Bruno Dominguez <bru.dominguez@gmail.com>

There was no possibility to add specific cxx flags using the configure
file. So A new entrance has been created to support it.

Duplication of information in configure and rules.mak. Taking
QEMU_CFLAGS and add them to QEMU_CXXFLAGS, now the value of
QEMU_CXXFLAGS is stored in config-host.mak, so there is no need for
it.

The makefile for libvixl was adding flags for QEMU_CXXFLAGS in
QEMU_CFLAGS because of the addition in rules.mak. That was removed, so
adding them where it should be.

Signed-off-by: Bruno Dominguez <bru.dominguez@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Matching --extra-cxxflags description with --cxx
 * Removing some extra spaces indicated by checkpatch script
 * Fixed patch format
---
 configure                   | 74 +++++++++++++++++++++++++--------------------
 disas/libvixl/Makefile.objs |  2 +-
 rules.mak                   |  3 --
 3 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/configure b/configure
index 0586ec9..4ab0d0f 100755
--- a/configure
+++ b/configure
@@ -91,7 +91,8 @@ update_cxxflags() {
     # Set QEMU_CXXFLAGS from QEMU_CFLAGS by filtering out those
     # options which some versions of GCC's C++ compiler complain about
     # because they only make sense for C programs.
-    QEMU_CXXFLAGS=
+    QEMU_CXXFLAGS="$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS"
+
     for arg in $QEMU_CFLAGS; do
         case $arg in
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
@@ -344,6 +345,9 @@ for opt do
   --extra-cflags=*) QEMU_CFLAGS="$QEMU_CFLAGS $optarg"
                     EXTRA_CFLAGS="$optarg"
   ;;
+  --extra-cxxflags=*) QEMU_CXXFLAGS="$QEMU_CXXFLAGS $optarg"
+                      EXTRA_CXXFLAGS="$optarg"
+  ;;
   --extra-ldflags=*) LDFLAGS="$LDFLAGS $optarg"
                      EXTRA_LDFLAGS="$optarg"
   ;;
@@ -787,6 +791,8 @@ for opt do
   ;;
   --extra-cflags=*)
   ;;
+  --extra-cxxflags=*)
+  ;;
   --extra-ldflags=*)
   ;;
   --enable-debug-info)
@@ -1304,6 +1310,7 @@ Advanced options (experts only):
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
   --extra-cflags=CFLAGS    append extra C compiler flags QEMU_CFLAGS
+  --extra-cxxflags=CXXFLAGS append extra C++ compiler flags QEMU_CXXFLAGS
   --extra-ldflags=LDFLAGS  append extra linker flags LDFLAGS
   --make=MAKE              use specified make [$make]
   --install=INSTALL        use specified install [$install]
@@ -1489,37 +1496,6 @@ if test "$bogus_os" = "yes"; then
     error_exit "Unrecognized host OS $targetos"
 fi
 
-# Check that the C++ compiler exists and works with the C compiler
-if has $cxx; then
-    cat > $TMPC <<EOF
-int c_function(void);
-int main(void) { return c_function(); }
-EOF
-
-    compile_object
-
-    cat > $TMPCXX <<EOF
-extern "C" {
-   int c_function(void);
-}
-int c_function(void) { return 42; }
-EOF
-
-    update_cxxflags
-
-    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $LDFLAGS; then
-        # C++ compiler $cxx works ok with C compiler $cc
-        :
-    else
-        echo "C++ compiler $cxx does not work with C compiler $cc"
-        echo "Disabling C++ specific optional code"
-        cxx=
-    fi
-else
-    echo "No C++ compiler available; disabling C++ specific optional code"
-    cxx=
-fi
-
 gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
 gcc_flags="-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers $gcc_flags"
 gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
@@ -5063,6 +5039,38 @@ EOF
   fi
 fi
 
+# Check that the C++ compiler exists and works with the C compiler.
+# All the QEMU_CXXFLAGS are based on QEMU_CFLAGS. Keep this at the end to don't miss any other that could be added.
+if has $cxx; then
+    cat > $TMPC <<EOF
+int c_function(void);
+int main(void) { return c_function(); }
+EOF
+
+    compile_object
+
+    cat > $TMPCXX <<EOF
+extern "C" {
+   int c_function(void);
+}
+int c_function(void) { return 42; }
+EOF
+
+    update_cxxflags
+
+    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $LDFLAGS; then
+        # C++ compiler $cxx works ok with C compiler $cc
+        :
+    else
+        echo "C++ compiler $cxx does not work with C compiler $cc"
+        echo "Disabling C++ specific optional code"
+        cxx=
+    fi
+else
+    echo "No C++ compiler available; disabling C++ specific optional code"
+    cxx=
+fi
+
 echo_version() {
     if test "$1" = "yes" ; then
         echo "($2)"
@@ -5268,6 +5276,7 @@ if test "$mingw32" = "no" ; then
 fi
 echo "qemu_helperdir=$libexecdir" >> $config_host_mak
 echo "extra_cflags=$EXTRA_CFLAGS" >> $config_host_mak
+echo "extra_cxxflags=$EXTRA_CXXFLAGS" >> $config_host_mak
 echo "extra_ldflags=$EXTRA_LDFLAGS" >> $config_host_mak
 echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
@@ -5906,6 +5915,7 @@ echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
+echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
 echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
 if test "$sparse" = "yes" ; then
   echo "CC           := REAL_CC=\"\$(CC)\" cgcc"       >> $config_host_mak
diff --git a/disas/libvixl/Makefile.objs b/disas/libvixl/Makefile.objs
index bbe7695..dbf7def 100644
--- a/disas/libvixl/Makefile.objs
+++ b/disas/libvixl/Makefile.objs
@@ -6,6 +6,6 @@ libvixl_OBJS = vixl/utils.o \
 
 # The -Wno-sign-compare is needed only for gcc 4.6, which complains about
 # some signed-unsigned equality comparisons which later gcc versions do not.
-$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CFLAGS := -I$(SRC_PATH)/disas/libvixl $(QEMU_CFLAGS) -Wno-sign-compare
+$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CXXFLAGS := -I$(SRC_PATH)/disas/libvixl $(QEMU_CXXFLAGS) -Wno-sign-compare
 
 common-obj-$(CONFIG_ARM_A64_DIS) += $(libvixl_OBJS)
diff --git a/rules.mak b/rules.mak
index 1c0eabb..2a2fb72 100644
--- a/rules.mak
+++ b/rules.mak
@@ -20,9 +20,6 @@ MAKEFLAGS += -rR
 %.mak:
 clean-target:
 
-# Flags for C++ compilation
-QEMU_CXXFLAGS = -D__STDC_LIMIT_MACROS $(filter-out -Wstrict-prototypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls, $(QEMU_CFLAGS))
-
 # Flags for dependency generation
 QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
-- 
1.9.1
