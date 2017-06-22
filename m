Received: from eggs.gnu.org ([2001:4830:134:3::10]:42740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzFE-0006VQ-BX
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzFD-0005Dy-6Z
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:21:48 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNzFC-0005Do-UA
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:21:47 -0400
Received: by mail-wr0-x236.google.com with SMTP id k67so16857564wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:21:46 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-14-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-14-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 11:22:29 +0100
Message-ID: <877f04tj8a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/21] travis: improve ccache use
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

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Can you expand the commit message to breifly explain what all these
extra settings change. What is CCACHE_SLOPINESS and ccache -s doing?

> ---
>  .travis.yml | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index a7512f3ab0..96ddc16cfd 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -68,6 +68,8 @@ env:
>        # be kind with Travis free plan, restrict to at most 4 cores
>      - PARALLEL_JOBS="$(($(test ${HW_CORES} -gt ${VM_CORES} && echo ${VM_CORES} || echo ${HW_CORES}) + 1))"
>      - HOMEBREW_MAKE_JOBS="${PARALLEL_JOBS}"
> +    # ccache
> +    - CCACHE_SLOPPINESS="file_macro,time_macros"
>      # tests
>      - TEST_CMD="make -j${PARALLEL_JOBS} check"
>    matrix:
> @@ -82,14 +84,21 @@ git:
>    submodules: false
>  before_install:
>    - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew update ; fi
> -  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ; fi
> +  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then brew install libffi gettext glib pixman ccache ; fi
>    - git submodule update --init --recursive
>  before_script:
> +  # https://docs.travis-ci.com/user/caching#ccache-on-os-x
> +  - if [ "$TRAVIS_OS_NAME" == "osx" ]; then export PATH=/usr/local/opt/ccache/libexec:$PATH ; fi
> +  - if [ "$CC" == "clang" ]; then export CCACHE_CPP2=1 ; fi
> +  - if [ -x "$(command -v ccache 2>/dev/null)" ]; then export CC="ccache ${CC}"; ccache -s -M 0 -z; fi
>    - echo "Using ${PARALLEL_JOBS} parallel jobs"
> +  - export HOST_CC="${CC}"
>    - ./configure ${CONFIG}
>  script:
> -  - make -j${PARALLEL_JOBS}
> +  - make -j${PARALLEL_JOBS} && ccache -s
>    - ${TEST_CMD}
> +before_cache:
> +  - ccache -s
>  matrix:
>    include:
>      # Test with CLang for compile portability
> @@ -112,6 +121,7 @@ matrix:
>             TEST_CMD=""
>        compiler: gcc
>      - env: CONFIG=""
> +           CCACHE_SLOPPINESS="file_macro,time_macros,include_file_ctime,include_file_mtime"
>        os: osx
>        compiler: clang
>      # Plain Trusty System Build


--
Alex Bennée
