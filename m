Received: from eggs.gnu.org ([209.51.188.92]:37539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqqjt-0001Bw-Q7
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 21:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqqeJ-0004sF-5x
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 21:39:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 20:39:37 -0600
Message-Id: <20190205023937.18245-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: Avoid non-portable 'test -o/-a'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com

POSIX says that it is better to use &&/|| and two separate test
invocations than it is to try and use -a and -o (in fact, there
are some tests that are inherently ambiguous to parse if the
user passes in corner-case input like "(").

Since we cannot guarantee which shell runs configure, we cannot
rely on -o/-a always following bash's parser rules.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 configure | 63 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/configure b/configure
index 3d89870d996..61bc70708e4 100755
--- a/configure
+++ b/configure
@@ -1834,8 +1834,8 @@ fi
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
-    if test -d "$source_path/.git" -a \
-        \( "$linux" =3D "yes" -o "$mingw32" =3D "yes" \) ; then
+    if test -d "$source_path/.git" && \
+        { test "$linux" =3D "yes" || test "$mingw32" =3D "yes"; }; then
         werror=3D"yes"
     else
         werror=3D"no"
@@ -2940,7 +2940,7 @@ EOF
     sdl=3Dyes

     # static link with sdl ? (note: sdl.pc's --static --libs is broken)
-    if test "$sdl" =3D "yes" -a "$static" =3D "yes" ; then
+    if test "$sdl" =3D "yes" && test "$static" =3D "yes" ; then
       if test $? =3D 0 && echo $sdl_libs | grep -- -laa > /dev/null; the=
n
          sdl_libs=3D"$sdl_libs $(aalib-config --static-libs 2>/dev/null)=
"
          sdl_cflags=3D"$sdl_cflags $(aalib-config --cflags 2>/dev/null)"
@@ -3082,7 +3082,7 @@ fi

 ##########################################
 # VNC SASL detection
-if test "$vnc" =3D "yes" -a "$vnc_sasl" !=3D "no" ; then
+if test "$vnc" =3D "yes" && test "$vnc_sasl" !=3D "no" ; then
   cat > $TMPC <<EOF
 #include <sasl/sasl.h>
 #include <stdio.h>
@@ -3105,7 +3105,7 @@ fi

 ##########################################
 # VNC JPEG detection
-if test "$vnc" =3D "yes" -a "$vnc_jpeg" !=3D "no" ; then
+if test "$vnc" =3D "yes" && test "$vnc_jpeg" !=3D "no" ; then
 cat > $TMPC <<EOF
 #include <stdio.h>
 #include <jpeglib.h>
@@ -3127,7 +3127,7 @@ fi

 ##########################################
 # VNC PNG detection
-if test "$vnc" =3D "yes" -a "$vnc_png" !=3D "no" ; then
+if test "$vnc" =3D "yes" && test "$vnc_png" !=3D "no" ; then
 cat > $TMPC <<EOF
 //#include <stdio.h>
 #include <png.h>
@@ -3491,7 +3491,7 @@ fi
 # This workaround is required due to a bug in pkg-config file for glib a=
s it
 # doesn't define GLIB_STATIC_COMPILATION for pkg-config --static

-if test "$static" =3D yes -a "$mingw32" =3D yes; then
+if test "$static" =3D yes && test "$mingw32" =3D yes; then
     QEMU_CFLAGS=3D"-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"
 fi

@@ -3584,7 +3584,7 @@ fi
 ##########################################
 # pixman support probe

-if test "$want_tools" =3D "no" -a "$softmmu" =3D "no"; then
+if test "$want_tools" =3D "no" && test "$softmmu" =3D "no"; then
   pixman_cflags=3D
   pixman_libs=3D
 elif $pkg_config --atleast-version=3D0.21.8 pixman-1 > /dev/null 2>&1; t=
hen
@@ -3699,7 +3699,7 @@ else
   done
 fi

-if test "$mingw32" !=3D yes -a "$pthread" =3D no; then
+if test "$mingw32" !=3D yes && test "$pthread" =3D no; then
   error_exit "pthread check failed" \
       "Make sure to have the pthread libs and headers installed."
 fi
@@ -3826,7 +3826,7 @@ fi
 ##########################################
 # TPM passthrough is only on x86 Linux

-if test "$targetos" =3D Linux && test "$cpu" =3D i386 -o "$cpu" =3D x86_=
64; then
+if test "$targetos" =3D Linux && { test "$cpu" =3D i386 || test "$cpu" =3D=
 x86_64; }; then
   tpm_passthrough=3D$tpm
 else
   tpm_passthrough=3Dno
@@ -3992,7 +3992,7 @@ EOF
   fi
 fi

-if test "$opengl" =3D "yes" -a "$have_x11" =3D "yes"; then
+if test "$opengl" =3D "yes" && test "$have_x11" =3D "yes"; then
   for target in $target_list; do
     case $target in
       lm32-softmmu) # milkymist-tmu2 requires X11 and OpenGL
