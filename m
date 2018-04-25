Received: from eggs.gnu.org ([2001:4830:134:3::10]:59081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLPd-0001xP-Au
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLPZ-0004Wu-CM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:28:49 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLPZ-0004Wc-7r
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:28:45 -0400
Received: by mail-qk0-x244.google.com with SMTP id d125so6719037qkb.8
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:28:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-40-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <85bb0031-ee39-3504-1e19-e5023e21342a@amsat.org>
Date: Wed, 25 Apr 2018 11:28:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-40-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 39/46] tests/tcg: enable building for
 m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> As before, using Debian SID compilers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                     |  1 +
>  tests/docker/dockerfiles/debian-m68k-cross.docker | 12 ++++++++++++
>  tests/tcg/m68k/Makefile.include                   |  2 ++
>  3 files changed, 15 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
>  create mode 100644 tests/tcg/m68k/Makefile.include
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 2471c4f30a..15c52127c7 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -64,6 +64,7 @@ docker-image-debian-win32-cross: docker-image-debian8-mxe
>  docker-image-debian-win64-cross: docker-image-debian8-mxe
>  docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-debian-hppa-cross: docker-image-debian-sid
> +docker-image-debian-m68k-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=1
>  
>  # Expand all the pre-requistes for each docker image and test combination
> diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/docker/dockerfiles/debian-m68k-cross.docker
> new file mode 100644
> index 0000000000..21ba3b0132
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-m68k-cross.docker
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
> +        gcc-m68k-linux-gnu \
> +        libc6-dev-m68k-cross
> diff --git a/tests/tcg/m68k/Makefile.include b/tests/tcg/m68k/Makefile.include
> new file mode 100644
> index 0000000000..cd7c6bf50d
> --- /dev/null
> +++ b/tests/tcg/m68k/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=debian-m68k-cross
> +DOCKER_CROSS_COMPILER=m68k-linux-gnu-gcc

$ make -j1 run-tcg-tests-m68k-linux-user
  BUILD   debian-sid
  BUILD   debian-m68k-cross
  CROSS-BUILD m68k guest-tests with docker qemu:debian-m68k-cross
/source/qemu/tests/tcg/m68k/Makefile.target:8: warning: overriding
recipe for target 'run-test-mmap'
/source/qemu/tests/tcg/multiarch/Makefile.target:26: warning: ignoring
old recipe for target 'run-test-mmap'
  BUILD   debian-sid
  BUILD   debian-m68k-cross
  CROSS-BUILD m68k guest-tests with docker qemu:debian-m68k-cross
/source/qemu/tests/tcg/m68k/Makefile.target:8: warning: overriding
recipe for target 'run-test-mmap'
/source/qemu/tests/tcg/multiarch/Makefile.target:26: warning: ignoring
old recipe for target 'run-test-mmap'
  RUN-TESTS for m68k
/source/qemu/tests/tcg/m68k/Makefile.target:8: warning: overriding
recipe for target 'run-test-mmap'
/source/qemu/tests/tcg/multiarch/Makefile.target:26: warning: ignoring
old recipe for target 'run-test-mmap'
  TEST    test-mmap (default) on m68k
  TEST    sha1 on m68k
  BROKEN TEST linux-test SKIPPED on m68k
  TEST    testthread on m68k

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
