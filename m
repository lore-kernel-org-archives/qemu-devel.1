Received: from eggs.gnu.org ([2001:4830:134:3::10]:60584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coqOR-0008W0-9A
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coqON-0003OA-La
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coqON-0003Np-Cv
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:49:59 -0400
Date: Fri, 17 Mar 2017 11:49:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170317114953.GF8050@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Mar 17, 2017 at 11:08:22AM +0000, Peter Maydell wrote:
> We plan to drop support in a future QEMU release for host OSes
> and host architectures for which we have no test machine where
> we can build and run tests. For the 2.9 release, make configure
> print a warning if it is run on such a host, so that the user
> has some warning of the plans and can volunteer to help us
> maintain the port if they need it to continue to function.
> 
> This commit flags up as deprecated the CPU architectures:
>  * ia64
>  * sparc
>  * anything which we don't have a TCG port for
>    (and which was presumably using TCI)

This seems to imply that if we remove supported for these architectures,
then TCI is no longer required either, or would there be other reasons
to want to keep TCI around, even when all host archs have a TCG port ? 

> and the OSes:
>  * Cygwin
>  * GNU/kFreeBSD
>  * FreeBSD
>  * DragonFly BSD
>  * NetBSD
>  * OpenBSD
>  * Solaris
>  * AIX
>  * Haiku
> 
> It also makes entirely unrecognized host OS strings be
> rejected rather than treated as if they were Linux (which
> likely never worked).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This list is definitely too all-encompassing, and we should
> move at least some of the BSDs into "not-deprecated".
> I'm posting the patch for the moment for code review on the
> logic and as a placeholder.

FreeBSD is the one where I most frequently see developers engaging across
the overall virt tools stack (QEMU/libvirt/virt-manager/OpenStack).
GNU/kFreeBSD has come up a few times in libvirt, and I don't recall seeing
anyone mentioning the remaining BSDs - though perhaps thats because the
FreeBSD port fixes are enough to also make other BSDs work.

> diff --git a/configure b/configure
> index 75c7c35..5ddc985 100755
> --- a/configure
> +++ b/configure
> @@ -321,6 +321,9 @@ tcmalloc="no"
>  jemalloc="no"
>  replication="yes"
>  
> +supported_cpu="no"
> +supported_os="no"
> +
>  # parse CC options first
>  for opt do
>    optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
> @@ -517,23 +520,32 @@ ARCH=
>  # Normalise host CPU name and set ARCH.
>  # Note that this case should only have supported host CPUs, not guests.
>  case "$cpu" in
> -  ia64|ppc|ppc64|s390|s390x|sparc64|x32)
> +  ppc|ppc64|s390|s390x|x32)
> +    cpu="$cpu"
> +    supported_cpu="yes"
> +  ;;
> +  ia64|sparc64)
>      cpu="$cpu"
>    ;;
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu="i386"
> +    supported_cpu="yes"
>    ;;
>    x86_64|amd64)
>      cpu="x86_64"
> +    supported_cpu="yes"
>    ;;
>    armv*b|armv*l|arm)
>      cpu="arm"
> +    supported_cpu="yes"
>    ;;
>    aarch64)
>      cpu="aarch64"
> +    supported_cpu="yes"
>    ;;
>    mips*)
>      cpu="mips"
> +    supported_cpu="yes"
>    ;;
>    sparc|sun4[cdmuv])
>      cpu="sparc"
> @@ -568,6 +580,7 @@ MINGW32*)
>    else
>      audio_drv_list=""
>    fi
> +  supported_os="yes"
>  ;;
>  GNU/kFreeBSD)
>    bsd="yes"
> @@ -626,6 +639,7 @@ Darwin)
>    # won't work when we're compiling with gcc as a C compiler.
>    QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
>    HOST_VARIANT_DIR="darwin"
> +  supported_os="yes"
>  ;;
>  SunOS)
>    solaris="yes"
> @@ -672,7 +686,7 @@ Haiku)
>    QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
>    LIBS="-lposix_error_mapper -lnetwork $LIBS"
>  ;;
> -*)
> +Linux)
>    audio_drv_list="oss"
>    audio_possible_drivers="oss alsa sdl pa"
>    linux="yes"
> @@ -682,6 +696,10 @@ Haiku)
>    vhost_scsi="yes"
>    vhost_vsock="yes"
>    QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
> +  supported_os="yes"
> +;;
> +*)
> +  error_exit "Unsupported host OS $targetos"
>  ;;
>  esac
>  
> @@ -5095,6 +5113,32 @@ if test "$sdl_too_old" = "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
>  fi
>  
> +if test "$supported_cpu" = "no"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!"
> +    echo
> +    echo "CPU host architecture $cpu support is not currently maintained."
> +    echo "The QEMU project intends to remove support for this host CPU in"
> +    echo "a future release if nobody volunteers to maintain it and to"
> +    echo "provide a build host for our continuous integration setup."
> +    echo "configure has succeeded and you can continue to build, but"
> +    echo "if you care about QEMU on this platform you should contact"
> +    echo "us upstream at qemu-devel@nongnu.org."
> +fi
> +
> +if test "$supported_os" = "no"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!"
> +    echo
> +    echo "CPU host OS $targetos support is not currently maintained."
> +    echo "The QEMU project intends to remove support for this host CPU in"
> +    echo "a future release if nobody volunteers to maintain it and to"
> +    echo "provide a build host for our continuous integration setup."
> +    echo "configure has succeeded and you can continue to build, but"
> +    echo "if you care about QEMU on this platform you should contact"
> +    echo "us upstream at qemu-devel@nongnu.org."
> +fi
> +
>  config_host_mak="config-host.mak"
>  
>  echo "# Automatically generated by configure - do not modify" >config-all-disas.mak

The approach here all looks sane.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
