Received: from eggs.gnu.org ([2001:4830:134:3::10]:57790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqO0s-0002JM-DH
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqO0p-0005A0-Pz
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cqO0p-00059v-HW
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:56:03 -0400
References: <1490106717-9542-1-git-send-email-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <472e433e-8cd7-4762-c102-bf7a4ca91afc@redhat.com>
Date: Tue, 21 Mar 2017 18:55:51 +0100
MIME-Version: 1.0
In-Reply-To: <1490106717-9542-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 21.03.2017 15:31, Peter Maydell wrote:
> We plan to drop support in a future QEMU release for host OSes
> and host architectures for which we have no test machine where
> we can build and run tests. For the 2.9 release, make configure
> print a warning if it is run on such a host, so that the user
> has some warning of the plans and can volunteer to help us
> maintain the port if they need it to continue to function.
>=20
> This commit flags up as deprecated the CPU architectures:
>  * ia64
>  * sparc
>  * anything which we don't have a TCG port for
>    (and which was presumably using TCI)
> and the OSes:
>  * GNU/kFreeBSD
>  * DragonFly BSD
>  * NetBSD
>  * OpenBSD
>  * Solaris
>  * AIX
>  * Haiku
>=20
> It also makes entirely unrecognized host OS strings be
> rejected rather than treated as if they were Linux (which
> likely never worked).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2: mark FreeBSD as 'supported' as I have got a
> VM config going for it for build tests.
> NetBSD doesn't boot inside KVM (!), and OpenBSD I have got
> running but "make check" hangs where we try to run guest code.
>=20
>  configure | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
>=20
> diff --git a/configure b/configure
> index 02e3b69..3291603 100755
> --- a/configure
> +++ b/configure
> @@ -321,6 +321,9 @@ tcmalloc=3D"no"
>  jemalloc=3D"no"
>  replication=3D"yes"
> =20
> +supported_cpu=3D"no"
> +supported_os=3D"no"
> +
>  # parse CC options first
>  for opt do
>    optarg=3D$(expr "x$opt" : 'x[^=3D]*=3D\(.*\)')
> @@ -517,23 +520,32 @@ ARCH=3D
>  # Normalise host CPU name and set ARCH.
>  # Note that this case should only have supported host CPUs, not guests=
.
>  case "$cpu" in
> -  ia64|ppc|ppc64|s390|s390x|sparc64|x32)
> +  ppc|ppc64|s390|s390x|x32)
> +    cpu=3D"$cpu"
> +    supported_cpu=3D"yes"
> +  ;;
> +  ia64|sparc64)
>      cpu=3D"$cpu"
>    ;;
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu=3D"i386"
> +    supported_cpu=3D"yes"
>    ;;
>    x86_64|amd64)
>      cpu=3D"x86_64"
> +    supported_cpu=3D"yes"
>    ;;
>    armv*b|armv*l|arm)
>      cpu=3D"arm"
> +    supported_cpu=3D"yes"
>    ;;
>    aarch64)
>      cpu=3D"aarch64"
> +    supported_cpu=3D"yes"
>    ;;
>    mips*)
>      cpu=3D"mips"
> +    supported_cpu=3D"yes"
>    ;;
>    sparc|sun4[cdmuv])
>      cpu=3D"sparc"
> @@ -562,6 +574,7 @@ MINGW32*)
>    else
>      audio_drv_list=3D""
>    fi
> +  supported_os=3D"yes"
>  ;;
>  GNU/kFreeBSD)
>    bsd=3D"yes"
> @@ -579,6 +592,7 @@ FreeBSD)
>    libs_qga=3D"-lutil $libs_qga"
>    netmap=3D""  # enable netmap autodetect
>    HOST_VARIANT_DIR=3D"freebsd"
> +  supported_os=3D"yes"
>  ;;
>  DragonFly)
>    bsd=3D"yes"
> @@ -620,6 +634,7 @@ Darwin)
>    # won't work when we're compiling with gcc as a C compiler.
>    QEMU_CFLAGS=3D"-DOS_OBJECT_USE_OBJC=3D0 $QEMU_CFLAGS"
>    HOST_VARIANT_DIR=3D"darwin"
> +  supported_os=3D"yes"
>  ;;
>  SunOS)
>    solaris=3D"yes"
> @@ -666,7 +681,7 @@ Haiku)
>    QEMU_CFLAGS=3D"-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
>    LIBS=3D"-lposix_error_mapper -lnetwork $LIBS"
>  ;;
> -*)
> +Linux)
>    audio_drv_list=3D"oss"
>    audio_possible_drivers=3D"oss alsa sdl pa"
>    linux=3D"yes"
> @@ -676,6 +691,10 @@ Haiku)
>    vhost_scsi=3D"yes"
>    vhost_vsock=3D"yes"
>    QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers=
 $QEMU_INCLUDES"
> +  supported_os=3D"yes"
> +;;
> +*)
> +  error_exit "Unsupported host OS $targetos"

I'd still prefer if we could start with a warning here instead of a hard
error ... but well, if someone really wants to compile on an unsupported
host OS, I guess they are also smart enough to patch the configure
script here on their own... so I shut up now... ;-)

>  ;;
>  esac
> =20
> @@ -5108,6 +5127,32 @@ if test "$sdl_too_old" =3D "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL supp=
ort"
>  fi
> =20
> +if test "$supported_cpu" =3D "no"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RE=
LEASES!"
> +    echo
> +    echo "CPU host architecture $cpu support is not currently maintain=
ed."
> +    echo "The QEMU project intends to remove support for this host CPU=
 in"
> +    echo "a future release if nobody volunteers to maintain it and to"
> +    echo "provide a build host for our continuous integration setup."
> +    echo "configure has succeeded and you can continue to build, but"
> +    echo "if you care about QEMU on this platform you should contact"
> +    echo "us upstream at qemu-devel@nongnu.org."
> +fi
> +
> +if test "$supported_os" =3D "no"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE REL=
EASES!"
> +    echo
> +    echo "CPU host OS $targetos support is not currently maintained."

Maybe rather just "Host OS" instead of "CPU host OS" ?

> +    echo "The QEMU project intends to remove support for this host CPU=
 in"

At least here I think you should replace "host CPU" with "host OS". With
that modification:

Reviewed-by: Thomas Huth <thuth@redhat.com>

> +    echo "a future release if nobody volunteers to maintain it and to"
> +    echo "provide a build host for our continuous integration setup."
> +    echo "configure has succeeded and you can continue to build, but"
> +    echo "if you care about QEMU on this platform you should contact"
> +    echo "us upstream at qemu-devel@nongnu.org."
> +fi
> +
>  config_host_mak=3D"config-host.mak"
> =20
>  echo "# Automatically generated by configure - do not modify" >config-=
all-disas.mak
>=20
