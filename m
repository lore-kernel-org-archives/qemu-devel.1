Received: from eggs.gnu.org ([2001:4830:134:3::10]:46006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBhl-0002Rs-N8
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBhh-00020t-LV
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:33:09 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBhh-00020l-FI
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:33:05 -0400
Received: by mail-qt0-x243.google.com with SMTP id a18-v6so1621985qtj.4
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 18:33:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
	<20180608123307.24773-40-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1288eb56-9ffd-cc02-9e0e-1bddcf452519@amsat.org>
Date: Sun, 10 Jun 2018 22:30:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180608123307.24773-40-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 39/49] docker: move debian-powerpc-cross
 to sid based build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 06/08/2018 09:32 AM, Alex Bennée wrote:
> The original Jessie based cross builder hasn't worked for a while. The
> state of the libraries is still perilous for cross-building QEMU but
> we can use it for building TCG tests.
> 
> The debian-apt-fake.sh script can also be dropped as it is no longer
> used.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/Makefile.include                 |  4 +-
>  tests/docker/dockerfiles/debian-apt-fake.sh   | 46 -------------------
>  .../dockerfiles/debian-powerpc-cross.docker   | 39 +++-------------
>  tests/docker/dockerfiles/debian8.docker       |  3 --
>  4 files changed, 7 insertions(+), 85 deletions(-)
>  delete mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 10f98916f9..78568d7c61 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -47,8 +47,6 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
>  		"BUILD","$*")
>  
> -docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerfiles/debian-apt-fake.sh
> -
>  # Enforce dependencies for composite images
>  docker-image-debian: docker-image-debian9
>  docker-image-debian8-mxe: docker-image-debian8
> @@ -58,7 +56,6 @@ docker-image-debian-armhf-cross: docker-image-debian9
>  docker-image-debian-arm64-cross: docker-image-debian9
>  docker-image-debian-mips-cross: docker-image-debian9
>  docker-image-debian-mips64el-cross: docker-image-debian9
> -docker-image-debian-powerpc-cross: docker-image-debian8
>  docker-image-debian-ppc64el-cross: docker-image-debian9
>  docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-win32-cross: docker-image-debian8-mxe
> @@ -76,6 +73,7 @@ docker-image-debian-sh4-cross: docker-image-debian-sid
>  docker-image-debian-sparc64-cross: docker-image-debian-sid
>  docker-image-debian-mips64-cross: docker-image-debian-sid
>  docker-image-debian-riscv64-cross: docker-image-debian-sid
> +docker-image-debian-powerpc-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=1
>  
>  # Specialist build images, sometimes very limited tools
> diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/dockerfiles/debian-apt-fake.sh
> deleted file mode 100755
> index 2ec0fdf47a..0000000000
> --- a/tests/docker/dockerfiles/debian-apt-fake.sh
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -#! /bin/sh
> -#
> -# Generate fake debian package to resolve unimportant unmet dependencies held
> -# by upstream multiarch broken packages.
> -#
> -# Copyright (c) 2017 Philippe Mathieu-Daudé <f4bug@amsat.org>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2
> -# or (at your option) any later version. See the COPYING file in
> -# the top-level directory.
> -
> -test $1 = "install" && shift 1
> -
> -fake_install()
> -{
> -    echo "Generating fake $2 $1 $3 ..."
> -    (cd /var/cache/apt/archives
> -        (cat << 'EOF'
> -Section: misc
> -Priority: optional
> -Standards-Version: 3.9.2
> -
> -Package: NAME
> -Version: VERSION
> -Maintainer: qemu-devel@nongnu.org
> -Architecture: any
> -Multi-Arch: same
> -Description: fake NAME
> -EOF
> -        ) | sed s/NAME/$2/g | sed s/VERSION/$3/g > $2.control
> -        equivs-build -a $1 $2.control 1>/dev/null 2>/dev/null
> -        dpkg -i --force-overwrite $2_$3_$1.deb
> -    )
> -}
> -
> -try_install()
> -{
> -    name=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\1/")
> -    arch=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\2/")
> -    vers=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\3/")
> -    apt-get install -q -yy $1 || fake_install $arch $name $vers
> -}
> -
> -for package in $*; do
> -    try_install $package
> -done
> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> index a5dd46b4ac..5e62ca0df1 100644
> --- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
> +++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> @@ -1,40 +1,13 @@
>  #
>  # Docker powerpc cross-compiler target
>  #
> -# This docker target builds on the debian Jessie base image.
> +# This docker target builds on the debian sid base image which
> +# contains cross compilers for Debian "ports" targets. The original
> +# Jessie based no longer builds.
>  #
> -FROM qemu:debian8
> -MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
> +FROM qemu:debian-sid
>  
> -# Add the foreign architecture we want and install dependencies
> -RUN dpkg --add-architecture powerpc
> -RUN apt-get update
>  RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> -        crossbuild-essential-powerpc
> -
> -# <kludge> to fix "following packages have unmet dependencies" ...
> -ADD debian-apt-fake.sh /usr/local/bin/apt-fake
> -RUN apt-get install -y --no-install-recommends \
> -        equivs \
> -        pkg-config
> -RUN apt-fake install \
> -        pkg-config:powerpc=0.28-1.1-fake && \
> -    ln -s pkg-config /usr/bin/powerpc-linux-gnu-pkg-config
> -ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
> -# </kludge>
> -
> -# Specify the cross prefix for this image (see tests/docker/common.rc)
> -ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-
> -
> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> -    apt-get build-dep -yy -a powerpc qemu
> -RUN DEBIAN_FRONTEND=noninteractive \
> -    apt-get install -y --no-install-recommends \
> -        glusterfs-common:powerpc \
> -        libbz2-dev:powerpc \
> -        liblzo2-dev:powerpc \
> -        libncursesw5-dev:powerpc \
> -        libnfs-dev:powerpc \
> -        librdmacm-dev:powerpc \
> -        libsnappy-dev:powerpc
> +        gcc-powerpc-linux-gnu \
> +        libc6-dev-powerpc-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
> diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
> index 1bcf2e3d2f..52945631cd 100644
> --- a/tests/docker/dockerfiles/debian8.docker
> +++ b/tests/docker/dockerfiles/debian8.docker
> @@ -32,6 +32,3 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          pkg-config \
>          python-minimal
>  
> -# Setup Emdebian [emdebian-archive-keyring]
> -RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/emdebian.list && \
> -    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
> 
