Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGppO-0002FC-JA
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGppN-0001vY-Le
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:25:50 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGppN-0001vJ-EC
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:25:49 -0500
Received: by mail-wr0-x244.google.com with SMTP id 4so8794623wrt.0
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 09:25:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171120171728.31266-1-berrange@redhat.com>
References: <20171120171728.31266-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 17:25:27 +0000
Message-ID: <CAFEAcA9CxyLdE6cs9sEf6YasA+cmFSgUkvj__3ePSMncjD+wng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] build: disarm the TCG unit test trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 November 2017 at 17:17, Daniel P. Berrange <berrange@redhat.com> wrote:
> Developers sometimes mistakenly run 'make test' instead of 'make check'.
> 'make test' triggers the ancient, unmaintained tcg unit tests in
> tests/tcg/Makefile which have long since ceased compiling.
>
> Even if someone fixes the TCG tests, it makes little sense to put
> them in a 'make test' target, rather they should be 'make check-tcg',
> possibly wired up as a dependency of 'make check'.
>
> In the meantime, this patch disarms the 'make test' trap by turning
> it into a synonym for 'make check'.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/Makefile.include | 1 +
>  tests/tcg/Makefile     | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 434a2ce868..55fd99f451 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -919,6 +919,7 @@ check-unit: $(patsubst %,check-%, $(check-unit-y))
>  check-speed: $(patsubst %,check-%, $(check-speed-y))
>  check-block: $(patsubst %,check-%, $(check-block-y))
>  check: check-qapi-schema check-unit check-qtest
> +test: check
>  check-clean:
>         $(MAKE) -C tests/tcg clean
>         rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
> diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
> index 89e3342f3d..4b5d196326 100644
> --- a/tests/tcg/Makefile
> +++ b/tests/tcg/Makefile
> @@ -36,9 +36,6 @@ ifneq ($(call find-in-path, $(CC_I386)),)
>  TESTS += $(I386_TESTS)
>  endif
>
> -all: $(patsubst %,run-%,$(TESTS))
> -test: all
> -
>  # rules to run tests
>
>  .PHONY: $(patsubst %,run-%,$(TESTS))
> --
> 2.14.3

I'm inclined to prefer having 'make test' just fail rather
than silently behave like 'make check'.

thanks
-- PMM
