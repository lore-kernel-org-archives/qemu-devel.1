Received: from eggs.gnu.org ([2001:4830:134:3::10]:48204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgNA-0003hk-Dt
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgN5-0005Jh-Ni
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:28:44 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:40456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgN5-0005JR-Ic
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:28:39 -0400
Received: by mail-qt0-x243.google.com with SMTP id h2-v6so10485546qtp.7
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:28:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-44-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97fd88b9-c0c1-2d69-724f-f26144e36a2e@amsat.org>
Date: Fri, 18 May 2018 11:28:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-44-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 43/49] tests/tcg: enable building for
 sparc64
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
>  tests/docker/dockerfiles/debian-sparc64-cross.docker | 12 ++++++++++++
>  tests/tcg/sparc64/Makefile.include                   |  2 ++
>  3 files changed, 15 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker
>  create mode 100644 tests/tcg/sparc64/Makefile.include
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index c08f32ca58..62d1f4dec0 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -66,6 +66,7 @@ docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-debian-hppa-cross: docker-image-debian-sid
>  docker-image-debian-m68k-cross: docker-image-debian-sid
>  docker-image-debian-sh4-cross: docker-image-debian-sid
> +docker-image-debian-sparc64-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=1
>  
>  # Expand all the pre-requistes for each docker image and test combination
> diff --git a/tests/docker/dockerfiles/debian-sparc64-cross.docker b/tests/docker/dockerfiles/debian-sparc64-cross.docker
> new file mode 100644
> index 0000000000..1e2c809274
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-sparc64-cross.docker
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
> +        gcc-sparc64-linux-gnu \
> +        libc6-dev-sparc64-cross
> diff --git a/tests/tcg/sparc64/Makefile.include b/tests/tcg/sparc64/Makefile.include
> new file mode 100644
> index 0000000000..95fc8dee9f
> --- /dev/null
> +++ b/tests/tcg/sparc64/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=debian-sparc64-cross
> +DOCKER_CROSS_COMPILER=sparc64-linux-gnu-gcc
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
