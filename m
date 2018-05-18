Received: from eggs.gnu.org ([2001:4830:134:3::10]:46211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgGK-0005m4-E9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgGD-0006oq-TZ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:21:40 -0400
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:44884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgGD-0006oR-NX
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:21:33 -0400
Received: by mail-vk0-x22a.google.com with SMTP id x66-v6so4904095vka.11
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:21:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-39-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e33b816a-7bdf-f807-b6db-6f4077441b5c@amsat.org>
Date: Fri, 18 May 2018 11:21:21 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-39-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 38/49] tests/tcg: enable building for
 Alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Hi Alex,

On 05/17/2018 02:47 PM, Alex Bennée wrote:
> We can't use our normal Debian based compilers as Alpha isn't an
> officially supported architecture. However it is available as a port
> and fortunately cross compilers for all these targets are included in
> Debian Sid, the perpetual rolling/unstable/testing version of Debian.

I see 2/3 commits at once here.

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                 |  1 +
>  .../dockerfiles/debian-alpha-cross.docker     | 12 +++++++
>  .../dockerfiles/debian-cross-build.docker     | 36 +++++++++++++++++++
>  tests/docker/dockerfiles/debian-sid.docker    | 23 ++++++++++++
>  tests/tcg/alpha/Makefile.include              |  2 ++
>  5 files changed, 74 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker

^ Alpha

>  create mode 100644 tests/docker/dockerfiles/debian-cross-build.docker

^ for guest-tests I presume.

>  create mode 100644 tests/docker/dockerfiles/debian-sid.docker

^ cross base

I'd like to review the debian-sid.docker separately than the Alpha part.

>  create mode 100644 tests/tcg/alpha/Makefile.include
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 6a5aa9ec71..bcf44e80c4 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -62,6 +62,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
>  docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>  docker-image-debian-win64-cross: docker-image-debian8-mxe
> +docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=1
>  
>  # Expand all the pre-requistes for each docker image and test combination
> diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles/debian-alpha-cross.docker
> new file mode 100644
> index 0000000000..e446f7af3f
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
> @@ -0,0 +1,12 @@
> +#
> +# Docker cross-compiler target
> +#
> +# This docker target builds on the debian sid base image which
> +# contains cross compilers for Debian "ports" targets.
> +#
> +FROM qemu:debian-sid
> +
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        gcc-alpha-linux-gnu \
> +        libc6.1-dev-alpha-cross
> diff --git a/tests/docker/dockerfiles/debian-cross-build.docker b/tests/docker/dockerfiles/debian-cross-build.docker
> new file mode 100644
> index 0000000000..c3611a7d3a
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-cross-build.docker
> @@ -0,0 +1,36 @@
> +#
> +# Docker multiarch cross-compiler target
> +#
> +# This docker target is builds on Debian cross compiler targets to build distro
> +# with a selection of cross compilers for building test binaries.
> +#
> +# On its own you can't build much but the docker-foo-cross targets
> +# build on top of the base debian image.
> +#
> +FROM debian:stretch
> +
> +# Duplicate deb line as deb-src
> +RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
> +
> +# Install common build utilities
> +RUN apt update
> +RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt install -y --no-install-recommends \
> +        bison \
> +        build-essential \
> +        ca-certificates \
> +        flex \
> +        gettext \
> +        git \
> +        libgmp-dev \
> +        libmpfr-dev \
> +        libmpc-dev \
> +        pkg-config \
> +        psmisc \
> +        python \
> +        texinfo \
> +        wget \
> +        $(apt-get -s build-dep binutils | egrep ^Inst | cut -d\  -f2) \
> +        $(apt-get -s build-dep gcc | egrep ^Inst | cut -d\  -f2) \
> +        $(apt-get -s build-dep glibc | egrep ^Inst | cut -d\  -f2)
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
> new file mode 100644
> index 0000000000..adeb7134ca
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -0,0 +1,23 @@
> +#
> +# A number of our guests exist as ports only. We can either use the ports repo or get everything from SID
> +#
> +
> +FROM debian:sid-slim
> +
> +# Duplicate deb line as deb-src
> +RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
> +
> +# Install common build utilities
> +RUN apt update
> +RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt install -y --no-install-recommends \
> +        bison \
> +        build-essential \
> +        ca-certificates \
> +        flex \
> +        git \
> +        pkg-config \
> +        psmisc \
> +        python \
> +        texinfo
> diff --git a/tests/tcg/alpha/Makefile.include b/tests/tcg/alpha/Makefile.include
> new file mode 100644
> index 0000000000..c7dc48eadb
> --- /dev/null
> +++ b/tests/tcg/alpha/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=debian-alpha-cross
> +DOCKER_CROSS_COMPILER=alpha-linux-gnu-gcc
> 

Ignoring the Debian "Sid/unstable" problems (I'll develop this replying
to the cover), and using a snapshot:

-- >8 --
diff --git a/tests/docker/dockerfiles/debian-sid.docker
b/tests/docker/dockerfiles/debian-sid.docker
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >>
/etc/apt/sources.list
+# random 'working' snapshot
+RUN echo "deb
http://snapshot.debian.org/archive/debian/20180512T101008Z/ sid main" >
/etc/apt/sources.list && \
+    echo "deb-src
http://snapshot.debian.org/archive/debian/20180512T101008Z/ sid main" >>
/etc/apt/sources.list
--

For the Alpha part:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
