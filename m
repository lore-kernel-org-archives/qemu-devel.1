Received: from eggs.gnu.org ([2001:4830:134:3::10]:48754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSC18-0001Zb-6A
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSC13-0003aD-Fz
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:53:10 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSC13-0003a5-Ah
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:53:05 -0400
Received: by mail-qt0-x242.google.com with SMTP id i18-v6so18894564qtp.12
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 18:53:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
	<20180608123307.24773-41-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <abdbe000-3b80-d116-1183-10dae22fbd9e@amsat.org>
Date: Sun, 10 Jun 2018 22:52:57 -0300
MIME-Version: 1.0
In-Reply-To: <20180608123307.24773-41-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 40/49] tests/tcg: enable building for
 PowerPC
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
> Now we have restored debian-image-powerpc-cross using Debian SID
> compilers we can build for 32 bit powerpc. Although PPC32 supports a
> range of pages sizes currently only 4k works so the others are
> commented out for now.
> 
> We can also merge the ppc64 support under the base architecture
> directory to avoid too much proliferation of directories.

ppc64el doesn't seem to work:

$ make subdir-ppc64le-linux-user build-tcg-tests-ppc64el-linux-user -j1
make[1]: *** ppc64el-linux-user: No such file or directory.  Stop.
make: *** [tests/Makefile.include:947:
build-tcg-tests-ppc64el-linux-user] Error 2

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

ppc32:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v5
>   - new for v5
> ---
>  tests/tcg/ppc/Makefile.include     |  7 +++++++
>  tests/tcg/ppc/Makefile.target      | 12 ++++++++++++
>  tests/tcg/ppc64le/Makefile.include |  2 --
>  3 files changed, 19 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/ppc/Makefile.include
>  create mode 100644 tests/tcg/ppc/Makefile.target
>  delete mode 100644 tests/tcg/ppc64le/Makefile.include
> 
> diff --git a/tests/tcg/ppc/Makefile.include b/tests/tcg/ppc/Makefile.include
> new file mode 100644
> index 0000000000..b062c30dd3
> --- /dev/null
> +++ b/tests/tcg/ppc/Makefile.include
> @@ -0,0 +1,7 @@
> +ifeq ($(TARGET_NAME),ppc)
> +DOCKER_IMAGE=debian-powerpc-cross
> +DOCKER_CROSS_COMPILER=powerpc-linux-gnu-gcc
> +else ifeq ($(TARGET_NAME),ppc64le)
> +DOCKER_IMAGE=debian-ppc64el-cross
> +DOCKER_CROSS_COMPILER=powerpc64le-linux-gnu-gcc
> +endif
> diff --git a/tests/tcg/ppc/Makefile.target b/tests/tcg/ppc/Makefile.target
> new file mode 100644
> index 0000000000..f5e08c7376
> --- /dev/null
> +++ b/tests/tcg/ppc/Makefile.target
> @@ -0,0 +1,12 @@
> +# -*- Mode: makefile -*-
> +#
> +# PPC - included from tests/tcg/Makefile
> +#
> +
> +ifneq (,$(findstring 64,$(TARGET_NAME)))
> +# On PPC64 Linux can be configured with 4k (default) or 64k pages (currently broken)
> +EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-65536
> +else
> +# On PPC32 Linux supports 4K/16K/64K/256K (but currently only 4k works)
> +EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-16384 run-test-mmap-65536 run-test-mmap-262144
> +endif
> diff --git a/tests/tcg/ppc64le/Makefile.include b/tests/tcg/ppc64le/Makefile.include
> deleted file mode 100644
> index d71cfc9aa7..0000000000
> --- a/tests/tcg/ppc64le/Makefile.include
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -DOCKER_IMAGE=debian-ppc64el-cross
> -DOCKER_CROSS_COMPILER=powerpc64le-linux-gnu-gcc
> 
