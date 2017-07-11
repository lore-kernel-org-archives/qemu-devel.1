Received: from eggs.gnu.org ([2001:4830:134:3::10]:58895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlss-0005AU-RN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlso-00046l-L5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:30:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlso-000464-EU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:30:42 -0400
Received: by mail-it0-f67.google.com with SMTP id o202so1233785itc.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:30:42 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170711031000.24844-18-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
	<20170711031000.24844-18-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:29:41 -0300
Message-ID: <CAAdtpL4HH19dTxzqwb23+2hD6Vf=2bMczOX3j499uYg7RctFuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 17/18] shippable: add powerpc target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hmmm it seems I squashed "add debian/powerpc" (only docker + Makefile)
altogether with this one (shippable entry)

On Tue, Jul 11, 2017 at 12:09 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .shippable.yml                                     |  2 ++
>  tests/docker/Makefile.include                      |  3 ++
>  .../docker/dockerfiles/debian-powerpc-cross.docker | 40 ++++++++++++++++=
++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker
>
> diff --git a/.shippable.yml b/.shippable.yml
> index 7a89341cea..4c8a85941f 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -18,6 +18,8 @@ env:
>      # mips64el-softmmu disabled due to libfdt problem
>      - IMAGE=3Ddebian-mipsel-cross
>        TARGET_LIST=3Dmipsel-softmmu,mipsel-linux-user,mips64el-linux-user
> +    - IMAGE=3Ddebian-powerpc-cross
> +      TARGET_LIST=3Dppc-softmmu,ppcemb-softmmu,ppc-linux-user
>      - IMAGE=3Ddebian-ppc64el-cross
>        TARGET_LIST=3Dppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
>  build:
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
> index d2a81b0d71..a6babf4f1d 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -55,11 +55,14 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>                 $(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),=
\
>                 "BUILD","$*")
>
> +docker-image-debian-powerpc-cross: EXTRA_FILES:=3Dtests/docker/dockerfil=
es/debian-apt-fake.sh
> +
>  # Enforce dependancies for composite images
>  docker-image-debian-armel-cross: docker-image-debian9
>  docker-image-debian-armhf-cross: docker-image-debian9
>  docker-image-debian-arm64-cross: docker-image-debian9
>  docker-image-debian-mipsel-cross: docker-image-debian9
> +docker-image-debian-powerpc-cross: docker-image-debian8
>  docker-image-debian-ppc64el-cross: docker-image-debian9
>  docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-amd64-cross: docker-image-debian9
> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests=
/docker/dockerfiles/debian-powerpc-cross.docker
> new file mode 100644
> index 0000000000..a5dd46b4ac
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> @@ -0,0 +1,40 @@
> +#
> +# Docker powerpc cross-compiler target
> +#
> +# This docker target builds on the debian Jessie base image.
> +#
> +FROM qemu:debian8
> +MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +
> +# Add the foreign architecture we want and install dependencies
> +RUN dpkg --add-architecture powerpc
> +RUN apt-get update
> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        crossbuild-essential-powerpc
> +
> +# <kludge> to fix "following packages have unmet dependencies" ...
> +ADD debian-apt-fake.sh /usr/local/bin/apt-fake
> +RUN apt-get install -y --no-install-recommends \
> +        equivs \
> +        pkg-config
> +RUN apt-fake install \
> +        pkg-config:powerpc=3D0.28-1.1-fake && \
> +    ln -s pkg-config /usr/bin/powerpc-linux-gnu-pkg-config
> +ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
> +# </kludge>
> +
> +# Specify the cross prefix for this image (see tests/docker/common.rc)
> +ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dpowerpc-linux-gnu-
> +
> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt-get build-dep -yy -a powerpc qemu
> +RUN DEBIAN_FRONTEND=3Dnoninteractive \
> +    apt-get install -y --no-install-recommends \
> +        glusterfs-common:powerpc \
> +        libbz2-dev:powerpc \
> +        liblzo2-dev:powerpc \
> +        libncursesw5-dev:powerpc \
> +        libnfs-dev:powerpc \
> +        librdmacm-dev:powerpc \
> +        libsnappy-dev:powerpc
> --
> 2.13.2
>
