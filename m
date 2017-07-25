Received: from eggs.gnu.org ([2001:4830:134:3::10]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da0cE-00064Y-Gp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da0cA-0004lV-Rd
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:15:14 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1da0cA-0004kz-GH
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:15:10 -0400
Received: by mail-wm0-x231.google.com with SMTP id c184so53420315wmd.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:15:10 -0700 (PDT)
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-35-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170724182751.18261-35-f4bug@amsat.org>
Date: Tue, 25 Jul 2017 15:15:07 +0100
Message-ID: <87k22weh78.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 34/35] docker: add debian
 'bleeding' image with gcc7 and clang5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .../docker/dockerfiles/debian-bleeding-dev.docker  | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-bleeding-dev.docker
>
> diff --git a/tests/docker/dockerfiles/debian-bleeding-dev.docker b/tests/docker/dockerfiles/debian-bleeding-dev.docker
> new file mode 100644
> index 0000000000..d6ae20692c
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-bleeding-dev.docker
> @@ -0,0 +1,94 @@
> +#
> +# Docker x86_64 bleeding image
> +#
> +# This docker target builds on the debian unstable base image. Further
> +# libraries which are not widely available are installed by hand.
> +#

Not for 2.10 please.

> +FROM debian:unstable
> +
> +MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
> +
> +RUN echo 'Acquire::ForceIPv4 "true";' >> /etc/apt/apt.conf.d/01network
> +
> +# Duplicate deb line as deb-src
> +RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
> +
> +# Install common build utilities
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=noninteractive apt-get install -yy eatmydata
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        bison \
> +        build-essential \
> +        ca-certificates \
> +        ccache \
> +        flex \
> +        git \
> +        less \
> +        pkg-config \
> +        psmisc \
> +        python \
> +        texinfo \
> +        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        binutils-multiarch \
> +        gdb-multiarch \
> +        libnewlib-dev \
> +        musl-dev \
> +        uclibc-source
> +
> +############################################################################
> +# GCC 7
> +
> +RUN echo deb http://httpredir.debian.org/debian experimental main >> \
> +    /etc/apt/sources.list.d/experimental.list && apt-get update
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        gcc-7 \
> +        gcc-7-cross-base-ports \
> +        gcc-7-multilib \
> +        g++-7
> +
> +############################################################################
> +# Clang 5
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        curl gnupg
> +RUN curl http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
> +    echo 'deb http://apt.llvm.org/unstable/ llvm-toolchain main' \
> +        > /etc/apt/sources.list.d/llvm.list && \
> +    apt-get update
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        clang-5.0 \
> +        lldb-5.0 \
> +        llvm-5.0 && \
> +    test -x /usr/bin/clang || ln -s clang-5.0 /usr/bin/clang
> +
> +############################################################################
> +# QEMU specific starts here
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get build-dep -yy qemu
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        libbz2-dev \
> +        liblzo2-dev \
> +        librdmacm-dev \
> +        libsnappy-dev \
> +        libvte-dev
> +
> +# virgl
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        libegl1-mesa-dev \
> +        libepoxy-dev \
> +        libgbm-dev
> +RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer
> +RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure
> --with-glx --disable-tests && make install

There are a lot of moving parts basing this in debian unstable and
compiling extra bleeding edge stuff. What does this buy that the clang
and toolchain builds in Travis don't already cover?

> +
> +ENV QEMU_CONFIGURE_OPTS --host-cc=clang-5.0 --cc=clang-5.0 --cxx=clang++-5.0


--
Alex Bennée
