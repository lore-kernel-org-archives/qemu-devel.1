Received: from eggs.gnu.org ([2001:4830:134:3::10]:42497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzDx-0005yi-Rw
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzDu-0004fn-Ge
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:20:29 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNzDu-0004fQ-AT
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:20:26 -0400
Received: by mail-wr0-x230.google.com with SMTP id 77so16923214wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:20:26 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-13-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-13-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 11:21:08 +0100
Message-ID: <878tkktjaj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/21] travis: build using all available
 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Few improvement as of today, but if Travis release their limit on the opensource
> plan or upgrade their hardware, new builds will get some benefit.
>
> Restrict to as most 4 cores to respect Travis Open Source plan.

You need to mention you are also enabling a parallel make check here.

>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .travis.yml | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 777914f759..a7512f3ab0 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -62,7 +62,14 @@ notifications:
>      on_failure: always
>  env:
>    global:
> -    - TEST_CMD="make check"
> +    # jobs
> +      # detects cores on the hosting hardware, rather than the VM (https://docs.travis-ci.com/user/languages/c#hints)
> +    - VM_CORES="4" HW_CORES="$(getconf _NPROCESSORS_ONLN)"
> +      # be kind with Travis free plan, restrict to at most 4 cores
> +    - PARALLEL_JOBS="$(($(test ${HW_CORES} -gt ${VM_CORES} && echo ${VM_CORES} || echo ${HW_CORES}) + 1))"
> +    - HOMEBREW_MAKE_JOBS="${PARALLEL_JOBS}"
> +    # tests
> +    - TEST_CMD="make -j${PARALLEL_JOBS} check"
>    matrix:
>      - CONFIG=""
>      - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
> @@ -78,9 +85,11 @@ before_install:
>    - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
>    - git submodule update --init --recursive
>  before_script:
> +  - echo "Using ${PARALLEL_JOBS} parallel jobs"
>    - ./configure ${CONFIG}
>  script:
> -  - make -j3 && ${TEST_CMD}
> +  - make -j${PARALLEL_JOBS}
> +  - ${TEST_CMD}
>  matrix:
>    include:
>      # Test with CLang for compile portability
> @@ -234,7 +243,7 @@ matrix:
>        group: edge
>        env:
>          - COVERITY=1
> -        - COVERITY_BUILD_CMD="make -j3"
> +        - COVERITY_BUILD_CMD="make -j${PARALLEL_JOBS}"
>          - COVERITY_EMAIL=peter.maydell@linaro.org
>          # This 'secure' setting sets COVERITY_TOKEN=<secret token>
>          # and was created with travis encrypt -r qemu/qemu COVERITY_TOKEN=...


--
Alex Bennée
