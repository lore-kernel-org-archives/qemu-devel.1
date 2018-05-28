Received: from eggs.gnu.org ([2001:4830:134:3::10]:54948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fNE6c-0004bs-Qr
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fNE6Z-00056e-Jm
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:06:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fNE6Z-00055n-E3
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:06:15 -0400
Date: Mon, 28 May 2018 17:06:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180528090611.GA4599@lemon.usersys.redhat.com>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141915.6497-1-alex.bennee@linaro.org>
	<20180525141915.6497-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180525141915.6497-4-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 43/49] docker: move debian-powerpc-cross
 to sid based build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Fri, 05/25 15:19, Alex Benn=E9e wrote:
> The original Jessie based cross builder hasn't worked for a while. The
> state of the libraries is still perilous for cross-building QEMU but
> we can use it for building TCG tests.
>=20
> The debian-apt-fake.sh script can also be dropped as it is no longer
> used.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                 |  4 +-
>  tests/docker/dockerfiles/debian-apt-fake.sh   | 46 -------------------
>  .../dockerfiles/debian-powerpc-cross.docker   | 39 +++-------------
>  tests/docker/dockerfiles/debian8.docker       |  3 --
>  4 files changed, 7 insertions(+), 85 deletions(-)
>  delete mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 36779645d7..d59314ee65 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -46,8 +46,6 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
>  		"BUILD","$*")
> =20
> -docker-image-debian-powerpc-cross: EXTRA_FILES:=3D$(SRC_PATH)/tests/do=
cker/dockerfiles/debian-apt-fake.sh
> -
>  # Enforce dependencies for composite images
>  docker-image-debian: docker-image-debian9
>  docker-image-debian8-mxe: docker-image-debian8
> @@ -57,7 +55,6 @@ docker-image-debian-armhf-cross: docker-image-debian9
>  docker-image-debian-arm64-cross: docker-image-debian9
>  docker-image-debian-mips-cross: docker-image-debian9
>  docker-image-debian-mips64el-cross: docker-image-debian9
> -docker-image-debian-powerpc-cross: docker-image-debian8
>  docker-image-debian-ppc64el-cross: docker-image-debian9
>  docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-win32-cross: docker-image-debian8-mxe
> @@ -69,6 +66,7 @@ docker-image-debian-sh4-cross: docker-image-debian-si=
d
>  docker-image-debian-sparc64-cross: docker-image-debian-sid
>  docker-image-debian-mips64-cross: docker-image-debian-sid
>  docker-image-debian-riscv64-cross: docker-image-debian-sid
> +docker-image-debian-powerpc-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=3D1
> =20
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
> diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker=
/dockerfiles/debian-apt-fake.sh
> deleted file mode 100755
> index 2ec0fdf47a..0000000000
> --- a/tests/docker/dockerfiles/debian-apt-fake.sh
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -#! /bin/sh
> -#
> -# Generate fake debian package to resolve unimportant unmet dependenci=
es held
> -# by upstream multiarch broken packages.
> -#
> -# Copyright (c) 2017 Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2
> -# or (at your option) any later version. See the COPYING file in
> -# the top-level directory.
> -
> -test $1 =3D "install" && shift 1
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
> -    name=3D$(echo $1|sed "s/\(.*\):\(.*\)=3D\(.*\)/\1/")
> -    arch=3D$(echo $1|sed "s/\(.*\):\(.*\)=3D\(.*\)/\2/")
> -    vers=3D$(echo $1|sed "s/\(.*\):\(.*\)=3D\(.*\)/\3/")
> -    apt-get install -q -yy $1 || fake_install $arch $name $vers
> -}
> -
> -for package in $*; do
> -    try_install $package
> -done
> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tes=
ts/docker/dockerfiles/debian-powerpc-cross.docker
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
> -MAINTAINER Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> +FROM qemu:debian-sid
> =20
> -# Add the foreign architecture we want and install dependencies
> -RUN dpkg --add-architecture powerpc
> -RUN apt-get update
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> -        crossbuild-essential-powerpc
> -
> -# <kludge> to fix "following packages have unmet dependencies" ...
> -ADD debian-apt-fake.sh /usr/local/bin/apt-fake
> -RUN apt-get install -y --no-install-recommends \
> -        equivs \
> -        pkg-config
> -RUN apt-fake install \
> -        pkg-config:powerpc=3D0.28-1.1-fake && \
> -    ln -s pkg-config /usr/bin/powerpc-linux-gnu-pkg-config
> -ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
> -# </kludge>
> -
> -# Specify the cross prefix for this image (see tests/docker/common.rc)
> -ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dpowerpc-linux-gnu-
> -
> -RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -    apt-get build-dep -yy -a powerpc qemu
> -RUN DEBIAN_FRONTEND=3Dnoninteractive \
> -    apt-get install -y --no-install-recommends \
> -        glusterfs-common:powerpc \
> -        libbz2-dev:powerpc \
> -        liblzo2-dev:powerpc \
> -        libncursesw5-dev:powerpc \
> -        libnfs-dev:powerpc \
> -        librdmacm-dev:powerpc \
> -        libsnappy-dev:powerpc
> +        gcc-powerpc-linux-gnu \
> +        libc6-dev-powerpc-cross || { echo "Failed to build - see debia=
n-sid.docker notes"; exit 1; }
> diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/doc=
kerfiles/debian8.docker
> index 1bcf2e3d2f..52945631cd 100644
> --- a/tests/docker/dockerfiles/debian8.docker
> +++ b/tests/docker/dockerfiles/debian8.docker
> @@ -32,6 +32,3 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          pkg-config \
>          python-minimal
> =20
> -# Setup Emdebian [emdebian-archive-keyring]
> -RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/ap=
t/sources.list.d/emdebian.list && \
> -    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.k=
ey | apt-key add -
> --=20
> 2.17.0
>=20

Nice clean up!

Reviewed-by: Fam Zheng <famz@redhat.com>
