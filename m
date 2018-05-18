Received: from eggs.gnu.org ([2001:4830:134:3::10]:46867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgIi-0007WX-1r
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgIg-0000rz-Tv
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:24:08 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:43037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgIg-0000rS-Oy
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:24:06 -0400
Received: by mail-qt0-x234.google.com with SMTP id f13-v6so10450068qtp.10
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:24:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-46-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <45d110eb-8014-f1d2-fbe4-d1d62d7c5882@amsat.org>
Date: Fri, 18 May 2018 11:24:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-46-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 45/49] tests/tcg: enable building for
 RISCV64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 05/17/2018 02:47 PM, Alex Bennée wrote:
> As before, using Debian SID compilers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                        |  1 +
>  tests/docker/dockerfiles/debian-riscv64-cross.docker | 12 ++++++++++++
>  tests/tcg/riscv/Makefile.include                     | 10 ++++++++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-riscv64-cross.docker
>  create mode 100644 tests/tcg/riscv/Makefile.include
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index f58afb8c5d..d00887bdf1 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -68,6 +68,7 @@ docker-image-debian-m68k-cross: docker-image-debian-sid
>  docker-image-debian-sh4-cross: docker-image-debian-sid
>  docker-image-debian-sparc64-cross: docker-image-debian-sid
>  docker-image-debian-mips64-cross: docker-image-debian-sid
> +docker-image-debian-riscv64-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=1
>  
>  # Expand all the pre-requistes for each docker image and test combination
> diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
> new file mode 100644
> index 0000000000..2b2e64cee6
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
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
> +        gcc-riscv64-linux-gnu \
> +        libc6-dev-riscv64-cross
> diff --git a/tests/tcg/riscv/Makefile.include b/tests/tcg/riscv/Makefile.include
> new file mode 100644
> index 0000000000..d92ac6c89f
> --- /dev/null
> +++ b/tests/tcg/riscv/Makefile.include
> @@ -0,0 +1,10 @@
> +#
> +# Makefile.include for all RISCV targets
> +#
> +# Debian only really cares about 64 bit going forward
> +#
> +
> +ifeq ($(TARGET_NAME),riscv64)
> +DOCKER_IMAGE=debian-riscv64-cross
> +DOCKER_CROSS_COMPILER=riscv64-linux-gnu-gcc
> +endif
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
