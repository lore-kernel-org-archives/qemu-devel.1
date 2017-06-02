Received: from eggs.gnu.org ([2001:4830:134:3::10]:34680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bru.dominguez@gmail.com>) id 1dGmId-0008El-Ls
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bru.dominguez@gmail.com>) id 1dGmIc-0003uh-7m
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:07:31 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bru.dominguez@gmail.com>)
	id 1dGmIb-0003u6-To
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:07:30 -0400
Received: by mail-wm0-x243.google.com with SMTP id d127so18878123wmf.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:07:28 -0700 (PDT)
MIME-Version: 1.0
From: Bruno Dominguez <bru.dominguez@gmail.com>
Date: Fri, 2 Jun 2017 14:07:26 +0100
Message-ID: <CALfaEa0MirxK6ESnepptGLiugYZBOSQVxe=R72h+c_-GBXkYzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] split c and cxx extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: claudio.fontana@huawei.com

There was no possibility to add specific cxx flags using the configure
file. So A new entrance has been created to support it.

Duplication of information in configure and rules.mak. Taking
QEMU_CFLAGS and add them to QEMU_CXXFLAGS, now the value of
QEMU_CXXFLAGS is stored in config-host.mak, so there is no need for
it.

The makefile for libvixl was adding flags for QEMU_CXXFLAGS in
QEMU_CFLAGS because of the addition in rules.mak. That was removed, so
adding them where it should be.

-----
Signed-off-by: Bruno Dominguez <bru.dominguez@gmail.com>
-----

diff --git a/configure b/configure
index 0586ec9..2fff3cc 100755
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
@@ -102,6 +103,8 @@ update_cxxflags() {
                 ;;
         esac
     done
+
+
 }

 compile_object() {
@@ -344,6 +347,9 @@ for opt do
   --extra-cflags=*) QEMU_CFLAGS="$QEMU_CFLAGS $optarg"
                     EXTRA_CFLAGS="$optarg"
   ;;
+  --extra-cxxflags=*) QEMU_CXXFLAGS="$QEMU_CXXFLAGS $optarg"
+                      EXTRA_CXXFLAGS="$optarg"
+  ;;
   --extra-ldflags=*) LDFLAGS="$LDFLAGS $optarg"
                      EXTRA_LDFLAGS="$optarg"
   ;;
@@ -787,6 +793,8 @@ for opt do
   ;;
   --extra-cflags=*)
   ;;
+  --extra-cxxflags=*)
+  ;;
   --extra-ldflags=*)
   ;;
   --enable-debug-info)
@@ -1304,6 +1312,7 @@ Advanced options (experts only):
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
   --extra-cflags=CFLAGS    append extra C compiler flags QEMU_CFLAGS
+  --extra-cxxflags=CXXFLAGS append extra CXX compiler flags QEMU_CXXFLAGS
   --extra-ldflags=LDFLAGS  append extra linker flags LDFLAGS
   --make=MAKE              use specified make [$make]
   --install=INSTALL        use specified install [$install]
@@ -1489,37 +1498,6 @@ if test "$bogus_os" = "yes"; then
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
 gcc_flags="-Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers $gcc_flags"
 gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
@@ -5063,6 +5041,38 @@ EOF
   fi
 fi

+# Check that the C++ compiler exists and works with the C compiler.
+# All the QEMU_CXXFLAGS are based on QEMU_CFLAGS. Keep this at the
end to don't miss any other that could be added.
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
@@ -5268,6 +5278,7 @@ if test "$mingw32" = "no" ; then
 fi
 echo "qemu_helperdir=$libexecdir" >> $config_host_mak
 echo "extra_cflags=$EXTRA_CFLAGS" >> $config_host_mak
+echo "extra_cxxflags=$EXTRA_CXXFLAGS" >> $config_host_mak
 echo "extra_ldflags=$EXTRA_LDFLAGS" >> $config_host_mak
 echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
@@ -5906,6 +5917,7 @@ echo "WINDRES=$windres" >> $config_host_mak
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
-$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CFLAGS :=
-I$(SRC_PATH)/disas/libvixl $(QEMU_CFLAGS) -Wno-sign-compare
+$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CXXFLAGS :=
-I$(SRC_PATH)/disas/libvixl $(QEMU_CXXFLAGS) -Wno-sign-compare

 common-obj-$(CONFIG_ARM_A64_DIS) += $(libvixl_OBJS)
diff --git a/rules.mak b/rules.mak
index 1c0eabb..2a2fb72 100644
--- a/rules.mak
+++ b/rules.mak
@@ -20,9 +20,6 @@ MAKEFLAGS += -rR
 %.mak:
 clean-target:

-# Flags for C++ compilation
-QEMU_CXXFLAGS = -D__STDC_LIMIT_MACROS $(filter-out
-Wstrict-prototypes -Wmissing-prototypes -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls,
$(QEMU_CFLAGS))
-
 # Flags for dependency generation
 QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d


Bruno
