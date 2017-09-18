Received: from eggs.gnu.org ([2001:4830:134:3::10]:55512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsN8-0008FJ-Et
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsN4-00081C-Gh
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:29:46 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:44904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dtsN4-00080x-9p
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:29:42 -0400
Received: by mail-wm0-x236.google.com with SMTP id 189so12272608wmh.1
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 02:29:42 -0700 (PDT)
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-14-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170918024402.3265-14-famz@redhat.com>
Date: Mon, 18 Sep 2017 10:29:39 +0100
Message-ID: <87fubkjqws.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 13/13] docker: Use archive-source.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


Fam Zheng <famz@redhat.com> writes:

> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/Makefile.include | 15 ++-------------
>  tests/docker/run              |  8 +-------
>  2 files changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index aaab1a4208..7a027d5bd6 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -17,24 +17,13 @@ DOCKER_TOOLS := travis
>  TESTS ?= %
>  IMAGES ?= %
>
> -# Make archive from git repo $1 to tar.gz $2
> -make-archive-maybe = $(if $(wildcard $1/*), \
> -	$(call quiet-command, \
> -		(cd $1; if git diff-index --quiet HEAD -- &>/dev/null; then \
> -			git archive -1 HEAD --format=tar.gz; \
> -		else \
> -			git archive -1 $$(git stash create) --format=tar.gz; \
> -		fi) > $2, \
> -		"ARCHIVE","$(notdir $2)"))
> -
>  CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
>  DOCKER_SRC_COPY := docker-src.$(CUR_TIME)
>
>  $(DOCKER_SRC_COPY):
>  	@mkdir $@
> -	$(call make-archive-maybe, $(SRC_PATH), $@/qemu.tgz)
> -	$(call make-archive-maybe, $(SRC_PATH)/dtc, $@/dtc.tgz)
> -	$(call make-archive-maybe, $(SRC_PATH)/pixman, $@/pixman.tgz)
> +	$(call quiet-command, $(SRC_PATH)/scripts/archive-source.sh $@/qemu.tar, \
> +		"GEN", "$@/qemu.tar")
>  	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
>  		"COPY","RUNNER")
>
> diff --git a/tests/docker/run b/tests/docker/run
> index c1e4513bce..9eb9165f76 100755
> --- a/tests/docker/run
> +++ b/tests/docker/run
> @@ -32,13 +32,7 @@ export TEST_DIR=/tmp/qemu-test
>  mkdir -p $TEST_DIR/{src,build,install}
>
>  # Extract the source tarballs
> -tar -C $TEST_DIR/src -xzf $BASE/qemu.tgz
> -for p in dtc pixman; do
> -    if test -f $BASE/$p.tgz; then
> -        tar -C $TEST_DIR/src/$p -xzf $BASE/$p.tgz
> -        export FEATURES="$FEATURES $p"
> -    fi
> -done
> +tar -C $TEST_DIR/src -xf $BASE/qemu.tar
>
>  if test -n "$SHOW_ENV"; then
>      if test -f /packages.txt; then


--
Alex Bennée
