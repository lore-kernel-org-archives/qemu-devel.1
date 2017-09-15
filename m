Received: from eggs.gnu.org ([2001:4830:134:3::10]:50414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dssTz-00088Q-EP
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dssTv-0003uu-Ex
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:24:43 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:46704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dssTv-0003uZ-8Q
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:24:39 -0400
Received: by mail-wr0-x231.google.com with SMTP id o42so2113751wrb.3
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:24:39 -0700 (PDT)
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-9-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170809202712.6951-9-f4bug@amsat.org>
Date: Fri, 15 Sep 2017 16:24:36 +0100
Message-ID: <87r2v87znv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 08/16] travis: reorder matrix
 to speedup failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index e56c928bef..57462b0471 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -64,11 +64,11 @@ env:
>      - MAKEFLAGS="-j3"
>    matrix:
>      - CONFIG=""
> -    - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
>      - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
>      - CONFIG="--enable-modules"
>      - CONFIG="--with-coroutine=ucontext"
>      - CONFIG="--with-coroutine=sigaltstack"
> +    - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
>  git:
>    # we want to do this ourselves
>    submodules: false
> @@ -83,30 +83,32 @@ script:
>    - make ${MAKEFLAGS} && ${TEST_CMD}
>  matrix:
>    include:
> +    # We manually include builds which we disable "make check" for, they also
> +    # are the faster jobs (no testing).
> +    - env: CONFIG="--disable-tcg"
> +           TEST_CMD=""
> +      compiler: gcc
> +    - env: CONFIG="--enable-trace-backends=ust"
> +           TEST_CMD=""
> +      compiler: gcc
> +    - env: CONFIG="--enable-debug --enable-tcg-interpreter"
> +           TEST_CMD=""
> +      compiler: gcc
> +    - env: CONFIG="--enable-trace-backends=simple"
> +           TEST_CMD=""
> +      compiler: gcc
> +    - env: CONFIG="--enable-trace-backends=ftrace"
> +           TEST_CMD=""
> +      compiler: gcc
>      # Test with CLang for compile portability
>      - env: CONFIG=""
>        compiler: clang
> +
>      # gprof/gcov are GCC features
>      - env: CONFIG="--enable-gprof --disable-pie"
>        compiler: gcc
>      - env: CONFIG="--enable-gcov --disable-pie"
>        compiler: gcc
> -    # We manually include builds which we disable "make check" for
> -    - env: CONFIG="--enable-debug --enable-tcg-interpreter"
> -           TEST_CMD=""
> -      compiler: gcc
> -    - env: CONFIG="--enable-trace-backends=simple"
> -           TEST_CMD=""
> -      compiler: gcc
> -    - env: CONFIG="--enable-trace-backends=ftrace"
> -           TEST_CMD=""
> -      compiler: gcc
> -    - env: CONFIG="--enable-trace-backends=ust"
> -           TEST_CMD=""
> -      compiler: gcc
> -    - env: CONFIG="--disable-tcg"
> -           TEST_CMD=""
> -      compiler: gcc
>      - env: CONFIG=""
>        os: osx
>        compiler: clang


--
Alex Bennée
