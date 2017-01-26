Received: from eggs.gnu.org ([2001:4830:134:3::10]:52635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWhgf-0007TC-Jj
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWhgc-0000HB-Fv
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:53:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWhgc-0000Gv-8E
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:53:50 -0500
Date: Thu, 26 Jan 2017 18:53:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170126105346.GH6879@lemon>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
	<20170124143346.22240-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170124143346.22240-6-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/7] new debian-multiarch-cross.docker:
 a cross-compiling docker guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>

On Tue, 01/24 14:33, Alex Benn=E9e wrote:
> This provides a basic Debian install with access to the emdebian cross
> compilers for armhf, arm64, mipsel and ppc64el. On its own it provides
> the basic cross build essentials for building any of those
> architectures. More complex cross-compilations would need to install
> library dependencies on top of this image.
>=20
> An example use:
>=20
>   docker run --rm -it \
>     -v /home/alex/lsrc/qemu/qemu.git/:/home/alex/lsrc/qemu/qemu.git/ \
>     --user=3Dalex:alex \
>     -w /home/alex/lsrc/qemu/qemu.git/arm-linux-user/tests \
>     -e CROSS_CC=3D"arm-linux-gnueabihf-gcc" \
>     debian:cross make -f ../../tests/tcg/arm/Makefile
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - add clang (keep shippable happy)
>   - rm adduser code (done direct now)
>   - add aptitude (useful for debugging package clashes)
> ---
>  .../dockerfiles/debian-multiarch-cross.docker      | 45 ++++++++++++++=
++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-multiarch-cross.doc=
ker
>=20
> diff --git a/tests/docker/dockerfiles/debian-multiarch-cross.docker b/t=
ests/docker/dockerfiles/debian-multiarch-cross.docker
> new file mode 100644
> index 0000000000..749fdf07e1
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-multiarch-cross.docker
> @@ -0,0 +1,45 @@
> +#
> +# Docker multiarch cross-compiler target
> +#
> +# This docker target is builds on Debian and Emdebian's cross compiler=
 targets
> +# to build distro with a selection of cross compilers for building tes=
t binaries.
> +#
> +# This does not include the build dependancies for QEMU as there are
> +# so many there are unresolvable clashes.
> +#
> +FROM debian:stable-slim
> +
> +# Setup some basic tools we need
> +RUN apt update
> +RUN apt install -yy curl aptitude
> +
> +# Setup Emdebian
> +RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/a=
pt/sources.list
> +RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.k=
ey | apt-key add -
> +
> +# Duplicate deb line as deb-src
> +RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sourc=
es.list
> +
> +# Add the foriegn architectures we want
> +RUN dpkg --add-architecture armhf
> +RUN dpkg --add-architecture arm64
> +RUN dpkg --add-architecture mipsel
> +RUN dpkg --add-architecture ppc64el
> +
> +#FIXME: Currently these cause clashes due to multi-arch being an ongoi=
g process

"ongoing"?

> +#RUN dpkg --add-architecture mips
> +#RUN dpkg --add-architecture powerpc
> +
> +# Final update
> +RUN apt update
> +
> +# Install the crossbuild essential packages
> +# FIXME: crossbuild-essential-powerpc has a clash with '/lib/ld.so.1'
> +RUN apt install -yy clang crossbuild-essential-arm64 crossbuild-essent=
ial-armhf crossbuild-essential-mipsel crossbuild-essential-ppc64el
> +
> +# Before you can actually build something you need to install its buil=
d dependancies.
> +# This is best done in a child container as architecture specific -dev=
 packages have a habit of clashing with
> +# each other because not everything is fully complient with the multia=
rch specififcation.

"compliant"?

> +#
> +# To install the QEMU build dependacnies you need to run:
> +# RUN apt-get build-dep -yy -a armhf qemu
> --=20
> 2.11.0
>=20

Does this image work with our tests, such as "make
docker-test-quick@debian-multiarch-cross"? If not let's put it into a dif=
ferent
folder okay?

Fam
