Received: from eggs.gnu.org ([209.51.188.92]:35612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr2mZ-00036o-Vo
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr2mV-0007f0-Cw
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:37:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gr2mT-0007YG-HC
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:37:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so12830664wmh.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 07:36:46 -0800 (PST)
References: <20190205023937.18245-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3272680e-7b0e-96f5-b500-5a24222a7606@redhat.com>
Date: Tue, 5 Feb 2019 16:36:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190205023937.18245-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Avoid non-portable 'test -o/-a'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com

On 2/5/19 3:39 AM, Eric Blake wrote:
> POSIX says that it is better to use &&/|| and two separate test
> invocations than it is to try and use -a and -o (in fact, there
> are some tests that are inherently ambiguous to parse if the
> user passes in corner-case input like "(").
> 
> Since we cannot guarantee which shell runs configure, we cannot
> rely on -o/-a always following bash's parser rules.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
(bash, ash, dash, ksh)

> ---
>  configure | 63 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/configure b/configure
> index 3d89870d996..61bc70708e4 100755
> --- a/configure
> +++ b/configure
> @@ -1834,8 +1834,8 @@ fi
>  # Consult white-list to determine whether to enable werror
>  # by default.  Only enable by default for git builds
>  if test -z "$werror" ; then
> -    if test -d "$source_path/.git" -a \
> -        \( "$linux" = "yes" -o "$mingw32" = "yes" \) ; then
> +    if test -d "$source_path/.git" && \
> +        { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
>          werror="yes"
>      else
>          werror="no"
> @@ -2940,7 +2940,7 @@ EOF
>      sdl=yes
> 
>      # static link with sdl ? (note: sdl.pc's --static --libs is broken)
> -    if test "$sdl" = "yes" -a "$static" = "yes" ; then
> +    if test "$sdl" = "yes" && test "$static" = "yes" ; then
>        if test $? = 0 && echo $sdl_libs | grep -- -laa > /dev/null; then
>           sdl_libs="$sdl_libs $(aalib-config --static-libs 2>/dev/null)"
>           sdl_cflags="$sdl_cflags $(aalib-config --cflags 2>/dev/null)"
> @@ -3082,7 +3082,7 @@ fi
> 
>  ##########################################
>  # VNC SASL detection
> -if test "$vnc" = "yes" -a "$vnc_sasl" != "no" ; then
> +if test "$vnc" = "yes" && test "$vnc_sasl" != "no" ; then
>    cat > $TMPC <<EOF
>  #include <sasl/sasl.h>
>  #include <stdio.h>
> @@ -3105,7 +3105,7 @@ fi
> 
>  ##########################################
>  # VNC JPEG detection
> -if test "$vnc" = "yes" -a "$vnc_jpeg" != "no" ; then
> +if test "$vnc" = "yes" && test "$vnc_jpeg" != "no" ; then
>  cat > $TMPC <<EOF
>  #include <stdio.h>
>  #include <jpeglib.h>
> @@ -3127,7 +3127,7 @@ fi
> 
>  ##########################################
>  # VNC PNG detection
> -if test "$vnc" = "yes" -a "$vnc_png" != "no" ; then
> +if test "$vnc" = "yes" && test "$vnc_png" != "no" ; then
>  cat > $TMPC <<EOF
>  //#include <stdio.h>
>  #include <png.h>
> @@ -3491,7 +3491,7 @@ fi
>  # This workaround is required due to a bug in pkg-config file for glib as it
>  # doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
> 
> -if test "$static" = yes -a "$mingw32" = yes; then
> +if test "$static" = yes && test "$mingw32" = yes; then
>      QEMU_CFLAGS="-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"
>  fi
> 
> @@ -3584,7 +3584,7 @@ fi
>  ##########################################
>  # pixman support probe
> 
> -if test "$want_tools" = "no" -a "$softmmu" = "no"; then
> +if test "$want_tools" = "no" && test "$softmmu" = "no"; then
>    pixman_cflags=
>    pixman_libs=
>  elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
> @@ -3699,7 +3699,7 @@ else
>    done
>  fi
> 
> -if test "$mingw32" != yes -a "$pthread" = no; then
> +if test "$mingw32" != yes && test "$pthread" = no; then
>    error_exit "pthread check failed" \
>        "Make sure to have the pthread libs and headers installed."
>  fi
> @@ -3826,7 +3826,7 @@ fi
>  ##########################################
>  # TPM passthrough is only on x86 Linux
> 
> -if test "$targetos" = Linux && test "$cpu" = i386 -o "$cpu" = x86_64; then
> +if test "$targetos" = Linux && { test "$cpu" = i386 || test "$cpu" = x86_64; }; then
>    tpm_passthrough=$tpm
>  else
>    tpm_passthrough=no
> @@ -3992,7 +3992,7 @@ EOF
>    fi
>  fi
> 
> -if test "$opengl" = "yes" -a "$have_x11" = "yes"; then
> +if test "$opengl" = "yes" && test "$have_x11" = "yes"; then
>    for target in $target_list; do
>      case $target in
>        lm32-softmmu) # milkymist-tmu2 requires X11 and OpenGL
> @@ -4612,8 +4612,8 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
>    libs_qga="$libs_qga -lrt"
>  fi
> 
> -if test "$darwin" != "yes" -a "$mingw32" != "yes" -a "$solaris" != yes -a \
> -        "$haiku" != "yes" ; then
> +if test "$darwin" != "yes" && test "$mingw32" != "yes" && \
> +        test "$solaris" != yes && test "$haiku" != "yes" ; then
>      libs_softmmu="-lutil $libs_softmmu"
>  fi
> 
> @@ -4688,7 +4688,8 @@ fi
>  ##########################################
>  # check if we have VSS SDK headers for win
> 
> -if test "$mingw32" = "yes" -a "$guest_agent" != "no" -a "$vss_win32_sdk" != "no" ; then
> +if test "$mingw32" = "yes" && test "$guest_agent" != "no" && \
> +        test "$vss_win32_sdk" != "no" ; then
>    case "$vss_win32_sdk" in
>      "")   vss_win32_include="-isystem $source_path" ;;
>      *\ *) # The SDK is installed in "Program Files" by default, but we cannot
> @@ -4727,7 +4728,8 @@ fi
>  # VSS provider from the source. It is usually unnecessary because the
>  # pre-compiled .tlb file is included.
> 
> -if test "$mingw32" = "yes" -a "$guest_agent" != "no" -a "$guest_agent_with_vss" = "yes" ; then
> +if test "$mingw32" = "yes" && test "$guest_agent" != "no" && \
> +        test "$guest_agent_with_vss" = "yes" ; then
>    if test -z "$win_sdk"; then
>      programfiles="$PROGRAMFILES"
>      test -n "$PROGRAMW6432" && programfiles="$PROGRAMW6432"
> @@ -4743,7 +4745,7 @@ fi
> 
>  ##########################################
>  # check if mingw environment provides a recent ntddscsi.h
> -if test "$mingw32" = "yes" -a "$guest_agent" != "no"; then
> +if test "$mingw32" = "yes" && test "$guest_agent" != "no"; then
>    cat > $TMPC << EOF
>  #include <windows.h>
>  #include <ntddscsi.h>
> @@ -4790,7 +4792,7 @@ case "$capstone" in
>    "" | yes)
>      if $pkg_config capstone; then
>        capstone=system
> -    elif test -e "${source_path}/.git" -a $git_update = 'yes' ; then
> +    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
>        capstone=git
>      elif test -e "${source_path}/capstone/Makefile" ; then
>        capstone=internal
> @@ -5162,7 +5164,7 @@ fi
>  # There is no point enabling this if cpuid.h is not usable,
>  # since we won't be able to select the new routines.
> 
> -if test "$cpuid_h" = "yes" -a "$avx2_opt" != "no"; then
> +if test "$cpuid_h" = "yes" && test "$avx2_opt" != "no"; then
>    cat > $TMPC << EOF
>  #pragma GCC push_options
>  #pragma GCC target("avx2")
> @@ -5220,7 +5222,7 @@ EOF
>  fi
> 
>  cmpxchg128=no
> -if test "$int128" = yes -a "$atomic128" = no; then
> +if test "$int128" = yes && test "$atomic128" = no; then
>    cat > $TMPC << EOF
>  int main(void)
>  {
> @@ -5893,9 +5895,9 @@ fi
> 
>  # Mac OS X ships with a broken assembler
>  roms=
> -if test \( "$cpu" = "i386" -o "$cpu" = "x86_64" \) -a \
> -        "$targetos" != "Darwin" -a "$targetos" != "SunOS" -a \
> -        "$softmmu" = yes ; then
> +if { test "$cpu" = "i386" || test "$cpu" = "x86_64"; } && \
> +        test "$targetos" != "Darwin" && test "$targetos" != "SunOS" && \
> +        test "$softmmu" = yes ; then
>      # Different host OS linkers have different ideas about the name of the ELF
>      # emulation. Linux and OpenBSD/amd64 use 'elf_i386'; FreeBSD uses the _fbsd
>      # variant; OpenBSD/i386 uses the _obsd variant; and Windows uses i386pe.
> @@ -5907,7 +5909,7 @@ if test \( "$cpu" = "i386" -o "$cpu" = "x86_64" \) -a \
>          fi
>      done
>  fi
> -if test "$cpu" = "ppc64" -a "$targetos" != "Darwin" ; then
> +if test "$cpu" = "ppc64" && test "$targetos" != "Darwin" ; then
>    roms="$roms spapr-rtas"
>  fi
> 
> @@ -6373,7 +6375,7 @@ if test "$modules" = "yes"; then
>    echo "CONFIG_STAMP=_$( (echo $qemu_version; echo $pkgversion; cat $0) | $shacmd - | cut -f1 -d\ )" >> $config_host_mak
>    echo "CONFIG_MODULES=y" >> $config_host_mak
>  fi
> -if test "$have_x11" = "yes" -a "$need_x11" = "yes"; then
> +if test "$have_x11" = "yes" && test "$need_x11" = "yes"; then
>    echo "CONFIG_X11=y" >> $config_host_mak
>    echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
>    echo "X11_LIBS=$x11_libs" >> $config_host_mak
> @@ -6568,7 +6570,7 @@ fi
>  if test "$vhost_scsi" = "yes" ; then
>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>  fi
> -if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
> +if test "$vhost_net" = "yes" && test "$vhost_user" = "yes"; then
>    echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
>  fi
>  if test "$vhost_crypto" = "yes" ; then
> @@ -6963,11 +6965,11 @@ elif test "$ARCH" = "sparc64" ; then
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/sparc $QEMU_INCLUDES"
>  elif test "$ARCH" = "s390x" ; then
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/s390 $QEMU_INCLUDES"
> -elif test "$ARCH" = "x86_64" -o "$ARCH" = "x32" ; then
> +elif test "$ARCH" = "x86_64" || test "$ARCH" = "x32" ; then
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
>  elif test "$ARCH" = "ppc64" ; then
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
> -elif test "$ARCH" = "riscv32" -o "$ARCH" = "riscv64" ; then
> +elif test "$ARCH" = "riscv32" || test "$ARCH" = "riscv64" ; then
>    QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/riscv $QEMU_INCLUDES"
>  else
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
> @@ -7384,7 +7386,7 @@ if test ! -z "$gdb_xml_files" ; then
>    echo "TARGET_XML_FILES=$list" >> $config_target_mak
>  fi
> 
> -if test "$target_user_only" = "yes" -a "$bflt" = "yes"; then
> +if test "$target_user_only" = "yes" && test "$bflt" = "yes"; then
>    echo "TARGET_HAS_BFLT=y" >> $config_target_mak
>  fi
>  if test "$target_bsd_user" = "yes" ; then
> @@ -7506,7 +7508,7 @@ if test "$gprof" = "yes" ; then
>    fi
>  fi
> 
> -if test "$target_linux_user" = "yes" -o "$target_bsd_user" = "yes" ; then
> +if test "$target_linux_user" = "yes" || test "$target_bsd_user" = "yes" ; then
>    ldflags="$ldflags $textseg_ldflags"
>  fi
> 
> @@ -7518,7 +7520,8 @@ fi
>  #  - we build the system emulation for s390x (qemu-system-s390x)
>  #  - KVM is enabled
>  #  - the linker supports --s390-pgste
> -if test "$TARGET_ARCH" = "s390x" -a "$target_softmmu" = "yes"  -a "$ARCH" = "s390x" -a "$kvm" = "yes"; then
> +if test "$TARGET_ARCH" = "s390x" && test "$target_softmmu" = "yes" && \
> +        test "$ARCH" = "s390x" && test "$kvm" = "yes"; then
>      if ld_has --s390-pgste ; then
>          ldflags="-Wl,--s390-pgste $ldflags"
>      fi
> 
