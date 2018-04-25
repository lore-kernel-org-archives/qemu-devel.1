Received: from eggs.gnu.org ([2001:4830:134:3::10]:55475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLDT-0000NO-6E
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLDO-0005dn-Dd
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:16:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLDO-0005da-8l
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:16:10 -0400
Received: by mail-qt0-x243.google.com with SMTP id a25-v6so26988908qtm.1
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:16:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-41-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <13dde1ff-6365-dd69-0cfa-948c8d97a7cb@amsat.org>
Date: Wed, 25 Apr 2018 11:16:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-41-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 40/46] tests/tcg: enable building for sh4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> As before, using Debian SID compilers. While the compiler can be
> coerced into generating big-endian code it seems the linker can't deal
> with it so we only enable the building for little endian SH4.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                    |  1 +
>  tests/docker/dockerfiles/debian-sh4-cross.docker | 12 ++++++++++++
>  tests/tcg/sh4/Makefile.include                   |  4 ++++
>  3 files changed, 17 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
>  create mode 100644 tests/tcg/sh4/Makefile.include
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 15c52127c7..c08f32ca58 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -65,6 +65,7 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
>  docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-debian-hppa-cross: docker-image-debian-sid
>  docker-image-debian-m68k-cross: docker-image-debian-sid
> +docker-image-debian-sh4-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=1
>  
>  # Expand all the pre-requistes for each docker image and test combination
> diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/docker/dockerfiles/debian-sh4-cross.docker
> new file mode 100644
> index 0000000000..88a2423094
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-sh4-cross.docker
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
> +        gcc-sh4-linux-gnu \
> +        libc6-dev-sh4-cross
> diff --git a/tests/tcg/sh4/Makefile.include b/tests/tcg/sh4/Makefile.include
> new file mode 100644
> index 0000000000..ad21594d9d
> --- /dev/null
> +++ b/tests/tcg/sh4/Makefile.include
> @@ -0,0 +1,4 @@
> +ifneq ($(TARGET_NAME), sh4eb)
> +DOCKER_IMAGE=debian-sh4-cross
> +DOCKER_CROSS_COMPILER=sh4-linux-gnu-gcc
> +endif
> 

$ make -j1 run-tcg-tests-sh4-linux-user
  GEN     sh4-linux-user/config-target.h
  BUILD   debian-sid
  BUILD   debian-sh4-cross
  CROSS-BUILD sh4 guest-tests with docker qemu:debian-sh4-cross
  BUILD   debian-sid
  BUILD   debian-sh4-cross
  CROSS-BUILD sh4 guest-tests with docker qemu:debian-sh4-cross
  RUN-TESTS for sh4
  TEST    test-mmap (default) on sh4
  TEST    test-mmap (8k pages) on sh4
  TEST    test-mmap (16k pages) on sh4
  TEST    test-mmap (32k pages) on sh4
  TEST    sha1 on sh4
  BROKEN TEST linux-test SKIPPED on sh4
  TEST    testthread on sh4

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