@@ -4612,8 +4612,8 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
   libs_qga=3D"$libs_qga -lrt"
 fi

-if test "$darwin" !=3D "yes" -a "$mingw32" !=3D "yes" -a "$solaris" !=3D=
 yes -a \
-        "$haiku" !=3D "yes" ; then
+if test "$darwin" !=3D "yes" && test "$mingw32" !=3D "yes" && \
+        test "$solaris" !=3D yes && test "$haiku" !=3D "yes" ; then
     libs_softmmu=3D"-lutil $libs_softmmu"
 fi

@@ -4688,7 +4688,8 @@ fi
 ##########################################
 # check if we have VSS SDK headers for win

-if test "$mingw32" =3D "yes" -a "$guest_agent" !=3D "no" -a "$vss_win32_=
sdk" !=3D "no" ; then
+if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no" && \
+        test "$vss_win32_sdk" !=3D "no" ; then
   case "$vss_win32_sdk" in
     "")   vss_win32_include=3D"-isystem $source_path" ;;
     *\ *) # The SDK is installed in "Program Files" by default, but we c=
annot
@@ -4727,7 +4728,8 @@ fi
 # VSS provider from the source. It is usually unnecessary because the
 # pre-compiled .tlb file is included.

-if test "$mingw32" =3D "yes" -a "$guest_agent" !=3D "no" -a "$guest_agen=
t_with_vss" =3D "yes" ; then
+if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no" && \
+        test "$guest_agent_with_vss" =3D "yes" ; then
   if test -z "$win_sdk"; then
     programfiles=3D"$PROGRAMFILES"
     test -n "$PROGRAMW6432" && programfiles=3D"$PROGRAMW6432"
@@ -4743,7 +4745,7 @@ fi

 ##########################################
 # check if mingw environment provides a recent ntddscsi.h
-if test "$mingw32" =3D "yes" -a "$guest_agent" !=3D "no"; then
+if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no"; then
   cat > $TMPC << EOF
 #include <windows.h>
 #include <ntddscsi.h>
@@ -4790,7 +4792,7 @@ case "$capstone" in
   "" | yes)
     if $pkg_config capstone; then
       capstone=3Dsystem
-    elif test -e "${source_path}/.git" -a $git_update =3D 'yes' ; then
+    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; t=
hen
       capstone=3Dgit
     elif test -e "${source_path}/capstone/Makefile" ; then
       capstone=3Dinternal
@@ -5162,7 +5164,7 @@ fi
 # There is no point enabling this if cpuid.h is not usable,
 # since we won't be able to select the new routines.

-if test "$cpuid_h" =3D "yes" -a "$avx2_opt" !=3D "no"; then
+if test "$cpuid_h" =3D "yes" && test "$avx2_opt" !=3D "no"; then
   cat > $TMPC << EOF
 #pragma GCC push_options
 #pragma GCC target("avx2")
@@ -5220,7 +5222,7 @@ EOF
 fi

 cmpxchg128=3Dno
