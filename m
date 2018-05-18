Received: from eggs.gnu.org ([2001:4830:134:3::10]:47775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgLK-00027K-At
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgLH-0003tB-He
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:50 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:40461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgLH-0003sn-Di
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:47 -0400
Received: by mail-qk0-x230.google.com with SMTP id s83-v6so6563078qke.7
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:26:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-45-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <808487cd-05c1-4b4a-bd20-e5ded42f2cc8@amsat.org>
Date: Fri, 18 May 2018 11:26:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-45-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 44/49] tests/tcg: enable building for
 mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>

On 05/17/2018 02:47 PM, Alex Bennée wrote:
> As before, using Debian SID compilers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                       |  1 +
>  tests/docker/dockerfiles/debian-mips64-cross.docker | 12 ++++++++++++
>  tests/tcg/mips/Makefile.include                     |  3 +++
>  3 files changed, 16 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 62d1f4dec0..f58afb8c5d 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -67,6 +67,7 @@ docker-image-debian-hppa-cross: docker-image-debian-sid
>  docker-image-debian-m68k-cross: docker-image-debian-sid
>  docker-image-debian-sh4-cross: docker-image-debian-sid
>  docker-image-debian-sparc64-cross: docker-image-debian-sid
> +docker-image-debian-mips64-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=1
>  
>  # Expand all the pre-requistes for each docker image and test combination
> diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/docker/dockerfiles/debian-mips64-cross.docker
> new file mode 100644
> index 0000000000..ed1ce0e919
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-mips64-cross.docker
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
> +        gcc-mips64-linux-gnuabi64 \
> +        libc6-dev-mips64-cross
> diff --git a/tests/tcg/mips/Makefile.include b/tests/tcg/mips/Makefile.include
> index a9beceb623..4a14fc078d 100644
> --- a/tests/tcg/mips/Makefile.include
> +++ b/tests/tcg/mips/Makefile.include
> @@ -8,6 +8,9 @@
>  ifeq ($(TARGET_NAME),mips64el)
>  DOCKER_IMAGE=debian-mips64el-cross
>  DOCKER_CROSS_COMPILER=mips64el-linux-gnuabi64-gcc
> +else ifeq ($(TARGET_NAME),mips64)
> +DOCKER_IMAGE=debian-mips64-cross
> +DOCKER_CROSS_COMPILER=mips64-linux-gnuabi64-gcc
>  else ifeq ($(TARGET_NAME),mipsel)
>  DOCKER_IMAGE=debian-mipsel-cross
>  DOCKER_CROSS_COMPILER=mipsel-linux-gnu-gcc
> 

Using a snapshot:

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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
