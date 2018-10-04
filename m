Received: from eggs.gnu.org ([2001:4830:134:3::10]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83aM-0002Ca-CQ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83ZF-00006a-Nx
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g83ZF-00005W-ID
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:25 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so13001671itd.5
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<2510f7c260bd2cbdf1b6089c2a021e6434cb0d38.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <2510f7c260bd2cbdf1b6089c2a021e6434cb0d38.1538652143.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Oct 2018 17:21:11 +0400
Message-ID: <CAMxuvayJMM2G2b2USz6HLithrXNbqGyc3-CeQ5=067-6oqMz_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/11] configure: add test for libudev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tomas Golembiovsky <tgolembi@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>, sjubran@redhat.com, okrishtal@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com> wrote:
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  configure | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/configure b/configure
> index 0f168607e8..ac24cb3975 100755
> --- a/configure
> +++ b/configure
> @@ -477,6 +477,7 @@ libxml2=3D""
>  docker=3D"no"
>  debug_mutex=3D"no"
>  libpmem=3D""
> +libudev=3D"no"
>
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
>  cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
> @@ -873,6 +874,7 @@ Linux)
>    vhost_vsock=3D"yes"
>    QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $=
QEMU_INCLUDES"
>    supported_os=3D"yes"
> +  libudev=3D"yes"
>  ;;
>  esac
>
> @@ -5676,6 +5678,20 @@ if test "$libnfs" !=3D "no" ; then
>    fi
>  fi
>
> +##########################################
> +# Do we have libudev
> +if test "$libudev" !=3D "no" ; then
> +  if $pkg_config libudev; then
> +    libudev=3D"yes"
> +    libudev_libs=3D$($pkg_config --libs libudev)
> +  else
> +    if test "$libudev" =3D "yes" ; then
> +      feature_not_found "libudev" "Install systemd development files"
> +    fi
> +    libudev=3D"no"
> +  fi
> +fi
> +
>  # Now we've finished running tests it's OK to add -Werror to the compile=
r flags
>  if test "$werror" =3D "yes"; then
>      QEMU_CFLAGS=3D"-Werror $QEMU_CFLAGS"
> @@ -6100,6 +6116,7 @@ echo "VxHS block device $vxhs"
>  echo "capstone          $capstone"
>  echo "docker            $docker"
>  echo "libpmem support   $libpmem"
> +echo "libudev           $libudev"
>
>  if test "$sdl_too_old" =3D "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL suppor=
t"
> @@ -6944,6 +6961,11 @@ if test "$docker" !=3D "no"; then
>      echo "HAVE_USER_DOCKER=3Dy" >> $config_host_mak
>  fi
>
> +if test "$libudev" !=3D "no"; then
> +    echo "CONFIG_LIBUDEV=3Dy" >> $config_host_mak
> +    echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
> +fi
> +
>  # use included Linux headers
>  if test "$linux" =3D "yes" ; then
>    mkdir -p linux-headers
> --
> 2.19.0
>
