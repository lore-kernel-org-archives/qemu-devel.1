Received: from eggs.gnu.org ([2001:4830:134:3::10]:34262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evOBJ-0008Vq-Fv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evOBD-0003yr-M4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:12:05 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evOBD-0003tb-FV
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:11:59 -0400
Received: by mail-wr0-x243.google.com with SMTP id v65so15829091wrc.11
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 07:11:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312120849.20073-1-marcandre.lureau@redhat.com>
References: <20180312120849.20073-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 15:11:57 +0100
Message-ID: <CAJ+F1CJM2mk8BKUm=kkKwTJJSjqNT7Hd0pdLM_=ZTMzxnb6FHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: make docker-test-debug@fedora run
 sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi Fam,

It would be great if patchew could run the debug/sanitizer build.
Unfortunately, except x86 target, the run is full of ASAN leaks or
warnings.

Do you think patchew could learn to do regression testing? By that I
mean that patchew could compare a patchset output with the current
master (that output should be cached for multiple tests). The output
to compare here would be the errors reported by ASAN during the build.
(eventually, this could be used for other metrics some day). If so,
would you be willing to help me implementing it?


On Mon, Mar 12, 2018 at 1:08 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Since --enable-debug no longer enable sanitizers, we need explicit
> --enable-sanitizers.
>
> llvm package is required for llvm-symbolizer, to get symbols in
> backtraces.
>
> Add make V=3D1 to get details about failing tests.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  tests/docker/test-debug                | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 994a35a332..a00004319e 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -2,7 +2,7 @@ FROM fedora:27
>  ENV PACKAGES \
>      ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostna=
me \
>      glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> -    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> +    gcc gcc-c++ llvm clang make perl which bc findutils libaio-devel \
>      nettle-devel libasan libubsan \
>      mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-con=
fig \
>      mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libt=
asn1 \
> diff --git a/tests/docker/test-debug b/tests/docker/test-debug
> index d020b06917..d3f9f70d01 100755
> --- a/tests/docker/test-debug
> +++ b/tests/docker/test-debug
> @@ -1,6 +1,6 @@
>  #!/bin/bash -e
>  #
> -# Compile and check with clang & --enable-debug.
> +# Compile and check with clang & --enable-debug --enable-sanitizers.
>  #
>  # Copyright (c) 2016-2018 Red Hat Inc.
>  #
> @@ -19,8 +19,8 @@ requires clang asan
>  cd "$BUILD_DIR"
>
>  OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang"
> -OPTS=3D"--enable-debug $OPTS"
> +OPTS=3D"--enable-debug --enable-sanitizers $OPTS"
>
>  build_qemu $OPTS
> -make $MAKEFLAGS check
> +make $MAKEFLAGS V=3D1 check
>  install_qemu
> --
> 2.16.2.346.g9779355e34
>
>



--=20
Marc-Andr=C3=A9 Lureau
