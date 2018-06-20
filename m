Received: from eggs.gnu.org ([2001:4830:134:3::10]:34746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVjfN-0008CO-6b
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVjfJ-0002rR-TM
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:25:21 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVjfJ-0002rH-J7
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:25:17 -0400
Received: by mail-qt0-x241.google.com with SMTP id q6-v6so854484qtn.7
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 13:25:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180620132032.12952-1-alex.bennee@linaro.org>
	<20180620132032.12952-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e84de975-f434-cd1b-e360-88224c67360d@amsat.org>
Date: Wed, 20 Jun 2018 17:25:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180620132032.12952-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/5] build-system: remove per-test GCOV
 reporting
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

On 06/20/2018 10:20 AM, Alex Bennée wrote:
> I'm not entirely sure who's using this information and certainly in a
> CI environment it just washes over as additional noise. Later patches
> will provide new reporting options so a user who wants to analyse
> individual tests will be able to use that to get the information.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  docs/devel/testing.rst | 11 +++++------
>  tests/Makefile.include | 10 ----------
>  2 files changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index f33e5a8423..66ef219f69 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -158,12 +158,11 @@ rarely used. See "QEMU iotests" section below for more information.
>  GCC gcov support
>  ----------------
>  
> -``gcov`` is a GCC tool to analyze the testing coverage by instrumenting the
> -tested code. To use it, configure QEMU with ``--enable-gcov`` option and build.
> -Then run ``make check`` as usual. There will be additional ``gcov`` output as
> -the testing goes on, showing the test coverage percentage numbers per analyzed
> -source file. More detailed reports can be obtained by running ``gcov`` command
> -on the output files under ``$build_dir/tests/``, please read the ``gcov``
> +``gcov`` is a GCC tool to analyze the testing coverage by
> +instrumenting the tested code. To use it, configure QEMU with
> +``--enable-gcov`` option and build. Then run ``make check`` as usual.
> +Reports can be obtained by running ``gcov`` command on the output
> +files under ``$build_dir/tests/``, please read the ``gcov``
>  documentation for more information.
>  
>  QEMU iotests
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ca91da26cb..55d54bd180 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -891,26 +891,16 @@ GCOV_OPTIONS = -n $(if $(V),-f,)
>  
>  .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
>  $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu $(check-qtest-y)
> -	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>  	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
>  		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
>  		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
>  		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
> -	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$*-y) $(gcov-files-generic-y); do \
> -	  echo Gcov report for $$f:;\
> -	  $(GCOV) $(GCOV_OPTIONS) $$f -o `dirname $$f`; \
> -	done,)
>  
>  .PHONY: $(patsubst %, check-%, $(check-unit-y) $(check-speed-y))
>  $(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
> -	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>  	$(call quiet-command, \
>  		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
>  		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $*,"GTESTER","$*")
> -	$(if $(CONFIG_GCOV),@for f in $(gcov-files-$(subst tests/,,$*)-y) $(gcov-files-generic-y); do \
> -	  echo Gcov report for $$f:;\
> -	  $(GCOV) $(GCOV_OPTIONS) $$f -o `dirname $$f`; \
> -	done,)
>  
>  # gtester tests with XML output
>  
> 