-if test "$int128" =3D yes -a "$atomic128" =3D no; then
+if test "$int128" =3D yes && test "$atomic128" =3D no; then
   cat > $TMPC << EOF
 int main(void)
 {
@@ -5893,9 +5895,9 @@ fi

 # Mac OS X ships with a broken assembler
 roms=3D
-if test \( "$cpu" =3D "i386" -o "$cpu" =3D "x86_64" \) -a \
-        "$targetos" !=3D "Darwin" -a "$targetos" !=3D "SunOS" -a \
-        "$softmmu" =3D yes ; then
+if { test "$cpu" =3D "i386" || test "$cpu" =3D "x86_64"; } && \
+        test "$targetos" !=3D "Darwin" && test "$targetos" !=3D "SunOS" =
&& \
+        test "$softmmu" =3D yes ; then
     # Different host OS linkers have different ideas about the name of t=
he ELF
     # emulation. Linux and OpenBSD/amd64 use 'elf_i386'; FreeBSD uses th=
e _fbsd
     # variant; OpenBSD/i386 uses the _obsd variant; and Windows uses i38=
6pe.
@@ -5907,7 +5909,7 @@ if test \( "$cpu" =3D "i386" -o "$cpu" =3D "x86_64"=
 \) -a \
         fi
     done
 fi
-if test "$cpu" =3D "ppc64" -a "$targetos" !=3D "Darwin" ; then
+if test "$cpu" =3D "ppc64" && test "$targetos" !=3D "Darwin" ; then
   roms=3D"$roms spapr-rtas"
 fi

@@ -6373,7 +6375,7 @@ if test "$modules" =3D "yes"; then
   echo "CONFIG_STAMP=3D_$( (echo $qemu_version; echo $pkgversion; cat $0=
) | $shacmd - | cut -f1 -d\ )" >> $config_host_mak
   echo "CONFIG_MODULES=3Dy" >> $config_host_mak
 fi
-if test "$have_x11" =3D "yes" -a "$need_x11" =3D "yes"; then
+if test "$have_x11" =3D "yes" && test "$need_x11" =3D "yes"; then
   echo "CONFIG_X11=3Dy" >> $config_host_mak
   echo "X11_CFLAGS=3D$x11_cflags" >> $config_host_mak
   echo "X11_LIBS=3D$x11_libs" >> $config_host_mak
@@ -6568,7 +6570,7 @@ fi
 if test "$vhost_scsi" =3D "yes" ; then
   echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak
 fi
-if test "$vhost_net" =3D "yes" -a "$vhost_user" =3D "yes"; then
+if test "$vhost_net" =3D "yes" && test "$vhost_user" =3D "yes"; then
   echo "CONFIG_VHOST_NET_USED=3Dy" >> $config_host_mak
 fi
 if test "$vhost_crypto" =3D "yes" ; then
@@ -6963,11 +6965,11 @@ elif test "$ARCH" =3D "sparc64" ; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
 elif test "$ARCH" =3D "s390x" ; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
-elif test "$ARCH" =3D "x86_64" -o "$ARCH" =3D "x32" ; then
+elif test "$ARCH" =3D "x86_64" || test "$ARCH" =3D "x32" ; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" =3D "ppc64" ; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
-elif test "$ARCH" =3D "riscv32" -o "$ARCH" =3D "riscv64" ; then
+elif test "$ARCH" =3D "riscv32" || test "$ARCH" =3D "riscv64" ; then
   QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/riscv $QEMU_INCLUDES"
 else
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
@@ -7384,7 +7386,7 @@ if test ! -z "$gdb_xml_files" ; then
   echo "TARGET_XML_FILES=3D$list" >> $config_target_mak
 fi

-if test "$target_user_only" =3D "yes" -a "$bflt" =3D "yes"; then
+if test "$target_user_only" =3D "yes" && test "$bflt" =3D "yes"; then
   echo "TARGET_HAS_BFLT=3Dy" >> $config_target_mak
 fi
 if test "$target_bsd_user" =3D "yes" ; then
@@ -7506,7 +7508,7 @@ if test "$gprof" =3D "yes" ; then
   fi
 fi

-if test "$target_linux_user" =3D "yes" -o "$target_bsd_user" =3D "yes" ;=
 then
+if test "$target_linux_user" =3D "yes" || test "$target_bsd_user" =3D "y=
es" ; then
   ldflags=3D"$ldflags $textseg_ldflags"
 fi

@@ -7518,7 +7520,8 @@ fi
 #  - we build the system emulation for s390x (qemu-system-s390x)
 #  - KVM is enabled
 #  - the linker supports --s390-pgste
-if test "$TARGET_ARCH" =3D "s390x" -a "$target_softmmu" =3D "yes"  -a "$=
ARCH" =3D "s390x" -a "$kvm" =3D "yes"; then
+if test "$TARGET_ARCH" =3D "s390x" && test "$target_softmmu" =3D "yes" &=
& \
+        test "$ARCH" =3D "s390x" && test "$kvm" =3D "yes"; then
     if ld_has --s390-pgste ; then
         ldflags=3D"-Wl,--s390-pgste $ldflags"
     fi
--=20
2.20.1
