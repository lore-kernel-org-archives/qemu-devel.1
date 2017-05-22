Received: from eggs.gnu.org ([2001:4830:134:3::10]:34480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo0i-0006mU-3y
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCo0e-0001o7-MU
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:08:36 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCo0e-0001nu-FW
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:08:32 -0400
Received: by mail-wm0-x22e.google.com with SMTP id 7so65536639wmo.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 07:08:32 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-16-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-16-f4bug@amsat.org>
Date: Mon, 22 May 2017 15:08:35 +0100
Message-ID: <87zie52dcs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/24] docker: add powerpc build target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Aurelien Jarno <aurel32@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Vagrant Cascadian <vagrant@debian.org>, Michael Tokarev <mjt@tls.msk.ru>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include                      |  4 +--
>  .../docker/dockerfiles/debian-powerpc-cross.docker | 40 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 2 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 111b8090b2..9815976486 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -56,11 +56,13 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		"BUILD","$*")
>
>  docker-image-debian-mipsel-cross: EXTRA_FILES:=tests/docker/dockerfiles/debian-apt-fake.sh
> +docker-image-debian-powerpc-cross: EXTRA_FILES:=tests/docker/dockerfiles/debian-apt-fake.sh
>
>  # Enforce dependancies for composite images
>  docker-image-debian-armhf-cross: docker-image-debian
>  docker-image-debian-arm64-cross: docker-image-debian
>  docker-image-debian-mipsel-cross: docker-image-debian
> +docker-image-debian-powerpc-cross: docker-image-debian
>
>  # Expand all the pre-requistes for each docker image and test combination
>  $(foreach i,$(DOCKER_IMAGES), \
> @@ -111,8 +113,6 @@ docker:
>  	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
>  	@echo '    NOCACHE=1            Ignore cache when build images.'
>  	@echo '    EXECUTABLE=<path>    Include executable in image.'
> -	@echo '    EXTRA_FILES="<path> [... <path>]"'
> -	@echo '                         Include extra files in image.'

I'm fairly sure you didn't want to do this.

>
>  # This rule if for directly running against an arbitrary docker target.
>  # It is called by the expanded docker targets (e.g. make
> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> new file mode 100644
> index 0000000000..fa2cc7a657
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> @@ -0,0 +1,40 @@
> +#
> +# Docker powerpc cross-compiler target
> +#
> +# This docker target builds on the base debian image.
> +#
> +FROM qemu:debian
> +MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
> +
> +# Add the foreign architecture we want and install dependencies
> +RUN dpkg --add-architecture powerpc
> +RUN apt-get update
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        crossbuild-essential-powerpc
> +
> +# <kludge> to fix "following packages have unmet dependencies" ...
> +ADD debian-apt-fake.sh /usr/local/bin/apt-fake
> +RUN apt-get install -y --no-install-recommends \
> +        equivs \
> +        pkg-config
> +RUN apt-fake install \
> +        pkg-config:powerpc=0.28-1.1-fake && \
> +    ln -s pkg-config /usr/bin/powerpc-linux-gnu-pkg-config
> +ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
> +# </kludge>
> +
> +# Specify the cross prefix for this image (see tests/docker/common.rc)
> +ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get build-dep -yy -a powerpc qemu
> +RUN DEBIAN_FRONTEND=noninteractive \
> +    apt-get install -y --no-install-recommends \
> +        glusterfs-common:powerpc \
> +        libbz2-dev:powerpc \
> +        liblzo2-dev:powerpc \
> +        libncursesw5-dev:powerpc \
> +        libnfs-dev:powerpc \
> +        librdmacm-dev:powerpc \
> +        libsnappy-dev:powerpc


--
Alex Bennée
