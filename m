Received: from eggs.gnu.org ([209.51.188.92]:55248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcfZ-00041p-W6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpcfT-0001xV-4c
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:31:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpcfR-0001w5-9F
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:31:55 -0500
Received: by mail-wr1-x442.google.com with SMTP id t6so7901988wrr.12
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 09:31:49 -0800 (PST)
References: <20190131215611.29341-1-michael@walle.cc>
	<20190131215611.29341-3-michael@walle.cc>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190131215611.29341-3-michael@walle.cc>
Date: Fri, 01 Feb 2019 17:31:46 +0000
Message-ID: <875zu3v2il.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] tests/tcg: also pass AS and LD
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: qemu-devel@nongnu.org


Michael Walle <michael@walle.cc> writes:

> The lm32 architecture doesn't need the complete compiler. In fact, only
> the building of GCC is skipped to make building the docker image faster.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  tests/tcg/Makefile.include | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
> index 73b5626fc5..19b81400f5 100644
> --- a/tests/tcg/Makefile.include
> +++ b/tests/tcg/Makefile.include
> @@ -41,17 +41,26 @@ ifneq ($(DOCKER_IMAGE),)
>  # We also need the Docker make rules to depend on
>  include $(SRC_PATH)/tests/docker/Makefile.include
>
> -DOCKER_COMPILE_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
> +DOCKER_CC_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
>  		--cc $(DOCKER_CROSS_COMPILER) \
>  		-i qemu:$(DOCKER_IMAGE) \
>  		-s $(SRC_PATH) -- "
> +DOCKER_AS_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
> +		--cc $(DOCKER_CROSS_ASSEMBLER) \
> +		-i qemu:$(DOCKER_IMAGE) \
> +		-s $(SRC_PATH) -- "
> +DOCKER_LD_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
> +		--cc $(DOCKER_CROSS_LINKER) \
> +		-i qemu:$(DOCKER_IMAGE) \
> +		-s $(SRC_PATH) -- "
>  DOCKER_PREREQ=3Ddocker-image-$(DOCKER_IMAGE)
>
>  .PHONY: docker-build-guest-tests
>  docker-build-guest-tests: $(DOCKER_PREREQ)
>  	$(call quiet-command, \
>  	  (mkdir -p tests && cd tests && \
> -	   $(MAKE) -f $(TCG_MAKE) CC=3D$(DOCKER_COMPILE_CMD) \
> +	   $(MAKE) -f $(TCG_MAKE) CC=3D$(DOCKER_CC_CMD) \
> +			AS=3D$(DOCKER_AS_CMD) LD=3D$(DOCKER_LD_CMD) \

Hmm will these overrides break exiting builds? We haven't defined
DOCKER_CROSS_ASSEMBLER or DOCKER_CROSS_LINKER for all our targets.

>  			BUILD_STATIC=3Dy \
>  			EXTRA_CFLAGS=3D$(DOCKER_CROSS_COMPILER_CFLAGS)), \
>  	"BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")


--
Alex Benn=C3=A9e
